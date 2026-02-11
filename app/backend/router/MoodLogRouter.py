from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.crud import MoodLogCrud
from backend.response.MoodLogResponse import (
    MoodLogCreate,
    MoodLogRead,
    MoodLogUpdate,
    MoodLogResponse,
)
from backend.models.UserModel import UserModel
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from typing import Optional
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel

router = APIRouter(
    prefix="/mood_logs", 
    tags=["mood_logs"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_mood_log(data: MoodLogCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        data.user_id = current_user.id
        mood_log = MoodLogCrud.create_mood_log(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/search-all-mood-logs",
            response_model=PaginatedResponse[MoodLogResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_mood_logs(
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    convo_id: Optional[str]= None,
    created_time: Optional[datetime]= None,
    session: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
):
    try:
        print("search mood logs")
        results = MoodLogCrud.search_mood_logs(
            session=session,
            q=q,
            user_id=current_user.id,
            convo_id=convo_id,
            created_time=created_time,
            page=page,
            page_size=page_size
        )

        if not results:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        
        return PaginatedResponse[MoodLogResponse](
            message=MessageCode.GET_MOOD_LOG_SUCCESSFULLY.value,
            data=results["items"],
            total=results["total"],
            page=results["page"],
            page_size=results["page_size"],
            total_pages=results["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# READ ALL
@router.get("/", 
            response_model=PaginatedResponse[MoodLogRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_mood_log(session: Session = Depends(get_db), current_user: UserModel = Depends(get_current_user),):
    try:
        result =  MoodLogCrud.get_all_mood_logs(session,user_id=current_user.id, page=1,page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return PaginatedResponse[MoodLogResponse](
            message=MessageCode.GET_MOOD_LOG_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# READ ONE
@router.get("/{mood_log_id}", 
            response_model=SuccessResponse[MoodLogResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_mood_log(mood_log_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        result = MoodLogCrud.get_mood_log_by_id(session, mood_log_id,current_user.id)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return SuccessResponse[MoodLogResponse](
            message = MessageCode.GET_MOOD_LOG_SUCCESSFULLY.value,
            data = result
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
                        


# UPDATE
@router.put("/{mood_log_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_mood_log(mood_log_id: str, data: MoodLogUpdate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        mood_log = MoodLogCrud.update_mood_log(session,mood_log_id,current_user.id,data)
        if not mood_log:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# DELETE
@router.delete("/{mood_log_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_mood_log(mood_log_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        print("delete mood log")
        success = MoodLogCrud.delete_mood_log(session, mood_log_id,current_user.id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
