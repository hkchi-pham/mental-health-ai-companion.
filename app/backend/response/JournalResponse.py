from sqlmodel import SQLModel, Field
from sqlalchemy import Column
from sqlalchemy.types import JSON
from typing import Optional, Dict
from datetime import datetime

class JournalBase(SQLModel):
    user_id: str
    title: str
    emoji: str
    page: Dict = Field(default_factory=dict, sa_column=Column(JSON))
    content: str
    visibility: str
    color: Optional[str] = "green"

class JournalCreate(JournalBase):
    pass

class JournalRead(JournalBase):
    id: str
    title: str
    emoji: str
    content:str
    page: Dict
    visibility: str

class JournalUpdate(SQLModel):
    title: str
    emoji: str
    visibility: str
    color: str

class JournalPageUpdate(SQLModel):
    id: Optional[str] = None
    content: str

class JournalPageReplace(SQLModel):
    page: Dict

class JournalResponse(SQLModel):
    id: str
    user_id: str
    title: str
    emoji: str
    page: Dict
    content: str
    visibility: str
    color: Optional[str] = "green"
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





