from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from config.database import get_db
from backend.crud import CurrencyCrud
from backend.response.CurrencyResponse import CurrencyUpdate, MeRead
from backend.response.CommonResponse import SuccessResponse, ErrorResponse, MessageCode
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel

# NOTE on route ordering / collision:
# FastAPI/Starlette match routes in REGISTRATION ORDER, not by specificity.
# Plan 06 registers this router's include_router line STRICTLY BEFORE the legacy
# UserRouter so that GET /users/me is matched here (prefix "/users", path "/me")
# and NOT captured by UserRouter's /{user_name} wildcard.
router = APIRouter(prefix="/users", tags=["users-me"])


@router.get(
    "/me",
    response_model=SuccessResponse[MeRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def get_me(
    current_user: UserModel = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Return the authenticated user's identity + currency fields."""
    try:
        user = CurrencyCrud.get_me(db, current_user.id)
        if user is None:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.USER_NOT_FOUND.value,
            )
        return SuccessResponse(
            message=MessageCode.GET_CURRENCY_SUCCESSFULLY.value,
            data=user,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.GET_CURRENCY_FAILED.value,
        )


@router.put(
    "/me/currency",
    response_model=SuccessResponse[MeRead],
    responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}},
)
def update_currency(
    data: CurrencyUpdate,
    current_user: UserModel = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Absolute-set the authenticated user's points and water_units.

    Both fields are required and the entire balance is overwritten — no
    add/subtract math — so the offline queue can replay this call safely.
    """
    try:
        user = CurrencyCrud.set_currency(db, current_user.id, data)
        if user is None:
            raise HTTPException(
                status_code=404,
                detail=MessageCode.USER_NOT_FOUND.value,
            )
        return SuccessResponse(
            message=MessageCode.UPDATE_CURRENCY_SUCCESSFULLY.value,
            data=user,
        )
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=500,
            detail=MessageCode.UPDATE_CURRENCY_FAILED.value,
        )
