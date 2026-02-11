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

class JournalCreate(JournalBase):
    pass

class JournalRead(JournalBase):
    id: str
    title: str
    emoji: str
    content:str
    visibility: str

class JournalUpdate(SQLModel):
    title: str
    emoji: str
    visibility: str

class JournalPageUpdate(SQLModel):
    content: str

class JournalResponse(SQLModel):
    id: str
    user_id: str
    title: str
    page: Dict = Field(default_factory=dict, sa_column=Column(JSON))
    content: str
    visibility: str
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





