"""
Base class for AI Service adapters.
All AI providers (OpenAI, Gemini, HuggingFace) must implement this interface.
"""

from abc import ABC, abstractmethod
from typing import List, Dict, Any, Optional
from dataclasses import dataclass


@dataclass
class EmotionAnalysis:
    """Result of emotion analysis."""
    mood: str
    confidence: float
    suggested_tone: str
    coaching_tips: List[str]
    conversation_stage: int = 1
    mood_persistence: int = 1


@dataclass
class AIResponse:
    """Result of AI response generation."""
    content: str
    emotion_analysis: Optional[EmotionAnalysis] = None
    action_recommendation: Optional[Dict[str, Any]] = None
    metadata: Optional[Dict[str, Any]] = None


class BaseAIService(ABC):
    """Abstract base class for AI services."""
    
    def __init__(self):
        self._name = "base"
    
    @property
    def name(self) -> str:
        """Return the name of this AI service."""
        return self._name
    
    @abstractmethod
    def is_available(self) -> bool:
        """Check if this AI service is available and configured."""
        pass
    
    @abstractmethod
    async def analyze_emotion(
        self, 
        message: str, 
        chat_history: Optional[List[Dict[str, str]]] = None
    ) -> EmotionAnalysis:
        """
        Analyze emotion from user message.
        
        Args:
            message: Current user message
            chat_history: List of previous messages [{"role": "user"|"assistant", "content": "..."}]
            
        Returns:
            EmotionAnalysis with mood, confidence, suggested_tone, coaching_tips
        """
        pass
    
    @abstractmethod
    async def generate_response(
        self,
        message: str,
        emotion_context: EmotionAnalysis,
        chat_history: Optional[List[Dict[str, str]]] = None,
        action_context: Optional[Dict[str, Any]] = None,
        system_prompt: Optional[str] = None
    ) -> AIResponse:
        """
        Generate AI response based on message and context.
        
        Args:
            message: Current user message
            emotion_context: Analyzed emotion from analyze_emotion()
            chat_history: List of previous messages
            action_context: Recommended action from action search
            system_prompt: Optional custom system prompt
            
        Returns:
            AIResponse with content and metadata
        """
        pass
    
    async def process_message(
        self,
        message: str,
        chat_history: Optional[List[Dict[str, str]]] = None,
        action_context: Optional[Dict[str, Any]] = None,
        system_prompt: Optional[str] = None
    ) -> AIResponse:
        """
        Full pipeline: analyze emotion + generate response.
        
        This is a convenience method that combines analyze_emotion 
        and generate_response into a single call.
        """
        emotion = await self.analyze_emotion(message, chat_history)
        response = await self.generate_response(
            message=message,
            emotion_context=emotion,
            chat_history=chat_history,
            action_context=action_context,
            system_prompt=system_prompt
        )
        response.emotion_analysis = emotion
        return response
