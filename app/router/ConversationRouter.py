from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from typing import List
from app.config.database import get_db
from app.crud import ConversationCrud
from app.response.ConversationResponse import (
    ConversationCreate,
    ConversationRead,
    ConversationUpdate,
    ConversationResponse,
)
from app.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse

router = APIRouter(
    prefix="/conversations", 
    tags=["conversations"])


# CREATE
@router.post("/", 
             response_model=ConversationCreate,
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_conversation(data: ConversationCreate, session: Session = Depends(get_db)):
    try:
        conv = ConversationCrud.create_conversation(session, data)
        raise HTTPException(status_code=200, detail=MessageCode.CREATE_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_CONVERSATION_FAILED.value)


# READ ALL
@router.get("/", 
            response_model=List[ConversationRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_conversations(session: Session = Depends(get_db)):
    try:
        result =  ConversationCrud.get_all_conversations(session,page=1,page_size=10)
        if not result:
            raise HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONVERSATION_FAILED.value)


# READ ONE
@router.get("/{conv_id}", 
            response_model=ConversationResponse,
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_conversation(conv_id: str, session: Session = Depends(get_db)):
    try: 
        conv = ConversationCrud.get_conversation_by_id(session, conv_id)
        if not conv:
            raise HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.GET_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_CONVERSATION_FAILED.value)
        
                        


# UPDATE
@router.put("/{conv_id}",
             response_model=SuccessResponse[ConversationRead],
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_conversation(conv_id: str, data: ConversationUpdate, session: Session = Depends(get_db)):
    try: 
        conv = ConversationCrud.update_conversation(session, conv_id,data)
        if not conv:
            raise HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        raise HTTPException(status_code=200, detail=MessageCode.UPDATE_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_CONVERSATION_FAILED.value)


# DELETE
@router.delete("/{conv_id}", 
               response_model=SuccessResponse[None],
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_conversation(conv_id: str, session: Session = Depends(get_db)):
    try: 
        success = ConversationCrud.delete_conversation(session, conv_id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND)
        raise HTTPException(status_code=200, detail=MessageCode.DELETE_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_CONVERSATION_FAILED.value)
