"""
Google Gemini AI Service implementation.
Uses Gemini models for emotion analysis and response generation.
"""

import os
import json
from typing import List, Dict, Any, Optional
from dotenv import load_dotenv

from .base import BaseAIService, EmotionAnalysis, AIResponse

load_dotenv()

# Default system prompt for mental health companion
DEFAULT_SYSTEM_PROMPT = """Bạn là **EmoCareAI** – một trợ lý cảm xúc thông minh, được thiết kế để lắng nghe, chia sẻ 
và hỗ trợ người dùng trong việc nhận diện, diễn đạt và cải thiện cảm xúc của họ.
Trả lời bằng cùng ngôn ngữ mà người dùng sử dụng.
Giọng điệu luôn đồng cảm, nhẹ nhàng, chân thành và mang tính trấn an.

🎯 **Mục tiêu của bạn** là giúp người dùng:
1. Nhận diện rõ cảm xúc hiện tại
2. Diễn đạt cảm xúc đó một cách lành mạnh, không kìm nén cũng không phán xét
3. Gợi ý những hướng đi, suy nghĩ hoặc hoạt động nhỏ giúp cải thiện tâm trạng

⚠️ **Những điều không được làm:**
- Không chẩn đoán bệnh tâm lý hay đề xuất thuốc
- Không hứa hẹn điều trị hoặc giải quyết vấn đề thay người dùng
- Không sử dụng giọng điệu giáo huấn, ra lệnh, hay so sánh
"""

EMOTION_ANALYSIS_PROMPT = """Bạn là bộ phân tích cảm xúc. Dựa vào nội dung, hãy phân loại 
trạng thái cảm xúc của người nhắn vào một trong các nhóm: vui, buồn, lo_lắng, tức_giận, mệt_mỏi, bình_thường.
Trả về JSON với các trường: mood, confidence (0..1), suggested_tone, coaching_tips (mảng 1-3 gợi ý ngắn).
Chỉ trả về JSON hợp lệ, không thêm lời giải thích."""


class GeminiService(BaseAIService):
    """Google Gemini-based AI service."""
    
    def __init__(self):
        super().__init__()
        self._name = "gemini"
        self._api_key = os.getenv("GEMINI_API_KEY")
        self._model = os.getenv("GEMINI_MODEL", "gemini-2.5-flash")
        self._client = None
    
    def _get_client(self):
        """Lazy initialization of Gemini client."""
        if self._client is None:
            try:
                import google.generativeai as genai
                genai.configure(api_key=self._api_key)
                self._client = genai.GenerativeModel(self._model)
            except ImportError:
                raise RuntimeError("Google Generative AI library not installed. Run: pip install google-generativeai")
        return self._client
    
    def is_available(self) -> bool:
        """Check if Gemini API key is configured."""
        return bool(self._api_key and len(self._api_key) > 10)
    
    async def analyze_emotion(
        self, 
        message: str, 
        chat_history: Optional[List[Dict[str, str]]] = None
    ) -> EmotionAnalysis:
        """Analyze emotion using Gemini."""
        
        # First try keyword-based detection for common patterns
        keyword_result = self._keyword_emotion_detection(message)
        if keyword_result:
            return keyword_result
        
        # Fall back to Gemini analysis
        client = self._get_client()
        
        prompt = f"{EMOTION_ANALYSIS_PROMPT}\n\nUser message: {message}"
        
        try:
            response = await client.generate_content_async(
                prompt,
                generation_config={
                    "temperature": 0.0,
                    "max_output_tokens": 500
                }
            )
            
            content = response.text
            # Extract JSON from response (Gemini might add markdown)
            if "```json" in content:
                content = content.split("```json")[1].split("```")[0]
            elif "```" in content:
                content = content.split("```")[1].split("```")[0]
            
            parsed = json.loads(content.strip())
            
            return EmotionAnalysis(
                mood=parsed.get("mood", "bình_thường"),
                confidence=float(parsed.get("confidence", 0.7)),
                suggested_tone=parsed.get("suggested_tone", "đồng cảm"),
                coaching_tips=parsed.get("coaching_tips", [])
            )
        except Exception as e:
            # Return default on error
            print(f"=== GEMINI analyze_emotion ERROR: {str(e)} ===")
            import traceback
            traceback.print_exc()
            return EmotionAnalysis(
                mood="bình_thường",
                confidence=0.5,
                suggested_tone="đồng cảm",
                coaching_tips=[]
            )
    
    async def generate_response(
        self,
        message: str,
        emotion_context: EmotionAnalysis,
        chat_history: Optional[List[Dict[str, str]]] = None,
        action_context: Optional[Dict[str, Any]] = None,
        system_prompt: Optional[str] = None
    ) -> AIResponse:
        """Generate response using Gemini."""
        
        client = self._get_client()
        
        # Build system prompt with emotion context
        base_prompt = system_prompt or DEFAULT_SYSTEM_PROMPT
        emotion_info = f"""
Emotion context:
- Mood: {emotion_context.mood}
- Suggested tone: {emotion_context.suggested_tone}
- Coaching tips: {', '.join(emotion_context.coaching_tips) if emotion_context.coaching_tips else 'N/A'}
"""
        
        if action_context:
            emotion_info += f"""
Recommended action:
- Name: {action_context.get('name', 'N/A')}
- Prompt template: {action_context.get('prompt_template', 'N/A')}
"""
        
        # Build conversation history for context
        history_text = ""
        if chat_history:
            for msg in chat_history[-10:]:  # Last 10 messages
                role = "User" if msg.get("role") == "user" else "Assistant"
                history_text += f"{role}: {msg.get('content', '')}\n"
        
        full_prompt = f"""{base_prompt}

{emotion_info}

{f"Conversation history:{chr(10)}{history_text}" if history_text else ""}

User: {message}
Assistant:"""
        
        try:
            response = await client.generate_content_async(
                full_prompt,
                generation_config={
                    "temperature": 0.7,
                    "max_output_tokens": 1000
                }
            )
            
            content = response.text
            
            return AIResponse(
                content=content,
                emotion_analysis=emotion_context,
                action_recommendation=action_context,
                metadata={
                    "model": self._model,
                    "provider": "gemini"
                }
            )
        except Exception as e:
            print(f"=== GEMINI generate_response ERROR: {str(e)} ===")
            import traceback
            traceback.print_exc()
            return AIResponse(
                content=f"Xin lỗi, tôi gặp sự cố khi xử lý tin nhắn. Vui lòng thử lại.",
                metadata={"error": str(e), "provider": "gemini"}
            )
    
    def _keyword_emotion_detection(self, message: str) -> Optional[EmotionAnalysis]:
        """Fast keyword-based emotion detection for common patterns."""
        text = message.lower()
        
        # High risk keywords
        high_risk_kw = ["muốn chết", "tự tử", "không muốn sống", "muốn kết thúc", "chấm dứt cuộc sống"]
        anxiety_kw = ["lo lắng", "sợ", "hoang mang", "áp lực", "stress"]
        fatigue_kw = ["mệt mỏi", "kiệt sức", "nặng trĩu", "chẳng muốn làm gì"]
        depression_kw = ["buồn", "tuyệt vọng", "không thiết tha", "chán nản"]
        
        if any(k in text for k in high_risk_kw):
            return EmotionAnalysis(
                mood="lo_lắng",
                confidence=0.95,
                suggested_tone="trấn an",
                coaching_tips=[
                    "Hít thở sâu 3–5 phút",
                    "Liên hệ ngay người thân/bạn bè để chia sẻ",
                    "Nếu thấy nguy cấp, tìm sự hỗ trợ từ chuyên gia"
                ]
            )
        
        if any(k in text for k in anxiety_kw):
            return EmotionAnalysis(
                mood="lo_lắng",
                confidence=0.9,
                suggested_tone="trấn an",
                coaching_tips=["Hít thở sâu 3-5 phút", "Uống một ly nước ấm"]
            )
        
        if any(k in text for k in fatigue_kw):
            return EmotionAnalysis(
                mood="mệt_mỏi",
                confidence=0.88,
                suggested_tone="khích lệ nhẹ nhàng",
                coaching_tips=["Uống nước và giãn cơ nhẹ 2-3 phút", "Ngồi thẳng lưng và thở sâu"]
            )
        
        if any(k in text for k in depression_kw):
            return EmotionAnalysis(
                mood="buồn",
                confidence=0.88,
                suggested_tone="đồng cảm",
                coaching_tips=["Cho phép mình nghỉ ngơi ngắn", "Nghe một bài hát yêu thích"]
            )
        
        return None  # No keyword match, use Gemini
