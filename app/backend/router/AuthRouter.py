from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session
from backend.crud import UserCrud as crud
from backend.response.UserResponse import UserLogin, UserCreate
from backend.response.AuthResponse import AuthToken, PasswordChange
from backend.response.CommonResponse import MessageCode, SuccessResponse, ErrorResponse
from backend.security import Authentication as auth
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel
from config.database import get_db

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

# login
@router.post("/login", response_model=AuthToken,
             responses={400: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def user_login(user_in: UserLogin, db: Session = Depends(get_db)):
    try:
        user = crud.authenticate_user(db, user_in)
        if not user:
            raise HTTPException(status_code=400, detail=MessageCode.INVALID_CREDENTIALS.value)
        token = auth.create_access_token(data={"sub": user.user_name, "user_id": user.id})
        return {
            "access_token": token,
            "expires_in": auth.ACCESS_TOKEN_EXPIRE_MINUTES,
            "user_name": user.user_name,
            "user_id": user.id,
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.USER_LOGIN_FAILED.value)


# register — explicit signup endpoint. Wraps user creation (equivalent to
# POST /users/) so clients have an obvious /auth/register to call.
@router.post("/register",
             responses={400: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def register(data: UserCreate, db: Session = Depends(get_db)):
    try:
        if crud.check_user_name_exist(db, data.user_name):
            raise HTTPException(status_code=400, detail=MessageCode.USER_ALREADY_EXISTS.value)
        crud.create_user(db, data)
        return SuccessResponse(message=MessageCode.CREATE_USER_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_USER_FAILED.value)


# change password — authenticated user verifies old password and sets new hash
@router.put("/password",
            responses={400: {"model": ErrorResponse}, 401: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def change_password(data: PasswordChange,
                    current_user: UserModel = Depends(get_current_user),
                    db: Session = Depends(get_db)):
    try:
        if not crud.verify_password(data.old_password, current_user.hashed_password):
            raise HTTPException(status_code=400, detail=MessageCode.INVALID_OLD_PASSWORD.value)
        current_user.hashed_password = crud.get_password_hash(data.new_password)
        db.add(current_user)
        db.commit()
        return SuccessResponse(message=MessageCode.CHANGE_PASSWORD_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_USER_FAILED.value)
