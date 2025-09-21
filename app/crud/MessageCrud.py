from sqlmodel import Session, select
from typing import List, Optional
from app.models.MessageModel import MessageModel
from app.response.MessageResponse import MessageCreate


def create_message(session: Session, data: MessageCreate):
    message = MessageModel(**data.dict())
    session.add(message)
    session.commit()
    session.refresh(message)
    return True


def get_message_by_id(session: Session, mess_id: str):
    return session.get(MessageModel, mess_id)


def get_messages_by_convo(session: Session,convo_id: str, page:int = 1, page_size: int = 10):
    total = session.exec(select(MessageModel).where(MessageModel.conversation_id == convo_id)).count()

    # lấy danh sách theo phân trang
    statement = select(MessageModel).where(MessageModel.conversation_id == convo_id).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }

def get_messages_by_user(session: Session,user_id: str, page:int = 1, page_size: int = 10):
    total = session.exec(select(MessageModel).where(MessageModel.sender_id == user_id)).count()

    # lấy danh sách theo phân trang
    statement = select(MessageModel).where(MessageModel.sender_id == user_id).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }