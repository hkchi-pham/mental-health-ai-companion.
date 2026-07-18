"""
Provider-agnostic curated-action lookup service.

Responsibilities:
  1. Normalize the six AI moods (accented Vietnamese + underscored) to the
     emotion slugs used in the seed database.
  2. Bucket a conversation's message count into a stage (1/2/3).
  3. Query the seeded curated tables (emotion_need_links → strongest need →
     emotion_need_action_map → actions) and return the single best-matching
     action, or None when nothing qualifies.

This module is the pure, testable core of Phase 13.3.  Plan 02 wires it into
the chat router; this plan only builds and unit-tests the lookup so it remains
provider-agnostic and correct before integration.

Run tests from the app/ directory:
  python -m pytest backend/services/test_action_suggestion.py -x -q
"""

from __future__ import annotations

import logging
from typing import Any, Dict, List, Optional, Set

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# 1. Mood → emotion-slug normalization
# ---------------------------------------------------------------------------

# Maps the EXACT six mood strings that the AI providers return (accented +
# underscored, matching EmotionAnalysis.mood) to the seed DB emotion slugs.
# Also includes unaccented / bare ASCII variants seen in internal code paths.
_MOOD_TO_SLUG: Dict[str, str] = {
    # ── accented forms (primary — AI providers return these) ──────────────
    "buồn": "buon",
    "lo_lắng": "lo_lang",
    "mệt_mỏi": "met_moi",
    "vui": "vui",
    "tức_giận": "tuc_gian",
    "bình_thường": "trung_lap",
    # ── unaccented / bare ASCII pass-through variants ──────────────────────
    # HuggingFace keyword path may emit these; map them through.
    "buon": "buon",
    "lo_lang": "lo_lang",
    "met_moi": "met_moi",
    "tuc_gian": "tuc_gian",
    "trung_lap": "trung_lap",
}


def mood_to_emotion_slug(mood: Optional[str]) -> Optional[str]:
    """
    Normalize an AI mood string to its corresponding emotion slug.

    Args:
        mood: One of the six Vietnamese mood values returned by EmotionAnalysis
              (accented + underscored forms), or an unaccented variant.
              None, empty string, or any unknown value returns None.

    Returns:
        An emotion slug string (e.g. "buon", "lo_lang") or None if the mood
        is unrecognised — callers treat None as "no curated lookup possible".
    """
    if not mood:
        return None
    return _MOOD_TO_SLUG.get(mood.strip())


# ---------------------------------------------------------------------------
# 2. Message-count → stage bucketing
# ---------------------------------------------------------------------------

# Stage thresholds (Claude's discretion per plan spec):
#   early   : message count ≤  4  → stage 1  (user is still warming up)
#   mid     : message count  5–12 → stage 2  (conversation has some depth)
#   long    : message count > 12  → stage 3  (sustained, rich context)
_STAGE_EARLY_MAX = 4
_STAGE_MID_MAX = 12


def stage_for_message_count(n: int) -> int:
    """
    Map a conversation message count to a stage bucket (1, 2, or 3).

    Thresholds:
      - Stage 1 (early):  n ≤ 4   — user is still warming up; prefer gentle
                                     surface-level suggestions.
      - Stage 2 (mid):    5 ≤ n ≤ 12 — conversation has enough depth for
                                     more targeted suggestions.
      - Stage 3 (long):   n > 12  — sustained exchange; deeper engagement
                                     and reflection activities are appropriate.

    Args:
        n: Total number of user (or total) messages in the conversation.

    Returns:
        Integer stage 1, 2, or 3.
    """
    if n <= _STAGE_EARLY_MAX:
        return 1
    if n <= _STAGE_MID_MAX:
        return 2
    return 3


# ---------------------------------------------------------------------------
# 3. Pure row selection helper
# ---------------------------------------------------------------------------

def _pick_best_row(
    rows: List[Dict[str, Any]],
    confidence: float,
    stage: int,
    exclude_slugs: Set[str],
) -> Optional[Dict[str, Any]]:
    """
    Select the best candidate action row from a pre-fetched list.

    Selection rules (applied in order):
      1. Skip rows where confidence < row["min_confidence"].
      2. Skip rows where stage is outside [row["stage_min"], row["stage_max"]].
      3. Skip rows whose action_slug is in exclude_slugs.
      4. Among remaining rows, sort by need_strength DESC, then min_confidence
         DESC, and return the first element.

    Args:
        rows:          Candidate rows, each a dict with keys: need_strength,
                       min_confidence, stage_min, stage_max, action_slug, name,
                       description, type, prompt_template.
        confidence:    Detected mood confidence in [0, 1].
        stage:         Current conversation stage (1, 2, or 3).
        exclude_slugs: Set of action slugs already shown (cooldown / variety).

    Returns:
        The best-matching row dict, or None if no row qualifies.
    """
    candidates = [
        r for r in rows
        if (
            confidence >= r["min_confidence"]
            and r["stage_min"] <= stage <= r["stage_max"]
            and r["action_slug"] not in exclude_slugs
        )
    ]
    if not candidates:
        return None
    # Primary sort: strongest need (DESC); tiebreak: highest min_confidence (DESC)
    candidates.sort(key=lambda r: (r["need_strength"], r["min_confidence"]), reverse=True)
    return candidates[0]


# ---------------------------------------------------------------------------
# 4. DB-backed curated-action lookup
# ---------------------------------------------------------------------------

# SQL that fetches all candidate rows for a given emotion slug.
# Joins:  emotions(e) → emotion_need_links(l) → needs(n)
#              → emotion_need_action_map(m) → actions(a)
# Filters: a.active = true  (only live actions)
# Returns: one row per (need, action) combination with the need relationship
#          strength so that _pick_best_row can apply pure selection logic.
_LOOKUP_SQL = """
SELECT
    l.relationship_strength AS need_strength,
    m.min_confidence,
    m.stage_min,
    m.stage_max,
    a.slug        AS action_slug,
    a.name,
    a.description,
    a.type,
    a.prompt_template
FROM emotions e
JOIN emotion_need_links   l ON l.emotion_id = e.id
JOIN needs                n ON n.id          = l.need_id
JOIN emotion_need_action_map m
                              ON m.emotion_id = e.id
                             AND m.need_id    = l.need_id
JOIN actions a ON a.id = m.action_id
WHERE e.slug = :slug
  AND a.active = true
"""


def lookup_curated_action(
    session: Any,
    mood: str,
    confidence: float,
    message_count: int = 0,
    exclude_slugs: Optional[Set[str]] = None,
) -> Optional[Dict[str, Any]]:
    """
    Look up the best curated action for a detected mood.

    Steps:
      1. Normalise mood → emotion slug; return None for unknown moods.
      2. Derive conversation stage from message_count.
      3. Run a parameterised SQL query joining the curated seed tables.
      4. Apply _pick_best_row with confidence gating, stage range, and
         cooldown exclusions.
      5. Return a forward-compatible dict or None (never raises).

    Args:
        session:        SQLModel/SQLAlchemy Session (supports .exec(text(...), params={})).
        mood:           EmotionAnalysis.mood — one of the six Vietnamese mood strings.
        confidence:     EmotionAnalysis.confidence in [0, 1].
        message_count:  Number of messages in the current conversation (for stage).
        exclude_slugs:  Set of action slugs already shown in this conversation.
                        Pass None or empty set for the first suggestion.

    Returns:
        Dict with keys {slug, name, description, type, prompt_template} for the
        chosen action, or None when nothing qualifies.
        The slug is included so callers can add it to exclude_slugs for cooldown
        / need-rotation tracking across the conversation.
    """
    if exclude_slugs is None:
        exclude_slugs = set()

    # Step 1 — mood normalisation
    slug = mood_to_emotion_slug(mood)
    if slug is None:
        logger.debug("lookup_curated_action: unknown mood %r — returning None", mood)
        return None

    # Step 2 — stage bucket
    stage = stage_for_message_count(message_count)

    # Step 3 — DB query
    try:
        from sqlmodel import text  # local import avoids hard dependency at module load

        result = session.exec(text(_LOOKUP_SQL), params={"slug": slug})
        # result may be a CursorResult; support both .mappings() and direct iteration
        try:
            rows = [dict(r) for r in result.mappings()]
        except AttributeError:
            rows = [dict(r._mapping) for r in result]
    except Exception as exc:  # noqa: BLE001
        logger.warning(
            "lookup_curated_action: DB error for slug=%r — returning None. %s: %s",
            slug, type(exc).__name__, exc,
        )
        return None

    # Step 4 — pure selection
    best = _pick_best_row(rows, confidence=confidence, stage=stage, exclude_slugs=exclude_slugs)
    if best is None:
        logger.debug(
            "lookup_curated_action: no qualifying row for slug=%r conf=%.2f stage=%d",
            slug, confidence, stage,
        )
        return None

    # Step 5 — shape return dict (forward-compatible; include slug for cooldown tracking)
    return {
        "slug": best["action_slug"],
        "name": best["name"],
        "description": best["description"],
        "type": best["type"],
        "prompt_template": best["prompt_template"],
    }
