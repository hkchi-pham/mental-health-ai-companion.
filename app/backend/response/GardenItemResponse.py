from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime


class GardenItemBase(SQLModel):
    user_id: str
    item_type: str
    growth_stage: int
    growth_points: int
    health: int
    row: int
    col: int
    panel_index: int
    last_water_at: Optional[datetime] = None


class GardenItemCreate(GardenItemBase):
    # client may supply a UUID for idempotent offline-queue replay;
    # if None the server generates one via BaseModel.id default_factory.
    id: Optional[str] = None
    # user_id is inherited from GardenItemBase but overwritten from the JWT
    # token inside the router — client value is ignored.


class GardenItemUpdate(SQLModel):
    row: Optional[int] = None
    col: Optional[int] = None
    panel_index: Optional[int] = None
    growth_stage: Optional[int] = None
    growth_points: Optional[int] = None
    health: Optional[int] = None


class GardenItemWater(SQLModel):
    # client-computed post-water state; server persists verbatim (no recompute)
    health: int
    growth_stage: int
    growth_points: int
    # absolute water balance to write to the user row
    water_units: int


class GardenItemRead(SQLModel):
    id: str
    user_id: str
    item_type: str
    growth_stage: int
    growth_points: int
    health: int
    row: int
    col: int
    panel_index: int
    last_water_at: Optional[datetime] = None
    created_at: datetime
    updated_at: Optional[datetime] = None
