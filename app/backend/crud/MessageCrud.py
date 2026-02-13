from sqlmodel import Session, select
from typing import List, Optional
from backend.models.MessageModel import MessageModel
from backend.response.MessageResponse import MessageCreate
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func
from datetime import datetime
from sqlalchemy import or_, desc, asc
from datetime import datetime


def get_recent_messages(session: Session, convo_id: str, limit: int = 5):
    """Get the most recent messages in a conversation for AI context."""
    statement = (
        select(MessageModel)
        .where(
            MessageModel.conversation_id == convo_id,
            MessageModel.deleted_at.is_(None)
        )
        .order_by(desc(MessageModel.created_at))
        .limit(limit)
    )
    items = session.exec(statement).all()
    return list(reversed(items))  # Oldest first for context

def create_message(session: Session, data: MessageCreate):
    print("start creating message")
    message = MessageModel(**data.dict())
    print("123")
    session.add(message)
    print("add")
    session.commit()
    print("111")
    session.refresh(message)
    print("done")
    return True

def search_messages(
    session: Session,
    sender_id:str,
    q: str= None,
    message_type: str= None,
    start_time: str = None,
    end_time: str= None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int = 1, page_size: int = 10
):
    query = session.query(MessageModel)
    
    if q:
        query = query.filter(
            or_(
                MessageModel.content.ilike(f"%{q}%"),
                MessageModel.message_type.ilike(f"%{q}%")
            )
        )

    
    if message_type:
        query = query.filter(MessageModel.message_type == message_type)
    if sender_id:
        query = query.filter(MessageModel.user_id == sender_id)
    if start_time:
        query = query.filter(MessageModel.created_at >= start_time)
    if end_time:
        query = query.filter(MessageModel.created_at <= end_time)

    
    if hasattr(MessageModel, sort_by):
        column = getattr(MessageModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(MessageModel.created_at))
    
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

def get_message_by_id(session: Session, mess_id: str, user_id: str):
    mess = session.query(MessageModel).filter(MessageModel.id == mess_id,MessageModel.sender_id==user_id, MessageModel.deleted_at.is_(None)).first()
    print(mess)
    if mess:
        return mess
    return None



def get_messages_by_convo(session: Session,user_id:str,convo_id: str, page:int = 1, page_size: int = 10):
    print("start get mess by convo")
    stmt = select(func.count()).select_from(MessageModel).where(
            MessageModel.conversation_id == convo_id,
            MessageModel.sender_id == user_id,
            MessageModel.deleted_at.is_(None)
        )
    print("stmt")
    total = session.exec(stmt).first()

    # lấy danh sách theo phân trang
    statement = (
        select(MessageModel)
        .where(MessageModel.conversation_id == convo_id,MessageModel.sender_id== user_id,MessageModel.deleted_at.is_(None))
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

def get_messages_by_user(session: Session,user_id: str, page:int = 1, page_size: int = 10):
    print("start get mess by user")
    stmt = select(func.count()).select_from(MessageModel).where(
            MessageModel.user_id == user_id,
            MessageModel.deleted_at.is_(None)
        )
    print("stmt")
    total = session.exec(stmt).first()


    # lấy danh sách theo phân trang
    statement = (
        select(MessageModel)
        .where(MessageModel.user_id == user_id, MessageModel.deleted_at.is_(None))
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