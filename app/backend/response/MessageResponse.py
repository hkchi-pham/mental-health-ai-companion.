from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class MessageBase(SQLModel):
    sender_id: Optional[str] = None
    conversation_id: str
    content: str
    message_type: str

class MessageCreate(MessageBase):
    pass

class MessageRead(MessageBase):
    id: str
    content: str
    message_type: str

    
class MessageResponse(SQLModel):
    id: str
    sender_id: str
    conversation_id: str
    content: str
    message_type: str
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None