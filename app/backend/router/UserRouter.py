from fastapi import APIRouter, HTTPException, Depends, Body, Query
from sqlmodel import Session
from typing import Optional
from app.config.database import get_db
from app.response.UserResponse import UserCreate, UserUpdate, UserResponse
from app.response.CommonResponse import SuccessResponse, PaginatedResponse, ErrorResponse, MessageCode
from app.crud import UserCrud as crud

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

@router.post("/", 
             response_model=SuccessResponse[UserResponse], 
             responses={500: {"model": ErrorResponse}}
             # dependencies=[Depends(KiemTraQuyen("quan_ly_co_so_them"))]
            )
def create_user(
    data: UserCreate = Body(...),
    db: Session = Depends(get_db)
):
    try:
        result = crud.create_user(db, data)
        # return SuccessResponse[UserResponse](message="Tạo cơ sở thành công", data=result)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_USER_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_USER_FAILED.value)

@router.get("/", 
            response_model=PaginatedResponse[UserResponse], 
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
        if not result or not result["items"]:
            raise HTTPException(status_code=404, detail="Không tìm thấy cơ sở nào")
        return PaginatedResponse[UserResponse](
            message="Lấy danh sách cơ sở thành công",
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi khi lấy danh sách cơ sở: {str(e)}")

@router.put("/{user_id}", response_model=SuccessResponse[UserResponse], 
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}
            # dependencies=[Depends(KiemTraQuyen("quan_ly_co_so_sua"))]
        )
def update_user(
    user_id: str,
    data: UserUpdate = Body(...),
    db: Session = Depends(get_db)
):
    try:
        result = crud.update_user(db, user_id, data)
        if not result:
            raise HTTPException(status_code=404, detail="Cơ sở không tồn tại")
        # return SuccessResponse[CoSoResponse](message="Cập nhật cơ sở thành công", data=result)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_USER_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_USER_FAILED.value)

@router.delete("/{user_id}", 
               response_model=SuccessResponse[dict], 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}}
               # dependencies=[Depends(KiemTraQuyen("quan_ly_co_so_xoa"))]
            )
def delete_user(user_id: str, db: Session = Depends(get_db)):
    try:
        result = crud.delete_user(db, user_id)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        # return SuccessResponse[dict](message="Xoá cơ sở thành công", data=None)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_USER_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_USER_FAILED.value)
