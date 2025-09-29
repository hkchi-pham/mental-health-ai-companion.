from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from typing import List
from app.config.database import get_db
from app.crud import ContactAlertCrud
from app.response.ContactAlertResponse import (
    ContactAlertCreate,
    ContactAlertRead,
    ContactAlertUpdate,
    ContactAlertResponse,
)
from app.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/contact_alerts", 
    tags=["contact_alerts"])


# CREATE
@router.post("/", 
             response_model=ContactAlertCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_contact_alert(data: ContactAlertCreate, session: Session = Depends(get_db)):
    try:
        contact_alert = ContactAlertCrud.create_contact_alert(session, data)
        raise HTTPException(status_code=200, detail=MessageCode.CREATE_CONTACT_ALERT_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_CONTACT_ALERT_FAILED.value)


# READ ALL
@router.get("/", 
            response_model=List[ContactAlertRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_contact_alert(session: Session = Depends(get_db)):
    try:
        result =  ContactAlertCrud.get_all_contact_alerts(session,page=1,page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONTACT_ALERT_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONTACT_ALERT_FAILED.value)


# READ ONE
@router.get("/{contact_alert_id}", 
            response_model=ContactAlertResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_contact_alert(contact_alert_id: str, session: Session = Depends(get_db)):
    try: 
        conv = ContactAlertCrud.get_contact_alert_by_id(session, contact_alert_id)
        if not conv:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONTACT_ALERT_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONTACT_ALERT_FAILED.value)
        
                        


# UPDATE
@router.put("/{contact_alert_id}",
             response_model=SuccessResponse[ContactAlertRead],
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_contact_alert(contact_alert_id: str, data: ContactAlertUpdate, session: Session = Depends(get_db)):
    try: 
        contact_alert = ContactAlertCrud.update_contact_alert(session,contact_alert_id,data,)
        if not contact_alert:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.UPDATE_CONTACT_ALERT_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_CONTACT_ALERT_FAILED.value)


# DELETE
@router.delete("/{contact_alert_id}", 
               response_model=SuccessResponse[None],
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_contact_alert(contact_alert_id: str, session: Session = Depends(get_db)):
    try: 
        success = ContactAlertCrud.delete_contact_alert(session, contact_alert_id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND)
        raise HTTPException(status_code=200, detail=MessageCode.DELETE_CONTACT_ALERT_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_CONTACT_ALERT_FAILED.value)
