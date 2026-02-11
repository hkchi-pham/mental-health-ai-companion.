from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session
from backend.crud import UserCrud as crud
from backend.response.UserResponse import UserLogin
from backend.response.AuthResponse import AuthToken
from backend.response.CommonResponse import MessageCode
from backend.security import Authentication as auth
from config.database import get_db 

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

# login 
@router.post("/login", response_model=AuthToken)
def user_login(user_in: UserLogin, db: Session = Depends(get_db)):
    try:
        user = crud.authenticate_user(db, user_in)
        if not user:
            return HTTPException(status_code=400, detail=MessageCode.INVALID_CREDENTIALS.value)
        token = auth.create_access_token(data={"sub": user.user_name, "user_id": user.id})
        return {
            "access_token": token,
            "expires_in": auth.ACCESS_TOKEN_EXPIRE_MINUTES,
            "user_name": user.user_name,
            "user_id": user.id, 
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.USER_LOGIN_FAILED.value)
