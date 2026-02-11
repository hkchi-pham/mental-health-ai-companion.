from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session
from typing import List
from config.database import get_db
from backend.crud import TreeCrud
from backend.response.TreeResponse import (
    TreeCreate,
    TreeRead,
    TreeUpdate,
    TreeResponse,
)
from backend.response.CommonResponse import SuccessResponse, MessageCode, ErrorResponse, PaginatedResponse
from typing import Optional
from datetime import datetime

router = APIRouter(
    prefix="/mood_logs", 
    tags=["mood_logs"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_tree(data: TreeCreate, session: Session = Depends(get_db)):
    try:
        tree = TreeCrud.create_tree(session, data)
        return HTTPException(status_code=200, detail=MessageCode.CREATE_TREE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_TREE_FAILED.value)




# READ ALL
@router.get("/", 
            response_model=PaginatedResponse[TreeRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def get_tree_by_user(session: Session = Depends(get_db),user_id:str):
    try:
        result =  TreeCrud.get_tree_by_user(session, user_id)
        if not result:
            return HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return PaginatedResponse[TreeResponse](
            message=MessageCode.GET_TREE_SUCCESSFULLY.value
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_TREE_FAILED.value)


# UPDATE
@router.put("/{tree_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def water_tree(user_id:str, session: Session = Depends(get_db)):
    try: 
        tree = TreeCrud.water_tree(session,user_id)
        if not tree:
            return HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)

@router.put("/{tree_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def change_tree(user_id:str, new_type: str, session: Session = Depends(get_db)):
    try: 
        tree = TreeCrud.change_tree(session,user_id,new_type)
        if not tree:
            return HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)

 @router.put("/{tree_id}",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def grow_new_tree(user_id:str, data: TreeCreate, session: Session = Depends(get_db)):
    try: 
        tree = TreeCrud.grow_new_tree(session,user_id,data)
        if not tree:
            return HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return HTTPException(status_code=200, detail=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)


# DELETE
@router.delete("/{tree_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_tree(tree_id: str, session: Session = Depends(get_db)):
    try: 
        print("delete tree")
        success = TreeCrud.delete_tree(session,tree_id)
        if not success:
            return HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND)
        return HTTPException(status_code=200, detail=MessageCode.DELETE_TREE_SUCCESSFULLY.value)
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_TREE_FAILED.value)
