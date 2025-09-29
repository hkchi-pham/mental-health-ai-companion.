from sqlmodel import Session, select
from app.models.UserModel import UserModel
from app.response.UserResponse import UserCreate, UserUpdate, UserLogin
from app import utils
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password: str) -> str: # ENCRYPT
    """Hash password"""
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool: # CHECK FOR CORRECT PASSWORD
    """Verify password"""
    return pwd_context.verify(plain_password, hashed_password)

# trc khi thêm 
def authenticate_user(db: Session, data: UserLogin):
    user = db.query(UserModel).filter(UserModel.username == data.user_name).first()
    if not user or not verify_password(data.password, user.hashed_password):
        return None
    return True

def create_user(db: Session, data: UserCreate):
    # lưu ý: change password các hth lớn thường sẽ check password, password ph tuân theo một rule nhất định
    # add thêm pass word đã hash vào hashed_password=get_password_hash(password)
    user = UserModel(**data.dict(), password=get_password_hash(data.password))
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
    db.add(user) # SOFT DELETE
    db.commit()
    return True

