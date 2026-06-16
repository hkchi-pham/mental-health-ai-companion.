from sqlmodel import Field, Column, String
from sqlalchemy import CheckConstraint, JSON
from typing import Optional, Any, Dict, List
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4



class JournalModel(BaseModel, table=True):
    __tablename__ = "journals"

    user_id: str = Field(nullable=False)
    title: str = Field(nullable=False)
    emoji: str = Field(nullable=True)
    page: List[Any] = Field(default=[], sa_column=Column(JSON))
    content: str = Field(nullable=False)
    visibility: str = Field(
        sa_column=Column(
            String,
            CheckConstraint("visibility IN ('private','public')"),
            nullable=False,
        )
    )
    
    


#vt tất cả model còn lại
#check init db