from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from config.database import get_db
from backend.crud import GardenDecorationCrud
from backend.response.GardenDecorationResponse import (
    GardenDecorationCreate,
    GardenDecorationUpdate,
    GardenDecorationRead,
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
    prefix="/garden/decorations",
    tags=["garden-decorations"],
)


# READ ALL — empty list is valid (200, not 404)
@router.get(
    "/",
    response_model=PaginatedResponse[GardenDecorationRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def get_garden_decorations(
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        result = GardenDecorationCrud.get_decorations(session, current_user.id)
        return PaginatedResponse[GardenDecorationRead](
            message=MessageCode.GET_GARDEN_DECORATION_SUCCESSFULLY.value,
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
            detail=MessageCode.GET_GARDEN_DECORATION_FAILED.value,
        )


# CREATE (idempotent upsert) — echoes the full saved object
@router.post(
    "/",
    response_model=SuccessResponse[GardenDecorationRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def create_garden_decoration(
    data: GardenDecorationCreate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        # JWT user_id wins — never trust client-supplied user_id.
        data.user_id = current_user.id
        deco = GardenDecorationCrud.create_decoration(session, current_user.id, data)
        return SuccessResponse[GardenDecorationRead](
            message=MessageCode.CREATE_GARDEN_DECORATION_SUCCESSFULLY.value,
            data=deco,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.CREATE_GARDEN_DECORATION_FAILED.value,
        )


# UPDATE (partial move/update)
@router.put(
    "/{deco_id}",
    response_model=SuccessResponse[GardenDecorationRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def update_garden_decoration(
    deco_id: str,
    data: GardenDecorationUpdate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        deco = GardenDecorationCrud.update_decoration(session, current_user.id, deco_id, data)
        if deco is None:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_DECORATION_NOT_FOUND.value,
            )
        return SuccessResponse[GardenDecorationRead](
            message=MessageCode.UPDATE_GARDEN_DECORATION_SUCCESSFULLY.value,
            data=deco,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.UPDATE_GARDEN_DECORATION_FAILED.value,
        )


# DELETE (soft-delete)
@router.delete(
    "/{deco_id}",
    response_model=SuccessResponse,
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def delete_garden_decoration(
    deco_id: str,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    try:
        ok = GardenDecorationCrud.delete_decoration(session, current_user.id, deco_id)
        if not ok:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_DECORATION_NOT_FOUND.value,
            )
        return SuccessResponse(message=MessageCode.DELETE_GARDEN_DECORATION_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.DELETE_GARDEN_DECORATION_FAILED.value,
        )
