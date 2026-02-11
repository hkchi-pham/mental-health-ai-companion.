from sqlmodel import SQLModel
from typing import Optional
from datetime import datetime

class TreeBase(SQLModel):
    user_id: str
    tree_type: str
    level: str
    growth_points: int
    health: str
    last_water_at: datetime

class TreeCreate(TreeBase):
    user_id: str
    tree_types: str

class TreeRead(TreeBase):
    id: str
    tree_type: str
    level: str
    health:str
    last_water_at: datetime

class TreeUpdate(SQLModel):
    tree_type: str
    level: str
    last_water_at: datetime

class TreeResponse(SQLModel):
    user_id: str
    tree_type: str
    level: str
    growth_points: int
    health: str
    last_water_at: datetime
    created_at: datetime
    updated_at: Optional[datetime] = None
    ended_at: Optional[datetime] = None
    created_by: Optional[str] = None
    updated_by: Optional[str] = None





