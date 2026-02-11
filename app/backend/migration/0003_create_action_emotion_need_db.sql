
CREATE TABLE IF NOT EXISTS emotions (
  id VARCHAR(36) PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  valence NUMERIC(3,2) DEFAULT 0.0 CHECK (valence BETWEEN -1.0 AND 1.0),
  intensity NUMERIC(3,2) DEFAULT 0.5 CHECK (intensity BETWEEN 0.0 AND 1.0),
  risk_level TEXT DEFAULT 'low' CHECK (risk_level IN ('low','medium','high')),
  default_tone TEXT,
  category TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: emotion_keywords
CREATE TABLE IF NOT EXISTS emotion_keywords (
  id VARCHAR(36) PRIMARY KEY,
  emotion_id VARCHAR(36) NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  keyword TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  type TEXT DEFAULT 'keyword' CHECK (type IN ('exact','lemma','regex','keyword','ft')),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (emotion_id, keyword, type)
);

-- Table: needs
CREATE TABLE IF NOT EXISTS needs (
  id VARCHAR(36) PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  domain TEXT DEFAULT 'unknown' CHECK (domain IN ('health','school','relationship','personal','unknown')),
  priority NUMERIC(3,2) DEFAULT 0.5 CHECK (priority BETWEEN 0.0 AND 1.0),
  urgency NUMERIC(3,2) DEFAULT 0.5 CHECK (urgency BETWEEN 0.0 AND 1.0),
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: need_keywords
CREATE TABLE IF NOT EXISTS need_keywords (
  id VARCHAR(36) PRIMARY KEY,
  need_id VARCHAR(36) NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  keyword TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  type TEXT DEFAULT 'keyword' CHECK (type IN ('exact','lemma','regex','keyword','ft')),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (need_id, keyword, type)
);

-- Table: emotion_need_links (many-to-many between emotions and needs)
CREATE TABLE IF NOT EXISTS emotion_need_links (
  id VARCHAR(36) PRIMARY KEY,
  emotion_id VARCHAR(36) NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  need_id VARCHAR(36) NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  relationship_strength NUMERIC(3,2) DEFAULT 0.5 CHECK (relationship_strength BETWEEN 0.0 AND 1.0),
  notes TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (emotion_id, need_id)
);

-- Table: actions
CREATE TABLE IF NOT EXISTS actions (
  id VARCHAR(36) PRIMARY KEY,
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
  escalation_action_id VARCHAR(36) REFERENCES actions(id) ON DELETE SET NULL,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Table: action_patterns (to match triggers/success/failure/followup)
CREATE TABLE IF NOT EXISTS action_patterns (
  id VARCHAR(36) PRIMARY KEY,
  action_id VARCHAR(36) NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  pattern TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('regex','keyword','semantic_intent')),
  direction TEXT NOT NULL CHECK (direction IN ('trigger','success','failure','followup')),
  weight NUMERIC(3,2) DEFAULT 1.0 CHECK (weight BETWEEN 0.0 AND 1.0),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (action_id, pattern, direction)
);

-- Table: emotion_need_action_map (link emotion+need to actions with conditions)
CREATE TABLE IF NOT EXISTS emotion_need_action_map (
  id VARCHAR(36) PRIMARY KEY,
  emotion_id VARCHAR(36) NOT NULL REFERENCES emotions(id) ON DELETE CASCADE,
  need_id VARCHAR(36) NOT NULL REFERENCES needs(id) ON DELETE CASCADE,
  action_id VARCHAR(36) NOT NULL REFERENCES actions(id) ON DELETE CASCADE,
  min_confidence NUMERIC(3,2) DEFAULT 0.6 CHECK (min_confidence BETWEEN 0.0 AND 1.0),
  stage_min INTEGER DEFAULT 1,
  stage_max INTEGER DEFAULT 3,
  context_tags TEXT[] DEFAULT ARRAY[]::TEXT[],
  blocked_by VARCHAR(36)[] DEFAULT ARRAY[]::VARCHAR(36)[],
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE (emotion_id, need_id, action_id)
);
