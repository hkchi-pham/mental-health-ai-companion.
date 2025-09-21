from sqlmodel import Session, select
from typing import List, Optional
from app.models.MoodLogModel import MoodLogModel
from app.response.MoodLogResponse import MoodLogCreate, MoodLogUpdate
from app import utils

def create_mood_log(session: Session, data: MoodLogCreate):
    mood_log = MoodLogModel(**data.dict())
    session.add(mood_log)
    session.commit()
    session.refresh(mood_log)
    return True


def get_mood_log_by_id(session: Session, mood_log_id: str):
    return session.get(MoodLogModel, mood_log_id)


def get_all_mood_logs(session: Session, page: int =1,page_size: int = 10 ):
    total = session.exec(select(MoodLogModel)).count()

    # lấy danh sách theo phân trang
    statement = select(MoodLogModel).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def update_mood_log(session: Session, mood_log_id: str, data: MoodLogUpdate):
    mood_log = session.get(MoodLogModel, mood_log_id)
    if not mood_log:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(mood_log, key, value)
    session.add(mood_log)
    session.commit()
    session.refresh(mood_log)
    return True


def delete_mood_log(session: Session, mood_log_id: str) -> bool:
    mood_log = session.exec(
        select(MoodLogModel).where(
            MoodLogModel.id == mood_log_id,
            MoodLogModel.deleted_at.is_(None)
        )
    ).first()
    if not mood_log:
        return False
    
    mood_log.deleted_at = utils.get_current_time
    session.add(mood_log)
    session.commit()
    return True
