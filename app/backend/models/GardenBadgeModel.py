from sqlmodel import Field
from typing import Optional
from datetime import datetime
from .BaseModel import BaseModel


class GardenBadgeModel(BaseModel, table=True):
    __tablename__ = "garden_badges"

    user_id: str = Field(nullable=False)
    tree_type: str = Field(nullable=False, max_length=128)
    stage: int = 0
    earned_at: Optional[datetime] = None
    traded: bool = False
    trade_type: Optional[str] = Field(default=None, max_length=32)
    seen: bool = False
    tree_id: Optional[str] = Field(default=None, max_length=64)
