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
    hashed_password: str = Field(nullable=False, max_length=128)
    phone: str = Field(nullable=False, max_length=128)
    address: Optional[str] = Field(nullable=True,max_length=256)
    avatar: str = Field(nullable=False, max_length=256)

    def __repr__(self):
        return f"<UserModel(id={self.id}, fullname={self.fullname}, user_name={self.user_name}, email={self.email}, phone={self.phone}, address={self.address}, avatar={self.avatar})>"

#vt tất cả model còn lại
#check init db