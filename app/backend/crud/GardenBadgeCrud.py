from sqlmodel import Session, select
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from backend.models.GardenBadgeModel import GardenBadgeModel
from backend.response.GardenBadgeResponse import GardenBadgeCreate, GardenBadgeTrade


def get_badges(db: Session, user_id: str) -> list:
    """Return all non-deleted badges for the given user."""
    items = db.exec(
        select(GardenBadgeModel).where(
            GardenBadgeModel.user_id == user_id,
            GardenBadgeModel.deleted_at.is_(None),
        )
    ).all()
    # Always a list (possibly empty) so the caller can build a PaginatedResponse.
    return jsonable_encoder(items)


def get_badge(db: Session, user_id: str, badge_id: str):
    """Return a single badge row or None."""
    return db.exec(
        select(GardenBadgeModel).where(
            GardenBadgeModel.user_id == user_id,
            GardenBadgeModel.id == badge_id,
            GardenBadgeModel.deleted_at.is_(None),
        )
    ).first()


def create_badge(db: Session, user_id: str, data: GardenBadgeCreate) -> GardenBadgeModel:
    """Idempotent upsert — if a row with data.id + user_id already exists
    (even soft-deleted) we restore and update it instead of inserting a duplicate.
    This lets the offline queue replay safely without generating 409 conflicts.
    """
    existing = None
    if data.id:
        # Look up regardless of deleted_at so a soft-deleted badge can be restored.
        existing = db.exec(
            select(GardenBadgeModel).where(
                GardenBadgeModel.id == data.id,
                GardenBadgeModel.user_id == user_id,
            )
        ).first()

    if existing:
        # Update every mutable field and clear soft-delete if present.
        existing.tree_type = data.tree_type
        existing.stage = data.stage
        existing.earned_at = data.earned_at
        existing.traded = data.traded
        existing.trade_type = data.trade_type
        existing.seen = data.seen
        existing.tree_id = data.tree_id
        existing.deleted_at = None
        existing.updated_at = datetime.now()
        db.add(existing)
        db.commit()
        db.refresh(existing)
        return existing

    # New badge — use the client-supplied id if provided.
    badge_data = data.dict(exclude_none=False)
    badge = GardenBadgeModel(**badge_data)
    badge.user_id = user_id  # always overwrite from token
    if data.id:
        badge.id = data.id
    db.add(badge)
    db.commit()
    db.refresh(badge)
    return badge


def trade_badge(db: Session, user_id: str, badge_id: str, data: GardenBadgeTrade) -> tuple:
    """Flip traded/trade_type exactly once.

    Returns:
        (None, "not_found")      — badge does not exist for this user
        (badge, "already_traded") — badge was already traded; no change
        (badge, "ok")            — badge marked traded successfully
    """
    badge = get_badge(db, user_id, badge_id)

    if badge is None:
        return (None, "not_found")

    if badge.traded is True:
        return (badge, "already_traded")

    badge.traded = True
    badge.trade_type = data.trade_type
    badge.updated_at = datetime.now()
    db.add(badge)
    db.commit()
    db.refresh(badge)
    return (badge, "ok")
