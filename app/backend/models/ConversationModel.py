from sqlmodel import Field, Relationship, SQLModel
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from backend.utils import get_current_time
from .BaseModel import BaseModel
from uuid import uuid4



class ConversationModel(BaseModel, table=True):
    __tablename__ = "conversations"

    user_id: str = Field(nullable=False)
    persona: str = Field(nullable=False)
    ended_at: Optional[str] = Field(default_factory=get_current_time)


#vt tất cả model còn lại
#check init db