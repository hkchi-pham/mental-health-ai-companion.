from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.crud.UserCrud import authenticate_user
from app.response.UserResponse import UserLogin
from app.response.AuthResponse import AuthToken
from app.response.CommonResponse import MessageCode
from app.security.AuthToken import create_access_token
from app.config.database import get_db 

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

# login 
@router.post("/login", response_model=AuthToken)
def user_login(user_in: UserLogin, db: Session = Depends(get_db)):
    try:
        user = authenticate_user(db, user_in.user_name, user_in.password)
        if not user:
            raise HTTPException(status_code=400, detail=MessageCode.INVALID_CREDENTIALS.value)
        token = create_access_token({"sub": user.user_name})
        raise HTTPException(status_code=200, detail=MessageCode.USER_LOGIN_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.USER_LOGIN_FAILED.value)
