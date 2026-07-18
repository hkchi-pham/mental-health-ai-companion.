"""
Offline unit tests for mood_streak service.

All tests run without a live DB — pure logic only.

Run from the app/ directory:
  python -m pytest backend/services/test_mood_streak.py -x -q
"""

import sys
import os

# Ensure app/ is on the path when running with pytest from app/
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

import pytest

from backend.services.mood_streak import (
    parse_prepended_mood,
    detect_streak_mood,
)

# ---------------------------------------------------------------------------
# Test 1: parse_prepended_mood — happy path and no-prefix cases
# ---------------------------------------------------------------------------

def test_parse_prepended_mood_happy_path():
    """Chip prefix present — extract the mapped canonical mood."""
    assert parse_prepended_mood("Mình đang cảm thấy buồn. hôm nay tệ") == "buồn"
    assert parse_prepended_mood("Mình đang cảm thấy vui. yay") == "vui"
    assert parse_prepended_mood("Mình đang cảm thấy lo lắng. căng thẳng") == "lo_lắng"
    assert parse_prepended_mood("Mình đang cảm thấy giận. tức lắm") == "tức_giận"
    assert parse_prepended_mood("Mình đang cảm thấy mệt. muốn ngủ") == "mệt_mỏi"
    assert parse_prepended_mood("Mình đang cảm thấy bình thường. oke") == "bình_thường"


def test_parse_prepended_mood_no_prefix():
    """Text without chip prefix returns None."""
    assert parse_prepended_mood("hôm nay tệ quá") is None
    assert parse_prepended_mood("tôi đang vui") is None
    assert parse_prepended_mood("") is None
    assert parse_prepended_mood("Mình đang cảm thấy") is None  # no word after


# ---------------------------------------------------------------------------
# Test 2: 3 fresh same-mood messages → fires
# ---------------------------------------------------------------------------

def test_detect_streak_fires_on_3_fresh_same_mood():
    """3 messages with the same mood, no prior fire → fires."""
    moods = ["buồn", "buồn", "buồn"]
    result = detect_streak_mood(moods, current_index=2, last_fired_index=-1)
    assert result == "buồn"


def test_detect_streak_fires_5_window_3_same():
    """5 messages with 3 same mood within window → fires."""
    moods = ["vui", "buồn", "buồn", "vui", "buồn"]
    result = detect_streak_mood(moods, current_index=4, last_fired_index=-1)
    assert result == "buồn"


# ---------------------------------------------------------------------------
# Test 3: sustained mood immediately after a fire → NO back-to-back
# ---------------------------------------------------------------------------

def test_no_back_to_back_fire():
    """After a fire at index 2, next message (index 3) must NOT refire.

    last_fired_index=2, current_index=3: only 1 fresh message (index 3) — not >=3.
    """
    # moods[0..2] created the first streak; fired at index 2.
    moods = ["buồn", "buồn", "buồn", "buồn"]
    result = detect_streak_mood(moods, current_index=3, last_fired_index=2)
    assert result is None, "Should NOT back-to-back fire with only 1 fresh message"


def test_no_back_to_back_fire_several_fresh_but_less_than_3():
    """2 fresh messages after fire — still not enough."""
    moods = ["buồn", "buồn", "buồn", "buồn", "buồn"]
    result = detect_streak_mood(moods, current_index=4, last_fired_index=2)
    assert result is None, "2 fresh messages (indices 3,4) should not be enough to refire"


# ---------------------------------------------------------------------------
# Test 4: mood persisting for 3 NEW messages after a fire → fires again
# ---------------------------------------------------------------------------

def test_rebuilt_streak_refires():
    """After fire at index 2, 3 new same-mood messages (indices 3,4,5) rebuild the streak."""
    moods = ["buồn", "buồn", "buồn", "buồn", "buồn", "buồn"]
    result = detect_streak_mood(moods, current_index=5, last_fired_index=2)
    assert result == "buồn", "Should refire after 3 fresh same-mood messages"


# ---------------------------------------------------------------------------
# Test 5: non-consecutive fresh same-mood within window still counts
# ---------------------------------------------------------------------------

def test_non_consecutive_fresh_moods_count():
    """Fresh moods: [buồn, vui, buồn, vui, buồn] — 3 buồn across the window → fires."""
    # last_fired_index=-1, so all 5 are fresh; window is the last 5
    moods = ["buồn", "vui", "buồn", "vui", "buồn"]
    result = detect_streak_mood(moods, current_index=4, last_fired_index=-1)
    assert result == "buồn"


def test_non_consecutive_fresh_after_fire():
    """After fire at index 1, fresh moods alternate but 3 buồn → fires."""
    # Indices > 1 are fresh: [buồn, vui, buồn, vui, buồn] — window contains these 5
    moods = ["buồn", "buồn", "buồn", "vui", "buồn", "vui", "buồn"]
    result = detect_streak_mood(moods, current_index=6, last_fired_index=1)
    assert result == "buồn"


# ---------------------------------------------------------------------------
# Test 6: fewer than 3 fresh same-mood → None
# ---------------------------------------------------------------------------

def test_less_than_3_fresh_returns_none():
    """Only 2 same-mood messages → None."""
    moods = ["buồn", "vui", "buồn"]
    result = detect_streak_mood(moods, current_index=2, last_fired_index=-1)
    assert result is None


def test_empty_history_returns_none():
    """Empty mood list → None without error."""
    result = detect_streak_mood([], current_index=0, last_fired_index=-1)
    assert result is None


def test_single_message_returns_none():
    """Only one message → cannot form a 3-streak → None."""
    result = detect_streak_mood(["buồn"], current_index=0, last_fired_index=-1)
    assert result is None


def test_short_history_with_fire_returns_none():
    """1 fresh message after fire → None."""
    moods = ["vui", "vui", "vui", "vui"]
    result = detect_streak_mood(moods, current_index=3, last_fired_index=2)
    assert result is None
