from sqlmodel import Session, select
from typing import List, Optional
from backend.models.ContactAlertModel import ContactAlertModel
from backend.response.ContactAlertResponse import ContactAlertCreate, ContactAlertUpdate
from backend import utils
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc

def create_contact_alert(session: Session, data: ContactAlertCreate):
    print("start to create contact alert")
    contact_alert = ContactAlertModel(**data.dict())
    print("create")
    session.add(contact_alert)
    print("add")
    session.commit()
    print("123")
    session.refresh(contact_alert)
    print("done")
    return True


def search_contact_alerts(
    session: Session,
    q: str = None,
    contact_name: str = None,
    contact_relation: str = None,
    contact_phone: str = None,
    contact_email:str = None,
    is_active: bool = None,
    created_time: str = None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int = 1, page_size: int = 10
):
    query = session.query(ContactAlertModel)
    
    if q:
        query = query.filter(
            or_(
                ContactAlertModel.alert_type.ilike(f"%{q}%"),
                ContactAlertModel.user_id.ilike(f"%{q}%"),
            )
        )

    
    if created_time:
        query = query.filter(ContactAlertModel.created_at >= created_time)
    if contact_name:
        query = query.filter(ContactAlertModel.contact_name == contact_name)
    if contact_email:
        query = query.filter(ContactAlertModel.contact_email == contact_email)
    if contact_phone:
        query = query.filter(ContactAlertModel.contact_phone == contact_phone)
    if contact_relation:
        query = query.filter(ContactAlertModel.contact_relation == contact_relation)
    if is_active:
        query = query.filter(ContactAlertModel.is_active == is_active)

    if hasattr(ContactAlertModel, sort_by):
        column = getattr(ContactAlertModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(ContactAlertModel.created_at))
    
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


def get_contact_alert_by_id(session: Session, contact_alert_id: str):
    contact_alert = session.query(ContactAlertModel).filter(ContactAlertModel.id == contact_alert_id, ContactAlertModel.deleted_at.is_(None)).first()
    print(contact_alert)
    if contact_alert:
        return contact_alert
    return None


def get_all_contact_alerts(session: Session, page: int =1,page_size: int = 10 ):
    stmt = select(func.count()).select_from(ContactAlertModel).where(
            ContactAlertModel.deleted_at.is_(None)
        )
    print("stmt")
    total = session.exec(stmt).first()

    # lấy danh sách theo phân trang
    statement = (
        select(ContactAlertModel)
        .where(ContactAlertModel.deleted_at.is_(None))
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
    
    contact_alert.deleted_at = utils.get_current_time()
    session.add(contact_alert)
    session.commit()
    return True
