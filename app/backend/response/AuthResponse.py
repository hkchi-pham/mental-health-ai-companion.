from sqlmodel import SQLModel
from datetime import time
from typing import Optional

class AuthToken(SQLModel):
    access_token: str
    expires_in: time 
    user_name: str
    user_id: str


class TokenData(SQLModel):
    username: Optional[str] = None
    user_id: Optional[str] = None
