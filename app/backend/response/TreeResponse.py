from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class TreeBase(SQLModel):
    user_id: str
    tree_type: str
    level: int
    growth_points: int
    health: int
    last_water_at: Optional[datetime] = None

class TreeCreate(TreeBase):
    user_id: str
    tree_type: str

class TreeRead(TreeBase):
    id: str
    tree_type: str
    level: int
    health: int
    last_water_at: Optional[datetime] = None

class TreeUpdate(SQLModel):
    tree_type: str
    level: int
    last_water_at: Optional[datetime] = None

class TreeResponse(SQLModel):
    user_id: str
    tree_type: str
    level: int
    growth_points: int
    health: int
    last_water_at: Optional[datetime] = None
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





