from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime


class GardenDecorationBase(SQLModel):
    user_id: str
    deco_type: str
    row: int
    col: int
    panel_index: int


class GardenDecorationCreate(GardenDecorationBase):
    # client may supply a UUID for idempotent offline-queue replay;
    # if None the server generates one via BaseModel.id default_factory.
    id: Optional[str] = None
    # user_id is inherited from GardenDecorationBase but overwritten from the JWT
    # token inside the router — client value is ignored.


class GardenDecorationUpdate(SQLModel):
    deco_type: Optional[str] = None
    row: Optional[int] = None
    col: Optional[int] = None
    panel_index: Optional[int] = None


class GardenDecorationRead(SQLModel):
    id: str
    user_id: str
    deco_type: str
    row: int
    col: int
    panel_index: int
    created_at: datetime
    updated_at: Optional[datetime] = None
