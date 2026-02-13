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
from typing import List, Optional
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel

router = APIRouter(
    prefix="/messages", 
    tags=["messages"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_message(data: MessageCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        print("create message")
        message_old = MessageCrud.get_messages_by_convo(session, data.conversation_id, page=1, page_size=10)
        data.sender_id = current_user.id
        mess = MessageCrud.create_message(session, data)
        print("mess")
        return HTTPException(status_code=200, detail=MessageCode.CREATE_MESSAGE_SUCCESSFULLY.value)
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
        
      