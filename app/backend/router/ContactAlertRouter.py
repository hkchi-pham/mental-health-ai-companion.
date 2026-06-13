from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List, Optional
from config.database import get_db
from backend.crud import ContactAlertCrud
from backend.response.ContactAlertResponse import (
    ContactAlertCreate,
    ContactAlertRead,
    ContactAlertUpdate,
    ContactAlertResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel
router = APIRouter(
    prefix="/contact_alerts", 
    tags=["contact_alerts"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_contact_alert(data: ContactAlertCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        print("create contact alert")
        data.user_id = current_user.id
        contact_alert = ContactAlertCrud.create_contact_alert(session, data)
        print("created contact alert")
        return SuccessResponse(message=MessageCode.CREATE_CONTACT_ALERT_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/search-all-contact-alerts",
            response_model=PaginatedResponse[ContactAlertResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_contact_alerts(
    session: Session = Depends(get_db),
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    contact_name: Optional[str]= None,
    contact_relation: Optional[str]= None,
    contact_phone: Optional[str]= None,
    contact_email: Optional[str]= None,
    is_active: Optional[bool]= None,
    created_time: Optional[datetime]= None,
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
    
):
    try:
        print("search contact alerts")
        results = ContactAlertCrud.search_contact_alerts(
            session=session,
            user_id=current_user.id,
            q=q,
            contact_name=contact_name,
            contact_relation=contact_relation,
            contact_phone=contact_phone,
            contact_email=contact_email,
            is_active=is_active,
            created_time=created_time,
            page=page,
            page_size=page_size
        )

        if not results:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        
        return PaginatedResponse[ContactAlertRead](
            message=MessageCode.GET_CONTACT_ALERT_SUCCESSFULLY.value,
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
            response_model=PaginatedResponse[ContactAlertRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_contact_alert(session: Session = Depends(get_db),current_user: UserModel = Depends(get_current_user),):
    try:
        result =  ContactAlertCrud.get_all_contact_alerts(session,current_user.id,page=1,page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        return PaginatedResponse[ContactAlertRead](
            message=MessageCode.GET_CONTACT_ALERT_SUCCESSFULLY.value,
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
@router.get("/{contact_alert_id}", 
            response_model=SuccessResponse[ContactAlertResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_contact_alert(contact_alert_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        result = ContactAlertCrud.get_contact_alert_by_id(session, current_user.id,contact_alert_id)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        return SuccessResponse[ContactAlertResponse](
            message=MessageCode.GET_CONTACT_ALERT_SUCCESSFULLY.value,
            data = result
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))





# UPDATE
@router.put("/{contact_alert_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_contact_alert(contact_alert_id: str, data: ContactAlertUpdate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        contact_alert = ContactAlertCrud.update_contact_alert(session,current_user.id,contact_alert_id,data)
        if not contact_alert:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.UPDATE_CONTACT_ALERT_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# DELETE
@router.delete("/{contact_alert_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_contact_alert(contact_alert_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        success = ContactAlertCrud.delete_contact_alert(session,current_user.id, contact_alert_id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.CONTACT_ALERT_NOT_FOUND)
        return SuccessResponse(message=MessageCode.DELETE_CONTACT_ALERT_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
