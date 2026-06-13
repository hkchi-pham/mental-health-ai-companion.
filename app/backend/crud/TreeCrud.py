from sqlmodel import Session, select
from fastapi import HTTPException
from typing import List, Optional
from backend.models.TreeModel import TreeModel
from backend.response.TreeResponse import TreeCreate
from backend.models.UserModel import UserModel
from backend import utils
from datetime import datetime
from fastapi.encoders import jsonable_encoder
from sqlalchemy import func, or_, desc, asc

def create_tree(db: Session, data: TreeCreate):
    tree = TreeModel(**data.dict())
    db.add(tree)
    db.commit()
    db.refresh(tree)
    return True

def get_tree_by_user(db: Session, user_id: str):
    trees = db.exec(
        select(TreeModel).where(
            TreeModel.user_id == user_id,
            TreeModel.deleted_at.is_(None),
        )
    ).all()

    # Always a list (possibly empty) so the caller can build a PaginatedResponse.
    return jsonable_encoder(trees)

def water_tree(db: Session, user_id : str):
    tree = db.exec(
        select(TreeModel).where(TreeModel.user_id == user_id)
    ).first()
    user =  db.exec(
        select(UserModel).where(UserModel.id == user_id)
    ).first()

    amount = user.points//10

    if user.water_units < amount:
        return False
    
    user.water_units -= amount

    if tree.health < 100:
        heal_needed = 100 - tree.health
        heal_water = min(amount, heal_needed//10)

        tree.health += heal_water *10
        amount -= heal_water
    
    if amount > 0:
        tree.growth_points += amount * 5
    
    while tree.level < 5:
        required = 80
        if tree.growth_points >= required:
            tree.growth_points -= required
            tree.level += 1
        else:
            break 
    
    db.commit()
    db.refresh(tree)
    db.refresh(user)
    return True

def change_tree(db: Session,user_id:str, new_type: str):
    tree = db.exec(select(TreeModel).where(TreeModel.user_id == user_id)).first()

    if not tree:
        return False
    
    tree.tree_type = new_type

    db.commit()
    db.refresh(tree)
    return True

def grow_new_tree(db: Session, data: TreeCreate):
    tree = db.exec(select(TreeModel).where(TreeModel.user_id == data.user_id)).first()

    if not tree:
        return False
    
    tree.deleted_at = utils.get_current_time()
    db.add(tree)
    db.commit()

    new_tree = TreeModel(**data.dict())

    db.add(new_tree)
    db.commit()
    db.refresh(new_tree)
    return True

def delete_tree(db: Session, user_id: str):
    tree = db.exec(select(TreeModel).where(TreeModel.user_id == user_id)).first()

    if not tree:
        return False
    
    tree.deleted_at = utils.get_current_time()
    db.add(tree)
    db.commit()



            
            
        
        



    


