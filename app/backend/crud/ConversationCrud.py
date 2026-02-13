from sqlmodel import Session, select
from typing import List, Optional
from backend.models.ConversationModel import ConversationModel
from backend.response.ConversationResponse import ConversationCreate, ConversationUpdate
from backend import utils
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc
from datetime import datetime


def create_conversation(session: Session, data: ConversationCreate):
    print("create convo")
    conv = ConversationModel(**data.dict())
    print(conv)
    session.add(conv)
    print(111)
    session.commit()
    print(123)
    session.refresh(conv)
    print("done")
    return True


def check_conversation_id_exist(db: Session, user_id:str,conv_id: str):
    conv = db.query(ConversationModel).filter(ConversationModel.conv_id == conv_id, ConversationModel.user_id == user_id).first()
    print(conv)
    if conv:
        return True
    return False

def search_conversations(
    session: Session,
    user_id:str,
    q: str = None,
    start_from: str = None,
    ended_to: str = None,
    sort_by: str = "created_at",
    sort_order: str = "asc",
    page: int =1, page_size = 10
):
    print("start search convo")
    query = session.query(ConversationModel)
    print("query")
    if q:
        query = query.filter(
            or_(
                ConversationModel.persona.ilike(f"%{q}%"),
            )
        )
    

    print("q")
    if start_from:
        query = query.filter(ConversationModel.created_at >= start_from)
    if ended_to:
        query = query.filter(ConversationModel.ended_at <= ended_to)
    if user_id:
        query = query.filter(ConversationModel.user_id == user_id)
    print("filter")
    if hasattr(ConversationModel, sort_by):
        column = getattr(ConversationModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(ConversationModel.created_at))
    print("sort")
    total = query.count()  
    
    statement = query.offset((page - 1) * page_size).limit(page_size).all()

    total_pages = (total + page_size - 1) // page_size if total > 0 else 0
    print("statement")
    return {
        "items": jsonable_encoder(statement),  
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }


def get_conversation_by_id(session: Session,user_id:str, conv_id: str):
    print("get conv by id")
    print(ConversationModel.__table__.columns.keys())
    conv = session.query(ConversationModel).filter(ConversationModel.id == conv_id,ConversationModel.user_id == user_id, ConversationModel.deleted_at.is_(None)).first()
    print(conv)
    if conv:
        return conv
    return None


def get_all_conversations(session: Session,user_id:str, page: int = 1,page_size: int = 10 ):
    print("start to get all convo")
    stmt = select(func.count()).select_from(ConversationModel).where(
            ConversationModel.deleted_at.is_(None),
            ConversationModel.user_id == user_id
        )
    print("stmt")
    total = session.exec(stmt).first()

    print(total)


    # lấy danh sách theo phân trang
    statement = (
        select(ConversationModel)
        .where(ConversationModel.deleted_at.is_(None), ConversationModel.user_id == user_id)
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


def update_conversation(session: Session, conv_id: str,user_id:str, data: ConversationUpdate):
    conv = session.exec(select(ConversationModel).where(ConversationModel.id == conv_id, ConversationModel.user_id == user_id))
    if not conv:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(conv, key, value)
    session.add(conv)
    session.commit()
    session.refresh(conv)
    return True


def delete_conversation(session: Session, user_id:str, conv_id: str) -> bool:
    convo = session.exec(
        select(ConversationModel).where(
            ConversationModel.id == conv_id,
            ConversationModel.user_id == user_id,
            ConversationModel.deleted_at.is_(None)
        )
    ).first()
    if not convo:
        return False
    
    convo.deleted_at = utils.get_current_time()
    session.add(convo)
    session.commit()
    return True
