from sqlmodel import SQLModel
from datetime import time
from typing import Optional

class AuthToken(SQLModel):
    access_token: str
    expires_in: int
    user_name: str
    user_id: str


class TokenData(SQLModel):
    username: Optional[str] = None
    user_id: Optional[str] = None


class PasswordChange(SQLModel):
    old_password: str
    new_password: str
