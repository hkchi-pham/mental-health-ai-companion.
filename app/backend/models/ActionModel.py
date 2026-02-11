from typing import Optional, List, Any
from sqlmodel import Field, Session, select
from sqlalchemy import Column, Integer, String, Text, Boolean, Numeric, ARRAY
from sqlalchemy.dialects.postgresql import JSONB
from typing import Optional, List, Any, Dict
from pgvector.sqlalchemy import Vector
from .BaseModel import BaseModel

class ActionModel(BaseModel, table=True):
    __tablename__ = "actions"

    slug: str = Field(nullable=False, unique=True)
    name: str = Field(nullable=False)
    description: Optional[str] = Field(sa_column=Column(Text))
    type: str = Field(nullable=False)
    level: Optional[int] = None
    stage_min: Optional[int] = Field(default=1)
    stage_max: Optional[int] = Field(default=3)
    prompt_template: Optional[str] = Field(sa_column=Column(Text))
    expected_outcomes: Optional[str] = Field(sa_column=Column(Text))
    # JSONB fields
    preconditions: Optional[Dict] = Field(default={}, sa_column=Column(JSONB))
    postconditions: Optional[Dict] = Field(default={}, sa_column=Column(JSONB))
    
    cooldown_seconds: Optional[int] = Field(default=0)
    max_repeats: Optional[int] = Field(default=3)
    domain: Optional[str] = Field(default='general')
    active: bool = Field(default=True)
    
    # Search-ready fields
    search_text: Optional[str] = Field(sa_column=Column(Text))
    tags: List[str] = Field(default=[], sa_column=Column(ARRAY(Text)))
    target_emotions: List[str] = Field(default=[], sa_column=Column(ARRAY(Text)))
    target_needs: List[str] = Field(default=[], sa_column=Column(ARRAY(Text)))
    search_keywords: List[str] = Field(default=[], sa_column=Column(ARRAY(Text)))
    synonyms: List[str] = Field(default=[], sa_column=Column(ARRAY(Text)))
    priority_score: Optional[float] = Field(default=0.5, sa_column=Column(Numeric(3, 2)))
    
    # Embedding field
    embedding: List[float] = Field(sa_column=Column(Vector(768)))

    def __repr__(self):
        return f"<ActionModel(slug={self.slug}, name={self.name}, type={self.type})>"
