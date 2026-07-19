"""
Offline unit tests for action_suggestion service.

All tests run without a live DB — pure logic (mood map, stage bucketing,
row selection) uses in-memory data; no DB session needed.

Run from the app/ directory:
  python -m pytest backend/services/test_action_suggestion.py -x -q
"""

import sys
import os

# Ensure app/ is on the path when running with pytest from app/
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

import pytest

from backend.services.action_suggestion import (
    mood_to_emotion_slug,
    stage_for_message_count,
    _pick_best_row,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _row(
    *,
    need_strength: float = 0.8,
    min_confidence: float = 0.5,
    stage_min: int = 1,
    stage_max: int = 3,
    action_slug: str = "action-a",
    name: str = "Action A",
    description: str = "Do action A",
    action_type: str = "tip",
    prompt_template: str = "Try this:",
) -> dict:
    """Build a candidate row dict as returned by the SQL query."""
    return {
        "need_strength": need_strength,
        "min_confidence": min_confidence,
        "stage_min": stage_min,
        "stage_max": stage_max,
        "action_slug": action_slug,
        "name": name,
        "description": description,
        "type": action_type,
        "prompt_template": prompt_template,
    }


# ---------------------------------------------------------------------------
# Test Group 1: mood_to_emotion_slug — six happy-path moods
# ---------------------------------------------------------------------------

def test_mood_to_slug_buon():
    assert mood_to_emotion_slug("buồn") == "buon"


def test_mood_to_slug_lo_lang():
    assert mood_to_emotion_slug("lo_lắng") == "lo_lang"


def test_mood_to_slug_met_moi():
    assert mood_to_emotion_slug("mệt_mỏi") == "met_moi"


def test_mood_to_slug_vui():
    assert mood_to_emotion_slug("vui") == "vui"


def test_mood_to_slug_tuc_gian():
    assert mood_to_emotion_slug("tức_giận") == "tuc_gian"


def test_mood_to_slug_binh_thuong():
    assert mood_to_emotion_slug("bình_thường") == "trung_lap"


# ---------------------------------------------------------------------------
# Test Group 2: mood_to_emotion_slug — edge cases
# ---------------------------------------------------------------------------

def test_mood_to_slug_unknown_returns_none():
    assert mood_to_emotion_slug("happy") is None


def test_mood_to_slug_empty_returns_none():
    assert mood_to_emotion_slug("") is None


def test_mood_to_slug_none_returns_none():
    assert mood_to_emotion_slug(None) is None


def test_mood_to_slug_bare_buon_passthrough():
    """bare ASCII variant without accent should also resolve."""
    assert mood_to_emotion_slug("buon") == "buon"


def test_mood_to_slug_bare_lo_lang_passthrough():
    """underscore-without-full-accent variant should also resolve."""
    assert mood_to_emotion_slug("lo_lang") == "lo_lang"


# ---------------------------------------------------------------------------
# Test Group 3: stage_for_message_count — three stage buckets
# ---------------------------------------------------------------------------

def test_stage_early_boundary_zero():
    assert stage_for_message_count(0) == 1


def test_stage_early_boundary_four():
    assert stage_for_message_count(4) == 1


def test_stage_mid_boundary_five():
    assert stage_for_message_count(5) == 2


def test_stage_mid_boundary_twelve():
    assert stage_for_message_count(12) == 2


def test_stage_long_boundary_thirteen():
    assert stage_for_message_count(13) == 3


def test_stage_long_large_count():
    assert stage_for_message_count(100) == 3


# ---------------------------------------------------------------------------
# Test Group 4: _pick_best_row — pure selection logic
# ---------------------------------------------------------------------------

def test_pick_happy_path_single_row():
    """Single qualifying row is returned."""
    rows = [_row(need_strength=0.8, min_confidence=0.5, stage_min=1, stage_max=3, action_slug="act-a")]
    result = _pick_best_row(rows, confidence=0.7, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "act-a"


def test_pick_returns_none_confidence_below_min():
    """Row is skipped when confidence < min_confidence."""
    rows = [_row(min_confidence=0.9)]
    result = _pick_best_row(rows, confidence=0.5, stage=1, exclude_slugs=set())
    assert result is None


def test_pick_returns_none_stage_out_of_range():
    """Row is skipped when current stage is outside [stage_min, stage_max]."""
    rows = [_row(stage_min=2, stage_max=3)]
    result = _pick_best_row(rows, confidence=0.9, stage=1, exclude_slugs=set())
    assert result is None


def test_pick_returns_none_all_excluded():
    """All rows are excluded via exclude_slugs."""
    rows = [_row(action_slug="act-a"), _row(action_slug="act-b", need_strength=0.6)]
    result = _pick_best_row(rows, confidence=0.8, stage=2, exclude_slugs={"act-a", "act-b"})
    assert result is None


def test_pick_returns_none_empty_rows():
    """Empty row list yields None."""
    result = _pick_best_row([], confidence=0.8, stage=2, exclude_slugs=set())
    assert result is None


def test_pick_strongest_need_first():
    """Among qualifying rows, the one with the highest need_strength wins."""
    rows = [
        _row(need_strength=0.5, action_slug="weak"),
        _row(need_strength=0.9, action_slug="strong"),
        _row(need_strength=0.7, action_slug="medium"),
    ]
    result = _pick_best_row(rows, confidence=0.8, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "strong"


def test_pick_tiebreak_by_min_confidence():
    """When need_strength is tied, the row with HIGHER min_confidence wins."""
    rows = [
        _row(need_strength=0.8, min_confidence=0.5, action_slug="low-conf"),
        _row(need_strength=0.8, min_confidence=0.7, action_slug="high-conf"),
    ]
    result = _pick_best_row(rows, confidence=0.9, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "high-conf"


def test_pick_skips_excluded_picks_next_best():
    """Excluded slug is skipped; next-strongest-need row is returned."""
    rows = [
        _row(need_strength=0.9, action_slug="best"),
        _row(need_strength=0.7, action_slug="second"),
    ]
    result = _pick_best_row(rows, confidence=0.8, stage=2, exclude_slugs={"best"})
    assert result is not None
    assert result["action_slug"] == "second"


def test_pick_stage_boundary_inclusive():
    """stage_min and stage_max are inclusive boundaries."""
    rows = [_row(stage_min=2, stage_max=2, action_slug="exact-stage")]
    # exactly at stage_min
    r1 = _pick_best_row(rows, confidence=0.8, stage=2, exclude_slugs=set())
    assert r1 is not None and r1["action_slug"] == "exact-stage"
    # one below stage_min
    r2 = _pick_best_row(rows, confidence=0.8, stage=1, exclude_slugs=set())
    assert r2 is None
    # one above stage_max
    r3 = _pick_best_row(rows, confidence=0.8, stage=3, exclude_slugs=set())
    assert r3 is None


# ---------------------------------------------------------------------------
# Test Group 5: _pick_best_row — severity gate + gentleness preference
# ---------------------------------------------------------------------------

def test_pick_excludes_handoff_for_non_high_risk():
    """A crisis handoff action is skipped when the emotion is not high-risk;
    a gentler non-handoff action is chosen instead (buồn = medium risk)."""
    rows = [
        {**_row(need_strength=0.9, action_type="handoff", action_slug="handoff-crisis"),
         "level": 3, "risk_level": "medium"},
        {**_row(need_strength=0.9, action_type="question", action_slug="gentle-question"),
         "level": 2, "risk_level": "medium"},
    ]
    result = _pick_best_row(rows, confidence=0.85, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "gentle-question"


def test_pick_allows_handoff_for_high_risk():
    """A handoff action DOES qualify when the emotion is high-risk."""
    rows = [
        {**_row(need_strength=0.9, action_type="handoff", action_slug="handoff-crisis"),
         "level": 3, "risk_level": "high"},
    ]
    result = _pick_best_row(rows, confidence=0.85, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "handoff-crisis"


def test_pick_prefers_lower_level_action():
    """Among qualifying non-handoff rows, the gentlest (lowest level) wins,
    even against a higher-need higher-level action — 'start gentle'."""
    rows = [
        {**_row(need_strength=0.9, action_slug="intense"), "level": 3, "risk_level": "low"},
        {**_row(need_strength=0.5, action_slug="gentle"), "level": 1, "risk_level": "low"},
    ]
    result = _pick_best_row(rows, confidence=0.8, stage=2, exclude_slugs=set())
    assert result is not None
    assert result["action_slug"] == "gentle"
