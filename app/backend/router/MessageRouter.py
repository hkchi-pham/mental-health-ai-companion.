from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.crud import MessageCrud
from backend.response.MessageResponse import (
    MessageCreate,
    MessageRead,
    MessageResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/messages", 
    tags=["messages"])


# CREATE
@router.post("/", 
             response_model=MessageCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_message(data: MessageCreate, session: Session = Depends(get_db)):
    try:
        conv = MessageCrud.create_message(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_MESSAGE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_MESSAGE_FAILED.value)


# READ ALL BY USER
@router.get("/", 
            response_model=List[MessageRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_messages_by_convo(data: MessageRead, session: Session = Depends(get_db)):
    try:
        user = data.user_id
        if not user:
            return HTTPException(status_code=404, detail=MessageCode.USER_NOT_FOUND.value)
        result =  MessageCrud.get_messages_by_user(session, user_id=data.user_id,page=1,page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_MESSAGE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_MESSAGE_FAILED.value)
# READ ALL BY CONVO
@router.get("/", 
            response_model=List[MessageRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_messages(data: MessageRead,session: Session = Depends(get_db)):
    try:
        convo = data.conversation_id
        if not convo:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND)
        result =  MessageCrud.get_messages_by_convo(session, convo_id=data.conversation_id,page=1, page_size=10)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_MESSAGE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_MESSAGE_FAILED.value)


# READ ONE
@router.get("/{message_id}", 
            response_model=MessageResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_message(message_id: str, session: Session = Depends(get_db)):
    try: 
        conv = MessageCrud.get_message_by_id(session, message_id)
        if not conv:
            return HTTPException(status_code=404, detail=MessageCode.MESSAGE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.GET_MESSAGE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_MESSAGE_FAILED.value)
        
      