from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime


class GardenBadgeBase(SQLModel):
    user_id: str
    tree_type: str
    stage: int
    earned_at: Optional[datetime] = None
    traded: bool = False
    trade_type: Optional[str] = None
    seen: bool = False
    tree_id: Optional[str] = None


class GardenBadgeCreate(GardenBadgeBase):
    # Client supplies the UUID so the offline queue can replay idempotently.
    id: Optional[str] = None


class GardenBadgeTrade(SQLModel):
    # The chosen trade currency: "water" or "seeds".
    # Currency credit is applied by the client via PUT /users/me/currency.
    trade_type: str


class GardenBadgeRead(SQLModel):
    id: str
    user_id: str
    tree_type: str
    stage: int
    earned_at: Optional[datetime] = None
    traded: bool
    trade_type: Optional[str] = None
    seen: bool
    tree_id: Optional[str] = None
    created_at: datetime
    updated_at: Optional[datetime] = None
