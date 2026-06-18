from sqlmodel import Session, select
from typing import Optional, List
from datetime import datetime
from fastapi.encoders import jsonable_encoder

from backend.models.GardenDecorationModel import GardenDecorationModel
from backend.response.GardenDecorationResponse import GardenDecorationCreate, GardenDecorationUpdate
from backend import utils


def get_decorations(db: Session, user_id: str) -> list:
    """Return all non-deleted garden decorations for the given user."""
    items = db.exec(
        select(GardenDecorationModel).where(
            GardenDecorationModel.user_id == user_id,
            GardenDecorationModel.deleted_at.is_(None),
        )
    ).all()
    # Always a list (possibly empty) so the caller can build a PaginatedResponse.
    return jsonable_encoder(items)


def get_decoration(db: Session, user_id: str, deco_id: str) -> Optional[GardenDecorationModel]:
    """Fetch a single non-deleted decoration scoped to user."""
    return db.exec(
        select(GardenDecorationModel).where(
            GardenDecorationModel.user_id == user_id,
            GardenDecorationModel.id == deco_id,
            GardenDecorationModel.deleted_at.is_(None),
        )
    ).first()


def create_decoration(db: Session, user_id: str, data: GardenDecorationCreate) -> GardenDecorationModel:
    """
    Idempotent upsert: if the client supplied an id AND a row with that
    id + user_id already exists (even if soft-deleted), un-delete it, update
    its fields, and return it.  Otherwise insert a new row.

    The router overwrites data.user_id from the JWT token before calling here.
    """
    if data.id:
        # Check for existing row (including soft-deleted) to support offline replay.
        existing = db.exec(
            select(GardenDecorationModel).where(
                GardenDecorationModel.id == data.id,
                GardenDecorationModel.user_id == user_id,
            )
        ).first()

        if existing:
            # Un-delete and update all writable fields.
            existing.deleted_at = None
            existing.deco_type = data.deco_type
            existing.row = data.row
            existing.col = data.col
            existing.panel_index = data.panel_index
            existing.updated_at = datetime.now()
            db.add(existing)
            db.commit()
            db.refresh(existing)
            return existing

    # Insert a new row.
    deco_data = data.dict(exclude_none=False)
    # Force the correct user_id (never trust the client value).
    deco_data["user_id"] = user_id
    # If client did not supply an id, remove the key so BaseModel generates one.
    if not deco_data.get("id"):
        deco_data.pop("id", None)

    deco = GardenDecorationModel(**deco_data)
    db.add(deco)
    db.commit()
    db.refresh(deco)
    return deco


def update_decoration(db: Session, user_id: str, deco_id: str, data: GardenDecorationUpdate) -> Optional[GardenDecorationModel]:
    """Partial update (move/update) — only fields present in the payload are touched."""
    deco = get_decoration(db, user_id, deco_id)
    if deco is None:
        return None

    for k, v in data.dict(exclude_unset=True).items():
        setattr(deco, k, v)
    deco.updated_at = datetime.now()
    db.add(deco)
    db.commit()
    db.refresh(deco)
    return deco


def delete_decoration(db: Session, user_id: str, deco_id: str) -> bool:
    """Soft-delete by setting deleted_at timestamp."""
    deco = get_decoration(db, user_id, deco_id)
    if deco is None:
        return False

    deco.deleted_at = utils.get_current_time()
    db.add(deco)
    db.commit()
    return True
