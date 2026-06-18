from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from config.database import get_db
from backend.crud import GardenItemCrud
from backend.response.GardenItemResponse import (
    GardenItemCreate,
    GardenItemUpdate,
    GardenItemWater,
    GardenItemRead,
)
from backend.response.CommonResponse import (
    SuccessResponse,
    PaginatedResponse,
    ErrorResponse,
    MessageCode,
)
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel

router = APIRouter(
    prefix="/garden/items",
    tags=["garden-items"],
)


# READ ALL — empty list is valid (200, not 404)
@router.get(
    "/",
    response_model=PaginatedResponse[GardenItemRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def get_garden_items(
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        result = GardenItemCrud.get_items(session, current_user.id)
        return PaginatedResponse[GardenItemRead](
            message=MessageCode.GET_GARDEN_ITEM_SUCCESSFULLY.value,
            data=result,
            total=len(result),
            page=1,
            page_size=len(result),
            total_pages=1 if result else 0,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.GET_GARDEN_ITEM_FAILED.value,
        )


# CREATE (idempotent upsert) — echoes the full saved object
@router.post(
    "/",
    response_model=SuccessResponse[GardenItemRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def create_garden_item(
    data: GardenItemCreate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        # JWT user_id wins — never trust client-supplied user_id.
        data.user_id = current_user.id
        item = GardenItemCrud.create_item(session, current_user.id, data)
        return SuccessResponse[GardenItemRead](
            message=MessageCode.CREATE_GARDEN_ITEM_SUCCESSFULLY.value,
            data=item,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.CREATE_GARDEN_ITEM_FAILED.value,
        )


# UPDATE (partial move/update)
@router.put(
    "/{item_id}",
    response_model=SuccessResponse[GardenItemRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def update_garden_item(
    item_id: str,
    data: GardenItemUpdate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        item = GardenItemCrud.update_item(session, current_user.id, item_id, data)
        if item is None:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_ITEM_NOT_FOUND.value,
            )
        return SuccessResponse[GardenItemRead](
            message=MessageCode.UPDATE_GARDEN_ITEM_SUCCESSFULLY.value,
            data=item,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.UPDATE_GARDEN_ITEM_FAILED.value,
        )


# WATER — persists client-computed state, echoes full object
@router.post(
    "/{item_id}/water",
    response_model=SuccessResponse[GardenItemRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def water_garden_item(
    item_id: str,
    data: GardenItemWater,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        item = GardenItemCrud.water_item(session, current_user.id, item_id, data)
        if item is None:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_ITEM_NOT_FOUND.value,
            )
        return SuccessResponse[GardenItemRead](
            message=MessageCode.WATER_GARDEN_ITEM_SUCCESSFULLY.value,
            data=item,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.WATER_GARDEN_ITEM_FAILED.value,
        )


# DELETE (soft-delete)
@router.delete(
    "/{item_id}",
    response_model=SuccessResponse,
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def delete_garden_item(
    item_id: str,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        ok = GardenItemCrud.delete_item(session, current_user.id, item_id)
        if not ok:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_ITEM_NOT_FOUND.value,
            )
        return SuccessResponse(message=MessageCode.DELETE_GARDEN_ITEM_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.DELETE_GARDEN_ITEM_FAILED.value,
        )
