from sqlmodel import Session, select
from datetime import datetime
from sqlalchemy import func
from backend.models.UserModel import UserModel
from backend.models.JournalModel import JournalModel
from backend.models.ConversationModel import ConversationModel
from backend.models.GardenBadgeModel import GardenBadgeModel
from backend.response.CurrencyResponse import CurrencyUpdate


def get_me(db: Session, user_id: str):
    """Return the UserModel row for the given user (non-deleted) or None."""
    return db.exec(
        select(UserModel).where(
            UserModel.id == user_id,
            UserModel.deleted_at.is_(None),
        )
    ).first()


def get_me_with_counts(db: Session, user_id: str):
    """Return user row plus live journal/conversation/badge counts, or None if user not found."""
    user = get_me(db, user_id)
    if user is None:
        return None

    jc = db.exec(
        select(func.count()).select_from(JournalModel).where(
            JournalModel.user_id == user_id,
            JournalModel.deleted_at.is_(None),
        )
    ).first() or 0

    cc = db.exec(
        select(func.count()).select_from(ConversationModel).where(
            ConversationModel.user_id == user_id,
            ConversationModel.deleted_at.is_(None),
        )
    ).first() or 0

    bc = db.exec(
        select(func.count()).select_from(GardenBadgeModel).where(
            GardenBadgeModel.user_id == user_id,
            GardenBadgeModel.deleted_at.is_(None),
        )
    ).first() or 0

    return {"user": user, "journal_count": jc, "conversation_count": cc, "badge_count": bc}


def set_currency(db: Session, user_id: str, data: CurrencyUpdate):
    """Absolute-set points and water_units on the existing UserModel row.

    Overwrites both currency columns with the client-supplied values — no
    add/subtract math — so the offline queue can replay this call idempotently.

    Returns the refreshed UserModel on success, or None if the user is not found.
    """
    user = get_me(db, user_id)
    if user is None:
        return None

    user.points = data.points
    user.water_units = data.water_units
    user.updated_at = datetime.now()

    db.add(user)
    db.commit()
    db.refresh(user)
    return user
