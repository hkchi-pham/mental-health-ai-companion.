from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List, Optional
from config.database import get_db
from backend.crud import ContactAlertLogCrud
from backend.response.ContactAlertLogResponse import (
    ContactAlertLogCreate,
    ContactAlertLogRead,
    ContactAlertLogUpdate,
    ContactAlertLogResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from datetime import datetime
from backend.security.Authentication import get_current_user 
from backend.models.UserModel import UserModel

router = APIRouter(
    prefix="/contact_alert_logs", 
    tags=["contact_alert_logs"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_contact_alert_log(data: ContactAlertLogCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        data.user_id = current_user.id
        contact_alert_log = ContactAlertLogCrud.create_contact_alert_log(session, data)
        return SuccessResponse(message=MessageCode.CREATE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/search-all-contact-alert-logs",
            response_model=PaginatedResponse[ContactAlertLogResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_contact_alert_logs(
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    trigger_reason: Optional[str]= None,
    trigger_data: Optional[str]= None,
    status: Optional[str]= None,
    sent_at: Optional[str]= None,
    response_at: Optional[str]= None,
    response_detail: Optional[str]= None,
    session: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
):
    try:
        print("search contact alert logs")
        results = ContactAlertLogCrud.search_contact_alert_logs(
            session=session,
            user_id=current_user.id,
            q=q,
            trigger_reason=trigger_reason,
            trigger_data=trigger_data,
            status=status,
            sent_at=sent_at,
            response_at=response_at,
            response_detail=response_detail,
            page=page,
            page_size=page_size
        )

        if not results:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        
        return PaginatedResponse[ContactAlertLogRead](
            message=MessageCode.GET_CONTACT_ALERT_LOG_SUCCESSFULLY.value,
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

# READ ALL
@router.get("/", 
            response_model=PaginatedResponse[ContactAlertLogRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_contact_alert_log(session: Session = Depends(get_db),current_user: UserModel = Depends(get_current_user),):
    try:
        result =  ContactAlertLogCrud.get_all_contact_alert_logs(session,current_user.id,page=1,page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        return PaginatedResponse[ContactAlertLogRead](
            message=MessageCode.GET_CONTACT_ALERT_LOG_SUCCESSFULLY.value,
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


# READ ONE
@router.get("/{contact_alert_log_id}", 
            response_model=ContactAlertLogResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_contact_alert_log(contact_alert_log_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        conv = ContactAlertLogCrud.get_contact_alert_log_by_id(session,current_user.id, contact_alert_log_id)
        if not conv:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.GET_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
            


# UPDATE
@router.put("/{contact_alert_log_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_contact_alert_log(contact_alert_log_id: str, data: ContactAlertLogUpdate, current_user: UserModel = Depends(get_current_user),session: Session = Depends(get_db)):
    try: 
        contact_alert_log = ContactAlertLogCrud.update_contact_alert_log(session,current_user.id,contact_alert_log_id,data)
        if not contact_alert_log:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.UPDATE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# DELETE
@router.delete("/{contact_alert_log_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_contact_alert_log(contact_alert_log_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        success = ContactAlertLogCrud.delete_contact_alert_log(session,current_user.id, contact_alert_log_id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND)
        return SuccessResponse(message=MessageCode.DELETE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
