from sqlmodel import SQLModel, Field
from typing import Optional
from datetime import date, datetime

class UserBase(SQLModel): #common field shared across schema
    fullname: str
    user_name: str
    dob: Optional[date] = None
    gender: Optional[bool] = None
    email: str
    phone: str
    address: Optional[str] = None
    avatar: Optional[str] = None 

class UserCreate(UserBase): # create new user
    email: str
    password: str
    
class UserLogin(SQLModel):
    user_name: str
    password: str
    
class UserRead(UserBase): # read user from DB
    id: str
    

class UserResponse(SQLModel): # schema for what you send back to client
    id: str
    fullname: Optional[str] = None
    user_name: Optional[str] = None
    dob: Optional[date] = None
    gender: Optional[bool] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    address: Optional[str] = None
    avatar: Optional[str] = None
    created_at: Optional[datetime] = None
    created_by: Optional[str] = None
    
class UserUpdate(SQLModel): # schema for updating user's data
    fullname: Optional[str] = None
    user_name: Optional[str] = None
    dob: Optional[date] = None
    gender: Optional[bool] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    address: Optional[str] = None
    avatar: Optional[str] = None

    password: Optional[str] = None
