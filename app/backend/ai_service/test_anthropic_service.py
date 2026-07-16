"""
Offline mocked tests for AnthropicService.

All tests run without a live ANTHROPIC_API_KEY — everything is monkeypatched.
Run from the app/ directory:
  python -m pytest backend/ai_service/test_anthropic_service.py -x -q
"""

import json
import sys
import os

# Ensure app/ is on the path when running with pytest from app/
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

import pytest

from backend.ai_service.factory import AIProviderType, _create_service
from backend.ai_service.anthropic_service import AnthropicService
from backend.ai_service.base import EmotionAnalysis

# The exact six Vietnamese mood values the Flutter app expects
SIX = {"vui", "buồn", "lo_lắng", "tức_giận", "mệt_mỏi", "bình_thường"}


# ---------------------------------------------------------------------------
# Test A: factory selection — no live key required
# ---------------------------------------------------------------------------

def test_factory_returns_anthropic_service():
    """_create_service(ANTHROPIC) returns an AnthropicService instance."""
    svc = _create_service(AIProviderType.ANTHROPIC)
    assert isinstance(svc, AnthropicService)


# ---------------------------------------------------------------------------
# Test B: keyword path — mood always in six, no client call
# ---------------------------------------------------------------------------

@pytest.mark.asyncio
async def test_keyword_path_mood_in_six():
    """analyze_emotion returns mood in SIX via keyword detection (no API call)."""
    svc = AnthropicService()
    result = await svc.analyze_emotion("Tôi thấy lo lắng quá")
    assert isinstance(result, EmotionAnalysis)
    assert result.mood in SIX


# ---------------------------------------------------------------------------
# Test C: mocked Claude path — mood in six via structured output
# ---------------------------------------------------------------------------

class _FakeTextBlock:
    def __init__(self, text):
        self.type = "text"
        self.text = text


class _FakeResponse:
    def __init__(self, mood):
        payload = json.dumps({
            "mood": mood,
            "confidence": 0.85,
            "suggested_tone": "đồng cảm",
            "coaching_tips": ["Hít thở sâu"]
        })
        self.content = [_FakeTextBlock(payload)]


class _FakeMessages:
    """Mimics client.messages with an async create() method."""

    def __init__(self, mood="vui"):
        self._mood = mood
        self._should_raise = False

    async def create(self, **kwargs):
        if self._should_raise:
            raise RuntimeError("Simulated API error")
        return _FakeResponse(self._mood)


class _FakeClient:
    def __init__(self, mood="vui", should_raise=False):
        self.messages = _FakeMessages(mood)
        self.messages._should_raise = should_raise


@pytest.mark.asyncio
async def test_mocked_claude_path_mood_in_six(monkeypatch):
    """
    analyze_emotion on a non-keyword message uses the mocked client and returns
    a mood in the six-value set.
    """
    fake_client = _FakeClient(mood="vui")
    svc = AnthropicService()
    monkeypatch.setattr(svc, "_get_client", lambda: fake_client)

    # Use a message with no keyword triggers
    result = await svc.analyze_emotion("Hôm nay trời đẹp và tôi ăn kem")
    assert isinstance(result, EmotionAnalysis)
    assert result.mood in SIX


# ---------------------------------------------------------------------------
# Test D: exception → neutral default still in six
# ---------------------------------------------------------------------------

@pytest.mark.asyncio
async def test_exception_returns_neutral_default(monkeypatch):
    """When the Claude call raises, analyze_emotion returns mood='bình_thường' (still in SIX)."""
    fake_client = _FakeClient(should_raise=True)
    svc = AnthropicService()
    monkeypatch.setattr(svc, "_get_client", lambda: fake_client)

    result = await svc.analyze_emotion("Hôm nay trời đẹp và tôi ăn kem")
    assert isinstance(result, EmotionAnalysis)
    assert result.mood == "bình_thường"
    assert result.mood in SIX


# ---------------------------------------------------------------------------
# Test E: no-regression — existing providers still resolve correctly
# ---------------------------------------------------------------------------

def test_no_regression_existing_providers():
    """openai / gemini / huggingface factory branches return their existing service classes."""
    from backend.ai_service.openai_service import OpenAIService
    from backend.ai_service.gemini_service import GeminiService
    from backend.ai_service.huggingface_service import HuggingFaceService

    assert isinstance(_create_service(AIProviderType.OPENAI), OpenAIService)
    assert isinstance(_create_service(AIProviderType.GEMINI), GeminiService)
    assert isinstance(_create_service(AIProviderType.HUGGINGFACE), HuggingFaceService)
