-- ============================================
-- ACTION SCHEMA EXTENSION FOR VECTOR SEARCH
-- ============================================
-- This migration adds fields needed for Search Engine + Vector Database
-- The actual search API will be implemented in a separate project

-- Enable extensions (run once on database)
CREATE EXTENSION IF NOT EXISTS pg_trgm;      -- Trigram for fuzzy search

-- ============================================
-- 1. ADD NEW COLUMNS TO ACTIONS TABLE
-- ============================================

-- Search text: combined field for full-text search
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  search_text TEXT;

-- Tags for filtering and categorization
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  tags TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Target emotions this action is suited for (array of emotion slugs)
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  target_emotions TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Target needs this action addresses (array of need slugs)
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  target_needs TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Keywords for search matching
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  search_keywords TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Synonyms for better matching
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  synonyms TEXT[] DEFAULT ARRAY[]::TEXT[];

-- Domain/category for filtering
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  domain TEXT DEFAULT 'general';

-- Priority/relevance score for ranking
ALTER TABLE actions ADD COLUMN IF NOT EXISTS 
  priority_score NUMERIC(3,2) DEFAULT 0.5;

-- ============================================
-- 2. CREATE INDEXES FOR SEARCH
-- ============================================

-- Full-text search index on search_text
CREATE INDEX IF NOT EXISTS idx_actions_search_text_gin 
  ON actions USING GIN (to_tsvector('simple', coalesce(search_text, '')));

-- Trigram index for fuzzy name matching
CREATE INDEX IF NOT EXISTS idx_actions_name_trgm 
  ON actions USING GIN (name gin_trgm_ops);

-- Trigram index for fuzzy description matching  
CREATE INDEX IF NOT EXISTS idx_actions_description_trgm 
  ON actions USING GIN (description gin_trgm_ops);

-- GIN indexes for array fields
CREATE INDEX IF NOT EXISTS idx_actions_tags 
  ON actions USING GIN (tags);

CREATE INDEX IF NOT EXISTS idx_actions_target_emotions 
  ON actions USING GIN (target_emotions);

CREATE INDEX IF NOT EXISTS idx_actions_target_needs 
  ON actions USING GIN (target_needs);

CREATE INDEX IF NOT EXISTS idx_actions_search_keywords 
  ON actions USING GIN (search_keywords);

CREATE INDEX IF NOT EXISTS idx_actions_synonyms 
  ON actions USING GIN (synonyms);

-- ============================================
-- 3. POPULATE SEARCH DATA FOR EXISTING ACTIONS
-- ============================================

-- Update search_text from existing fields
UPDATE actions SET search_text = 
  coalesce(name, '') || ' ' || 
  coalesce(description, '') || ' ' ||
  coalesce(prompt_template, '') || ' ' ||
  coalesce(expected_outcomes, '')
WHERE search_text IS NULL;

-- ============================================
-- 4. UPDATE SEARCH METADATA FOR EACH ACTION
-- ============================================

-- tip_breathing_478: Thở sâu 4-7-8
UPDATE actions SET 
  target_emotions = ARRAY['lo_lang', 'so_hai', 'tuc_gian'],
  target_needs = ARRAY['binh_on', 'an_toan', 'kiem_soat'],
  tags = ARRAY['breathing', 'relaxation', 'immediate', 'physical', 'anxiety-relief'],
  search_keywords = ARRAY['thở', 'hít thở', 'lo âu', 'căng thẳng', 'hoảng loạn', 'tim đập nhanh', 'khó thở', 'bình tĩnh', 'thư giãn'],
  synonyms = ARRAY['kỹ thuật thở', 'thở sâu', 'breathing exercise', 'calm down', 'deep breath', '478 breathing'],
  domain = 'behavioral',
  priority_score = 0.95
WHERE slug = 'tip_breathing_478';

-- tip_grounding_54321: Bài tập 5-4-3-2-1
UPDATE actions SET 
  target_emotions = ARRAY['lo_lang', 'so_hai', 'boi_roi'],
  target_needs = ARRAY['binh_on', 'an_toan', 'kiem_soat'],
  tags = ARRAY['grounding', 'mindfulness', 'present-moment', 'sensory', 'anxiety-relief'],
  search_keywords = ARRAY['grounding', 'hiện tại', 'giác quan', 'hoang mang', 'mất kết nối', 'dissociate', 'panic'],
  synonyms = ARRAY['bài tập 54321', '5 senses exercise', 'grounding technique', 'mindfulness exercise'],
  domain = 'behavioral',
  priority_score = 0.90
WHERE slug = 'tip_grounding_54321';

-- tip_walk_outdoor: Đi bộ nhẹ ngoài trời
UPDATE actions SET 
  target_emotions = ARRAY['buon', 'met_moi', 'lo_lang'],
  target_needs = ARRAY['nghi_ngoi', 'binh_on', 'dong_luc'],
  tags = ARRAY['exercise', 'outdoor', 'physical', 'energy-boost', 'nature'],
  search_keywords = ARRAY['đi bộ', 'ra ngoài', 'vận động', 'thiên nhiên', 'thoáng đầu', 'mệt mỏi', 'buồn chán'],
  synonyms = ARRAY['walking', 'outdoor activity', 'fresh air', 'light exercise', 'nature walk'],
  domain = 'behavioral',
  priority_score = 0.80
WHERE slug = 'tip_walk_outdoor';

-- question_reframe: Tái cấu trúc suy nghĩ
UPDATE actions SET 
  target_emotions = ARRAY['toi_loi', 'buon', 'lo_lang'],
  target_needs = ARRAY['chap_nhan', 'duoc_hieu', 'tu_ton'],
  tags = ARRAY['cognitive', 'reframing', 'self-compassion', 'thought-work', 'perspective'],
  search_keywords = ARRAY['tự trách', 'tự phê phán', 'nghĩ khác', 'góc nhìn mới', 'thay đổi suy nghĩ', 'cognitive'],
  synonyms = ARRAY['cognitive reframing', 'perspective shift', 'thought restructuring', 'self-talk'],
  domain = 'cognitive',
  priority_score = 0.85
WHERE slug = 'question_reframe';

-- exercise_thought_log: Nhật ký suy nghĩ
UPDATE actions SET 
  target_emotions = ARRAY['boi_roi', 'lo_lang', 'buon'],
  target_needs = ARRAY['kiem_soat', 'duoc_hieu', 'dinh_huong'],
  tags = ARRAY['journaling', 'cognitive', 'pattern-recognition', 'self-awareness', 'thought-work'],
  search_keywords = ARRAY['nhật ký', 'ghi chép', 'suy nghĩ tiêu cực', 'overthinking', 'pattern', 'vòng xoáy'],
  synonyms = ARRAY['thought diary', 'CBT log', 'journaling', 'thought tracking'],
  domain = 'cognitive',
  priority_score = 0.85
WHERE slug = 'exercise_thought_log';

-- question_focus_control: Điều bạn kiểm soát
UPDATE actions SET 
  target_emotions = ARRAY['lo_lang', 'boi_roi', 'so_hai'],
  target_needs = ARRAY['kiem_soat', 'dinh_huong', 'binh_on'],
  tags = ARRAY['cognitive', 'control', 'empowerment', 'focus', 'anxiety-relief'],
  search_keywords = ARRAY['kiểm soát', 'chủ động', 'tập trung', 'điều có thể làm', 'bất lực', 'lo lắng'],
  synonyms = ARRAY['circle of control', 'focus on controllables', 'empowerment exercise'],
  domain = 'cognitive',
  priority_score = 0.85
WHERE slug = 'question_focus_control';

-- exercise_emotion_journal: Nhật ký cảm xúc
UPDATE actions SET 
  target_emotions = ARRAY['buon', 'lo_lang', 'tuc_gian', 'boi_roi'],
  target_needs = ARRAY['duoc_hieu', 'chap_nhan', 'kiem_soat'],
  tags = ARRAY['journaling', 'emotional', 'self-awareness', 'expression', 'processing'],
  search_keywords = ARRAY['nhật ký', 'cảm xúc', 'viết', 'ghi lại', 'diễn đạt', 'giải tỏa'],
  synonyms = ARRAY['emotion diary', 'feeling journal', 'mood tracking', 'emotional expression'],
  domain = 'emotional',
  priority_score = 0.85
WHERE slug = 'exercise_emotion_journal';

-- exercise_letter_self: Viết thư cho bản thân
UPDATE actions SET 
  target_emotions = ARRAY['toi_loi', 'buon', 'lo_lang'],
  target_needs = ARRAY['chap_nhan', 'tu_ton', 'duoc_hieu'],
  tags = ARRAY['self-compassion', 'writing', 'emotional', 'healing', 'acceptance'],
  search_keywords = ARRAY['viết thư', 'bản thân', 'tự thương', 'tha thứ', 'chấp nhận', 'cô đơn'],
  synonyms = ARRAY['self-compassion letter', 'letter to self', 'self-love exercise'],
  domain = 'emotional',
  priority_score = 0.80
WHERE slug = 'exercise_letter_self';

-- tip_body_scan: Body Scan
UPDATE actions SET 
  target_emotions = ARRAY['met_moi', 'lo_lang', 'tuc_gian'],
  target_needs = ARRAY['nghi_ngoi', 'binh_on', 'kiem_soat'],
  tags = ARRAY['mindfulness', 'relaxation', 'body-awareness', 'physical', 'meditation'],
  search_keywords = ARRAY['body scan', 'cơ thể', 'thư giãn', 'căng cơ', 'nhận biết', 'meditation'],
  synonyms = ARRAY['body awareness', 'progressive relaxation', 'mindful body scan'],
  domain = 'behavioral',
  priority_score = 0.80
WHERE slug = 'tip_body_scan';

-- exercise_selfcare_plan: Kế hoạch tự chăm sóc
UPDATE actions SET 
  target_emotions = ARRAY['met_moi', 'buon'],
  target_needs = ARRAY['nghi_ngoi', 'tu_ton', 'dong_luc'],
  tags = ARRAY['self-care', 'planning', 'wellness', 'energy', 'routine'],
  search_keywords = ARRAY['tự chăm sóc', 'nghỉ ngơi', 'năng lượng', 'burnout', 'kiệt sức', 'kế hoạch'],
  synonyms = ARRAY['self-care routine', 'wellness plan', 'recovery plan', 'rest plan'],
  domain = 'behavioral',
  priority_score = 0.80
WHERE slug = 'exercise_selfcare_plan';

-- tip_message_friend: Nhắn tin với bạn thân
UPDATE actions SET 
  target_emotions = ARRAY['buon', 'lo_lang'],
  target_needs = ARRAY['ket_noi', 'duoc_hieu', 'chap_nhan'],
  tags = ARRAY['social', 'connection', 'support', 'communication', 'friendship'],
  search_keywords = ARRAY['nhắn tin', 'bạn bè', 'chia sẻ', 'kết nối', 'cô đơn', 'lạc lõng'],
  synonyms = ARRAY['reach out', 'text a friend', 'social connection', 'talk to someone'],
  domain = 'social',
  priority_score = 0.80
WHERE slug = 'tip_message_friend';

-- question_social_support: Ai đang ở bên bạn?
UPDATE actions SET 
  target_emotions = ARRAY['buon', 'so_hai'],
  target_needs = ARRAY['ket_noi', 'an_toan', 'duoc_hieu'],
  tags = ARRAY['social', 'support-network', 'connection', 'reflection', 'safety'],
  search_keywords = ARRAY['ai ở bên', 'người thân', 'hỗ trợ', 'không một mình', 'cô đơn'],
  synonyms = ARRAY['support network', 'social support', 'who can help', 'trusted people'],
  domain = 'social',
  priority_score = 0.75
WHERE slug = 'question_social_support';

-- info_affirmation: Khẳng định tích cực
UPDATE actions SET 
  target_emotions = ARRAY['met_moi', 'buon', 'toi_loi'],
  target_needs = ARRAY['tu_ton', 'dong_luc', 'hy_vong'],
  tags = ARRAY['affirmation', 'motivation', 'self-esteem', 'positive', 'encouragement'],
  search_keywords = ARRAY['khẳng định', 'tích cực', 'động lực', 'tự tin', 'khích lệ', 'cố gắng'],
  synonyms = ARRAY['positive affirmation', 'self-encouragement', 'motivational quote', 'pep talk'],
  domain = 'emotional',
  priority_score = 0.70
WHERE slug = 'info_affirmation';

-- question_value_check: Xác định giá trị cá nhân
UPDATE actions SET 
  target_emotions = ARRAY['boi_roi', 'buon'],
  target_needs = ARRAY['y_nghia', 'dinh_huong', 'tu_ton'],
  tags = ARRAY['values', 'meaning', 'purpose', 'direction', 'reflection'],
  search_keywords = ARRAY['giá trị', 'ý nghĩa', 'mục tiêu', 'định hướng', 'mục đích sống', 'quan trọng'],
  synonyms = ARRAY['values clarification', 'purpose finding', 'meaning exploration', 'life direction'],
  domain = 'emotional',
  priority_score = 0.80
WHERE slug = 'question_value_check';

-- handoff_contact_support: Liên hệ hỗ trợ
UPDATE actions SET 
  target_emotions = ARRAY['so_hai', 'buon', 'toi_loi'],
  target_needs = ARRAY['an_toan', 'ket_noi', 'hy_vong'],
  tags = ARRAY['safety', 'support', 'professional', 'handoff', 'crisis'],
  search_keywords = ARRAY['hỗ trợ', 'chuyên gia', 'người thân', 'an toàn', 'quá tải', 'không chịu nổi'],
  synonyms = ARRAY['seek help', 'professional support', 'contact support', 'get help'],
  domain = 'safety',
  priority_score = 0.95
WHERE slug = 'handoff_contact_support';

-- handoff_hotline: Đường dây nóng
UPDATE actions SET 
  target_emotions = ARRAY['so_hai', 'buon'],
  target_needs = ARRAY['an_toan', 'hy_vong'],
  tags = ARRAY['emergency', 'crisis', 'hotline', 'immediate', 'safety'],
  search_keywords = ARRAY['đường dây nóng', 'khẩn cấp', 'tự tử', 'tự hại', 'nguy hiểm', 'cứu giúp', 'hotline'],
  synonyms = ARRAY['crisis hotline', 'emergency line', 'suicide prevention', 'help line'],
  domain = 'safety',
  priority_score = 1.0
WHERE slug = 'handoff_hotline';

-- ============================================
-- 5. VERIFY DATA
-- ============================================

-- Check updated actions
SELECT slug, name, 
       array_length(target_emotions, 1) as num_emotions,
       array_length(target_needs, 1) as num_needs,
       array_length(tags, 1) as num_tags,
       priority_score
FROM actions 
WHERE target_emotions IS NOT NULL
ORDER BY priority_score DESC;
