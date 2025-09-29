from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class MoodLogBase(SQLModel):
    user_id: str
    conversation_id: str
    mood: str
    note: str

class MoodLogCreate(MoodLogBase):
    pass

class MoodLogRead(MoodLogBase):
    id: str
    mood: str
    note: str

class MoodLogUpdate(SQLModel):
    mood: str
    note: str

class MoodLogResponse(SQLModel):
    id: str
    user_id: str
    conversation_id: str
    mood: str
    note: str
    created_at: str
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None