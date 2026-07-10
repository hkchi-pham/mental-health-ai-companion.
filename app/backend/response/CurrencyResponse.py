from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime


class CurrencyUpdate(SQLModel):
    """Authoritative balances sent by the client (absolute set — both fields required)."""
    points: int
    water_units: int


class MeRead(SQLModel):
    """Current-user payload returned by GET /users/me. No hashed_password."""
    id: str
    user_name: str
    fullname: str
    email: Optional[str] = None
    avatar: Optional[str] = None
    points: int
    water_units: int
    tree_grown: int
    created_at: Optional[datetime] = None
    journal_count: int = 0
    conversation_count: int = 0
    badge_count: int = 0
