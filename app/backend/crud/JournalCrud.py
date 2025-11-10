from sqlmodel import Session, select
from typing import List, Optional
from backend.models.JournalModel import JournalModel
from backend.response.JournalResponse import JournalCreate, JournalUpdate
from backend import utils
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc

def create_journal(session: Session, data: JournalCreate):
    journal = JournalModel(**data.dict())
    session.add(journal)
    session.commit()
    session.refresh(journal)
    return True

def search_journals(
    session: Session,
    q:  str = None,
    user_id:  str = None,
    visibility:  str = None,
    created_time:  str = None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int = 1, page_size: int =10
):
    print("start searching journal")
    query = session.query(JournalModel)
    
    if q:
        query = query.filter(JournalModel.content.ilike(f"%{q}%"),)
    if user_id:
        query = query.filter(JournalModel.user_id == user_id)
    if created_time:
        query = query.filter(JournalModel.created_at >= created_time)
    if visibility:
        query = query.filter(JournalModel.visibility == visibility)
    

    if hasattr(JournalModel, sort_by):
        column = getattr(JournalModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(JournalModel.created_at))
    
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


def get_journal_by_id(session: Session, journal_id: str):
    journal = session.query(JournalModel).filter(JournalModel.id == journal_id, JournalModel.deleted_at.is_(None)).first()
    print(journal)
    if journal:
        return journal
    return None


def get_all_journals(session: Session, page: int =1,page_size: int = 10 ):
    stmt = select(func.count()).select_from(JournalModel).where(
            JournalModel.deleted_at.is_(None)
        )
    total = session.exec(stmt).first() or 0 

    # lấy danh sách theo phân trang
    statement = (
        select(JournalModel)
        .where(JournalModel.deleted_at.is_(None))
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


def update_journal(session: Session, journal_id: str, data: JournalUpdate):
    print("startupdating journal")
    journal = session.get(JournalModel, journal_id)
    print("journal")
    if not journal:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(journal, key, value)
    print("key,value")
    session.add(journal)
    print("123")
    session.commit()
    print("commit")
    session.refresh(journal)
    print("done")
    return True


def delete_journal(session: Session, journal_id: str) -> bool:
    journal = session.exec(
        select(JournalModel).where(
            JournalModel.id == journal_id,
            JournalModel.deleted_at.is_(None)
        )
    ).first()

    if not journal:
        return False
    
    journal.deleted_at = utils.get_current_time()
    session.add(journal)
    session.commit()
    return True
