from sqlmodel import Session, select
from typing import List, Optional
from app.models.ContactAlertModel import ContactAlertModel
from app.response.ContactAlertResponse import ContactAlertCreate, ContactAlertUpdate
from app import utils

def create_contact_alert(session: Session, data: ContactAlertCreate):
    contact_alert = ContactAlertModel(**data.dict())
    session.add(contact_alert)
    session.commit()
    session.refresh(contact_alert)
    return True


def get_contact_alert_by_id(session: Session, contact_alert_id: str):
    return session.get(ContactAlertModel, contact_alert_id)


def get_all_contact_alerts(session: Session, page: int =1,page_size: int = 10 ):
    total = session.exec(select(ContactAlertModel)).count()

    # lấy danh sách theo phân trang
    statement = select(ContactAlertModel).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def update_contact_alert(session: Session, contact_alert_id: str, data: ContactAlertUpdate):
    contact_alert = session.get(ContactAlertModel, contact_alert_id)
    if not contact_alert:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(contact_alert, key, value)
    session.add(contact_alert)
    session.commit()
    session.refresh(contact_alert)
    return True


def delete_contact_alert(session: Session, contact_alert_id: str) -> bool:
    contact_alert = session.exec(
        select(ContactAlertModel).where(
            ContactAlertModel.id == contact_alert_id,
            ContactAlertModel.deleted_at.is_(None)
        )
    ).first()
    if not contact_alert:
        return False
    
    contact_alert.deleted_at = utils.get_current_time
    session.add(contact_alert)
    session.commit()
    return True
