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
from backend.security.Authentication import get_current_user
from backend.models.UserModel import UserModel
from typing import Optional
from datetime import datetime

router = APIRouter(
    prefix="/tree", 
    tags=["tree"])


# CREATE
@router.post("/", 
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def create_tree(data: TreeCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try:
        data.user_id = current_user.id
        tree = TreeCrud.create_tree(session, data)
        return SuccessResponse(message=MessageCode.CREATE_TREE_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.CREATE_TREE_FAILED.value)




# READ ALL
@router.get("/", 
            response_model=PaginatedResponse[TreeRead],
            responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
async def get_tree_by_user(
    session: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user)
):
    try:
        result = TreeCrud.get_tree_by_user(session, current_user.id)
        # A user with no tree is a valid empty collection, not a 404.
        return PaginatedResponse[TreeRead](
            message=MessageCode.GET_TREE_SUCCESSFULLY.value,
            data=result,
            total=len(result),
            page=1,
            page_size=len(result),
            total_pages=1 if result else 0,
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.GET_TREE_FAILED.value)


# UPDATE
@router.put("/{tree_id}/water",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def water_tree(current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        user_id = current_user.id
        tree = TreeCrud.water_tree(session,user_id)
        if not tree:
            raise HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)

@router.put("/{tree_id}/type", responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def change_tree(new_type: str, current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        user_id = current_user.id
        tree = TreeCrud.change_tree(session,user_id,new_type)
        if not tree:
            raise HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)

@router.post("/{tree_id}/grow",
             responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def grow_new_tree( data: TreeCreate,current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        user_id = current_user.id
        tree = TreeCrud.grow_new_tree(session,user_id,data)
        if not tree:
            raise HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND.value)
        return SuccessResponse(message=MessageCode.UPDATE_TREE_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.UPDATE_TREE_FAILED.value)


# DELETE
@router.delete("/{tree_id}", 
               responses={404: {"model": ErrorResponse}, 500: {"model": ErrorResponse}})
def delete_tree(current_user: UserModel = Depends(get_current_user), session: Session = Depends(get_db)):
    try: 
        print("delete tree")
        success = TreeCrud.delete_tree(session,current_user.id)
        if not success:
            raise HTTPException(status_code=404, detail=MessageCode.TREE_NOT_FOUND)
        return SuccessResponse(message=MessageCode.DELETE_TREE_SUCCESSFULLY.value)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=MessageCode.DELETE_TREE_FAILED.value)
