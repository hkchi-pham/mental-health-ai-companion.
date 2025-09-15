from sqlmodel import Field, Relationship, SQLModel
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel
from uuid import uuid4


class UserModel(BaseModel, table=True):
    __tablename__ = "users"

    fullname: str = Field(nullable=False,max_length=128)
    user_name: str = Field(nullable=False, max_length=128)
    dob: Optional[datetime] = None
    gender: Optional[bool] = None
    email: str = Field(nullable=False,max_length=128)
    password: str = Field(nullable=False, max_length=128)
    phone: str = Field(nullable=False, max_length=128)
    address: Optional[str] = Field(nullable=True,max_length=256)
    avatar: str = Field(nullable=False, max_length=256)

#vt tất cả model còn lại
#check init db