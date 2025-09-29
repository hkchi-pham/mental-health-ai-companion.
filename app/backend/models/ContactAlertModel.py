from sqlmodel import Field, Relationship, SQLModel, Column, Boolean
from sqlalchemy import CheckConstraint
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4



class ContactAlertModel(BaseModel, table=True):
    __tablename__ = "contact_alerts"

    user_id: str = Field(nullable=False)
    alert_type: str = Field(nullable=False)
    contact_name: str = Field(nullable=False)
    contact_relation: str | None = Field(default=None)
    contact_phone: str | None = Field(default=None)
    contact_email: str | None = Field(default=None)
    is_active: bool = Field(default=True,sa_column=Column(Boolean, nullable=False, server_default="true"))

    
    


#vt tất cả model còn lại
#check init db