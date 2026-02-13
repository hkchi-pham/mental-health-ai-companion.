-- ============================================
-- SUPPLEMENTARY DATA FOR EMOTION/NEED/ACTION SCHEMA
-- ============================================

-- ============================================
-- 1. EMOJI MAPPING TABLE & DATA
-- ============================================

CREATE TYPE text_weight AS (text text, weight numeric);

CREATE TABLE IF NOT EXISTS emotion_emojis (
    id VARCHAR(36) PRIMARY KEY DEFAULT gen_random_uuid(),
    emotion_id VARCHAR(36) REFERENCES emotions(id) ON DELETE CASCADE,
    emoji TEXT NOT NULL,
    weight NUMERIC(3,2) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(emotion_id, emoji)
);

-- Buồn emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😢', 1.0),
    ROW('😭', 1.0),
    ROW('😞', 0.9),
    ROW('😔', 0.9),
    ROW('🥺', 0.85),
    ROW('😿', 0.8),
    ROW('💔', 0.95),
    ROW('🥲', 0.75),
    ROW('😥', 0.85),
    ROW('😩', 0.8),
    ROW('😫', 0.85),
    ROW('🫠', 0.7),
    ROW('🙁', 0.75),
    ROW('☹️', 0.8),
    ROW('😣', 0.75)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='buon'
ON CONFLICT DO NOTHING;

-- Lo lắng emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😰', 1.0),
    ROW('😨', 0.95),
    ROW('😧', 0.9),
    ROW('😟', 0.85),
    ROW('🫣', 0.8),
    ROW('😬', 0.75),
    ROW('🥴', 0.7),
    ROW('😵', 0.85),
    ROW('😵‍💫', 0.9),
    ROW('🤯', 0.85),
    ROW('😓', 0.8),
    ROW('💦', 0.7),
    ROW('🫨', 0.85),
    ROW('😖', 0.8),
    ROW('🙀', 0.75)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='lo_lang'
ON CONFLICT DO NOTHING;

-- Mệt mỏi emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😴', 1.0),
    ROW('😪', 0.95),
    ROW('🥱', 0.9),
    ROW('😮‍💨', 0.85),
    ROW('🫠', 0.85),
    ROW('😩', 0.8),
    ROW('🥵', 0.75),
    ROW('🪫', 0.9),
    ROW('💤', 0.85),
    ROW('😶', 0.7),
    ROW('🙃', 0.65),
    ROW('😑', 0.7),
    ROW('😐', 0.65),
    ROW('🫥', 0.8),
    ROW('🧟', 0.75)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='met_moi'
ON CONFLICT DO NOTHING;

-- Vui emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😊', 1.0),
    ROW('😄', 1.0),
    ROW('🥰', 0.95),
    ROW('😁', 0.95),
    ROW('🤗', 0.9),
    ROW('😃', 0.9),
    ROW('🥳', 0.95),
    ROW('🎉', 0.85),
    ROW('✨', 0.8),
    ROW('💖', 0.85),
    ROW('🌟', 0.8),
    ROW('😍', 0.85),
    ROW('🤩', 0.9),
    ROW('🙂', 0.7),
    ROW('😌', 0.75)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='vui'
ON CONFLICT DO NOTHING;

-- Có động lực emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('💪', 1.0),
    ROW('🔥', 1.0),
    ROW('⚡', 0.95),
    ROW('🚀', 0.95),
    ROW('✊', 0.9),
    ROW('🎯', 0.9),
    ROW('💯', 0.85),
    ROW('👊', 0.85),
    ROW('🏆', 0.8),
    ROW('⭐', 0.8),
    ROW('🌈', 0.75),
    ROW('🙌', 0.85),
    ROW('👏', 0.8),
    ROW('🤘', 0.75),
    ROW('😤', 0.85)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='co_dong_luc'
ON CONFLICT DO NOTHING;

-- Tức giận emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😠', 1.0),
    ROW('😡', 1.0),
    ROW('🤬', 0.95),
    ROW('💢', 0.9),
    ROW('😤', 0.85),
    ROW('👿', 0.8),
    ROW('🔥', 0.75),
    ROW('💥', 0.75),
    ROW('😾', 0.7),
    ROW('🤯', 0.7),
    ROW('🙄', 0.65),
    ROW('😒', 0.7),
    ROW('😑', 0.6),
    ROW('🫨', 0.65),
    ROW('🤮', 0.6)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='tuc_gian'
ON CONFLICT DO NOTHING;

-- Tội lỗi emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😔', 1.0),
    ROW('😣', 0.95),
    ROW('🥺', 0.9),
    ROW('😞', 0.9),
    ROW('🙇', 0.85),
    ROW('🫣', 0.8),
    ROW('😶', 0.75),
    ROW('😕', 0.7),
    ROW('💔', 0.8),
    ROW('🥲', 0.75),
    ROW('😿', 0.7),
    ROW('🫠', 0.65),
    ROW('🙁', 0.7),
    ROW('😢', 0.75),
    ROW('✋', 0.6)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='toi_loi'
ON CONFLICT DO NOTHING;

-- Bối rối emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😵', 1.0),
    ROW('😵‍💫', 1.0),
    ROW('🤔', 0.9),
    ROW('😕', 0.9),
    ROW('🫤', 0.85),
    ROW('🤨', 0.8),
    ROW('❓', 0.85),
    ROW('❔', 0.8),
    ROW('🧐', 0.75),
    ROW('🙃', 0.7),
    ROW('😶', 0.65),
    ROW('🥴', 0.75),
    ROW('🫠', 0.7),
    ROW('💭', 0.7),
    ROW('🤷', 0.8)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='boi_roi'
ON CONFLICT DO NOTHING;

-- Sợ hãi emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😱', 1.0),
    ROW('😨', 1.0),
    ROW('😰', 0.95),
    ROW('🫣', 0.9),
    ROW('😧', 0.85),
    ROW('🥶', 0.8),
    ROW('😵', 0.8),
    ROW('🙀', 0.85),
    ROW('👻', 0.7),
    ROW('💀', 0.7),
    ROW('🫨', 0.8),
    ROW('😲', 0.75),
    ROW('😦', 0.75),
    ROW('🥺', 0.7),
    ROW('🆘', 0.85)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='so_hai'
ON CONFLICT DO NOTHING;

-- Trung lập emojis
INSERT INTO emotion_emojis (emotion_id, emoji, weight)
SELECT id, emoji, wt FROM emotions, unnest(ARRAY[
    ROW('😐', 1.0),
    ROW('😶', 0.95),
    ROW('🙂', 0.85),
    ROW('😑', 0.9),
    ROW('🫥', 0.85),
    ROW('🤷', 0.8),
    ROW('➖', 0.75),
    ROW('🆗', 0.75),
    ROW('👌', 0.7),
    ROW('✅', 0.7),
    ROW('💬', 0.65),
    ROW('🗣️', 0.6),
    ROW('😌', 0.65),
    ROW('🧘', 0.7),
    ROW('☯️', 0.75)
]::text_weight[]) AS t(emoji text, wt numeric)
WHERE slug='trung_lap'
ON CONFLICT DO NOTHING;

-- ============================================
-- 2. ADDITIONAL ACTIONS
-- ============================================

-- Action for self-forgiveness (toi_loi)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_self_forgiveness', 'Bài tập tha thứ bản thân', 'Giúp chấp nhận lỗi lầm và tiến về phía trước', 
   'exercise', 2, 2, 3, 
   'Viết ra: 1) Điều bạn hối hận 2) Bạn đã học được gì 3) Câu tha thứ cho chính mình.', 
   'Giảm tự phê phán, tăng tự thương', 
   '{"emotion_slug":"toi_loi"}', '{"emotion":"self_compassion"}', 
   0, 3, 'emotional')
ON CONFLICT (slug) DO NOTHING;

-- Action for goal-setting (co_dong_luc)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_small_goal', 'Đặt mục tiêu nhỏ', 'Chia mục tiêu lớn thành bước nhỏ có thể đo lường', 
   'exercise', 2, 1, 3, 
   'Hãy viết ra 1 mục tiêu nhỏ bạn có thể hoàn thành trong 24h tới. Càng cụ thể càng tốt!', 
   'Tăng cảm giác thành tựu, duy trì động lực', 
   '{"emotion_slug":"co_dong_luc"}', '{"emotion":"accomplished"}', 
   0, 5, 'cognitive')
ON CONFLICT (slug) DO NOTHING;

-- Action for celebrating wins (co_dong_luc)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_celebrate_win', 'Ăn mừng thắng lợi nhỏ', 'Ghi nhận và ăn mừng những thành tựu dù nhỏ', 
   'tip', 1, 1, 3, 
   'Hãy kể cho mình nghe: Hôm nay bạn đã hoàn thành được điều gì, dù nhỏ đến đâu?', 
   'Tăng tự tin, củng cố động lực', 
   '{"emotion_slug":"co_dong_luc"}', '{"emotion":"proud"}', 
   300, 3, 'emotional')
ON CONFLICT (slug) DO NOTHING;

-- Action for decision matrix (boi_roi)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_pros_cons', 'Liệt kê ưu nhược điểm', 'Bài tập phân tích để đưa ra quyết định rõ ràng hơn', 
   'exercise', 2, 2, 3, 
   'Hãy chia thành 2 cột: Ưu điểm (tại sao nên làm) và Nhược điểm (tại sao không nên). Viết ít nhất 3 điểm mỗi bên.', 
   'Giảm bối rối, tăng rõ ràng trong quyết định', 
   '{"emotion_slug":"boi_roi"}', '{"emotion":"clarity"}', 
   0, 5, 'cognitive')
ON CONFLICT (slug) DO NOTHING;

-- Action for progressive muscle relaxation (lo_lang, met_moi)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_muscle_relaxation', 'Thả lỏng cơ tiến dần', 'Kỹ thuật thư giãn cơ bắp từ chân lên đầu', 
   'tip', 2, 1, 3, 
   'Siết chặt từng nhóm cơ (chân, bụng, tay, vai) trong 5s rồi thả lỏng 10s. Lặp lại từ dưới lên trên.', 
   'Giảm căng cơ, thư giãn toàn thân', 
   '{"emotion_slug":"lo_lang"}', '{"emotion":"relaxed"}', 
   600, 2, 'behavioral')
ON CONFLICT (slug) DO NOTHING;

-- Action for anger cool-down (tuc_gian)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_anger_cooldown', 'Hạ nhiệt cơn giận', 'Kỹ thuật trì hoãn phản ứng khi đang tức giận', 
   'tip', 1, 1, 2, 
   'Đếm chậm từ 1 đến 10, hít thở sâu mỗi số. Nếu vẫn còn giận, đếm tiếp đến 20.', 
   'Giảm cường độ tức giận, tránh phản ứng tiêu cực', 
   '{"emotion_slug":"tuc_gian"}', '{"emotion":"cooled_down"}', 
   60, 5, 'behavioral')
ON CONFLICT (slug) DO NOTHING;

-- Action for safe space visualization (so_hai)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_safe_space', 'Hình dung nơi an toàn', 'Tưởng tượng một nơi an toàn và bình yên', 
   'exercise', 2, 1, 3, 
   'Nhắm mắt và tưởng tượng nơi bạn cảm thấy an toàn nhất. Mô tả: nhìn thấy gì, nghe gì, cảm nhận gì?', 
   'Tạo cảm giác an toàn nội tâm, giảm sợ hãi', 
   '{"emotion_slug":"so_hai"}', '{"emotion":"safe"}', 
   300, 3, 'emotional')
ON CONFLICT (slug) DO NOTHING;

-- Action for gratitude journal (vui, trung_lap)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_gratitude', 'Nhật ký biết ơn', 'Ghi lại những điều biết ơn để tăng cảm xúc tích cực', 
   'exercise', 1, 1, 3, 
   'Hãy viết ra 3 điều bạn biết ơn hôm nay, dù nhỏ đến đâu (ví dụ: được ăn sáng ngon, có người quan tâm...)', 
   'Tăng cảm xúc tích cực, giảm tiêu cực', 
   '{"emotion_slug":"vui"}', '{"emotion":"grateful"}', 
   0, 5, 'emotional')
ON CONFLICT (slug) DO NOTHING;

-- Action for worry time (lo_lang)
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_worry_time', 'Thời gian lo lắng có kiểm soát', 'Đặt thời gian riêng để lo lắng, tránh lo suốt ngày', 
   'exercise', 2, 2, 3, 
   'Chọn 15 phút mỗi ngày là "thời gian lo lắng". Ngoài thời gian đó, ghi lại nỗi lo và hẹn đến giờ mới nghĩ.', 
   'Kiểm soát lo âu, tách biệt lo lắng khỏi cuộc sống', 
   '{"emotion_slug":"lo_lang"}', '{"emotion":"in_control"}', 
   0, 3, 'cognitive')
ON CONFLICT (slug) DO NOTHING;

-- Action for energy boost (met_moi)  
INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_energy_boost', 'Nạp năng lượng nhanh', 'Các cách nhanh để tăng năng lượng khi mệt', 
   'tip', 1, 1, 2, 
   'Thử: Uống 1 cốc nước, đứng dậy vươn vai 30s, hoặc ra cửa sổ hít thở 5 hơi sâu.', 
   'Tăng năng lượng tạm thời, tỉnh táo hơn', 
   '{"emotion_slug":"met_moi"}', '{"emotion":"energized"}', 
   300, 5, 'behavioral')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- 3. ACTION PATTERNS FOR NEW ACTIONS
-- ============================================

-- Patterns for exercise_self_forgiveness
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('tội lỗi', 1.0),
    ROW('hối hận', 1.0),
    ROW('ăn năn', 0.95),
    ROW('tự trách', 0.95),
    ROW('day dứt', 0.9),
    ROW('có lỗi', 0.9),
    ROW('xấu hổ vì lỗi', 0.9),
    ROW('không tha thứ cho mình', 1.0),
    ROW('mình đã sai', 0.95),
    ROW('giá như', 0.85),
    ROW('regret', 0.9),
    ROW('guilty', 0.9),
    ROW('self blame', 0.95),
    ROW('can''t forgive myself', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_self_forgiveness'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('nhẹ lòng hơn', 1.0),
    ROW('thấy ổn hơn', 0.95),
    ROW('bớt tự trách', 0.95),
    ROW('tha thứ cho mình được rồi', 1.0),
    ROW('chấp nhận được rồi', 0.95),
    ROW('feel better about myself', 0.95),
    ROW('can move on now', 0.9),
    ROW('learned from it', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_self_forgiveness'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_small_goal
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('muốn đặt mục tiêu', 1.0),
    ROW('cần mục tiêu', 0.95),
    ROW('không biết bắt đầu từ đâu', 0.9),
    ROW('muốn làm gì đó', 0.85),
    ROW('có động lực', 0.9),
    ROW('sẵn sàng hành động', 0.95),
    ROW('want to start', 0.9),
    ROW('need a goal', 0.95),
    ROW('motivated', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_small_goal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('đã đặt mục tiêu xong', 1.0),
    ROW('biết mình cần làm gì', 0.95),
    ROW('rõ ràng hơn', 0.9),
    ROW('có kế hoạch rồi', 0.95),
    ROW('set my goal', 0.95),
    ROW('know what to do', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_small_goal'
ON CONFLICT DO NOTHING;

-- Patterns for tip_celebrate_win
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('vừa hoàn thành', 1.0),
    ROW('làm xong', 0.95),
    ROW('đạt được', 0.95),
    ROW('thành công', 0.9),
    ROW('completed', 0.9),
    ROW('achieved', 0.95),
    ROW('done with', 0.85),
    ROW('finished', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_celebrate_win'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_pros_cons
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('không biết chọn', 1.0),
    ROW('phân vân', 0.95),
    ROW('lựa chọn', 0.9),
    ROW('quyết định', 0.9),
    ROW('bối rối', 0.85),
    ROW('do dự', 0.9),
    ROW('can''t decide', 1.0),
    ROW('confused about', 0.9),
    ROW('pros and cons', 0.95),
    ROW('should I', 0.85)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_pros_cons'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('rõ ràng hơn', 1.0),
    ROW('biết nên làm gì', 0.95),
    ROW('đã quyết định', 0.95),
    ROW('bớt rối', 0.9),
    ROW('clearer now', 0.95),
    ROW('made decision', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_pros_cons'
ON CONFLICT DO NOTHING;

-- Patterns for tip_muscle_relaxation
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('căng cơ', 1.0),
    ROW('căng thẳng', 0.95),
    ROW('đau vai', 0.85),
    ROW('đau cổ', 0.85),
    ROW('căng người', 0.9),
    ROW('muscle tension', 0.95),
    ROW('stiff', 0.9),
    ROW('tense', 0.9),
    ROW('body feels tight', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_muscle_relaxation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('thả lỏng được', 1.0),
    ROW('đỡ căng', 0.95),
    ROW('thư giãn hơn', 0.95),
    ROW('cơ thể dễ chịu', 0.9),
    ROW('muscles relaxed', 0.95),
    ROW('feel looser', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_muscle_relaxation'
ON CONFLICT DO NOTHING;

-- Patterns for tip_anger_cooldown
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('tức giận', 1.0),
    ROW('giận', 0.95),
    ROW('bực', 0.9),
    ROW('điên tiết', 0.95),
    ROW('nổi nóng', 0.95),
    ROW('muốn đánh', 0.9),
    ROW('angry', 1.0),
    ROW('mad', 0.95),
    ROW('furious', 0.95),
    ROW('pissed', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_anger_cooldown'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('bình tĩnh hơn', 1.0),
    ROW('hết giận', 0.95),
    ROW('đỡ tức', 0.95),
    ROW('cooled down', 1.0),
    ROW('calmer now', 0.95),
    ROW('less angry', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_anger_cooldown'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_safe_space
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('sợ', 1.0),
    ROW('sợ hãi', 1.0),
    ROW('không an toàn', 0.95),
    ROW('bất an', 0.9),
    ROW('hoảng sợ', 0.95),
    ROW('scared', 1.0),
    ROW('afraid', 0.95),
    ROW('unsafe', 0.95),
    ROW('fearful', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_safe_space'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('an toàn hơn', 1.0),
    ROW('bình yên hơn', 0.95),
    ROW('đỡ sợ', 0.95),
    ROW('feel safer', 1.0),
    ROW('more peaceful', 0.95),
    ROW('grounded', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_safe_space'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_gratitude
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('biết ơn', 1.0),
    ROW('cảm ơn', 0.85),
    ROW('may mắn', 0.8),
    ROW('vui', 0.75),
    ROW('ổn', 0.7),
    ROW('grateful', 1.0),
    ROW('thankful', 0.95),
    ROW('blessed', 0.9),
    ROW('happy', 0.75)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_gratitude'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_worry_time
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('lo suốt ngày', 1.0),
    ROW('lo liên tục', 0.95),
    ROW('không dừng lo được', 0.95),
    ROW('overthinking', 1.0),
    ROW('lo quá nhiều', 0.95),
    ROW('can''t stop worrying', 1.0),
    ROW('constant worry', 0.95),
    ROW('always anxious', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_worry_time'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('kiểm soát được lo lắng', 1.0),
    ROW('bớt lo', 0.95),
    ROW('không lo liên tục nữa', 0.95),
    ROW('worry less', 0.95),
    ROW('controlled anxiety', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_worry_time'
ON CONFLICT DO NOTHING;

-- Patterns for tip_energy_boost
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('mệt', 1.0),
    ROW('kiệt sức', 0.95),
    ROW('hết năng lượng', 0.95),
    ROW('buồn ngủ', 0.9),
    ROW('uể oải', 0.9),
    ROW('tired', 1.0),
    ROW('exhausted', 0.95),
    ROW('sleepy', 0.9),
    ROW('no energy', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_energy_boost'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('tỉnh táo hơn', 1.0),
    ROW('có năng lượng', 0.95),
    ROW('đỡ mệt', 0.95),
    ROW('more awake', 0.95),
    ROW('energized', 1.0),
    ROW('refreshed', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_energy_boost'
ON CONFLICT DO NOTHING;

-- ============================================
-- 4. ACTION PATTERNS FOR EXISTING ACTIONS (that were missing)
-- ============================================

-- Patterns for tip_grounding_54321
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('hoang mang', 1.0),
    ROW('mất kết nối', 0.95),
    ROW('không ở đây', 0.9),
    ROW('dissociate', 0.95),
    ROW('disconnected', 0.9),
    ROW('not present', 0.9),
    ROW('floating', 0.85),
    ROW('unreal', 0.9),
    ROW('lơ lửng', 0.85),
    ROW('không thật', 0.9),
    ROW('panic', 0.95),
    ROW('hoảng loạn', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('cảm thấy hiện diện', 1.0),
    ROW('ở đây rồi', 0.95),
    ROW('grounded', 1.0),
    ROW('present now', 0.95),
    ROW('back to reality', 0.9),
    ROW('trở lại thực tại', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

-- Patterns for tip_walk_outdoor
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('cần không khí', 1.0),
    ROW('ngột ngạt', 0.95),
    ROW('muốn ra ngoài', 0.95),
    ROW('bí bách', 0.9),
    ROW('stuffy', 0.9),
    ROW('need fresh air', 1.0),
    ROW('want to go outside', 0.95),
    ROW('stuck inside', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('thoải mái hơn', 1.0),
    ROW('dễ thở hơn', 0.95),
    ROW('refreshed', 1.0),
    ROW('feel better after walk', 0.95),
    ROW('đầu óc thoáng', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

-- Patterns for question_reframe
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('tự trách', 1.0),
    ROW('tự phê phán', 0.95),
    ROW('mình tệ quá', 0.95),
    ROW('self criticism', 1.0),
    ROW('I''m so bad', 0.95),
    ROW('hate myself', 0.9),
    ROW('ghét bản thân', 0.9),
    ROW('mình không tốt', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('nhìn khác đi rồi', 1.0),
    ROW('hiểu hơn', 0.95),
    ROW('new perspective', 1.0),
    ROW('see it differently', 0.95),
    ROW('bớt tự trách', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

-- Patterns for exercise_thought_log
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('suy nghĩ tiêu cực', 1.0),
    ROW('nghĩ quá nhiều', 0.95),
    ROW('không kiểm soát được suy nghĩ', 0.95),
    ROW('negative thoughts', 1.0),
    ROW('overthinking', 0.95),
    ROW('can''t control thoughts', 0.9),
    ROW('vòng xoáy suy nghĩ', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('nhận ra pattern', 1.0),
    ROW('rõ ràng hơn', 0.95),
    ROW('understand my thoughts', 1.0),
    ROW('see the pattern', 0.95),
    ROW('hiểu mình hơn', 0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

-- Patterns for tip_body_scan
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
    ROW('căng thẳng', 1.0),
    ROW('đau nhức', 0.9),
    ROW('không cảm nhận cơ thể', 0.95),
    ROW('body tension', 1.0),
    ROW('disconnected from body', 0.95),
    ROW('feel numb', 0.9),
    ROW('tê liệt', 0.85)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
    ROW('cảm nhận cơ thể rõ hơn', 1.0),
    ROW('thư giãn hơn', 0.95),
    ROW('connected to body', 1.0),
    ROW('relaxed', 0.95),
    ROW('aware of body', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

-- ============================================
-- 5. ADDITIONAL EMOTION-NEED-ACTION MAPPINGS
-- ============================================

-- Self forgiveness for toi_loi
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='toi_loi'
  AND n.slug='chap_nhan'
  AND a.slug='exercise_self_forgiveness'
ON CONFLICT DO NOTHING;

-- Small goal for co_dong_luc
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='co_dong_luc'
  AND n.slug='dong_luc'
  AND a.slug='exercise_small_goal'
ON CONFLICT DO NOTHING;

-- Celebrate win for co_dong_luc
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='co_dong_luc'
  AND n.slug='cong_nhan'
  AND a.slug='tip_celebrate_win'
ON CONFLICT DO NOTHING;

-- Pros cons for boi_roi
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='boi_roi'
  AND n.slug='dinh_huong'
  AND a.slug='exercise_pros_cons'
ON CONFLICT DO NOTHING;

-- Muscle relaxation for lo_lang
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='binh_on'
  AND a.slug='tip_muscle_relaxation'
ON CONFLICT DO NOTHING;

-- Muscle relaxation for met_moi
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.85, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='met_moi'
  AND n.slug='nghi_ngoi'
  AND a.slug='tip_muscle_relaxation'
ON CONFLICT DO NOTHING;

-- Anger cooldown for tuc_gian
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='tuc_gian'
  AND n.slug='binh_on'
  AND a.slug='tip_anger_cooldown'
ON CONFLICT DO NOTHING;

-- Safe space for so_hai
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='so_hai'
  AND n.slug='an_toan'
  AND a.slug='exercise_safe_space'
ON CONFLICT DO NOTHING;

-- Gratitude for vui
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.7, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='vui'
  AND n.slug='hy_vong'
  AND a.slug='exercise_gratitude'
ON CONFLICT DO NOTHING;

-- Gratitude for trung_lap
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='trung_lap'
  AND n.slug='hy_vong'
  AND a.slug='exercise_gratitude'
ON CONFLICT DO NOTHING;

-- Worry time for lo_lang
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='kiem_soat'
  AND a.slug='exercise_worry_time'
ON CONFLICT DO NOTHING;

-- Energy boost for met_moi
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='met_moi'
  AND n.slug='nghi_ngoi'
  AND a.slug='tip_energy_boost'
ON CONFLICT DO NOTHING;

-- ============================================
-- 6. ADDITIONAL EMOTION-NEED LINKS
-- ============================================

-- Link co_dong_luc với dong_luc
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.95 FROM emotions e, needs n WHERE e.slug='co_dong_luc' AND n.slug='dong_luc'
ON CONFLICT DO NOTHING;

-- Link co_dong_luc với dinh_huong
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='co_dong_luc' AND n.slug='dinh_huong'
ON CONFLICT DO NOTHING;

-- Link toi_loi với duoc_hieu
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.75 FROM emotions e, needs n WHERE e.slug='toi_loi' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;

-- Link toi_loi với hy_vong
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='toi_loi' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

-- Link boi_roi với kiem_soat
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='boi_roi' AND n.slug='kiem_soat'
ON CONFLICT DO NOTHING;

-- Link boi_roi với duoc_hieu
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='boi_roi' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;

-- Link so_hai với duoc_hieu
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.75 FROM emotions e, needs n WHERE e.slug='so_hai' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;

-- Link so_hai với ket_noi
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='so_hai' AND n.slug='ket_noi'
ON CONFLICT DO NOTHING;

-- Link met_moi với ket_noi
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.65 FROM emotions e, needs n WHERE e.slug='met_moi' AND n.slug='ket_noi'
ON CONFLICT DO NOTHING;

-- Link met_moi với y_nghia
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.6 FROM emotions e, needs n WHERE e.slug='met_moi' AND n.slug='y_nghia'
ON CONFLICT DO NOTHING;

-- Link buon với y_nghia
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.75 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='y_nghia'
ON CONFLICT DO NOTHING;

-- Link buon với hy_vong
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.85 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

-- Link vui với ket_noi
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.85 FROM emotions e, needs n WHERE e.slug='vui' AND n.slug='ket_noi'
ON CONFLICT DO NOTHING;

-- Link vui với y_nghia
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.75 FROM emotions e, needs n WHERE e.slug='vui' AND n.slug='y_nghia'
ON CONFLICT DO NOTHING;

-- Link tuc_gian với duoc_hieu
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;

-- Link tuc_gian với tu_ton
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.75 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='tu_ton'
ON CONFLICT DO NOTHING;

-- ============================================
-- END OF SUPPLEMENTARY DATA
-- ============================================
