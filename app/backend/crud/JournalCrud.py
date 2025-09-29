from sqlmodel import Session, select
from typing import List, Optional
from app.models.JournalModel import JournalModel
from app.response.JournalResponse import JournalCreate, JournalUpdate
from app import utils

def create_journal(session: Session, data: JournalCreate):
    journal = JournalModel(**data.dict())
    session.add(journal)
    session.commit()
    session.refresh(journal)
    return True


def get_journal_by_id(session: Session, journal_id: str):
    return session.get(JournalModel, journal_id)


def get_all_journals(session: Session, page: int =1,page_size: int = 10 ):
    total = session.exec(select(JournalModel)).count()

    # lấy danh sách theo phân trang
    statement = select(JournalModel).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def update_journal(session: Session, journal_id: str, data: JournalUpdate):
    journal = session.get(JournalModel, journal_id)
    if not journal:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(journal, key, value)
    session.add(journal)
    session.commit()
    session.refresh(journal)
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
    
    journal.deleted_at = utils.get_current_time
    session.add(journal)
    session.commit()
    return True
