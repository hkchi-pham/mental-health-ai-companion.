from sqlmodel import Field, Relationship, SQLModel
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel



class MoodLogModel(BaseModel, table=True):
    __tablename__ = "mood_logs"

    user_id: str = Field(nullable=False)
    conversation_id: str = Field(nullable=False)
    mood: str = Field(nullable=False)
    note: Optional[str] = Field(default=None)
    
    


#vt tất cả model còn lại
#check init db