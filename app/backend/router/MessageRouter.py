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
from backend.services.action_suggestion import lookup_curated_action
from backend.services.mood_streak import parse_prepended_mood, detect_streak_mood
from backend.services import suggestion_state

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
        
    except HTTPException:
        raise
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

    Shared-pipeline flow (provider-agnostic):
    1. Save user message
    2. Get chat history for context (last 20 messages)
    3. Analyze emotion of current message (analyze_emotion, not process_message)
    4. Build ordered user-mood list from real history (streak reachable from typed msgs)
    5. Read per-conversation suggestion state (last_fired_index, shown_slugs)
    6. Detect mood streak (3-of-last-5 fresh same mood, reset-after-firing cursor)
    7. If streak fires: lookup curated action (exclude already-shown slugs)
    8. Generate AI response (generate_response with optional action_context)
    9. Save AI response; record_fire if a card fired
    10. Return AIChatResponse with action_recommendation from shared lookup
    """
    import logging
    logger = logging.getLogger(__name__)

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

        # 2. Get chat history for context (last 20 messages, ascending order)
        history_result = MessageCrud.get_messages_by_convo(
            session,
            user_id=current_user.id,
            convo_id=data.conversation_id,
            page=1,
            page_size=20
        )

        chat_history = []
        history_items = []
        if history_result and history_result.get("items"):
            history_items = history_result["items"]
            for msg in history_items:
                role = "assistant" if msg.get("message_type") == "ai" else "user"
                chat_history.append({
                    "role": role,
                    "content": msg.get("content", "")
                })

        # 3. Get AI service and analyze emotion of the current message
        ai_service = get_ai_service()
        emotion = await ai_service.analyze_emotion(data.content, chat_history)

        # -------------------------------------------------------------------
        # 4–8. Shared suggestion pipeline (try/except → degrade to no card)
        # -------------------------------------------------------------------
        action_ctx: Optional[Dict[str, Any]] = None
        current_index = 0

        try:
            # 4. Build ordered user-mood list from real history.
            #    Cap re-analysis to the last ~5 user messages (streak window = 5).
            #    Current message's mood: manual chip wins over AI-detected.
            current_mood = parse_prepended_mood(data.content) or emotion.mood

            # Collect all user messages from history (ascending by created_at).
            user_msgs = [
                msg for msg in history_items
                if msg.get("message_type") != "ai"
            ]

            # Only need to re-analyze the last 5 user messages for the window.
            # The current message is already in history (saved in step 1), so
            # it appears as the last user entry.
            recent_user_msgs = user_msgs[-5:]

            recent_user_moods: List[str] = []
            for i, msg in enumerate(recent_user_msgs):
                content = msg.get("content", "")
                # Is this the current user message? (last item in the window)
                is_current = (i == len(recent_user_msgs) - 1) and content == data.content
                if is_current:
                    # Use chip-derived or AI-analyzed mood for the current msg
                    recent_user_moods.append(current_mood)
                else:
                    # Try chip parse first; fall back to cheap AI keyword scan
                    chip_mood = parse_prepended_mood(content)
                    if chip_mood:
                        recent_user_moods.append(chip_mood)
                    else:
                        # keyword fast-path — cheap, provider-agnostic
                        hist_emotion = await ai_service.analyze_emotion(content)
                        recent_user_moods.append(hist_emotion.mood)

            # current_index is the position of the current message in the
            # FULL ordered user-message subsequence (not just the recent slice).
            current_index = len(user_msgs) - 1 if user_msgs else 0

            # Align recent_user_moods indices with the full user-msg sequence.
            # detect_streak_mood uses the index within the passed list, so we
            # need to pass the moods starting from the offset of the slice.
            #
            # Strategy: pass the full user-mood list by reconstructing it from
            # the (cheap) already-analyzed slice plus placeholder moods for
            # older messages beyond the window (they won't affect the 5-window).
            #
            # Simpler: reconstruct a list of length len(user_msgs) where the
            # last min(5, len(user_msgs)) entries are the re-analyzed moods and
            # the earlier entries use the current_mood as a neutral placeholder
            # (they are beyond the 5-window and will not be counted anyway).
            offset = len(user_msgs) - len(recent_user_msgs)
            full_user_moods = (
                [current_mood] * offset  # placeholder — beyond the 5-window
                + recent_user_moods
            )

            # 5. Read per-conversation suggestion state
            state = suggestion_state.get_or_create(session, data.conversation_id)
            last_fired_index = state.last_fired_index
            exclude_slugs = list(state.shown_slugs or [])

            # 6. Detect mood streak (reset-after-firing cursor enforced)
            streak_mood = detect_streak_mood(
                full_user_moods,
                current_index=current_index,
                last_fired_index=last_fired_index,
            )

            # 7. Lookup curated action if streak fires
            if streak_mood:
                action_ctx = lookup_curated_action(
                    session,
                    streak_mood,
                    emotion.confidence,
                    message_count=len(chat_history),
                    exclude_slugs=set(exclude_slugs),
                )

        except Exception as suggestion_err:
            logger.warning(
                "chat_with_ai: suggestion pipeline failed — degrading to no card. %s: %s",
                type(suggestion_err).__name__, suggestion_err,
            )
            action_ctx = None

        # 8. Generate AI response (explicit analyze+generate so action_context threads)
        ai_result = await ai_service.generate_response(
            message=data.content,
            emotion_context=emotion,
            chat_history=chat_history,
            action_context=action_ctx,
        )
        # Ensure emotion_analysis is populated from our already-computed result
        ai_result.emotion_analysis = emotion

        # 9. Save AI response; record_fire if a card actually fired
        ai_message_data = MessageCreate(
            sender_id="ai_assistant",
            conversation_id=data.conversation_id,
            content=ai_result.content,
            message_type="ai"
        )
        MessageCrud.create_message(session, ai_message_data)

        if action_ctx is not None:
            try:
                suggestion_state.record_fire(
                    session,
                    data.conversation_id,
                    current_index,
                    action_ctx.get("slug"),
                )
            except Exception as record_err:
                logger.warning(
                    "chat_with_ai: record_fire failed — card shown but state not persisted. %s: %s",
                    type(record_err).__name__, record_err,
                )

        # 10. Return response — action_recommendation populated by the shared
        #     router lookup, NOT the provider, so it is identical across providers.
        return AIChatResponse(
            ai_response=ai_result.content,
            emotion_analysis=EmotionAnalysisResponse(
                mood=emotion.mood,
                confidence=emotion.confidence,
                suggested_tone=emotion.suggested_tone,
                coaching_tips=emotion.coaching_tips
            ),
            action_recommendation=action_ctx,
            provider=ai_result.metadata.get("provider", "unknown") if ai_result.metadata else "unknown"
        )

    except HTTPException:
        raise
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
            raise HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        
        return PaginatedResponse[MessageResponse](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=results["items"],
            total=results["total"],
            page=results["page"],
            page_size=results["page_size"],
            total_pages=results["total_pages"]
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# READ ALL BY USER
@router.get("/user/{user_id}", 
            response_model=PaginatedResponse[MessageRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_messages_by_user(current_user: UserModel = Depends(get_current_user), page: int = 1, page_size: int = 10, session: Session = Depends(get_db)):
    try:
        if current_user is None :
            raise HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        
        result =  MessageCrud.get_messages_by_user(session, user_id=current_user.id, page=1,page_size=10)

        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)

        return PaginatedResponse[MessageRead](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except HTTPException:
        raise
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
            raise HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND)
        result =  MessageCrud.get_messages_by_convo(session, user_id=current_user.id,convo_id=convo_id,page=1, page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return PaginatedResponse[MessageRead](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except HTTPException:
        raise
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
            raise HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return SuccessResponse[MessageResponse](
            message=MessageCode.GET_MESSAGE_SUCCESSFULLY.value,
            data = result
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
      