from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from config.database import get_db
from backend.crud import GardenBadgeCrud
from backend.response.GardenBadgeResponse import (
    GardenBadgeCreate,
    GardenBadgeTrade,
    GardenBadgeRead,
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
    prefix="/garden/badges",
    tags=["garden-badges"],
)


# LIST
@router.get(
    "/",
    response_model=PaginatedResponse[GardenBadgeRead],
    responses={500: {"model": ErrorResponse}},
)
def list_garden_badges(
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    """Return all non-deleted badges for the authenticated user.
    An empty list is a valid 200 — not a 404.
    """
    try:
        result = GardenBadgeCrud.get_badges(session, current_user.id)
        return PaginatedResponse[GardenBadgeRead](
            message=MessageCode.GET_GARDEN_BADGE_SUCCESSFULLY.value,
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
            detail=MessageCode.GET_GARDEN_BADGE_FAILED.value,
        )


# CREATE / UPSERT
@router.post(
    "/",
    response_model=SuccessResponse[GardenBadgeRead],
    responses={500: {"model": ErrorResponse}},
)
def create_garden_badge(
    data: GardenBadgeCreate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    """Persist an earned badge.  Upserts if the client-supplied id already exists
    so the offline queue can replay safely without generating duplicates.
    Echoes the full saved object in data.
    """
    try:
        data.user_id = current_user.id
        badge = GardenBadgeCrud.create_badge(session, current_user.id, data)
        return SuccessResponse[GardenBadgeRead](
            message=MessageCode.CREATE_GARDEN_BADGE_SUCCESSFULLY.value,
            data=badge,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.CREATE_GARDEN_BADGE_FAILED.value,
        )


# TRADE
@router.post(
    "/{badge_id}/trade",
    response_model=SuccessResponse[GardenBadgeRead],
    responses={
        400: {"model": ErrorResponse},
        404: {"model": ErrorResponse},
        500: {"model": ErrorResponse},
    },
)
def trade_garden_badge(
    badge_id: str,
    data: GardenBadgeTrade,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db),
):
    """Mark a badge as traded with the chosen trade_type (water|seeds).
    Returns 404 when badge not found, 400 when already traded.
    Currency credit is applied separately by the client via PUT /users/me/currency.
    """
    try:
        badge, status_ = GardenBadgeCrud.trade_badge(
            session, current_user.id, badge_id, data
        )
        if status_ == "not_found":
            raise HTTPException(
                status_code=404,
                detail=MessageCode.GARDEN_BADGE_NOT_FOUND.value,
            )
        if status_ == "already_traded":
            raise HTTPException(
                status_code=400,
                detail=MessageCode.GARDEN_BADGE_ALREADY_TRADED.value,
            )
        return SuccessResponse[GardenBadgeRead](
            message=MessageCode.TRADE_GARDEN_BADGE_SUCCESSFULLY.value,
            data=badge,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.TRADE_GARDEN_BADGE_FAILED.value,
        )
