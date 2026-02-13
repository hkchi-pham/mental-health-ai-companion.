"""
HuggingFace Local Model AI Service implementation.
Uses local sentence-transformers models for emotion analysis.
DISABLED BY DEFAULT due to resource constraints.
"""

import os
from typing import List, Dict, Any, Optional
from dotenv import load_dotenv

from .base import BaseAIService, EmotionAnalysis, AIResponse

load_dotenv()


class HuggingFaceService(BaseAIService):
    """HuggingFace local model-based AI service.
    
    This service is disabled by default to reduce resource usage.
    Set HUGGINGFACE_ENABLED=true to enable.
    """
    
    def __init__(self):
        super().__init__()
        self._name = "huggingface"
        self._enabled = os.getenv("HUGGINGFACE_ENABLED", "false").lower() == "true"
        self._model_name = os.getenv("HUGGINGFACE_MODEL", "bkai-foundation-models/vietnamese-bi-encoder")
        self._model = None
        self._tokenizer = None
    
    def _load_model(self):
        """Lazy load the model only when needed."""
        if not self._enabled:
            raise RuntimeError("HuggingFace service is disabled. Set HUGGINGFACE_ENABLED=true to enable.")
        
        if self._model is None:
            try:
                from sentence_transformers import SentenceTransformer
                self._model = SentenceTransformer(self._model_name)
            except ImportError:
                raise RuntimeError("sentence-transformers not installed. Run: pip install sentence-transformers")
            except Exception as e:
                raise RuntimeError(f"Failed to load model {self._model_name}: {e}")
        
        return self._model
    
    def is_available(self) -> bool:
        """Check if HuggingFace service is enabled."""
        return self._enabled
    
    async def analyze_emotion(
        self, 
        message: str, 
        chat_history: Optional[List[Dict[str, str]]] = None
    ) -> EmotionAnalysis:
        """Analyze emotion using keyword matching only (no ML model for emotion).
        
        HuggingFace embedding model is for semantic search, not emotion classification.
        We use keyword-based detection for emotions.
        """
        return self._keyword_emotion_detection(message)
    
    async def generate_response(
        self,
        message: str,
        emotion_context: EmotionAnalysis,
        chat_history: Optional[List[Dict[str, str]]] = None,
        action_context: Optional[Dict[str, Any]] = None,
        system_prompt: Optional[str] = None
    ) -> AIResponse:
        """Generate response using template-based approach.
        
        HuggingFace embedding model is not designed for text generation.
        Instead, we use template-based responses based on emotion and action context.
        """
        
        # Build response from action context if available
        if action_context and action_context.get("prompt_template"):
            content = action_context["prompt_template"]
        else:
            # Generate template-based response based on mood
            content = self._get_template_response(emotion_context.mood)
        
        return AIResponse(
            content=content,
            emotion_analysis=emotion_context,
            action_recommendation=action_context,
            metadata={
                "model": self._model_name,
                "provider": "huggingface",
                "type": "template_based"
            }
        )
    
    def get_embedding(self, text: str) -> List[float]:
        """Get embedding vector for text. Used for semantic search."""
        if not self._enabled:
            raise RuntimeError("HuggingFace service is disabled.")
        
        model = self._load_model()
        embedding = model.encode(text)
        return embedding.tolist()
    
    def _keyword_emotion_detection(self, message: str) -> EmotionAnalysis:
        """Keyword-based emotion detection."""
        text = message.lower()
        
        # High risk keywords
        high_risk_kw = ["muốn chết", "tự tử", "không muốn sống", "muốn kết thúc"]
        anxiety_kw = ["lo lắng", "sợ", "hoang mang", "áp lực", "stress"]
        fatigue_kw = ["mệt mỏi", "kiệt sức", "nặng trĩu"]
        depression_kw = ["buồn", "tuyệt vọng", "chán nản"]
        happy_kw = ["vui", "hạnh phúc", "tuyệt vời", "tốt quá"]
        
        if any(k in text for k in high_risk_kw):
            return EmotionAnalysis(
                mood="lo_lắng",
                confidence=0.95,
                suggested_tone="trấn an",
                coaching_tips=[
                    "Hít thở sâu 3–5 phút",
                    "Liên hệ ngay người thân/bạn bè",
                    "Tìm sự hỗ trợ từ chuyên gia"
                ]
            )
        
        if any(k in text for k in anxiety_kw):
            return EmotionAnalysis(
                mood="lo_lắng",
                confidence=0.85,
                suggested_tone="trấn an",
                coaching_tips=["Hít thở sâu", "Uống nước ấm"]
            )
        
        if any(k in text for k in fatigue_kw):
            return EmotionAnalysis(
                mood="mệt_mỏi",
                confidence=0.85,
                suggested_tone="khích lệ nhẹ nhàng",
                coaching_tips=["Nghỉ ngơi ngắn", "Giãn cơ nhẹ"]
            )
        
        if any(k in text for k in depression_kw):
            return EmotionAnalysis(
                mood="buồn",
                confidence=0.85,
                suggested_tone="đồng cảm",
                coaching_tips=["Cho phép mình nghỉ ngơi", "Nghe nhạc"]
            )
        
        if any(k in text for k in happy_kw):
            return EmotionAnalysis(
                mood="vui",
                confidence=0.85,
                suggested_tone="tích cực",
                coaching_tips=["Tận hưởng khoảnh khắc này"]
            )
        
        return EmotionAnalysis(
            mood="bình_thường",
            confidence=0.6,
            suggested_tone="đồng cảm",
            coaching_tips=[]
        )
    
    def _get_template_response(self, mood: str) -> str:
        """Get template-based response for mood."""
        templates = {
            "lo_lắng": "Mình hiểu bạn đang lo lắng. Hãy thử hít thở sâu và từ từ nhé. Mình ở đây lắng nghe bạn.",
            "buồn": "Mình thấy bạn đang buồn. Không sao cả, ai cũng có lúc buồn. Bạn muốn chia sẻ thêm không?",
            "mệt_mỏi": "Bạn có vẻ mệt mỏi. Hãy nghỉ ngơi một chút nếu có thể. Mình sẵn sàng lắng nghe khi bạn muốn.",
            "tức_giận": "Mình hiểu bạn đang không vui. Hãy cho phép mình ở bên bạn. Bạn có muốn nói về chuyện gì không?",
            "vui": "Thật tuyệt khi thấy bạn vui! Mình cũng vui lây. Chia sẻ thêm cho mình nghe nhé!",
            "bình_thường": "Mình đây, sẵn sàng lắng nghe bạn. Bạn muốn nói về điều gì?"
        }
        return templates.get(mood, templates["bình_thường"])
