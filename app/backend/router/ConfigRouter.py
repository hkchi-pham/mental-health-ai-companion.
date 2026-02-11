"""
ConfigRouter - API endpoints for bot to fetch emotions/needs configuration.
These endpoints are called by medihome-ai-bot to get detection patterns.
"""

from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select, text
from typing import List, Dict, Any, Optional
from pydantic import BaseModel
from config.database import get_db

router = APIRouter(
    prefix="/config",
    tags=["config"]
)


# Response Models
class EmotionResponse(BaseModel):
    slug: str
    name: str
    description: Optional[str] = None
    keywords: List[str] = []
    emoji: Optional[str] = None


class NeedResponse(BaseModel):
    slug: str
    name: str
    description: Optional[str] = None
    keywords: List[str] = []


class DetectionPatternResponse(BaseModel):
    emotions: List[Dict[str, Any]]
    needs: List[Dict[str, Any]]
    keyword_patterns: Dict[str, List[str]]


# Emotion definitions (can be moved to database later)
EMOTIONS = [
    {
        "slug": "vui",
        "name": "Vui vẻ",
        "description": "Trạng thái vui vẻ, hạnh phúc",
        "keywords": ["vui", "hạnh phúc", "tuyệt vời", "tốt quá", "thích", "yêu", "phấn khích"],
        "emoji": "😊"
    },
    {
        "slug": "buon",
        "name": "Buồn",
        "description": "Trạng thái buồn bã, chán nản",
        "keywords": ["buồn", "chán", "tuyệt vọng", "không thiết tha", "chán nản", "thất vọng", "đau khổ"],
        "emoji": "😢"
    },
    {
        "slug": "lo_lang",
        "name": "Lo lắng",
        "description": "Trạng thái lo âu, bất an",
        "keywords": ["lo lắng", "sợ", "hoang mang", "áp lực", "stress", "căng thẳng", "bất an", "lo âu"],
        "emoji": "😰"
    },
    {
        "slug": "tuc_gian",
        "name": "Tức giận",
        "description": "Trạng thái tức giận, bực bội",
        "keywords": ["tức", "giận", "bực", "khó chịu", "phẫn nộ", "cáu", "điên"],
        "emoji": "😠"
    },
    {
        "slug": "met_moi",
        "name": "Mệt mỏi",
        "description": "Trạng thái mệt mỏi, kiệt sức",
        "keywords": ["mệt mỏi", "kiệt sức", "nặng trĩu", "chẳng muốn làm gì", "uể oải", "thiếu năng lượng"],
        "emoji": "😩"
    },
    {
        "slug": "binh_thuong",
        "name": "Bình thường",
        "description": "Trạng thái bình thường, ổn định",
        "keywords": [],
        "emoji": "😐"
    }
]

NEEDS = [
    {
        "slug": "binh_on",
        "name": "Bình ổn",
        "description": "Cần được trấn an, ổn định cảm xúc",
        "keywords": ["bình tĩnh", "ổn định", "an tâm", "thư giãn"]
    },
    {
        "slug": "an_toan",
        "name": "An toàn",
        "description": "Cần cảm giác an toàn, được bảo vệ",
        "keywords": ["an toàn", "bảo vệ", "che chở"]
    },
    {
        "slug": "ket_noi",
        "name": "Kết nối",
        "description": "Cần được lắng nghe, kết nối với người khác",
        "keywords": ["cô đơn", "một mình", "không ai hiểu", "chia sẻ", "tâm sự"]
    },
    {
        "slug": "kiem_soat",
        "name": "Kiểm soát",
        "description": "Cần lấy lại kiểm soát, chủ động",
        "keywords": ["kiểm soát", "mất kiểm soát", "bất lực", "không làm được gì"]
    },
    {
        "slug": "duoc_cong_nhan",
        "name": "Được công nhận",
        "description": "Cần được công nhận, xác nhận cảm xúc",
        "keywords": ["công nhận", "hiểu", "biết ơn", "đánh giá cao"]
    },
    {
        "slug": "nghi_ngoi",
        "name": "Nghỉ ngơi",
        "description": "Cần nghỉ ngơi, phục hồi năng lượng",
        "keywords": ["nghỉ", "thư giãn", "phục hồi", "nạp năng lượng"]
    }
]

# High risk keywords for escalation
HIGH_RISK_KEYWORDS = [
    "muốn chết", "tự tử", "không muốn sống", "muốn kết thúc",
    "chấm dứt cuộc sống", "tự tay chấm dứt", "muốn mọi thứ kết thúc",
    "muốn mọi thứ dừng lại"
]

KEYWORD_PATTERNS = {
    "high_risk": HIGH_RISK_KEYWORDS,
    "anxiety": EMOTIONS[2]["keywords"],
    "depression": EMOTIONS[1]["keywords"],
    "fatigue": EMOTIONS[4]["keywords"],
    "anger": EMOTIONS[3]["keywords"],
    "happy": EMOTIONS[0]["keywords"]
}


@router.get("/emotions", response_model=List[EmotionResponse])
async def get_emotions():
    """Get list of all emotion definitions."""
    return [EmotionResponse(**e) for e in EMOTIONS]


@router.get("/emotions/{slug}", response_model=EmotionResponse)
async def get_emotion_by_slug(slug: str):
    """Get single emotion by slug."""
    for emotion in EMOTIONS:
        if emotion["slug"] == slug:
            return EmotionResponse(**emotion)
    raise HTTPException(status_code=404, detail=f"Emotion '{slug}' not found")


@router.get("/needs", response_model=List[NeedResponse])
async def get_needs():
    """Get list of all need definitions."""
    return [NeedResponse(**n) for n in NEEDS]


@router.get("/needs/{slug}", response_model=NeedResponse)
async def get_need_by_slug(slug: str):
    """Get single need by slug."""
    for need in NEEDS:
        if need["slug"] == slug:
            return NeedResponse(**need)
    raise HTTPException(status_code=404, detail=f"Need '{slug}' not found")


@router.get("/detection-patterns", response_model=DetectionPatternResponse)
async def get_detection_patterns():
    """Get all detection patterns for bot to use in emotion/need detection."""
    return DetectionPatternResponse(
        emotions=EMOTIONS,
        needs=NEEDS,
        keyword_patterns=KEYWORD_PATTERNS
    )


@router.get("/ai-provider")
async def get_ai_provider_info():
    """Get current AI provider configuration."""
    import os
    from backend.ai_service import get_ai_service, list_available_providers
    
    try:
        current_service = get_ai_service()
        current_provider = current_service.name
        is_available = current_service.is_available()
    except Exception as e:
        current_provider = os.getenv("AI_PROVIDER", "openai")
        is_available = False
    
    return {
        "current_provider": current_provider,
        "is_available": is_available,
        "available_providers": list_available_providers() if is_available else [],
        "env_provider": os.getenv("AI_PROVIDER", "openai")
    }
