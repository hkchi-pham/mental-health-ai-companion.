from sqlmodel import Session, select
from app.models.UserModel import UserModel
from app.response.UserResponse import UserCreate, UserUpdate


from app import utils

def create_user(db: Session, data: UserCreate):
    user = UserModel(**data.dict())
    db.add(user)
    db.commit()
    db.refresh(user)
    return True

def get_user_by_id(db: Session, user_id: str):
    return db.get(UserModel, user_id)

def get_all_user(db: Session, page: int = 1, page_size: int = 10):
    # tổng số record
    total = db.exec(select(UserModel)).count()

    # lấy danh sách theo phân trang
    statement = select(UserModel).offset((page - 1) * page_size).limit(page_size)
    items = db.exec(statement).all()

    total_pages = (total + page_size - 1) // page_size  # làm tròn lên

    return {
        "items": items,
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages
    }

def update_user(db: Session, user_id: str, data: UserUpdate):
    user = db.get(UserModel, user_id)
    if not user:
        return None
    update_data = data.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(user, key, value)
    db.add(user)
    db.commit()
    db.refresh(user)
    return True

def delete_user(db: Session, user_id: str) -> bool:
    user = db.exec(
        select(UserModel).where(
            UserModel.id == user_id,
            UserModel.deleted_at.is_(None)
        )
    ).first()

    if not user:
        return False

    user.deleted_at = utils.get_current_time()
    db.delete(user)
    db.commit()
    return True

