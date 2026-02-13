from sqlmodel import Session, select
from typing import List, Optional
from backend.models.ChatbotBaseModel import *


def search_filter_data(
    session: Session,
    id: str= None,
    key: str=None,
    emotion_id: str = None,
    need_id: str = None,
):
    if key == "needs":
        query = session.query(NeedModel)
        if id:
            query = query.filter(NeedModel.id == id)
        
        statement = query.all()
        return statement
    
    if key == "emotions":
        query = session.query(EmotionModel)
        if id:
            query = query.filter(EmotionModel.id == id)
        statement = query.all()
        return statement
    
    if key == "actions":
        query = session.query(ActionModel)
        if emotion_id and need_id:
            # 1. lấy id của bảng emotion_need_link cho hai emotion và need trên
            # 2. lấy list id các action bằng id(emotion_need_link) trong bảng emotion_need_action_map



