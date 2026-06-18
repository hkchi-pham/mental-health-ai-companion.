from sqlmodel import Session, select
from typing import Optional, List
from datetime import datetime
from fastapi.encoders import jsonable_encoder

from backend.models.GardenItemModel import GardenItemModel
from backend.models.UserModel import UserModel
from backend.response.GardenItemResponse import GardenItemCreate, GardenItemUpdate, GardenItemWater
from backend import utils


def get_items(db: Session, user_id: str) -> list:
    """Return all non-deleted garden items for the given user."""
    items = db.exec(
        select(GardenItemModel).where(
            GardenItemModel.user_id == user_id,
            GardenItemModel.deleted_at.is_(None),
        )
    ).all()
    # Always a list (possibly empty) so the caller can build a PaginatedResponse.
    return jsonable_encoder(items)


def get_item(db: Session, user_id: str, item_id: str) -> Optional[GardenItemModel]:
    """Fetch a single non-deleted item scoped to user."""
    return db.exec(
        select(GardenItemModel).where(
            GardenItemModel.user_id == user_id,
            GardenItemModel.id == item_id,
            GardenItemModel.deleted_at.is_(None),
        )
    ).first()


def create_item(db: Session, user_id: str, data: GardenItemCreate) -> GardenItemModel:
    """
    Idempotent upsert: if the client supplied an id AND a row with that
    id + user_id already exists (even if soft-deleted), un-delete it, update
    its fields, and return it.  Otherwise insert a new row.

    The router overwrites data.user_id from the JWT token before calling here.
    """
    if data.id:
        # Check for existing row (including soft-deleted) to support offline replay.
        existing = db.exec(
            select(GardenItemModel).where(
                GardenItemModel.id == data.id,
                GardenItemModel.user_id == user_id,
            )
        ).first()

        if existing:
            # Un-delete and update all writable fields.
            existing.deleted_at = None
            existing.item_type = data.item_type
            existing.growth_stage = data.growth_stage
            existing.growth_points = data.growth_points
            existing.health = data.health
            existing.row = data.row
            existing.col = data.col
            existing.panel_index = data.panel_index
            existing.last_water_at = data.last_water_at
            existing.updated_at = datetime.now()
            db.add(existing)
            db.commit()
            db.refresh(existing)
            return existing

    # Insert a new row.
    item_data = data.dict(exclude_none=False)
    # Force the correct user_id (never trust the client value).
    item_data["user_id"] = user_id
    # If client did not supply an id, remove the key so BaseModel generates one.
    if not item_data.get("id"):
        item_data.pop("id", None)

    item = GardenItemModel(**item_data)
    db.add(item)
    db.commit()
    db.refresh(item)
    return item


def update_item(db: Session, user_id: str, item_id: str, data: GardenItemUpdate) -> Optional[GardenItemModel]:
    """Partial update (move/update) — only fields present in the payload are touched."""
    item = get_item(db, user_id, item_id)
    if item is None:
        return None

    for k, v in data.dict(exclude_unset=True).items():
        setattr(item, k, v)
    item.updated_at = datetime.now()
    db.add(item)
    db.commit()
    db.refresh(item)
    return item


def water_item(db: Session, user_id: str, item_id: str, data: GardenItemWater) -> Optional[GardenItemModel]:
    """
    Persist the client-computed post-water state verbatim.
    Server does NOT recompute heal/grow math — that authority lives in Flutter.
    Also writes the absolute water balance to the user row.
    """
    item = get_item(db, user_id, item_id)
    if item is None:
        return None

    user = db.exec(
        select(UserModel).where(UserModel.id == user_id)
    ).first()

    # Persist client-computed state.
    item.health = data.health
    item.growth_stage = data.growth_stage
    item.growth_points = data.growth_points
    item.last_water_at = datetime.now()

    # Write absolute water balance (client owns the calculation).
    if user is not None:
        user.water_units = data.water_units
        db.add(user)

    db.add(item)
    db.commit()
    db.refresh(item)
    if user is not None:
        db.refresh(user)
    return item


def delete_item(db: Session, user_id: str, item_id: str) -> bool:
    """Soft-delete by setting deleted_at timestamp."""
    item = get_item(db, user_id, item_id)
    if item is None:
        return False

    item.deleted_at = utils.get_current_time()
    db.add(item)
    db.commit()
    return True
