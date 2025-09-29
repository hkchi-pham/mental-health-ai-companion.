from sqlmodel import SQLModel
from datetime import time

class AuthToken(SQLModel):
    access_token: str
    expires_in: time 
    user_name: str
    user_id: str
