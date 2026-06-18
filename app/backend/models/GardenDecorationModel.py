from sqlmodel import Field
from typing import Optional
from datetime import datetime
from .BaseModel import BaseModel


class GardenDecorationModel(BaseModel, table=True):
    __tablename__ = "garden_decorations"

    user_id: str = Field(nullable=False)
    deco_type: str = Field(nullable=False, max_length=128)
    row: int = 0
    col: int = 0
    panel_index: int = 0
