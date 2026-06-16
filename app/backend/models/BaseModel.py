from sqlmodel import SQLModel, Field
from ..utils import get_current_time, generate_uuid
from datetime import datetime
from typing import Optional
import uuid 

class BaseModel(SQLModel):
    """
        Base model for all database models.
    """
    __abstract__ = True

    id: str = Field(default_factory=generate_uuid, index=True, unique=True, primary_key=True)
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)
    deleted_at: Optional[datetime] = Field(default=None, nullable=True)
    created_by: Optional[str] = None
    updated_by: Optional[str] = None
    
