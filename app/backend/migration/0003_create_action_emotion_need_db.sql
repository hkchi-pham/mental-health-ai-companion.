-- PostgreSQL schema for emotion/need/action management
-- Run with: psql -f src/database/schema.sql

-- Enable useful extensions (optional)
-- CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Table: emotions
CREATE TABLE IF NOT EXISTS emotions (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  valence NUMERIC(3,2) DEFAULT 0.0 CHECK (valence BETWEEN -1.0 AND 1.0),
  intensity NUMERIC(3,2) DEFAULT 0.5 CHECK (intensity BETWEEN 0.0 AND 1.0),
  risk_level TEXT DEFAULT 'low' CHECK (risk_level IN ('low','medium','high')),
  default_tone TEXT,
  category TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: emotion_keywords
CREATE TABLE IF NOT EXISTS emotion_keywords (
  id BIGSERIAL PRIMARY KEY,
  emotion_id BIGINT NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  keyword TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  type TEXT DEFAULT 'keyword' CHECK (type IN ('exact','lemma','regex','keyword','ft')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (emotion_id, keyword, type)
);

-- Table: needs
CREATE TABLE IF NOT EXISTS needs (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  domain TEXT DEFAULT 'unknown' CHECK (domain IN ('health','school','relationship','personal','unknown')),
  priority NUMERIC(3,2) DEFAULT 0.5 CHECK (priority BETWEEN 0.0 AND 1.0),
  urgency NUMERIC(3,2) DEFAULT 0.5 CHECK (urgency BETWEEN 0.0 AND 1.0),
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: need_keywords
CREATE TABLE IF NOT EXISTS need_keywords (
  id BIGSERIAL PRIMARY KEY,
  need_id BIGINT NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  keyword TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  type TEXT DEFAULT 'keyword' CHECK (type IN ('exact','lemma','regex','keyword','ft')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (need_id, keyword, type)
);

-- Table: emotion_need_links (many-to-many between emotions and needs)
CREATE TABLE IF NOT EXISTS emotion_need_links (
  id BIGSERIAL PRIMARY KEY,
  emotion_id BIGINT NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  need_id BIGINT NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  relationship_strength NUMERIC(3,2) DEFAULT 0.5 CHECK (relationship_strength BETWEEN 0.0 AND 1.0),
  notes TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (emotion_id, need_id)
);

-- Table: actions
CREATE TABLE IF NOT EXISTS actions (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL CHECK (type IN ('tip','question','exercise','info','handoff')),
  level INTEGER CHECK (level BETWEEN 1 AND 5),
  stage_min INTEGER DEFAULT 1 CHECK (stage_min >= 1),
  stage_max INTEGER DEFAULT 3 CHECK (stage_max >= stage_min),
  prompt_template TEXT,
  expected_outcomes TEXT,
  preconditions JSONB DEFAULT '{}'::jsonb,
  postconditions JSONB DEFAULT '{}'::jsonb,
  cooldown_seconds INTEGER DEFAULT 0,
  max_repeats INTEGER DEFAULT 3,
  domain TEXT DEFAULT 'general' CHECK (domain IN ('behavioral','cognitive','emotional','social','safety','educational','general')),
  escalation_action_id BIGINT REFERENCES actions(id) ON DELETE SET NULL,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: action_patterns (to match triggers/success/failure/followup)
CREATE TABLE IF NOT EXISTS action_patterns (
  id BIGSERIAL PRIMARY KEY,
  action_id BIGINT NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  pattern TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('regex','keyword','semantic_intent')),
  direction TEXT NOT NULL CHECK (direction IN ('trigger','success','failure','followup')),
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (action_id, pattern, direction)
);

-- Table: emotion_need_action_map (link emotion+need to actions with conditions)
CREATE TABLE IF NOT EXISTS emotion_need_action_map (
  id BIGSERIAL PRIMARY KEY,
  emotion_id BIGINT NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  need_id BIGINT NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  action_id BIGINT NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  min_confidence NUMERIC(3,2) DEFAULT 0.6 CHECK (min_confidence BETWEEN 0.0 AND 1.0),
  stage_min INTEGER DEFAULT 1,
  stage_max INTEGER DEFAULT 3,
  context_tags TEXT[] DEFAULT ARRAY[]::TEXT[],
  blocked_by BIGINT[] DEFAULT ARRAY[]::BIGINT[],
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (emotion_id, need_id, action_id)
);

-- Table: conversations
CREATE TABLE IF NOT EXISTS conversations (
  id BIGSERIAL PRIMARY KEY,
  user_id TEXT,
  started_at TIMESTAMPTZ DEFAULT NOW(),
  status TEXT DEFAULT 'active' CHECK (status IN ('active','closed','archived'))
);

-- Table: messages
CREATE TABLE IF NOT EXISTS messages (
  id BIGSERIAL PRIMARY KEY,
  conversation_id BIGINT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user','assistant','system')),
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: message_labels (emotion/need labels per message)
CREATE TABLE IF NOT EXISTS message_labels (
  id BIGSERIAL PRIMARY KEY,
  message_id BIGINT NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  emotion_id BIGINT REFERENCES emotions(id) ON DELETE SET NULL,
  emotion_confidence NUMERIC(3,2) CHECK (emotion_confidence BETWEEN 0.0 AND 1.0),
  need_id BIGINT REFERENCES needs(id) ON DELETE SET NULL,
  need_confidence NUMERIC(3,2) CHECK (need_confidence BETWEEN 0.0 AND 1.0),
  stage INTEGER,
  tone TEXT,
  mood_persistence INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: action_candidates (ranked candidates)
CREATE TABLE IF NOT EXISTS action_candidates (
  id BIGSERIAL PRIMARY KEY,
  conversation_id BIGINT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  message_id BIGINT REFERENCES messages(id) ON DELETE SET NULL,
  emotion_id BIGINT REFERENCES emotions(id) ON DELETE SET NULL,
  need_id BIGINT REFERENCES needs(id) ON DELETE SET NULL,
  action_id BIGINT NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  score NUMERIC(3,2) CHECK (score BETWEEN 0.0 AND 1.0),
  reason TEXT,
  source TEXT CHECK (source IN ('rule','ml','pattern')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: action_executions (selected actions and outcomes)
CREATE TABLE IF NOT EXISTS action_executions (
  id BIGSERIAL PRIMARY KEY,
  conversation_id BIGINT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  message_id BIGINT REFERENCES messages(id) ON DELETE SET NULL,
  action_id BIGINT NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  selected_score NUMERIC(3,2) CHECK (selected_score BETWEEN 0.0 AND 1.0),
  inputs JSONB DEFAULT '{}'::jsonb,
  outputs JSONB DEFAULT '{}'::jsonb,
  result_tags TEXT[] DEFAULT ARRAY[]::TEXT[],
  next_action_id BIGINT REFERENCES actions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index recommendations
CREATE INDEX IF NOT EXISTS idx_action_preconditions ON actions USING GIN (preconditions);
CREATE INDEX IF NOT EXISTS idx_action_postconditions ON actions USING GIN (postconditions);
CREATE INDEX IF NOT EXISTS idx_action_map_em_need_stage ON emotion_need_action_map (emotion_id, need_id, stage_min, stage_max);
CREATE INDEX IF NOT EXISTS idx_action_map_context_tags ON emotion_need_action_map USING GIN (context_tags);
CREATE INDEX IF NOT EXISTS idx_action_map_blocked_by ON emotion_need_action_map USING GIN (blocked_by);
CREATE INDEX IF NOT EXISTS idx_messages_conversation ON messages (conversation_id);
CREATE INDEX IF NOT EXISTS idx_message_labels_message ON message_labels (message_id);
CREATE INDEX IF NOT EXISTS idx_action_candidates_conv_msg ON action_candidates (conversation_id, message_id);
CREATE INDEX IF NOT EXISTS idx_action_exec_conv_msg ON action_executions (conversation_id, message_id);