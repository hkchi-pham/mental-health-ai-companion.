from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class JournalBase(SQLModel):
    user_id: str
    content: str
    visibility: str

class JournalCreate(JournalBase):
    pass

class JournalRead(JournalBase):
    id: str
    content:str
    visibility: str

class JournalUpdate(SQLModel):
    content: str
    visibility: str

class JournalResponse(SQLModel):
    id: str
    user_id: str
    content: str
    visibility: str
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





