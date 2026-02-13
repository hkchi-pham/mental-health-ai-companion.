from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.crud import MessageCrud
from backend.response.MessageResponse import (
    MessageCreate,
    MessageRead,
    MessageResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from typing import List, Optional, Dict, Any
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel
from pydantic import BaseModel

router = APIRouter(
    prefix="/messages", 
    tags=["messages"])


# Request/Response models for AI chat
class AIChatRequest(BaseModel):
    conversation_id: str
    content: str
    message_type: str = "text"


class EmotionAnalysisResponse(BaseModel):
    mood: str
    confidence: float
    suggested_tone: str
    coaching_tips: List[str]


class AIChatResponse(BaseModel):
    user_message_id: Optional[str] = None
    ai_response: str
    emotion_analysis: EmotionAnalysisResponse
    action_recommendation: Optional[Dict[str, Any]] = None
    provider: str


# CREATE - with AI integration
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
async def create_message(
    data: MessageCreate,
    current_user: UserModel = Depends(get_current_user), 
    session: Session = Depends(get_db)
):
    """
    Create a user message and generate AI response.
    
    Flow:
    1. Save user message
    2. Get last 5 messages for context
    3. Call Gemini AI to generate response
    4. Save AI response
    5. Return both user message and AI response
    """
    import traceback
    try:
        from backend.ai_service import get_ai_service
        
        # 1. Save user message
        data.sender_id = current_user.id
        MessageCrud.create_message(session, data)
        
        # 2. Get last 5 messages for context
        recent_messages = MessageCrud.get_recent_messages(
            session, 
            convo_id=data.conversation_id, 
            limit=5
        )
        
        chat_history = []
        for msg in recent_messages:
            role = "assistant" if msg.message_type == "ai" else "user"
            chat_history.append({
                "role": role,
                "content": msg.content or ""
            })
        
        # 3. Call Gemini AI
        ai_service = get_ai_service()
        ai_result = await ai_service.process_message(
            message=data.content,
            chat_history=chat_history
        )
        
        # 4. Save AI response
        ai_message = MessageCreate(
            sender_id="ai_assistant",
            conversation_id=data.conversation_id,
            content=ai_result.content,
            message_type="ai"
        )
        MessageCrud.create_message(session, ai_message)
        session.commit()  # Explicit commit to ensure AI message is saved
        
        # 5. Return response
        emotion_data = {}
        if ai_result.emotion_analysis:
            emotion_data = {
                "mood": ai_result.emotion_analysis.mood,
                "confidence": ai_result.emotion_analysis.confidence,
                "suggested_tone": ai_result.emotion_analysis.suggested_tone,
            }
        
        return {
            "message": "Message created successfully",
            "ai_response": ai_result.content,
            "emotion": emotion_data,
            "provider": ai_result.metadata.get("provider", "unknown") if ai_result.metadata else "unknown"
        }
        
    except Exception as e:
        print(f"=== ERROR in create_message: {str(e)} ===")
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=str(e))



# AI CHAT - Process message with AI and return response
@router.post("/chat", 
             response_model=AIChatResponse,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
async def chat_with_ai(
    data: AIChatRequest,
    current_user: UserModel = Depends(get_current_user), 
    session: Session = Depends(get_db)
):
    """
    Send a message and get AI response.
    
    Flow:
    1. Save user message
    2. Get chat history for context
    3. Call AI service to analyze emotion and generate response
    4. Save AI response as new message
    5. Return AI response with emotion analysis
    """
    try:
        from backend.ai_service import get_ai_service
        
        # 1. Save user message
        user_message_data = MessageCreate(
            sender_id=current_user.id,
            conversation_id=data.conversation_id,
            content=data.content,
            message_type=data.message_type
        )
        MessageCrud.create_message(session, user_message_data)
        
        # 2. Get chat history for context
        history_result = MessageCrud.get_messages_by_convo(
            session, 
            user_id=current_user.id,
            convo_id=data.conversation_id, 
            page=1, 
            page_size=20
        )
        
        chat_history = []
        if history_result and history_result.get("items"):
            for msg in history_result["items"]:
                role = "assistant" if msg.get("message_type") == "ai" else "user"
                chat_history.append({
                    "role": role,
                    "content": msg.get("content", "")
                })
        
        # 3. Get AI service and process message
        ai_service = get_ai_service()
        
        ai_result = await ai_service.process_message(
            message=data.content,
            chat_history=chat_history
        )
        
        # 4. Save AI response as new message
        ai_message_data = MessageCreate(
            sender_id="ai_assistant",
            conversation_id=data.conversation_id,
            content=ai_result.content,
            message_type="ai"
        )
        MessageCrud.create_message(session, ai_message_data)
        
        # 5. Return response
        return AIChatResponse(
            ai_response=ai_result.content,
            emotion_analysis=EmotionAnalysisResponse(
                mood=ai_result.emotion_analysis.mood,
                confidence=ai_result.emotion_analysis.confidence,
                suggested_tone=ai_result.emotion_analysis.suggested_tone,
                coaching_tips=ai_result.emotion_analysis.coaching_tips
            ),
            action_recommendation=ai_result.action_recommendation,
            provider=ai_result.metadata.get("provider", "unknown") if ai_result.metadata else "unknown"
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/search-all-messages",
            response_model=PaginatedResponse[MessageResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_messages(
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    message_type: Optional[str]= None,
    start_time: Optional[datetime]= None,
    end_time: Optional[datetime]= None,
    session: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100)
):
    try:
        print("search messages")
        results = MessageCrud.search_messages(
            session=session,
            q=q,
            sender_id=current_user.id,
            message_type=message_type,
            start_time=start_time,
            end_time=end_time
        )

        if not results:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        
        return PaginatedResponse[MessageResponse](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=results["items"],
            total=results["total"],
            page=results["page"],
            page_size=results["page_size"],
            total_pages=results["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# READ ALL BY USER
@router.get("/user/{user_id}", 
            response_model=PaginatedResponse[MessageRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_messages_by_user(current_user: UserModel = Depends(get_current_user), page: int = 1, page_size: int = 10, session: Session = Depends(get_db)):
    try:
        if current_user is None :
            return HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        
        result =  MessageCrud.get_messages_by_user(session, user_id=current_user.id, page=1,page_size=10)

        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)

        return PaginatedResponse[MessageRead](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
# READ ALL BY CONVO
@router.get("/conversation/{convo_id}", 
            response_model=PaginatedResponse[MessageRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_messages_by_convo(convo_id: str,current_user: UserModel = Depends(get_current_user), page: int = 1, page_size: int = 10,session: Session = Depends(get_db)):
    try:
        convo = convo_id
        if convo == None:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND)
        result =  MessageCrud.get_messages_by_convo(session, user_id=current_user.id,convo_id=convo_id,page=1, page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return PaginatedResponse[MessageRead](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# READ ONE
@router.get("/{message_id}", 
            response_model=MessageResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_message(message_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        result = MessageCrud.get_message_by_id(session, message_id,current_user.id)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return SuccessResponse[MessageResponse](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data = result
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
      