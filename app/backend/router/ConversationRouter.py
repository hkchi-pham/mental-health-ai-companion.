from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List, Optional
from config.database import get_db
from backend.crud import ConversationCrud
from backend.response.ConversationResponse import (
    ConversationCreate,
    ConversationRead,
    ConversationUpdate,
    ConversationResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from datetime import datetime
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel

router = APIRouter(
    prefix="/conversations", 
    tags=["conversations"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_conversation(data: ConversationCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        print("start create convo")
        data.user_id = current_user.id  # Use .id not full UserModel
        conv = ConversationCrud.create_conversation(session, data)
        return {"message": MessageCode.CREATE_CONVERSATION_SUCCESSFULLY.value, "success": True}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/search-all-conversations",
            response_model=PaginatedResponse[ConversationResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def search_all_conversations(
    q: Optional[str]= None,
    current_user: UserModel = Depends(get_current_user),
    start_from: Optional[datetime]= None,
    ended_to: Optional[datetime]= None,
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    session: Session = Depends(get_db)
):
    try:
        print("search convos")
        results = ConversationCrud.search_conversations(
            session=session,
            user_id=current_user.id,
            q=q,
            start_from=start_from,
            ended_to=ended_to,
            page=page,
            page_size=page_size
        )
        print(results)
        if not results:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        
        return PaginatedResponse[ConversationResponse](
            message= MessageCode.GET_CONVERSATION_SUCCESSFULLY.value,
            data=results["items"],
            total=results["total"],
            page=results["page"],
            page_size=results["page_size"],
            total_pages=results["total_pages"]
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
# READ ALL
@router.get("/",
            response_model=PaginatedResponse[ConversationResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_all_conversations(session: Session = Depends(get_db),current_user: UserModel = Depends(get_current_user),):
    try:
        print("start get convo")
        result =  ConversationCrud.get_all_conversations(session,current_user.id,page=1,page_size=10)
        print("got convo")
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        return PaginatedResponse[ConversationResponse](
            message="",
            data=result["items"],
            total=result["total"],
            page=result["page"],
            page_size=result["page_size"],
            total_pages=result["total_pages"]
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# READ ONE
@router.get("/{conv_id}", 
            response_model=SuccessResponse[ConversationResponse],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_conversation(conv_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        print("start get conv by id")
        conv = ConversationCrud.get_conversation_by_id(session,current_user.id, conv_id)
        print("got conv by id")
        if conv==None:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        return SuccessResponse[ConversationResponse](
            message=MessageCode.GET_CONVERSATION_SUCCESSFULLY.value,
            data=conv
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
                        


# UPDATE
@router.put("/{conv_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def update_conversation(conv_id: str, data: ConversationUpdate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        conv = ConversationCrud.update_conversation(session, conv_id,current_user.id,data)
        if not conv:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# DELETE
@router.delete("/{conv_id}", 
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_conversation(conv_id: str,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        success = ConversationCrud.delete_conversation(session, current_user.id,conv_id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.CONVERSATION_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_CONVERSATION_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
