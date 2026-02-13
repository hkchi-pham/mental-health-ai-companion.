from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session, select, text
from config.database import get_db
from backend.models.ActionModel import ActionModel
from typing import List, Optional, Dict, Any
from pydantic import BaseModel

router = APIRouter(
    prefix="/actions",
    tags=["actions"]
)


# Request/Response Models
class SearchRequest(BaseModel):
    query: str
    emotion_slug: Optional[str] = None
    need_slug: Optional[str] = None
    tags: Optional[List[str]] = None
    stage: Optional[int] = None
    limit: int = 5

class ActionResponse(BaseModel):
    slug: str
    name: str
    description: Optional[str]
    type: str
    prompt_template: Optional[str]
    score: float
    match_reason: Optional[str]

class SearchResponse(BaseModel):
    success: bool
    data: List[ActionResponse]
    metadata: Dict[str, Any]

class RecommendRequest(BaseModel):
    emotion_slug: str
    need_slug: str
    stage: int
    exclude_slugs: List[str] = []
    limit: int = 3

class RecommendResponse(BaseModel):
    success: bool
    data: List[Dict[str, Any]]


@router.post("/search", response_model=SearchResponse)
def search_actions(req: SearchRequest, session: Session = Depends(get_db)):
    """
    Search actions using keyword-based full-text search and filter matching.
    No AI/ML models are used - only database queries.
    """
    try:
        candidates = {}
        
        # 1. Full-text search using PostgreSQL tsvector
        text_res = session.exec(
            text("""
                SELECT slug, 
                       ts_rank(to_tsvector('simple', search_text), plainto_tsquery('simple', :query)) as score 
                FROM actions 
                WHERE active = true
                  AND to_tsvector('simple', search_text) @@ plainto_tsquery('simple', :query)
                  AND (:stage IS NULL OR (stage_min <= :stage AND stage_max >= :stage))
                LIMIT 50
            """),
            params={"query": req.query, "stage": req.stage}
        ).all()
        
        for row in text_res:
            act = session.exec(select(ActionModel).where(ActionModel.slug == row.slug)).first()
            if act:
                candidates[act.slug] = {"action": act, "text_score": row.score}

        # 2. If no text results, fallback to filter-based search
        if not candidates:
            query = select(ActionModel).where(ActionModel.active == True)
            
            if req.stage:
                query = query.where(ActionModel.stage_min <= req.stage).where(ActionModel.stage_max >= req.stage)
            
            actions = session.exec(query.limit(50)).all()
            for act in actions:
                candidates[act.slug] = {"action": act, "text_score": 0}

        # 3. Compute final score with filter matching
        final_results = []
        for slug, cand in candidates.items():
            act = cand["action"]
            
            # Filter score based on emotion/need matching
            filter_score = 0
            if req.emotion_slug and act.target_emotions and req.emotion_slug in act.target_emotions:
                filter_score += 0.5
            if req.need_slug and act.target_needs and req.need_slug in act.target_needs:
                filter_score += 0.5
            
            # Stage check
            if req.stage and (req.stage < act.stage_min or req.stage > act.stage_max):
                continue
            
            # Combine text score (60%) and filter score (40%)
            text_score = cand["text_score"]
            final_score = (0.6 * text_score) + (0.4 * filter_score)
            
            # Priority boost
            priority = float(act.priority_score) if act.priority_score else 0.5
            final_score *= (1 + priority * 0.2)
            
            final_results.append({
                "slug": act.slug,
                "name": act.name,
                "description": act.description,
                "type": act.type,
                "prompt_template": act.prompt_template,
                "score": final_score,
                "match_reason": f"text={text_score:.2f}, filter={filter_score}"
            })
            
        final_results.sort(key=lambda x: x["score"], reverse=True)
        final_results = final_results[:req.limit]
        
        return SearchResponse(
            success=True,
            data=final_results,
            metadata={"total_found": len(final_results), "search_type": "keyword"}
        )
        
    except Exception as e:
        print(f"Error search: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/{slug}")
def get_action(slug: str, session: Session = Depends(get_db)):
    """Get a single action by slug."""
    action = session.exec(select(ActionModel).where(ActionModel.slug == slug)).first()
    if not action:
        raise HTTPException(status_code=404, detail="Action not found")
    return {"success": True, "data": action}


@router.get("/")
def list_actions(
    emotion_slug: Optional[str] = None,
    need_slug: Optional[str] = None,
    stage: Optional[int] = None,
    action_type: Optional[str] = None,
    active_only: bool = True,
    limit: int = 20,
    offset: int = 0,
    session: Session = Depends(get_db)
):
    """List actions with optional filters."""
    try:
        query = select(ActionModel)
        
        if active_only:
            query = query.where(ActionModel.active == True)
        
        if stage:
            query = query.where(ActionModel.stage_min <= stage).where(ActionModel.stage_max >= stage)
        
        if action_type:
            query = query.where(ActionModel.type == action_type)
        
        query = query.offset(offset).limit(limit)
        actions = session.exec(query).all()
        
        # Filter by emotion/need in Python (since array contains is complex in SQLModel)
        if emotion_slug or need_slug:
            filtered = []
            for act in actions:
                if emotion_slug and act.target_emotions and emotion_slug not in act.target_emotions:
                    continue
                if need_slug and act.target_needs and need_slug not in act.target_needs:
                    continue
                filtered.append(act)
            actions = filtered
        
        return {
            "success": True,
            "data": actions,
            "metadata": {"count": len(actions), "offset": offset, "limit": limit}
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/recommend", response_model=RecommendResponse)
def recommend_actions(req: RecommendRequest, session: Session = Depends(get_db)):
    """
    Recommend actions based on emotion, need, and stage filters.
    Uses simple filter matching and priority scoring - no ML models.
    """
    try:
        query = select(ActionModel).where(ActionModel.active == True)
        
        # Stage filter
        query = query.where(ActionModel.stage_min <= req.stage).where(ActionModel.stage_max >= req.stage)
        
        # Exclude already used actions
        if req.exclude_slugs:
            query = query.where(ActionModel.slug.not_in(req.exclude_slugs))
            
        actions = session.exec(query).all()
        
        scored = []
        for act in actions:
            score = 0
            
            # Score based on emotion matching
            if act.target_emotions and req.emotion_slug in act.target_emotions:
                score += 1.0
                
            # Score based on need matching  
            if act.target_needs and req.need_slug in act.target_needs:
                score += 1.0
                
            # Add priority boost
            if act.priority_score:
                score += (act.priority_score * 0.5)
            
            if score > 0:
                scored.append({"action": act, "score": score})
                
        scored.sort(key=lambda x: x["score"], reverse=True)
        top = scored[:req.limit]
        
        data = []
        for item in top:
            act = item["action"]
            data.append({
                "slug": act.slug,
                "name": act.name,
                "description": act.description,
                "type": act.type,
                "score": item["score"],
                "reason": "emotion/need match"
            })
            
        return RecommendResponse(success=True, data=data)
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
