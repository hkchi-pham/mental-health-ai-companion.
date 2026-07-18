"""
Per-conversation suggestion-state table.

Stores the last-fired user-message index and the slugs of already-shown
curated actions for each conversation.  The router uses this to:
  - prevent back-to-back firing (last_fired_index cursor)
  - rotate to a different action on repeat fires (shown_slugs cooldown list)

Table is created idempotently at startup via init_garden_tables() in
app/config/bootstrap.py — no migration file, no ALTER, mirrors the pattern
established for garden_items / garden_decorations / garden_badges.
"""

from __future__ import annotations

from typing import List

from sqlalchemy import Column, text
from sqlalchemy.dialects.postgresql import JSONB
from sqlmodel import Field

from .BaseModel import BaseModel


class SuggestionStateModel(BaseModel, table=True):
    """Per-conversation row tracking suggestion-fire state."""

    __tablename__ = "conversation_suggestion_state"

    # The conversation this row belongs to — one row per conversation.
    conversation_id: str = Field(nullable=False, unique=True, index=True)

    # 0-based index of the user message at which a suggestion last fired.
    # -1 means the suggestion has never fired for this conversation.
    last_fired_index: int = Field(default=-1, nullable=False)

    # JSON array of action slugs that have already been shown to the user in
    # this conversation.  Used to exclude already-seen actions (cooldown /
    # rotation).  SQLAlchemy JSON columns MUST be reassigned (not mutated
    # in-place) to have the change detected — see Phase 11 lesson.
    shown_slugs: List[str] = Field(
        default=[],
        sa_column=Column(JSONB, nullable=False, server_default=text("'[]'::jsonb")),
    )
