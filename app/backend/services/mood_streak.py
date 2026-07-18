"""
Mood streak detection for the shared chat pipeline.

Responsibilities:
  1. parse_prepended_mood  — extract a canonical mood from the Flutter mood-chip
     prefix ("Mình đang cảm thấy <word>. ...") when present.
  2. detect_streak_mood    — decide whether the current user message crosses the
     3-of-last-5 same-mood threshold, with reset-after-firing semantics so a
     sustained mood does NOT produce back-to-back suggestion cards.

Both functions are pure (no DB, no async) — they are tested offline.

Run tests from the app/ directory:
  python -m pytest backend/services/test_mood_streak.py -x -q
"""

from __future__ import annotations

import re
from collections import Counter
from typing import Optional

# ---------------------------------------------------------------------------
# 1. Mood-chip prefix parsing
# ---------------------------------------------------------------------------

# Maps each of the six Vietnamese mood-chip display words (as typed in the
# Flutter chip prefix) to the canonical AI-mood strings used throughout the
# backend (matching EmotionAnalysis.mood).
#
# Flutter mood.dart prepend pattern:  "Mình đang cảm thấy <word>. "
# The six chip words and their canonical mappings:
_PREFIX_WORD_TO_MOOD: dict[str, str] = {
    "vui":          "vui",
    "bình thường":  "bình_thường",
    "buồn":         "buồn",
    "lo lắng":      "lo_lắng",
    "giận":         "tức_giận",
    "mệt":          "mệt_mỏi",
}

# Regex: "Mình đang cảm thấy " followed by one of the known chip words,
# followed by ". " (period + space) or end-of-string.
# We build the pattern with the longest words first (greedy) to avoid
# "bình" matching before "bình thường".
_SORTED_WORDS = sorted(_PREFIX_WORD_TO_MOOD.keys(), key=len, reverse=True)
_CHIP_PATTERN = re.compile(
    r"^Mình đang cảm thấy (" + "|".join(re.escape(w) for w in _SORTED_WORDS) + r")\.",
    re.UNICODE,
)


def parse_prepended_mood(text: str) -> Optional[str]:
    """
    Extract the canonical mood from a Flutter mood-chip prepend prefix.

    The Flutter app prepends "Mình đang cảm thấy <word>. " to the first user
    message when the user selects a mood chip.  This function detects that
    prefix and returns the canonical backend mood string, or None if the text
    does not start with the prefix.

    Args:
        text: Raw message content (may or may not start with the chip prefix).

    Returns:
        A canonical mood string ("vui", "buồn", "lo_lắng", "tức_giận",
        "mệt_mỏi", "bình_thường") when the prefix is present and the word is
        one of the six known chip words, or None otherwise.
    """
    if not text:
        return None
    m = _CHIP_PATTERN.match(text)
    if m is None:
        return None
    word = m.group(1)
    return _PREFIX_WORD_TO_MOOD.get(word)


# ---------------------------------------------------------------------------
# 2. Streak detection with reset-after-firing cursor
# ---------------------------------------------------------------------------

def detect_streak_mood(
    recent_user_moods: list[str],
    current_index: int,
    last_fired_index: int = -1,
) -> Optional[str]:
    """
    Decide whether the current user message triggers a mood-streak suggestion.

    Index contract:
        recent_user_moods[i] is the mood of the i-th user message (0-based,
        ascending by created_at).  current_index is the index of the CURRENT
        message in that list (usually len(recent_user_moods) - 1).

    Fresh-message window:
        Only user messages whose index is STRICTLY GREATER than last_fired_index
        are considered "fresh" (i.e., evidence that appeared after the last
        suggestion card was shown).  The streak must be reachable using only
        fresh messages — this prevents back-to-back firing when the mood simply
        continues after a fire.

    Window cap:
        Of the fresh messages, we consider only the last 5 (including the
        current message), mirroring the 3-of-last-5 rule.

    Firing rule:
        If the most frequent mood in the fresh window appears at least 3 times,
        that mood is returned.  Otherwise returns None.

    Reset semantics (key invariant):
        After a fire at index k:
          - Next message (k+1) has only 1 fresh entry   → None.
          - Message k+2 has only 2 fresh entries         → None.
          - Message k+3 has 3 fresh entries              → may fire if same mood.
        This forces a full streak rebuild before the next card appears.

    Args:
        recent_user_moods: Ordered list of mood strings for all user messages
                           in the conversation (ascending by created_at).
        current_index:     0-based index of the current user message in the list.
        last_fired_index:  Index at which a suggestion last fired for this
                           conversation.  -1 (default) means never fired.

    Returns:
        The streak mood string if the firing rule is met, else None.
    """
    if not recent_user_moods:
        return None

    # Collect fresh moods — only indices strictly after the last fired index.
    fresh_moods = [
        mood
        for idx, mood in enumerate(recent_user_moods)
        if idx > last_fired_index
    ]

    if not fresh_moods:
        return None

    # Apply the last-5 window cap to the fresh slice.
    window = fresh_moods[-5:]

    # Count occurrences in the window.
    counts = Counter(window)
    best_mood, best_count = counts.most_common(1)[0]

    if best_count >= 3:
        return best_mood

    return None
