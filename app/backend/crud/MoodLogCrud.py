from sqlmodel import Session, select
from typing import List, Optional
from backend.models.MoodLogModel import MoodLogModel
from backend.response.MoodLogResponse import MoodLogCreate, MoodLogUpdate
from backend import utils
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc

def create_mood_log(session: Session, data: MoodLogCreate):
    mood_log = MoodLogModel(**data.dict())
    session.add(mood_log)
    session.commit()
    session.refresh(mood_log)
    return True


def search_mood_logs(
    session: Session,
    q: str= None,
    user_id: str=None,
    convo_id: str =None,
    created_time: str = None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int = 1, page_size: int = 10
):
    query = session.query(MoodLogModel)
    
    if q:
        query = query.filter(
            or_(
                MoodLogModel.mood.ilike(f"%{q}%"),
                MoodLogModel.note.ilike(f"%{q}%"),
            )
        )

    
    if created_time:
        query = query.filter(MoodLogModel.created_at >= created_time)
    if user_id:
        query = query.filter(MoodLogModel.user_id == user_id)
    if convo_id:
        query = query.filter(MoodLogModel.conversation_id == convo_id)
    

    if hasattr(MoodLogModel, sort_by):
        column = getattr(MoodLogModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(MoodLogModel.created_at))
    
    total =query.count()  
    
    statement = query.offset((page - 1) * page_size).limit(page_size).all()

    total_pages = (total + page_size - 1) // page_size if total > 0 else 0
    print("statement")
    return {
        "items": jsonable_encoder(statement),  # ✅ serialize an toàn
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def get_mood_log_by_id(session: Session, mood_log_id: str):
    moodlog = session.query(MoodLogModel).filter(MoodLogModel.id == mood_log_id, MoodLogModel.deleted_at.is_(None)).first()
    print(moodlog)
    if moodlog:
        return moodlog
    return None


def get_all_mood_logs(session: Session, page: int =1,page_size: int = 10 ):
    print("start to get all mood log")
    stmt = select(func.count()).select_from(MoodLogModel).where(
            MoodLogModel.deleted_at.is_(None)
        )
    print("stmt")
    total = session.exec(stmt).first()

    print(total)


    # lấy danh sách theo phân trang
    statement = (
        select(MoodLogModel)
        .where(MoodLogModel.deleted_at.is_(None))
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": jsonable_encoder(items),
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
    print("start to delete moodlog")
    mood_log = session.exec(
        select(MoodLogModel).where(
            MoodLogModel.id == mood_log_id,
            MoodLogModel.deleted_at.is_(None)
        )
    ).first()
    print("mood log")
    if not mood_log:
        return False
    
    mood_log.deleted_at = utils.get_current_time()
    print("time")
    session.add(mood_log)
    print("add")
    session.commit()
    print("done")
    return True
