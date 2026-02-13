from sqlmodel import Field
from typing import Optional, TYPE_CHECKING
from datetime import datetime
from .BaseModel import BaseModel


class TreeModel(BaseModel, table=True):
    __tablename__ = "tree"

    user_id: str = Field(nullable=False)
    tree_type: str = Field(nullable=False,max_length=128)
    level: int = 1
    growth_points: int = 0
    health: int = 100
    last_water_at: Optional[datetime] = None
    