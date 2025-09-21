from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class ContactAlertLogBase(SQLModel):
    user_id: str
    alert_type: str
    trigger_reason: Optional[str] 
    trigger_data: Optional[dict] 
    status: str 
    sent_at: Optional[datetime] 
    response_at: Optional[datetime]
    response_detail: Optional[str]

class ContactAlertLogCreate(ContactAlertLogBase):
    pass

class ContactAlertLogRead(ContactAlertLogBase):
    id: str
    alert_type: str
    trigger_reason: Optional[str] 
    trigger_data: Optional[dict] 
    status: str 

class ContactAlertLogUpdate(SQLModel):
    trigger_reason: Optional[str] 
    trigger_data: Optional[dict] 
    status: str 

class ContactAlertLogResponse(SQLModel):
    id: str
    user_id: str
    alert_type: str
    trigger_reason: Optional[str] 
    trigger_data: Optional[dict] 
    status: str 
    sent_at: Optional[datetime] 
    response_at: Optional[datetime]
    response_detail: Optional[str]
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





