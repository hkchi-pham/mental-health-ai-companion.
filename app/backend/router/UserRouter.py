from fastapi import APIRouter, Depends, HTTPException, Query, Body
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.response.UserResponse import UserCreate, UserUpdate, UserResponse
from backend.response.CommonResponse import SuccessResponse, PaginatedResponse, ErrorResponse, MessageCode
from backend.models.UserModel import UserModel
from backend.crud import UserCrud as crud
from typing import Optional
from datetime import datetime
from backend.security.Authentication import get_current_user

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

@router.post("/", 
            #  response_model=SuccessResponse[UserResponse], 
             responses={500: {"model": ErrorResponse}}
            )
def create_user(
    data: UserCreate = Body(...),
    db: Session = Depends(get_db)
):
    import traceback
    try:
        print("=== CREATE USER START ===")
        if crud.check_user_name_exist(db, data.user_name):
            print("User already exists")
            raise HTTPException(status_code=400, detail=MessageCode.USER_ALREADY_EXISTS.value)
        print("Creating user...")
        result = crud.create_user(db, data)
        print("User created successfully")
        return {"message": MessageCode.CREATE_USER_SUCCESSFULLY.value, "success": True}
    except HTTPException:
        raise
    except Exception as e:
        print(f"=== ERROR: {str(e)} ===")
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/", 
            # response_model=PaginatedResponse[UserResponse], 
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}, 
            # dependencies=[Depends(KiemTraQuyen("quan_ly_co_so_xem"))]
        )
def get_all_user(
    db: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
    # đối với user, chỉ cần get detail ko cần get list, vẫn ph có create+update+delete
):
    try:
        result = crud.get_all_user(db, page=page, page_size=page_size)
        return PaginatedResponse[UserResponse](
            message="",
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/search-all-users",
            response_model=PaginatedResponse[UserResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_users(
    q: Optional[str]= None,
    created_time: Optional[datetime] = None,
    session: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
):
    try:
        print("search users")
        results = crud.search_users(
            session=session,
            q=q,
            created_time=created_time,
            page=page,
            page_size=page_size
        )
        print(results)
        if not results:
            raise HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        
    
        return PaginatedResponse[UserResponse](
            message=MessageCode.GET_USER_SUCCESSFULLY.value,
            data=results["items"],
            total=results["total"],
            page=results["page"],
            page_size=results["page_size"],
            total_pages=results["total_pages"]
        )

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))



@router.get("/{user_name}", response_model = SuccessResponse[UserResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}
        )
def get_user_by_user_name(
    user_name: str,
    db: Session = Depends(get_db)
):
    try:
        result = crud.get_user_by_user_name(db, user_name)
        if result == None:
            raise HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        return SuccessResponse[UserResponse](
            message=MessageCode.GET_USER_SUCCESSFULLY.value,
            data=result
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/{user_id}", 
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}
        )
def update_user(
    current_user: UserModel = Depends(get_current_user),
    data: UserUpdate = Body(...),
    db: Session = Depends(get_db)
):
    try:
        user_id = current_user.id
        result = crud.update_user(db, user_id, data)
        return SuccessResponse(message=MessageCode.UPDATE_USER_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.delete("/{user_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}
               
            )
def delete_user(current_user: UserModel = Depends(get_current_user), db: Session = Depends(get_db)):
    try:
        user_id = current_user.id
        print(user_id)
        result = crud.delete_user(db, user_id)
        if not result:
            raise HTTPException(status_code=409, detail=MessageCode.USER_NOT_FOUND.value)
        print(result)
        return SuccessResponse(message=MessageCode.DELETE_USER_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    # tạo ra một user rồi tự động thêm cho nó 1 đoạn chat default để lựa chọn con bot default. 
