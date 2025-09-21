from sqlmodel import Session, select
from typing import List, Optional
from app.models.ContactAlertLogModel import ContactAlertLogModel
from app.response.ContactAlertLogResponse import ContactAlertLogCreate, ContactAlertLogUpdate
from app import utils

def create_contact_alert(session: Session, data: ContactAlertLogCreate):
    contact_alert_log = ContactAlertLogModel(**data.dict())
    session.add(contact_alert_log)
    session.commit()
    session.refresh(contact_alert_log)
    return True


def get_contact_alert_by_id(session: Session, contact_alert_id: str):
    return session.get(ContactAlertLogModel, contact_alert_id)


def get_all_contact_alerts(session: Session, page: int =1,page_size: int = 10 ):
    total = session.exec(select(ContactAlertLogModel)).count()

    # lấy danh sách theo phân trang
    statement = select(ContactAlertLogModel).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def update_contact_alert(session: Session, contact_alert_id: str, data: ContactAlertLogUpdate):
    contact_alert_log = session.get(ContactAlertLogModel, contact_alert_id)
    if not contact_alert_log:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(contact_alert_log, key, value)
    session.add(contact_alert_log)
    session.commit()
    session.refresh(contact_alert_log)
    return contact_alert_log


def delete_contact_alert(session: Session, contact_alert_id: str) -> bool:
    contact_alert_log = session.exec(
        select(ContactAlertLogModel).where(
            ContactAlertLogModel.id == contact_alert_id,
            ContactAlertLogModel.deleted_at.is_(None)
        )
    ).first()
    if not contact_alert_log:
        return False
    
    contact_alert_log.deleted_at = utils.get_current_time
    session.add(contact_alert_log)
    session.commit()
    return True
