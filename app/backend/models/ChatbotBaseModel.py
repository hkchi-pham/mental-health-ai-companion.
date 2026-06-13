from sqlmodel import SQLModel, Field,  Column, Text, Numeric, Integer, JSONB, Dict, Any
from ..utils import get_current_time, generate_uuid
from datetime import datetime
from typing import Optional
import uuid 
from sqlalchemy import CheckConstraint

class EmotionModel(SQLModel, table=True):
    __tablename__ = "emotions"

    id: str = Field(nullable=False)
    slug: str = Field(nullable=False)
    name: str = Field(nullable=False)
    description: str = Field(nullable=False)
    valence: str = Field(nullable=False)
    intensity: str = Field(nullable=False)
    risk_level:str = Field(nullable=False)
    default_tone: str = Field(nullable=False)
    category: str = Field(nullable=False)

class NeedModel(SQLModel, table=True):
    __tablename__ = "needs"

    id: str = Field(nullable=False)
    slug: str = Field(nullable=False)
    name: str = Field(nullable=False)
    description: str = Field(nullable=False)
    domain: str = Field(
        default="unknown",
        sa_column=Column(
            Text,
            CheckConstraint(
                "domain IN ('health','school','relationship','personal','unknown')"
            ),
            nullable=False
        )
    )
    priority: float = Field(
        default=0.5,
        sa_column=Column(
            Numeric(3, 2),
            CheckConstraint("priority BETWEEN 0.0 AND 1.0"),
            nullable=False
        )
    )
    urgency: float = Field(
        default=0.5,
        sa_column=Column(
            Numeric(3, 2),
            CheckConstraint("urgency BETWEEN 0.0 AND 1.0"),
            nullable=False
        )
    )
    





    
    
