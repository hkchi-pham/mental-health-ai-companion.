"""
Per-conversation suggestion-state helpers.

Provides get_or_create and record_fire for reading/writing the
conversation_suggestion_state row that tracks:
  - last_fired_index  — fired cursor that prevents back-to-back suggestion cards
  - shown_slugs       — cooldown / rotation list of already-shown action slugs

IMPORTANT: shown_slugs is a PostgreSQL JSONB column. SQLAlchemy does NOT detect
in-place list mutations (e.g. .append()).  Always REASSIGN the list:
    row.shown_slugs = [*row.shown_slugs, new_slug]
This is the established Phase-11 lesson (journal.page = newdict pattern).

Callers wrap these functions in a try/except — a failure here must never break
chat; chat degrades gracefully to "reply without a card".
"""

from __future__ import annotations

import logging
from typing import Optional

from sqlmodel import Session, select

from backend.models.SuggestionStateModel import SuggestionStateModel

logger = logging.getLogger(__name__)


def get_state(
    session: Session,
    conversation_id: str,
) -> Optional[SuggestionStateModel]:
    """
    Fetch the suggestion-state row for a conversation, or None if it does not
    exist yet.

    Args:
        session:         SQLModel Session.
        conversation_id: The conversation UUID string.

    Returns:
        The SuggestionStateModel row, or None.
    """
    statement = select(SuggestionStateModel).where(
        SuggestionStateModel.conversation_id == conversation_id,
        SuggestionStateModel.deleted_at.is_(None),  # type: ignore[union-attr]
    )
    return session.exec(statement).first()


def get_or_create(
    session: Session,
    conversation_id: str,
) -> SuggestionStateModel:
    """
    Return the existing suggestion-state row for the conversation, or create a
    fresh one with last_fired_index=-1 and shown_slugs=[].

    Args:
        session:         SQLModel Session.
        conversation_id: The conversation UUID string.

    Returns:
        The (possibly freshly-created) SuggestionStateModel row.
    """
    existing = get_state(session, conversation_id)
    if existing is not None:
        return existing

    row = SuggestionStateModel(
        conversation_id=conversation_id,
        last_fired_index=-1,
        shown_slugs=[],
    )
    session.add(row)
    session.flush()  # populate row.id without full commit; caller commits later
    return row


def record_fire(
    session: Session,
    conversation_id: str,
    fired_index: int,
    slug: Optional[str],
) -> None:
    """
    Persist that a suggestion just fired at the given user-message index with
    the given action slug.

    Updates:
      - last_fired_index → fired_index  (reset / fired cursor)
      - shown_slugs      → deduplicated list with slug appended (cooldown /
                           rotation — excludes already-shown actions)

    The shown_slugs list is REASSIGNED (not mutated in-place) to ensure
    SQLAlchemy detects the change on a JSONB column (Phase-11 pattern).

    Args:
        session:         SQLModel Session.
        conversation_id: The conversation UUID string.
        fired_index:     0-based user-message index at which the fire occurred.
        slug:            Action slug that was shown; None is a no-op for slugs.
    """
    row = get_or_create(session, conversation_id)
    row.last_fired_index = fired_index

    if slug is not None:
        existing = list(row.shown_slugs or [])
        if slug not in existing:
            existing.append(slug)
        # REASSIGN — do NOT mutate in-place (JSONB tracking requirement)
        row.shown_slugs = existing

    session.add(row)
    session.commit()
