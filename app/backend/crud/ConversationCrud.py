from sqlmodel import Session, select
from typing import List, Optional
from app.models.ConversationModel import ConversationModel
from app.response.ConversationResponse import ConversationCreate, ConversationUpdate
from app import utils

def create_conversation(session: Session, data: ConversationCreate):
    conv = ConversationModel(**data.dict())
    session.add(conv)
    session.commit()
    session.refresh(conv)
    return True


def get_conversation_by_id(session: Session, conv_id: str):
    return session.get(ConversationModel, conv_id)


def get_all_conversations(session: Session, page: int =1,page_size: int = 10 ):
    total = session.exec(select(ConversationModel)).count()

    # lấy danh sách theo phân trang
    statement = select(ConversationModel).offset((page - 1) * page_size).limit(page_size)
    items = session.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def update_conversation(session: Session, conv_id: str, data: ConversationUpdate):
    conv = session.get(ConversationModel, conv_id)
    if not conv:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(conv, key, value)
    session.add(conv)
    session.commit()
    session.refresh(conv)
    return True


def delete_conversation(session: Session, conv_id: str) -> bool:
    convo = session.exec(
        select(ConversationModel).where(
            ConversationModel.id == conv_id,
            ConversationModel.deleted_at.is_(None)
        )
    ).first()
    if not convo:
        return False
    
    convo.deleted_at = utils.get_current_time()
    session.add(convo)
    session.commit()
    return True
