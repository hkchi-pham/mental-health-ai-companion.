-- No changes needed if no backslash quotes found, but checking context.
-- UPDATE SEARCH DATA FOR NEW ACTIONS (from db_supplement.sql)
-- ============================================
-- Run this AFTER running db_supplement.sql

-- exercise_self_forgiveness: Bài tập tha thứ bản thân
UPDATE actions SET 
  target_emotions = ARRAY['toi_loi', 'buon'],
  target_needs = ARRAY['chap_nhan', 'tu_ton', 'duoc_hieu'],
  tags = ARRAY['self-compassion', 'forgiveness', 'healing', 'guilt-relief', 'acceptance'],
  search_keywords = ARRAY['tha thứ', 'tội lỗi', 'hối hận', 'ăn năn', 'tự trách', 'day dứt', 'có lỗi'],
  synonyms = ARRAY['self-forgiveness', 'letting go of guilt', 'self-acceptance', 'moving on'],
  domain = 'emotional',
  priority_score = 0.85
WHERE slug = 'exercise_self_forgiveness';

-- exercise_small_goal: Đặt mục tiêu nhỏ
UPDATE actions SET 
  target_emotions = ARRAY['co_dong_luc', 'boi_roi', 'met_moi'],
  target_needs = ARRAY['dong_luc', 'dinh_huong', 'kiem_soat'],
  tags = ARRAY['goal-setting', 'motivation', 'action', 'planning', 'progress'],
  search_keywords = ARRAY['mục tiêu', 'bắt đầu', 'kế hoạch', 'động lực', 'hành động', 'không biết làm gì'],
  synonyms = ARRAY['small goals', 'micro-goals', 'action plan', 'getting started', 'first step'],
  domain = 'cognitive',
  priority_score = 0.80
WHERE slug = 'exercise_small_goal';

-- tip_celebrate_win: Ăn mừng thắng lợi nhỏ
UPDATE actions SET 
  target_emotions = ARRAY['co_dong_luc', 'vui'],
  target_needs = ARRAY['cong_nhan', 'tu_ton', 'dong_luc'],
  tags = ARRAY['celebration', 'achievement', 'positivity', 'reinforcement', 'motivation'],
  search_keywords = ARRAY['ăn mừng', 'hoàn thành', 'thành công', 'làm xong', 'đạt được', 'thắng lợi'],
  synonyms = ARRAY['celebrate wins', 'acknowledge success', 'reward yourself', 'positive reinforcement'],
  domain = 'emotional',
  priority_score = 0.70
WHERE slug = 'tip_celebrate_win';

-- exercise_pros_cons: Liệt kê ưu nhược điểm
UPDATE actions SET 
  target_emotions = ARRAY['boi_roi', 'lo_lang'],
  target_needs = ARRAY['dinh_huong', 'kiem_soat', 'duoc_hieu'],
  tags = ARRAY['decision-making', 'clarity', 'analysis', 'rational', 'problem-solving'],
  search_keywords = ARRAY['ưu nhược', 'quyết định', 'lựa chọn', 'phân vân', 'không biết chọn', 'do dự'],
  synonyms = ARRAY['pros and cons', 'decision matrix', 'weighing options', 'choice analysis'],
  domain = 'cognitive',
  priority_score = 0.80
WHERE slug = 'exercise_pros_cons';

-- tip_muscle_relaxation: Thả lỏng cơ tiến dần
UPDATE actions SET 
  target_emotions = ARRAY['lo_lang', 'met_moi', 'tuc_gian'],
  target_needs = ARRAY['binh_on', 'nghi_ngoi', 'kiem_soat'],
  tags = ARRAY['relaxation', 'physical', 'tension-relief', 'progressive', 'body'],
  search_keywords = ARRAY['thả lỏng', 'căng cơ', 'căng thẳng', 'đau vai', 'đau cổ', 'căng người', 'thư giãn'],
  synonyms = ARRAY['PMR', 'progressive muscle relaxation', 'muscle tension relief', 'body relaxation'],
  domain = 'behavioral',
  priority_score = 0.80
WHERE slug = 'tip_muscle_relaxation';

-- tip_anger_cooldown: Hạ nhiệt cơn giận
UPDATE actions SET 
  target_emotions = ARRAY['tuc_gian'],
  target_needs = ARRAY['binh_on', 'kiem_soat'],
  tags = ARRAY['anger-management', 'cooling-down', 'impulse-control', 'immediate', 'self-regulation'],
  search_keywords = ARRAY['tức giận', 'giận', 'bực', 'điên tiết', 'nổi nóng', 'muốn đánh', 'angry'],
  synonyms = ARRAY['cool down', 'anger control', 'calm the anger', '10-second rule'],
  domain = 'behavioral',
  priority_score = 0.95
WHERE slug = 'tip_anger_cooldown';

-- exercise_safe_space: Hình dung nơi an toàn
UPDATE actions SET 
  target_emotions = ARRAY['so_hai', 'lo_lang'],
  target_needs = ARRAY['an_toan', 'binh_on'],
  tags = ARRAY['visualization', 'safety', 'calming', 'imagination', 'grounding'],
  search_keywords = ARRAY['an toàn', 'sợ', 'sợ hãi', 'bất an', 'hoảng sợ', 'nơi an toàn', 'bình yên'],
  synonyms = ARRAY['safe place visualization', 'inner sanctuary', 'mental safe space', 'happy place'],
  domain = 'emotional',
  priority_score = 0.85
WHERE slug = 'exercise_safe_space';

-- exercise_gratitude: Nhật ký biết ơn
UPDATE actions SET 
  target_emotions = ARRAY['vui', 'trung_lap', 'buon'],
  target_needs = ARRAY['hy_vong', 'tu_ton', 'y_nghia'],
  tags = ARRAY['gratitude', 'positivity', 'journaling', 'mindset', 'appreciation'],
  search_keywords = ARRAY['biết ơn', 'cảm ơn', 'may mắn', 'điều tốt', 'tích cực'],
  synonyms = ARRAY['gratitude journal', 'counting blessings', 'thankfulness', 'appreciation list'],
  domain = 'emotional',
  priority_score = 0.75
WHERE slug = 'exercise_gratitude';

-- exercise_worry_time: Thời gian lo lắng có kiểm soát
UPDATE actions SET 
  target_emotions = ARRAY['lo_lang'],
  target_needs = ARRAY['kiem_soat', 'binh_on'],
  tags = ARRAY['anxiety-management', 'scheduled-worry', 'cognitive', 'control', 'boundaries'],
  search_keywords = ARRAY['lo suốt ngày', 'lo liên tục', 'overthinking', 'lo quá nhiều', 'không dừng lo'],
  synonyms = ARRAY['worry time', 'scheduled worry', 'containment strategy', 'worry window'],
  domain = 'cognitive',
  priority_score = 0.80
WHERE slug = 'exercise_worry_time';

-- tip_energy_boost: Nạp năng lượng nhanh
UPDATE actions SET 
  target_emotions = ARRAY['met_moi'],
  target_needs = ARRAY['nghi_ngoi', 'dong_luc'],
  tags = ARRAY['energy', 'quick-fix', 'physical', 'refreshment', 'immediate'],
  search_keywords = ARRAY['mệt', 'kiệt sức', 'hết năng lượng', 'buồn ngủ', 'uể oải', 'tired'],
  synonyms = ARRAY['energy boost', 'quick refresh', 'pick-me-up', 'fatigue relief'],
  domain = 'behavioral',
  priority_score = 0.75
WHERE slug = 'tip_energy_boost';

-- ============================================
-- VERIFY ALL ACTIONS HAVE SEARCH DATA
-- ============================================

-- List actions missing search data
SELECT slug, name 
FROM actions 
WHERE target_emotions IS NULL 
   OR array_length(target_emotions, 1) IS NULL
ORDER BY slug;
