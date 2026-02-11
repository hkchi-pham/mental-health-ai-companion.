from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class ContactAlertBase(SQLModel):
    user_id: str
    alert_type: str
    contact_name: str 
    contact_relation: Optional[str]
    contact_phone: Optional[str]
    contact_email: Optional[str]
    is_active: bool

class ContactAlertCreate(ContactAlertBase):
    pass

class ContactAlertRead(ContactAlertBase):
    id: str
    alert_type: str
    contact_name: str 
    contact_relation: Optional[str]
    contact_phone: Optional[str]
    contact_email: Optional[str]
    is_active: bool

class ContactAlertUpdate(SQLModel):
    contact_relation: Optional[str]
    contact_phone: Optional[str]
    contact_email: Optional[str]

class ContactAlertResponse(SQLModel):
    id: str
    user_id: str
    alert_type: str
    contact_name: str 
    contact_relation: Optional[str]
    contact_phone: Optional[str]
    contact_email: Optional[str]
    is_active: bool
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





