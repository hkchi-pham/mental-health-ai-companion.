from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from typing import List
from app.config.database import get_db
from app.crud import ContactAlertLogCrud
from app.response.ContactAlertLogResponse import (
    ContactAlertLogCreate,
    ContactAlertLogRead,
    ContactAlertLogUpdate,
    ContactAlertLogResponse,
)
from app.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/contact_alert_logs", 
    tags=["contact_alert_logs"])


# CREATE
@router.post("/", 
             response_model=ContactAlertLogCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_contact_alert_log(data: ContactAlertLogCreate, session: Session = Depends(get_db)):
    try:
        contact_alert_log = ContactAlertLogCrud.create_contact_alert_log(session, data)
        raise HTTPException(status_code=200, detail=MessageCode.CREATE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_CONTACT_ALERT_LOG_FAILED.value)


# READ ALL
@router.get("/", 
            response_model=List[ContactAlertLogRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_contact_alert_log(session: Session = Depends(get_db)):
    try:
        result =  ContactAlertLogCrud.get_all_contact_alert_logs(session,page=1,page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONTACT_ALERT_LOG_FAILED.value)


# READ ONE
@router.get("/{contact_alert_log_id}", 
            response_model=ContactAlertLogResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_contact_alert_log(contact_alert_log_id: str, session: Session = Depends(get_db)):
    try: 
        conv = ContactAlertLogCrud.get_contact_alert_log_by_id(session, contact_alert_log_id)
        if not conv:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONTACT_ALERT_LOG_FAILED.value)
        
                        


# UPDATE
@router.put("/{contact_alert_log_id}",
             response_model=SuccessResponse[ContactAlertLogRead],
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_contact_alert_log(contact_alert_log_id: str, data: ContactAlertLogUpdate, session: Session = Depends(get_db)):
    try: 
        contact_alert_log = ContactAlertLogCrud.update_contact_alert_log(session,contact_alert_log_id,data,)
        if not contact_alert_log:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.UPDATE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_CONTACT_ALERT_LOG_FAILED.value)


# DELETE
@router.delete("/{contact_alert_log_id}", 
               response_model=SuccessResponse[None],
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_contact_alert_log(contact_alert_log_id: str, session: Session = Depends(get_db)):
    try: 
        success = ContactAlertLogCrud.delete_contact_alert_log(session, contact_alert_log_id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_LOG_NOT_FOUND)
        raise HTTPException(status_code=200, detail=MessageCode.DELETE_CONTACT_ALERT_LOG_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_CONTACT_ALERT_LOG_FAILED.value)
