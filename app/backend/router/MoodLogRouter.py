from fastapi import APIRouter, Depends, HTTPException
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
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/mood_logs", 
    tags=["mood_logs"])


# CREATE
@router.post("/", 
             response_model=MoodLogCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_mood_log(data: MoodLogCreate, session: Session = Depends(get_db)):
    try:
        mood_log = MoodLogCrud.create_mood_log(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_MOOD_LOG_FAILED.value)


# READ ALL
@router.get("/", 
            response_model=List[MoodLogRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_mood_log(session: Session = Depends(get_db)):
    try:
        result =  MoodLogCrud.get_all_mood_logs(session,page=1,page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_MOOD_LOG_FAILED.value)


# READ ONE
@router.get("/{mood_log_id}", 
            response_model=MoodLogResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_mood_log(mood_log_id: str, session: Session = Depends(get_db)):
    try: 
        conv = MoodLogCrud.get_mood_log_by_id(session, mood_log_id)
        if not conv:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_MOOD_LOG_FAILED.value)
        
                        


# UPDATE
@router.put("/{mood_log_id}",
             response_model=SuccessResponse[MoodLogRead],
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_mood_log(mood_log_id: str, data: MoodLogUpdate, session: Session = Depends(get_db)):
    try: 
        mood_log = MoodLogCrud.update_mood_log(session,mood_log_id,data,)
        if not mood_log:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_MOOD_LOG_FAILED.value)


# DELETE
@router.delete("/{mood_log_id}", 
               response_model=SuccessResponse[None],
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_mood_log(mood_log_id: str, session: Session = Depends(get_db)):
    try: 
        success = MoodLogCrud.delete_mood_log(session, mood_log_id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.MOOD_LOG_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_MOOD_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_MOOD_LOG_FAILED.value)
