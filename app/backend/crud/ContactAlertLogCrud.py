from sqlmodel import Session, select
from typing import List, Optional
from backend.models.ContactAlertLogModel import ContactAlertLogModel
from backend.response.ContactAlertLogResponse import ContactAlertLogCreate, ContactAlertLogUpdate
from backend import utils
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc

def create_contact_alert_log(session: Session, data: ContactAlertLogCreate):
    contact_alert_log = ContactAlertLogModel(**data.dict())
    session.add(contact_alert_log)
    session.commit()
    session.refresh(contact_alert_log)
    return True


def search_contact_alert_logs(
    session: Session,
    user_id:str,
    q: str = None,
    trigger_reason: str = None,
    trigger_data: str = None,
    status: str = None,
    sent_at: str = None,
    response_at: str = None,
    response_detail: str = None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int = 1, page_size: int = 10
):
    query = session.query(ContactAlertLogModel)
    
    if q:
        query = query.filter(
            or_(
                ContactAlertLogModel.alert_id.ilike(f"%{q}%"),
            )
        )

    if user_id:
        query = query.filter(ContactAlertLogModel.user_id == user_id)
    if trigger_reason:
        query = query.filter(ContactAlertLogModel.trigger_reason == trigger_reason)
    if trigger_data:
        query = query.filter(ContactAlertLogModel.trigger_data == trigger_data)
    if status:
        query = query.filter(ContactAlertLogModel.status == status)
    if sent_at:
        query = query.filter(ContactAlertLogModel.sent_at >= sent_at)
    if response_at:
        query = query.filter(ContactAlertLogModel.response_at >= response_at)
    if response_detail:
        query = query.filter(ContactAlertLogModel.response_detail == response_detail)
    

    if hasattr(ContactAlertLogModel, sort_by):
        column = getattr(ContactAlertLogModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(ContactAlertLogModel.created_at))
    
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



def get_contact_alert_log_by_id(session: Session, user_id: str,contact_alert_log_id: str):
    contact_alert_log = session.query(ContactAlertLogModel).filter(ContactAlertLogModel.id == contact_alert_log_id, ContactAlertLogModel.user_id == user_id,ContactAlertLogModel.deleted_at.is_(None)).first()
    print(contact_alert_log)
    if contact_alert_log:
        return contact_alert_log
    return None


def get_all_contact_alert_logs(session: Session, user_id:str, page: int =1,page_size: int = 10 ):
    stmt = select(func.count()).select_from(ContactAlertLogModel).where(
            ContactAlertLogModel.deleted_at.is_(None),
            ContactAlertLogModel.user_id == user_id
        )
    print("stmt")
    total = session.exec(stmt).first()


    # lấy danh sách theo phân trang
    statement = (
        select(ContactAlertLogModel)
        .where(ContactAlertLogModel.deleted_at.is_(None),ContactAlertLogModel.user_id == user_id)
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


def update_contact_alert_log(session: Session,user_id:str, contact_alert_log_id: str, data: ContactAlertLogUpdate):
    contact_alert_log = session.exec(select(ContactAlertLogModel).where(ContactAlertLogModel.id == contact_alert_log_id, ContactAlertLogModel.user_id == user_id))
    if not contact_alert_log:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(contact_alert_log, key, value)
    session.add(contact_alert_log)
    session.commit()
    session.refresh(contact_alert_log)
    return True


def delete_contact_alert_log(session: Session,user_id:str, contact_alert_log_id: str) -> bool:
    contact_alert_log = session.exec(
        select(ContactAlertLogModel).where(
            ContactAlertLogModel.id == contact_alert_log_id,
            ContactAlertLogModel.user_id == user_id,
            ContactAlertLogModel.deleted_at.is_(None)
        )
    ).first()
    if not contact_alert_log:
        return False
    
    contact_alert_log.deleted_at = utils.get_current_time()
    session.add(contact_alert_log)
    session.commit()
    return True
