# Action Search API - Implementation Handoff

> **Mục đích**: Document này dùng để handoff sang project Search API. Project đó sẽ build APIs để project chatbot (medihome-ai-bot) gọi lấy actions phù hợp.

---

## 1. Tổng quan kiến trúc

```
┌─────────────────────┐      API calls       ┌─────────────────────┐
│  medihome-ai-bot    │ ──────────────────▶  │  Search API Project │
│  (Chatbot Client)   │                      │  (Vector + DB)      │
│                     │ ◀──────────────────  │                     │
│  - Nhận message     │    JSON response     │  - PostgreSQL       │
│  - Detect emotion   │                      │  - Vector DB        │
│  - Call Search API  │                      │  - Embedding model  │
│  - Return action    │                      │  - Search logic     │
└─────────────────────┘                      └─────────────────────┘
```

---

## 2. Database Schema

### 2.1 Actions Table (Extended)

```sql
CREATE TABLE actions (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL CHECK (type IN ('tip','question','exercise','info','handoff')),
  level INTEGER CHECK (level BETWEEN 1 AND 5),
  stage_min INTEGER DEFAULT 1,
  stage_max INTEGER DEFAULT 3,
  prompt_template TEXT,
  expected_outcomes TEXT,
  preconditions JSONB DEFAULT '{}'::jsonb,
  postconditions JSONB DEFAULT '{}'::jsonb,
  cooldown_seconds INTEGER DEFAULT 0,
  max_repeats INTEGER DEFAULT 3,
  domain TEXT DEFAULT 'general',
  active BOOLEAN DEFAULT TRUE,
  
  -- NEW: Search-ready fields
  search_text TEXT,                          -- Combined searchable text
  tags TEXT[] DEFAULT ARRAY[]::TEXT[],       -- ['breathing', 'relaxation', 'immediate']
  target_emotions TEXT[] DEFAULT ARRAY[]::TEXT[],  -- ['lo_lang', 'so_hai']
  target_needs TEXT[] DEFAULT ARRAY[]::TEXT[],     -- ['binh_on', 'an_toan']
  search_keywords TEXT[] DEFAULT ARRAY[]::TEXT[],  -- Vietnamese + English keywords
  synonyms TEXT[] DEFAULT ARRAY[]::TEXT[],         -- Alternative terms
  priority_score NUMERIC(3,2) DEFAULT 0.5,         -- 0.0 - 1.0
  embedding vector(768),                           -- For semantic search
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 2.2 Required Extensions

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;   -- Fuzzy text search
CREATE EXTENSION IF NOT EXISTS vector;    -- pgvector for embeddings
```

### 2.3 Indexes

```sql
-- Full-text search
CREATE INDEX idx_actions_search_text_gin 
  ON actions USING GIN (to_tsvector('simple', coalesce(search_text, '')));

-- Fuzzy matching
CREATE INDEX idx_actions_name_trgm ON actions USING GIN (name gin_trgm_ops);
CREATE INDEX idx_actions_description_trgm ON actions USING GIN (description gin_trgm_ops);

-- Vector similarity (HNSW for fast queries)
CREATE INDEX idx_actions_embedding_hnsw ON actions USING hnsw (embedding vector_cosine_ops);

-- Array fields
CREATE INDEX idx_actions_tags ON actions USING GIN (tags);
CREATE INDEX idx_actions_target_emotions ON actions USING GIN (target_emotions);
CREATE INDEX idx_actions_target_needs ON actions USING GIN (target_needs);
CREATE INDEX idx_actions_search_keywords ON actions USING GIN (search_keywords);
```

---

## 3. APIs cần implement

### 3.1 `POST /api/v1/actions/search`

**Hybrid Search** - Kết hợp vector + keyword + filters

```json
// Request
{
  "query": "mình đang rất lo lắng, tim đập nhanh",
  "emotion_slug": "lo_lang",        // optional
  "need_slug": "binh_on",           // optional
  "tags": ["immediate", "breathing"], // optional
  "stage": 1,                        // optional: 1-3
  "limit": 5,
  "search_type": "hybrid"           // "vector" | "keyword" | "hybrid"
}

// Response
{
  "success": true,
  "data": [
    {
      "slug": "tip_breathing_478",
      "name": "Thở sâu 4-7-8",
      "description": "Kỹ thuật thở giúp ổn định hệ thần kinh và giảm lo âu",
      "type": "tip",
      "prompt_template": "Hít vào 4s, giữ 7s, thở ra 8s. Lặp lại 3 lần.",
      "score": 0.95,
      "match_reason": "vector_similarity + emotion_match + keyword_match"
    },
    {
      "slug": "tip_grounding_54321",
      "name": "Bài tập 5-4-3-2-1",
      "score": 0.88,
      "match_reason": "vector_similarity + emotion_match"
    }
  ],
  "metadata": {
    "total_found": 8,
    "search_type": "hybrid",
    "took_ms": 45
  }
}
```

### 3.2 `GET /api/v1/actions/{slug}`

**Get single action by slug**

```json
// Response
{
  "success": true,
  "data": {
    "slug": "tip_breathing_478",
    "name": "Thở sâu 4-7-8",
    "description": "Kỹ thuật thở giúp ổn định hệ thần kinh và giảm lo âu",
    "type": "tip",
    "level": 1,
    "stage_min": 1,
    "stage_max": 2,
    "prompt_template": "Hít vào 4s, giữ 7s, thở ra 8s. Lặp lại 3 lần.",
    "expected_outcomes": "Cảm giác thư giãn, nhịp tim giảm",
    "domain": "behavioral",
    "target_emotions": ["lo_lang", "so_hai", "tuc_gian"],
    "target_needs": ["binh_on", "an_toan", "kiem_soat"],
    "tags": ["breathing", "relaxation", "immediate"],
    "priority_score": 0.95
  }
}
```

### 3.3 `POST /api/v1/actions/recommend`

**Recommend actions based on emotion + need**

```json
// Request
{
  "emotion_slug": "buon",
  "need_slug": "ket_noi",
  "stage": 2,
  "exclude_slugs": ["tip_message_friend"], // đã dùng rồi
  "limit": 3
}

// Response
{
  "success": true,
  "data": [
    {
      "slug": "question_social_support",
      "name": "Ai đang ở bên bạn?",
      "score": 0.90,
      "reason": "emotion_match + need_match + stage_match"
    }
  ]
}
```

### 3.4 `POST /api/v1/embeddings/generate`

**Generate embedding cho text** (dùng cho các use case khác)

```json
// Request
{
  "text": "mình đang rất buồn và cô đơn"
}

// Response
{
  "success": true,
  "data": {
    "embedding": [0.123, -0.456, ...],  // 768 dimensions
    "model": "vietnamese-bi-encoder"
  }
}
```

---

## 4. Search Logic

### 4.1 Hybrid Search Algorithm

```python
def hybrid_search(query, emotion=None, need=None, tags=None, limit=5):
    # 1. Generate query embedding
    query_embedding = embed_model.encode(query)
    
    # 2. Vector similarity search (weight: 0.4)
    vector_results = db.query("""
        SELECT *, 1 - (embedding <=> %s) as vector_score
        FROM actions
        WHERE active = true
        ORDER BY embedding <=> %s
        LIMIT 20
    """, [query_embedding, query_embedding])
    
    # 3. Full-text search (weight: 0.3)
    keyword_results = db.query("""
        SELECT *, ts_rank(to_tsvector('simple', search_text), 
                         plainto_tsquery('simple', %s)) as text_score
        FROM actions
        WHERE to_tsvector('simple', search_text) @@ plainto_tsquery('simple', %s)
    """, [query, query])
    
    # 4. Filter by emotion/need (weight: 0.3)
    if emotion:
        filter_results = db.query("""
            SELECT * FROM actions WHERE %s = ANY(target_emotions)
        """, [emotion])
    
    # 5. Merge & rank
    final_score = 0.4 * vector_score + 0.3 * text_score + 0.3 * filter_score
    
    # 6. Apply priority_score boost
    final_score *= (1 + priority_score * 0.2)
    
    return sorted(results, key=lambda x: x.final_score, reverse=True)[:limit]
```

### 4.2 Scoring Weights

| Factor | Weight | Description |
|--------|--------|-------------|
| Vector similarity | 0.4 | Semantic meaning match |
| Keyword match | 0.3 | Exact/fuzzy keyword match |
| Emotion/Need match | 0.3 | Filter match bonus |
| Priority score | +20% boost | Important actions get boost |

---

## 5. Integration Flow (Chatbot side)

```python
# Trong medihome-ai-bot

async def get_recommended_action(user_message: str, emotion: str, need: str):
    """Call Search API to get recommended action"""
    
    response = await httpx.post(
        f"{SEARCH_API_URL}/api/v1/actions/search",
        json={
            "query": user_message,
            "emotion_slug": emotion,
            "need_slug": need,
            "stage": current_stage,
            "limit": 3,
            "search_type": "hybrid"
        }
    )
    
    if response.status_code == 200:
        data = response.json()
        if data["data"]:
            return data["data"][0]  # Top match
    
    return None

# Usage in agent.py
action = await get_recommended_action(
    user_message="mình thấy lo lắng quá, tim cứ đập nhanh",
    emotion="lo_lang",
    need="binh_on"
)

if action:
    prompt = action["prompt_template"]
    # Use prompt in response generation
```

---

## 6. Data Files

Cần import vào database theo thứ tự:

```bash
# 1. Main schema + seed data
psql -f db.sql

# 2. Supplementary data (new actions, emoji, patterns)
psql -f db_supplement.sql

# 3. Search-ready columns + indexes + data for original actions
psql -f db_action_search_ready.sql

# 4. Search data for new actions
psql -f db_action_search_supplement.sql

# 5. Generate embeddings (run Python script)
python scripts/generate_embeddings.py
```

---

## 7. Embedding Model

Sử dụng: **`bkai-foundation-models/vietnamese-bi-encoder`**

- Dimension: 768
- Language: Vietnamese optimized
- Library: `sentence-transformers`

```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer('bkai-foundation-models/vietnamese-bi-encoder')

def generate_embedding(text: str) -> list[float]:
    return model.encode(text).tolist()
```

---

## 8. Environment Variables (Search API)

```env
# Database
DATABASE_URL=postgresql://user:pass@host:5432/dbname

# Embedding
EMBEDDING_MODEL=bkai-foundation-models/vietnamese-bi-encoder
EMBEDDING_DIMENSION=768

# Search config
SEARCH_VECTOR_WEIGHT=0.4
SEARCH_KEYWORD_WEIGHT=0.3
SEARCH_FILTER_WEIGHT=0.3
```

---

## 9. Sample Queries for Testing

| Query | Expected Top Result |
|-------|---------------------|
| "mình lo lắng quá, tim đập nhanh" | `tip_breathing_478` |
| "mình thấy mệt, không có năng lượng" | `tip_energy_boost` hoặc `exercise_selfcare_plan` |
| "mình cảm thấy cô đơn" | `tip_message_friend` |
| "mình tức giận quá, muốn nổ tung" | `tip_anger_cooldown` |
| "mình không biết chọn gì" | `exercise_pros_cons` |
| "mình hối hận quá" | `exercise_self_forgiveness` |

---

## 10. Next Steps

1. **Setup database** với schema mới
2. **Import data** từ các SQL files
3. **Build APIs** theo spec ở Section 3
4. **Generate embeddings** cho tất cả actions
5. **Test với sample queries**
6. **Integrate** với chatbot project
