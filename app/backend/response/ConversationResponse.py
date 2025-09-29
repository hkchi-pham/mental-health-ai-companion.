from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class ConversationBase(SQLModel):
    user_id: str
    persona: str
    ended_at: Optional[datetime] = None

class ConversationCreate(ConversationBase):
    pass

class ConversationRead(ConversationBase):
    id: str
    started_at: datetime
    ended_at: Optional[datetime] = None

class ConversationUpdate(SQLModel):
    persona: Optional[str] = None
    ended_at: Optional[datetime] = None

class ConversationResponse(SQLModel):
    id: str
    user_id: str
    persona: str
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[datetime] = None
    updated_by: Optional[datetime] = None