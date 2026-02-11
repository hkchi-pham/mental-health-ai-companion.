from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List, Optional, Any
from config.database import get_db
from backend.crud import JournalCrud
from backend.response.JournalResponse import (
    JournalCreate,
    JournalRead,
    JournalUpdate,
    JournalResponse,
    JournalPageUpdate
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel
router = APIRouter(
    prefix="/journals", 
    tags=["journals"])


# CREATE
@router.post("/", responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_journal(data: JournalCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        data.user_id = current_user.id
        journal = JournalCrud.create_journal(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/search-all-journals",
            response_model=PaginatedResponse[JournalResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_journals(
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    visibility: Optional[str]= None,
    created_time: Optional[datetime]= None,
    session: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
):
    try:
        print("search journals")
        results = JournalCrud.search_journals(
            session=session,
            q=q,
            user_id=current_user.id,
            visibility=visibility,
            created_time=created_time,
            page=page,
            page_size=page_size
        )

        if not results:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        
        return PaginatedResponse[JournalResponse](
            message=MessageCode.GET_JOURNAL_SUCCESSFULLY.value,
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
            response_model=PaginatedResponse[JournalResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_journal(session: Session = Depends(get_db),current_user: UserModel = Depends(get_current_user),):
    try:
        result =  JournalCrud.get_all_journals(session,current_user.id,page=1,page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return PaginatedResponse[JournalResponse](
            message=MessageCode.GET_JOURNAL_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# READ ONE
@router.get("/{journal_id}", 
            response_model=SuccessResponse[JournalResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_journal(journal_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        journal = JournalCrud.get_journal_by_id(session,current_user.id, journal_id)
        if not journal:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return SuccessResponse[JournalResponse](
            message = MessageCode.GET_JOURNAL_SUCCESSFULLY.value,
            data=journal
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))





# UPDATE
@router.put("/{journal_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_journal(journal_id: str, data: JournalUpdate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        print("update journal")
        journal = JournalCrud.update_journal(session,current_user.id,journal_id,data)
        print(journal)
        if not journal:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

#UPDATE PAGE
@router.post("/{journal_id}/page/entry")
def update_journal_page(
    journal_id: str,
    data: JournalPageUpdate,
    current_user: UserModel = Depends(get_current_user),
    session: Session = Depends(get_db)
):
    try:
        journal = JournalCrud.update_journal_page(session=session, user_id=current_user.id, journal_id=journal_id,data=data)
        if not journal:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# DELETE
@router.delete("/{journal_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_journal(journal_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        success = JournalCrud.delete_journal(session,current_user.id, journal_id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.JOURNAL_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_JOURNAL_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
