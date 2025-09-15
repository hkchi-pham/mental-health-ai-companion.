from sqlmodel import Field, Relationship, SQLModel, Column, String
from sqlalchemy import CheckConstraint
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4



class JournalModel(BaseModel, table=True):
    __tablename__ = "journals"

    user_id: str = Field(nullable=False)
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