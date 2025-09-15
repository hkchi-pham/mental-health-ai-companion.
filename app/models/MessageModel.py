from sqlmodel import Field, Relationship, SQLModel, Column, String
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4

class MessageModel(BaseModel, table=True):
    __tablename__ = "massages"

    conversation_id: str = Field(nullable=False)
    sender_id: str = Field(nullable=False)
    content: str = Field(nullable=False)
    message_type: str = Field(
        default="TEXT",
        sa_column=Column(String(50), nullable=False, server_default="TEXT")
    )

    
    


#vt tất cả model còn lại
#check init db