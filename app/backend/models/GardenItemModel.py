from sqlmodel import Field
from typing import Optional
from datetime import datetime
from .BaseModel import BaseModel


class GardenItemModel(BaseModel, table=True):
    __tablename__ = "garden_items"

    user_id: str = Field(nullable=False)
    item_type: str = Field(nullable=False, max_length=128)
    growth_stage: int = 1
    growth_points: int = 0
    health: int = 100
    row: int = 0
    col: int = 0
    panel_index: int = 0
    last_water_at: Optional[datetime] = None
