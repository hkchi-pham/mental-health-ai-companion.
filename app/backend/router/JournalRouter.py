from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.crud import JournalCrud
from backend.response.JournalResponse import (
    JournalCreate,
    JournalRead,
    JournalUpdate,
    JournalResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/journals", 
    tags=["journals"])


# CREATE
@router.post("/", 
             response_model=JournalCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_journal(data: JournalCreate, session: Session = Depends(get_db)):
    try:
        journal = JournalCrud.create_journal(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_JOURNAL_FAILED.value)


# READ ALL
@router.get("/", 
            response_model=List[JournalRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_journal(session: Session = Depends(get_db)):
    try:
        result =  JournalCrud.get_all_journals(session,page=1,page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_JOURNAL_FAILED.value)


# READ ONE
@router.get("/{journal_id}", 
            response_model=JournalResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_journal(journal_id: str, session: Session = Depends(get_db)):
    try: 
        conv = JournalCrud.get_journal_by_id(session, journal_id)
        if not conv:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_JOURNAL_FAILED.value)
        
                        


# UPDATE
@router.put("/{journal_id}",
             response_model=SuccessResponse[JournalRead],
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_journal(journal_id: str, data: JournalUpdate, session: Session = Depends(get_db)):
    try: 
        journal = JournalCrud.update_journal(session,journal_id,data,)
        if not journal:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_JOURNAL_FAILED.value)


# DELETE
@router.delete("/{journal_id}", 
               response_model=SuccessResponse[None],
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_journal(journal_id: str, session: Session = Depends(get_db)):
    try: 
        success = JournalCrud.delete_journal(session, journal_id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_JOURNAL_FAILED.value)
