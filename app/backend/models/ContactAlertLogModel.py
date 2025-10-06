from sqlmodel import Field, Relationship, SQLModel, Column, Boolean, String
from sqlalchemy import CheckConstraint, JSON
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4



class ContactAlertLogModel(BaseModel, table=True):
    __tablename__ = "contact_alert_logs"

    user_id: str = Field(nullable=False)
    alert_id: str = Field(nullable=False)
    trigger_reason: Optional[str] = Field(default=None,nullable=True)
    trigger_data: Optional[dict] = Field(default=None, sa_column=Column(JSON, nullable=True))
    status: str = Field(default="PENDING",sa_column=Column(String(50), nullable=False, server_default="PENDING"))
    sent_at: Optional[datetime] = Field(default=None, nullable=True)
    response_at: Optional[datetime] = Field(default=None, nullable=True)
    response_detail: Optional[str] = Field(default=None, nullable=True)
    
    


#vt tất cả model còn lại
#check init db