"""
Factory for creating AI service instances.
Supports OpenAI, Gemini, and HuggingFace (disabled by default).
"""

import os
from enum import Enum
from typing import Optional
from dotenv import load_dotenv

from .base import BaseAIService

load_dotenv()


class AIProviderType(str, Enum):
    """Supported AI provider types."""
    OPENAI = "openai"
    GEMINI = "gemini"
    HUGGINGFACE = "huggingface"


_service_cache: dict[AIProviderType, BaseAIService] = {}


def get_ai_service(provider: Optional[str] = None) -> BaseAIService:
    """
    Get AI service instance based on provider type.
    
    Args:
        provider: Provider name ("openai", "gemini", "huggingface")
                  If None, uses AI_PROVIDER env var, defaults to "openai"
    
    Returns:
        BaseAIService instance
        
    Raises:
        ValueError: If provider is not supported
        RuntimeError: If provider is not available/configured
    """
    if provider is None:
        provider = os.getenv("AI_PROVIDER", "openai").lower()
    
    try:
        provider_type = AIProviderType(provider)
    except ValueError:
        raise ValueError(
            f"Unsupported AI provider: {provider}. "
            f"Supported: {[p.value for p in AIProviderType]}"
        )
    
    # Return cached instance if available
    if provider_type in _service_cache:
        service = _service_cache[provider_type]
        if service.is_available():
            return service
    
    # Create new instance
    service = _create_service(provider_type)
    
    if not service.is_available():
        raise RuntimeError(
            f"AI provider '{provider}' is not available. "
            "Please check your configuration and API keys."
        )
    
    _service_cache[provider_type] = service
    return service


def _create_service(provider_type: AIProviderType) -> BaseAIService:
    """Create a new AI service instance."""
    
    if provider_type == AIProviderType.OPENAI:
        from .openai_service import OpenAIService
        return OpenAIService()
    
    elif provider_type == AIProviderType.GEMINI:
        from .gemini_service import GeminiService
        return GeminiService()
    
    elif provider_type == AIProviderType.HUGGINGFACE:
        from .huggingface_service import HuggingFaceService
        return HuggingFaceService()
    
    else:
        raise ValueError(f"Unknown provider type: {provider_type}")


def list_available_providers() -> list[str]:
    """List all available (properly configured) AI providers."""
    available = []
    for provider_type in AIProviderType:
        try:
            service = _create_service(provider_type)
            if service.is_available():
                available.append(provider_type.value)
        except Exception:
            pass
    return available
