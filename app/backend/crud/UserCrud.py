from sqlmodel import Session, select
from backend.models.UserModel import UserModel
from backend.response.UserResponse import UserCreate, UserUpdate, UserLogin
from backend import utils
from passlib.context import CryptContext
from sqlalchemy import func
from config.database import get_db
from fastapi import HTTPException, status, Depends
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc
from typing import Optional
from datetime import datetime


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password: str) -> str: # ENCRYPT
    """Hash password"""
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool: # CHECK FOR CORRECT PASSWORD
    """Verify password"""
    return pwd_context.verify(plain_password, hashed_password)




# trc khi thêm 
def authenticate_user(db: Session, data: UserLogin):
    print("start auth")
    user = db.query(UserModel).filter(UserModel.user_name == data.user_name).first()
    print(data.password)
    print(verify_password(data.password, user.hashed_password))
    print(user)
    if not user or not verify_password(data.password, user.hashed_password):
        return None
    return user 

def check_user_name_exist(db: Session, user_name: str):

    user = db.query(UserModel).filter(UserModel.user_name == user_name).first()
    print(user)
    if user:
        return True
    return False


def create_user(db: Session, data: UserCreate):
    # lưu ý: change password các hth lớn thường sẽ check password, password ph tuân theo một rule nhất định
    # add thêm pass word đã hash vào hashed_password=get_password_hash(password)
    print(111)
    user = UserModel(**data.dict(), hashed_password=get_password_hash(data.password))
    print("234")
    db.add(user)
    print(345)
    db.commit()
    print("acbde")
    db.refresh(user)
    print("12345")
    return True


def search_users(
    session: Session,
    q: str = None,
    created_time: str = None,
    sort_by: str = "user_name",
    sort_order: str = "asc",
    page: int = 1, page_size: int = 10
):
    print("start search user")
    query = session.query(UserModel)
    print("query")
    if q:
        query = query.filter(
            or_(
                UserModel.user_name.ilike(f"%{q}%"),
                UserModel.fullname.ilike(f"%{q}%"),
                UserModel.email.ilike(f"%{q}%")
            )
        )

    print("filter")
    if created_time:
        query = query.filter(UserModel.created_at >= created_time)

    if hasattr(UserModel, sort_by):
        column = getattr(UserModel, sort_by)
        query = query.order_by(asc(column) if sort_order.lower() == "asc" else desc(column))
    else:
        query = query.order_by(asc(UserModel.user_name))
    print("sort")

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


def get_user_by_user_name(db: Session, user_name: str):
    user = db.query(UserModel).filter(UserModel.user_name == user_name, UserModel.deleted_at.is_(None)).first()
    print(user)
    if user:
        return user
    return None


def get_all_user(db: Session = Depends(get_db), page: int = 1, page_size: int = 10):
    # tổng số record
    stmt = select(func.count()).select_from(UserModel).where(
            UserModel.deleted_at.is_(None)
        )
    total = db.exec(stmt).first() or 0  # luôn int, kể cả khi 0

    # lấy danh sách
    statement = (
        select(UserModel)
        .where(UserModel.deleted_at.is_(None))
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    items = db.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size if total > 0 else 0

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }

def update_user(db: Session, user_id: str, data: UserUpdate):
    print("start updating user")
    user = db.get(UserModel, user_id)
    print("user")
    if not user:
        return None
    update_data = data.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(user, key, value)
    print("key, value")
    db.add(user)
    db.commit()
    db.refresh(user)
    return True


def delete_user(db: Session, user_id: str) -> bool:
    print("start delete user")
    user = db.exec(
        select(UserModel).where(
            UserModel.id == user_id,
            UserModel.deleted_at.is_(None)
        )
    ).first()

    print(user)
    

    if not user:
        return False

    user.deleted_at = utils.get_current_time()
    db.add(user) # SOFT DELETE
    db.commit()
    return True

