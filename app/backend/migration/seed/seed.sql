-- Seed data for emotion/need/action schema

-- Emotions
INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('buon', 'Buồn', 'Cảm giác buồn bã, mất năng lượng', -0.7, 0.6, 'medium', 'đồng cảm', 'sad')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('lo_lang', 'Lo lắng', 'Cảm giác lo âu, căng thẳng', -0.5, 0.7, 'medium', 'trấn an', 'anxious')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('met_moi', 'Mệt mỏi', 'Kiệt sức, thiếu động lực', -0.6, 0.6, 'low', 'khích lệ nhẹ nhàng', 'fatigue')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('vui', 'Vui', 'Tích cực, hạnh phúc', 0.8, 0.6, 'low', 'tích cực', 'happy')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('co_dong_luc', 'Có động lực', 'Cảm thấy có mục tiêu và sẵn sàng hành động', 0.7, 0.8, 'low', 'khích lệ', 'drive')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('tuc_gian', 'Tức giận', 'Cảm giác bực bội, muốn phản kháng',-0.8, 0.8, 'high', 'bình tĩnh', 'anger')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('toi_loi', 'Tội lỗi', 'Cảm giác hối hận vì đã làm điều sai',-0.6, 0.6, 'medium', 'tha thứ, cảm thông', 'guilt')
ON CONFLICT (slug) DO NOTHING;


INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('boi_roi', 'Bối rối', 'Không rõ ràng, lẫn lộn trong suy nghĩ hoặc cảm xúc',-0.3, 0.5, 'low', 'giải thích, làm rõ', 'uncertainty')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('so_hai', 'Sợ hãi', 'Cảm giác sợ hãi, bất an, tránh né nguy hiểm',-0.7, 0.8, 'high', 'trấn an, đảm bảo an toàn', 'fear')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('neutral', 'Trung lập', 'Trạng thái bình thường, không cảm xúc rõ ràng',0.0, 0.4, 'low', 'tự nhiên', 'neutral')
ON CONFLICT (slug) DO NOTHING;


-- Emotion keywords
CREATE TYPE text_weight AS (kw text, wt numeric);

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('buồn',1.0),
    ROW('chán nản',0.9),
    ROW('mất năng lượng',0.8),
    ROW('tủi thân',0.8),
    ROW('sad',0.9),
    ROW('depressed',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='buon'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('lo lắng',1.0),
    ROW('bồn chồn',0.8),
    ROW('căng thẳng',0.8),
    ROW('nóng ruột',0.7),
    ROW('anxious',0.9),
    ROW('worried',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='lo_lang'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('mệt',1.0),
    ROW('kiệt sức',0.9),
    ROW('thiếu năng lượng',0.8),
    ROW('tired',0.9),
    ROW('exhausted',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='met_moi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('vui',1.0),
    ROW('hạnh phúc',0.9),
    ROW('tươi vui',0.8),
    ROW('phấn khởi',0.8),
    ROW('happy',0.9),
    ROW('cheerful',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='vui'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('có động lực',1.0),
    ROW('nhiệt huyết',0.9),
    ROW('tích cực',0.8),
    ROW('hăng hái',0.8),
    ROW('motivated',0.9),
    ROW('determined',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='co_dong_luc'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('tức giận',1.0),
    ROW('bực bội',0.9),
    ROW('cáu',0.8),
    ROW('giận',0.9),
    ROW('angry',0.9),
    ROW('furious',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='tuc_gian'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('tội lỗi',1.0),
    ROW('hối hận',0.9),
    ROW('tự trách',0.8),
    ROW('cắn rứt',0.8),
    ROW('guilty',0.9),
    ROW('regret',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='toi_loi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('bối rối',1.0),
    ROW('không chắc',0.8),
    ROW('không hiểu',0.7),
    ROW('không biết',0.8),
    ROW('rối trí',0.8),
    ROW('confused',0.9),
    ROW('uncertain',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='boi_roi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('sợ',1.0),
    ROW('hoảng sợ',0.9),
    ROW('lo sợ',0.9),
    ROW('run rẩy',0.8),
    ROW('fearful',0.9),
    ROW('afraid',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='so_hai'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('bình thường',1.0),
    ROW('ổn',0.8),
    ROW('không sao',0.8),
    ROW('neutral',0.9),
    ROW('okay',0.8)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='trung_lap'
ON CONFLICT DO NOTHING;



-- Needs
INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('nghi_ngoi', 'Nghỉ ngơi', 'Cần được thư giãn, giảm tải, tái tạo năng lượng', 'health', 0.7, 0.8)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('an_toan', 'An toàn', 'Cần cảm giác được bảo vệ, tránh rủi ro', 'health', 0.8, 0.7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('dinh_huong', 'Định hướng', 'Cần sự rõ ràng về mục tiêu, hướng đi', 'school', 0.7, 0.6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('dong_luc', 'Động lực', 'Cần cảm hứng hoặc mục tiêu để hành động', 'school', 0.8, 0.8)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('cong_nhan', 'Được công nhận', 'Cần được đánh giá cao, công nhận nỗ lực', 'school', 0.7, 0.7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('ket_noi', 'Kết nối', 'Cần sự gần gũi, chia sẻ, hoặc hỗ trợ', 'relationship', 0.8, 0.6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('duoc_hieu', 'Được hiểu', 'Cần được lắng nghe và thấu cảm', 'relationship', 0.9, 0.7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('chap_nhan', 'Chấp nhận', 'Cần cảm giác được chấp nhận dù có khuyết điểm', 'relationship', 0.8, 0.7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('tu_ton', 'Tự tôn', 'Cần tự tin, giá trị bản thân, tự trọng', 'personal', 0.8, 0.6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('kiem_soat', 'Kiểm soát', 'Cần cảm giác chủ động, kiểm soát tình huống', 'personal', 0.7, 0.6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('y_nghia', 'Ý nghĩa', 'Cần thấy cuộc sống hoặc hành động có ý nghĩa', 'personal', 0.9, 0.6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('binh_on', 'Bình ổn', 'Cần cân bằng, tránh quá tải cảm xúc', 'personal', 0.7, 0.8)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('hy_vong', 'Hy vọng', 'Cần niềm tin rằng mọi chuyện sẽ tốt hơn', 'personal', 0.9, 0.7)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO needs (slug, name, description, domain, priority, urgency)
VALUES
  ('khong_xac_dinh', 'Không xác định', 'Không rõ nhu cầu cụ thể', 'unknown', 0.5, 0.5)
ON CONFLICT (slug) DO NOTHING;

-- Need keywords
INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('muốn nghỉ', 1.0),
    ROW('nghỉ ngơi', 1.0),
    ROW('mệt mỏi', 0.9),
    ROW('muốn ngủ', 0.8),
    ROW('cần thư giãn', 0.7),
    ROW('kiệt sức', 0.8),
    ROW('không còn sức', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='nghi_ngoi'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('không an toàn', 1.0),
    ROW('được bảo vệ', 0.9),
    ROW('bất an', 0.9),
    ROW('tổn thương', 0.9),
    ROW('cần che chở', 0.7),
    ROW('muốn yên tâm', 0.8),
    ROW('nguy hiểm', 0.9),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='an_toan'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('hướng đi', 1.0),
    ROW('không biết nên làm gì', 0.9),
    ROW('lạc hướng', 0.9),
    ROW('lạc lối', 0.8),
    ROW('tìm lỗi đi', 0.8),
    ROW('phân vân', 0.9),
    ROW('cần hướng dẫn', 0.9),
    ROW('không chắc chắn', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='dinh_huong'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần động lực', 1.0),
    ROW('không có hứng thú', 0.8)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='dong_luc'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần động lực', 1.0),
    ROW('không có hứng thú', 0.8),
    ROW('mất hứng', 0.8),
    ROW('chán nản', 0.8),
    ROW('không có động lực', 0.9),
    ROW('thiếu năng lượng', 0.8),
    ROW('cần cảm hứng', 0.9),
    ROW('lười biếng', 0.8),
    ROW('không muốn làm gì', 0.7),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='dong_luc'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('được khen', 1.0),
    ROW('được công nhận', 0.9),
    ROW('được thừa nhận', 0.9),
    ROW('cần ghi nhận', 0.9),
    ROW('được trân trọng', 0.8),
    ROW('cần sự đồng ý', 0.7),
    ROW('cảm thấy bị bỏ qua', 0.9),
    ROW('được công nhận', 0.9)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='cong_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần bạn bè', 1.0),
    ROW('cô đơn', 0.9),
    ROW('lẻ loi', 0.9),
    ROW('bị bỏ rơi', 0.8),
    ROW('cần trò chuyện', 0.9),
    ROW('xa cách', 0.8),
    ROW('muốn tương tác', 0.8),
    ROW('không được thấu hiểu', 0.7),
    ROW('muốn gắn bó', 0.8),
    ROW('bị cô lập', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='ket_noi'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('được hiểu', 1.0),
    ROW('muốn chia sẻ', 0.9),
    ROW('không ai hiểu', 0.8),
    ROW('cảm thấy bị hiểu lầm', 0.9),
    ROW('muốn tâm sự', 0.8),
    ROW('muốn chia sẻ cảm xúc', 0.8),
    ROW('bị bỏ qua cảm xúc', 0.9),
    ROW('cảm thấy bị phớt lờ', 0.8),
    ROW('cần ai đó hiểu', 0.9),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='duoc_hieu'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('được chấp nhận', 1.0),
    ROW('không bị phán xét', 0.9),
    ROW('cần được đón nhận', 0.9),
    ROW('muốn hòa nhập', 0.9),
    ROW('bị bỏ qua', 0.8),
    ROW('cần cảm giác thuộc về', 0.9),
    ROW('cần được đón nhận', 0.8),
    ROW('sợ bị từ chối', 0.7),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='chap_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('tự tin', 1.0),
    ROW('tự trọng', 0.9),
    ROW('muốn được tôn trọng', 0.9),
    ROW('giá trị bản thân', 0.9),
    ROW('cảm thấy bị coi thường', 0.9),
    ROW('khẳng định bản thân', 0.8),
    ROW('muốn tự hào về bản thân', 0.8),
    ROW('không muốn bị coi nhẹ', 0.9)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='tu_ton'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần kiểm soát', 1.0),
    ROW('chủ động', 0.9),
    ROW('muốn tự quyết định', 0.9),
    ROW('cần quyền lựa chọn', 0.8),
    ROW('muốn tự lập', 0.8),
    ROW('bị kiểm soát quá mức', 0.9),
    ROW('cần kiểm soát tình huống', 0.9),
    ROW('tự quản lý', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='kiem_soat'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('ý nghĩa', 1.0),
    ROW('cảm thấy vô nghĩa', 0.9),
    ROW('không thấy mục đích', 0.8),
    ROW('cần lý do sống', 0.9),
    ROW('cần mục tiêu', 0.9),
    ROW('muốn đóng góp', 0.7),
    ROW('không biết tại sao', 0.9),
    ROW('muốn hiểu ý nghĩa', 0.9),
    ROW('cảm thấy trống rỗng', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='y_nghia'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('bình ổn', 1.0),
    ROW('muốn bình tĩnh', 0.9),
    ROW('cần yên tĩnh', 0.8),
    ROW('cân bằng', 0.9),
    ROW('muốn thoải mái', 0.7),
    ROW('muốn ổn định', 0.8),
    ROW('cảm thấy hỗn loạn', 0.9),
    ROW('cần kiểm soát cảm xúc', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='binh_on'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('muốn có hy vọng', 1.0),
    ROW('tin tưởng vào tương lai', 0.9),
    ROW('muốn lạc quan', 0.9),
    ROW('cần động lực', 0.7),
    ROW('mong mọi việc tốt đẹp', 0.9),
    ROW('cần niềm hy vọng', 0.9),
    ROW('cảm thấy mất hi vọng', 0.8),
    ROW('tuyệt vọng', 0.8),
    ROW('cần niềm tin', 0.8),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='hy_vong'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('không biết', 1.0),
    ROW('khó xác định', 0.9),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='khong_xac_dinh'
ON CONFLICT DO NOTHING;

-- Links emotion <-> need
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='ket_noi'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='chap_nhan'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.6 FROM emotions e, needs n WHERE e.slug='buon' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='lo_lang' AND n.slug='kiem_soat'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='lo_lang' AND n.slug='an_toan'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='lo_lang' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.6 FROM emotions e, needs n WHERE e.slug='lo_lang' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='met_moi' AND n.slug='nghi_ngoi'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='met_moi' AND n.slug='dong_luc'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.6 FROM emotions e, needs n WHERE e.slug='met_moi' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='vui' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='vui' AND n.slug='tu_ton'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='vui' AND n.slug='cong_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='dong_luc' AND n.slug='dong_luc'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='dong_luc' AND n.slug='y_nghia'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='dong_luc' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='kiem_soat'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='duoc_hieu'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.6 FROM emotions e, needs n WHERE e.slug='tuc_gian' AND n.slug='chap_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='toi_loi' AND n.slug='tu_ton'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='toi_loi' AND n.slug='chap_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='boi_roi' AND n.slug='dinh_huong'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='boi_roi' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.9 FROM emotions e, needs n WHERE e.slug='so_hai' AND n.slug='an_toan'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='so_hai' AND n.slug='kiem_soat'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='so_hai' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.8 FROM emotions e, needs n WHERE e.slug='trung_lap' AND n.slug='binh_on'
ON CONFLICT DO NOTHING;
INSERT INTO emotion_need_links (emotion_id, need_id, relationship_strength)
SELECT e.id, n.id, 0.7 FROM emotions e, needs n WHERE e.slug='trung_lap' AND n.slug='hy_vong'
ON CONFLICT DO NOTHING;

-- Actions

INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_breathing_478', 'Thở sâu 4-7-8', 'Kỹ thuật thở giúp ổn định hệ thần kinh và giảm lo âu', 
   'tip', 1, 1, 2, 'Hít vào 4s, giữ 7s, thở ra 8s. Lặp lại 3 lần.', 
   'Cảm giác thư giãn, nhịp tim giảm', 
   '{"emotion":"anxious"}', '{"emotion":"calm","physiological_state":"relaxed"}', 
   30, 3, 'behavioral'),

  ('tip_grounding_54321', 'Bài tập 5-4-3-2-1', 'Giúp đưa tâm trí về hiện tại bằng cách chú ý giác quan', 
   'tip', 1, 1, 2, 'Nhìn 5 thứ bạn thấy, chạm 4 thứ bạn cảm nhận, nghe 3 âm thanh, ngửi 2 mùi, nếm 1 vị.', 
   'Tăng khả năng hiện diện, giảm lo âu', 
   '{"emotion":"anxious"}', '{"emotion":"grounded"}', 
   120, 3, 'behavioral'),

  ('tip_walk_outdoor', 'Đi bộ nhẹ ngoài trời', 'Vận động nhẹ giúp cải thiện tâm trạng và giảm mệt mỏi', 
   'tip', 1, 1, 3, 'Hãy đi bộ chậm 10-15 phút, chú ý hơi thở và cảnh vật xung quanh.', 
   'Tăng năng lượng, giảm buồn và lo', 
   '{"emotion":"sad"}', '{"emotion":"energized"}', 
   600, 2, 'behavioral');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('question_reframe', 'Tái cấu trúc suy nghĩ', 'Giúp bạn nhìn nhận tình huống từ góc nhìn khác', 
   'question', 2, 2, 3, 'Nếu bạn là bạn thân của mình, bạn sẽ nói gì với chính bạn lúc này?', 
   'Giảm tự chỉ trích, tăng tự hiểu', 
   '{"emotion":"guilty, sad"}', '{"emotion":"understood"}', 
   120, 3, 'cognitive'),

  ('exercise_thought_log', 'Nhật ký suy nghĩ', 'Ghi lại suy nghĩ và cảm xúc để phát hiện mẫu tiêu cực', 
   'exercise', 2, 1, 3, 'Viết ra: Sự kiện - Suy nghĩ - Cảm xúc - Hành vi - Cách thay đổi suy nghĩ.', 
   'Nhận diện mô hình nhận thức tiêu cực', 
   '{"emotion":"confused"}', '{"emotion":"clarity"}', 
   0, 5, 'cognitive'),

  ('question_focus_control', 'Điều bạn kiểm soát', 'Giúp tập trung vào yếu tố có thể thay đổi', 
   'question', 2, 2, 3, 'Hôm nay bạn có thể kiểm soát được điều gì nhỏ nhất?', 
   'Giảm lo âu, tăng cảm giác chủ động', 
   '{"emotion":"anxious"}', '{"emotion":"in_control"}', 
   120, 3, 'cognitive');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('exercise_emotion_journal', 'Nhật ký cảm xúc', 'Ghi lại cảm xúc và nguyên nhân giúp nhận diện bản thân', 
   'exercise', 2, 1, 3, 'Hôm nay bạn cảm thấy thế nào? Hãy viết ra 3 cảm xúc và điều khiến bạn cảm thấy vậy.', 
   'Nhận diện và giải tỏa cảm xúc', 
   '{"emotion":"sad"}', '{"emotion":"relieved"}', 
   0, 5, 'emotional'),

  ('exercise_letter_self', 'Viết thư cho bản thân', 'Thư gửi chính mình giúp biểu lộ cảm xúc an toàn', 
   'exercise', 2, 2, 3, 'Viết cho bản thân: “Mình biết bạn đang cảm thấy..., nhưng mình vẫn ở đây cùng bạn.”', 
   'Tăng tự thương, giảm cô đơn', 
   '{"emotion":"guilty"}', '{"emotion":"accepted"}', 
   0, 3, 'emotional');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_body_scan', 'Body Scan', 'Quan sát cơ thể từ đầu đến chân, nhận biết cảm giác hiện tại', 
   'tip', 2, 1, 3, 'Nhắm mắt, di chuyển sự chú ý từ đầu đến chân, ghi nhận cảm giác mà không phán xét.', 
   'Giảm căng cơ, tăng kết nối thân-tâm', 
   '{"emotion":"tired, anxious"}', '{"emotion":"relaxed"}', 
   300, 3, 'behavioral'),

  ('exercise_selfcare_plan', 'Kế hoạch tự chăm sóc', 'Liệt kê 3 việc nhỏ giúp bạn nạp lại năng lượng', 
   'exercise', 2, 1, 3, 'Hôm nay bạn có thể làm gì để chăm sóc bản thân? (ngủ đủ, ăn ngon, nghỉ ngơi...)', 
   'Tăng ý thức tự chăm sóc, giảm kiệt sức', 
   '{"emotion":"tired"}', '{"emotion":"restored"}', 
   0, 3, 'behavioral');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('tip_message_friend', 'Nhắn tin với bạn thân', 'Gợi ý kết nối xã hội giúp giảm cô đơn', 
   'tip', 2, 1, 3, 'Gửi tin nhắn cho ai đó mà bạn tin tưởng hoặc nhớ đến.', 
   'Cảm giác được kết nối, giảm cô lập', 
   '{"emotion":"sad"}', '{"emotion":"connected"}', 
   600, 2, 'social'),

  ('question_social_support', 'Ai đang ở bên bạn?', 'Nhận diện nguồn hỗ trợ xã hội hiện có', 
   'question', 2, 1, 2, 'Ai là người bạn có thể chia sẻ hoặc nhờ giúp đỡ hôm nay?', 
   'Tăng cảm giác an toàn, giảm cô đơn', 
   '{"emotion":"sad"}', '{"emotion":"supported"}', 
   180, 3, 'social');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('info_affirmation', 'Khẳng định tích cực', 'Câu nói tự khích lệ giúp tăng động lực', 
   'info', 1, 1, 3, '“Mình đang cố gắng hết sức, và điều đó đủ tốt rồi.”', 
   'Tăng tự tin và lòng nhân ái', 
   '{"emotion":"tired, sad"}', '{"emotion":"motivated"}', 
   60, 5, 'motivational'),

  ('question_value_check', 'Xác định giá trị cá nhân', 'Giúp tìm lại định hướng và mục tiêu', 
   'question', 3, 2, 3, 'Điều gì quan trọng nhất với bạn hiện tại, và bạn có thể làm gì nhỏ để tiến gần hơn?', 
   'Tăng định hướng và ý nghĩa sống', 
   '{"emotion":"confused"}', '{"emotion":"purposeful"}', 
   120, 3, 'motivational');


INSERT INTO actions (slug, name, description, type, level, stage_min, stage_max,
  prompt_template, expected_outcomes, preconditions, postconditions, cooldown_seconds, max_repeats, domain)
VALUES
  ('handoff_contact_support', 'Liên hệ hỗ trợ', 'Gợi ý người dùng tìm hỗ trợ an toàn', 
   'handoff', 3, 2, 3, 'Bạn có thể gọi cho người thân hoặc c\huyên gia khi thấy quá tải.', 
   'Tăng cảm giác an toàn và được giúp đỡ', 
   '{"emotion":"fearful"}', '{"emotion":"safe"}', 
   0, 10, 'safety'),

  ('handoff_hotline', 'Đường dây nóng', 'Cung cấp thông tin liên hệ khẩn cấp khi cần thiết', 
   'handoff', 4, 3, 3, 'Nếu bạn cần, hãy liên hệ 111 hoặc 1900 6233 để được hỗ trợ ngay.', 
   'Đảm bảo an toàn tức thì', 
   '{"emotion":"fearful"}', '{"emotion":"safe"}', 
   0, 1, 'safety');
   
-- Action patterns
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('thở', 1.0),
  ROW('hít thở', 0.9),
  ROW('lo âu', 0.8),
  ROW('căng thẳng', 0.8),
  ROW('anxious', 0.7)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy thư giãn', 1.0),
  ROW('bớt căng thẳng', 0.9),
  ROW('đỡ hơn rồi', 0.9),
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn căng thẳng', 1.0),
  ROW('không bớt lo', 0.9),
  ROW('không đỡ chút nào', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn đã thử thở thật sâu chưa', 0.8),
  ROW('cảm thấy khá hơn không', 1.0),
  ROW('bạn thấy dễ chịu hơn chưa', 1.0),
  ROW('muốn thử thêm vài lần nữa không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('hiện tại', 0.8),
  ROW('tập trung', 0.9),
  ROW('loạn', 0.8),
  ROW('mất kiểm soát', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('ổn định lại', 1.0),
  ROW('bình tĩnh hơn', 0.9),
  ROW('bớt căng thẳng', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn hoảng', 0.9),
  ROW('chưa tập trung được', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('có thể thử mô tả 5 điều bạn thấy xung quanh không', 1.0),
  ROW('cảm thấy dễ chịu hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('đi bộ', 1.0),
  ROW('ra ngoài', 0.9),
  ROW('vận động', 0.8),
  ROW('không khí', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('dễ chịu hơn', 1.0),
  ROW('tươi tỉnh', 0.9),
  ROW('thoải mái hơn', 1.0),
  ROW('bớt căng thẳng', 0.9),
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn buồn', 0.9),
  ROW('không thấy đỡ', 0.8),
  ROW('còn căng thẳng', 0.8),
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('thấy dễ chịu hơn chưa', 1.0),
  ROW('đi dạo bao lâu rồi', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('nghĩ theo cách khác', 1.0),
  ROW('góc nhìn', 0.9),
  ROW('nhìn nhận lại', 1.0),
  ROW('tích cực hơn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('đúng là mình nhìn lệch hướng', 1.0),
  ROW('thấy nhẹ lòng hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn tiêu cực', 0.9),
  ROW('không nghĩ khác được', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có nhận ra điều gì mới không', 1.0),
  ROW('muốn thử nghĩ theo hướng khác nữa không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhật ký suy nghĩ', 1.0),
  ROW('ghi lại suy nghĩ', 0.9),
  ROW('thought log', 0.9),
  ROW('viết ra cảm xúc', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('hiểu rõ hơn', 1.0),
  ROW('nhẹ lòng hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('viết mà vẫn rối', 0.9),
  ROW('không giúp được gì', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có nhận ra mẫu suy nghĩ nào không', 1.0),
  ROW('muốn ghi thêm điều gì nữa không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

----------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('mất tập trung', 1.0),
  ROW('không thể tập trung', 0.9),
  ROW('rối trí', 0.8),
  ROW('khó chú ý', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('tập trung hơn', 1.0),
  ROW('đỡ rối trí', 0.9),
  ROW('cảm thấy kiểm soát được', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn xao nhãng', 0.9),
  ROW('không kiểm soát được', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử lại cách tập trung khác không', 1.0),
  ROW('có dễ chịu hơn chút nào không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhật ký cảm xúc', 1.0),
  ROW('ghi lại cảm xúc', 0.9),
  ROW('viết cảm xúc', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhận ra cảm xúc', 1.0),
  ROW('hiểu cảm xúc hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết ghi gì', 0.9),
  ROW('vẫn bối rối', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử viết thêm điều gì không', 1.0),
  ROW('cảm thấy nhẹ nhõm hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

-------------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('viết thư cho bản thân', 1.0),
  ROW('thư tự an ủi', 0.9),
  ROW('nhắn nhủ chính mình', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy an ủi', 1.0),
  ROW('nhẹ nhõm hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết viết gì', 0.9),
  ROW('vẫn buồn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử viết tiếp không', 1.0),
  ROW('cảm thấy khá hơn chút nào chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;
---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('quan sát cơ thể', 1.0),
  ROW('body scan', 0.9),
  ROW('cảm nhận cơ thể', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('thư giãn cơ thể', 1.0),
  ROW('cảm thấy nhẹ nhõm', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không thư giãn được', 0.9),
  ROW('vẫn căng thẳng', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử lại một lần nữa không', 1.0),
  ROW('có cảm thấy nhẹ nhõm hơn không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

--------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('lập kế hoạch tự chăm sóc', 1.0),
  ROW('selfcare plan', 0.9),
  ROW('lịch chăm sóc bản thân', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('thực hiện được kế hoạch', 1.0),
  ROW('cảm thấy tự chăm sóc hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không hoàn thành kế hoạch', 0.9),
  ROW('vẫn chưa chăm sóc bản thân', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử điều chỉnh kế hoạch không', 1.0),
  ROW('có dễ chịu hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhắn tin bạn bè', 1.0),
  ROW('gọi bạn', 0.9),
  ROW('chia sẻ với bạn bè', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy được an ủi', 1.0),
  ROW('nhẹ nhõm hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không muốn chia sẻ', 0.9),
  ROW('vẫn cô đơn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử nhắn thêm không', 1.0),
  ROW('cảm thấy khá hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

----------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('tìm hỗ trợ', 1.0),
  ROW('chia sẻ với người khác', 0.9),
  ROW('nhờ giúp đỡ', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy được lắng nghe', 1.0),
  ROW('hỗ trợ hữu ích', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không nhận được giúp đỡ', 0.9),
  ROW('vẫn cô đơn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử tìm ai khác không', 1.0),
  ROW('có ai để chia sẻ chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

----------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('khẳng định tích cực', 1.0),
  ROW('affirmation', 0.9),
  ROW('câu nói tích cực', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy tích cực', 1.0),
  ROW('được khích lệ', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không cảm thấy tốt hơn', 0.9),
  ROW('vẫn buồn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn nghe thêm câu khẳng định khác không', 1.0),
  ROW('cảm thấy khá hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

-------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('giá trị bản thân', 1.0),
  ROW('tự đánh giá', 0.9),
  ROW('question value', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhận ra giá trị', 1.0),
  ROW('cảm thấy tự tin hơn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn nghi ngờ bản thân', 0.9),
  ROW('không cảm thấy giá trị', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử kiểm tra lại không', 1.0),
  ROW('có thấy khá hơn không', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

--------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('cần giúp đỡ', 1.0),
  ROW('hỗ trợ ngay', 0.9),
  ROW('liên hệ người thân', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy an toàn', 1.0),
  ROW('được hỗ trợ', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không nhận được hỗ trợ', 0.9),
  ROW('vẫn lo lắng', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử gọi lại không', 1.0),
  ROW('có cảm thấy ổn hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

--------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('hotline', 1.0),
  ROW('số điện thoại hỗ trợ', 0.9),
  ROW('liên hệ chuyên gia', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('được giúp đỡ', 1.0),
  ROW('cảm thấy an toàn', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không kết nối được', 0.9),
  ROW('vẫn lo lắng', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử gọi lại không', 1.0),
  ROW('cảm thấy ổn hơn chưa', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;



-- Emotion+Need -> Actions map

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='buon'
  AND n.slug='nghi_ngoi'
  AND a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='buon'
  AND n.slug='duoc_hieu'
  AND a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='buon'
  AND n.slug='ket_noi'
  AND a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='buon'
  AND n.slug='ket_noi'
  AND a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;
---------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='nghi_ngoi'
  AND a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='binh_on'
  AND a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='ket_noi'
  AND a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='lo_lang'
  AND n.slug='binh_on'
  AND a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

-------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='met_moi'
  AND n.slug='dong_luc'
  AND a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='met_moi'
  AND n.slug='kiem_soat'
  AND a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='met_moi'
  AND n.slug='ket_noi'
  AND a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;
----------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.7, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='vui'
  AND n.slug='hy_vong'
  AND a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.7, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='vui'
  AND n.slug='cong_nhan'
  AND a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

--------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='co_dong_luc'
  AND n.slug='cong_nhan'
  AND a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='co_dong_luc'
  AND n.slug='hy_vong'
  AND a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='co_dong_luc'
  AND n.slug='hy_vong'
  AND a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;
--------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='tuc_gian'
  AND n.slug='binh_on'
  AND a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='tuc_gian'
  AND n.slug='binh_on'
  AND a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='tuc_gian'
  AND n.slug='binh_on'
  AND a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='tuc_gian'
  AND n.slug='binh_on'
  AND a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='toi_loi'
  AND n.slug='chap_nhan'
  AND a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='toi_loi'
  AND n.slug='duoc_hieu'
  AND a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 2, 3
FROM emotions e, needs n, actions a
WHERE e.slug='toi_loi'
  AND n.slug='duoc_hieu'
  AND a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;
------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='boi_roi'
  AND n.slug='kiem_soat'
  AND a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='boi_roi'
  AND n.slug='dinh_huong'
  AND a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 3
FROM emotions e, needs n, actions a
WHERE e.slug='boi_roi'
  AND n.slug='dinh_huong'
  AND a.slug='question_value_check'
ON CONFLICT DO NOTHING;

--------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 1.0, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='so_hai'
  AND n.slug='binh_on'
  AND a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='so_hai'
  AND n.slug='binh_on'
  AND a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='so_hai'
  AND n.slug='an_toan'
  AND a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

--------
INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.8, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='trung_lap'
  AND n.slug='hy_vong'
  AND a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='trung_lap'
  AND n.slug='dinh_huong'
  AND a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_need_action_map (emotion_id, need_id, action_id, min_confidence, stage_min, stage_max)
SELECT e.id, n.id, a.id, 0.9, 1, 2
FROM emotions e, needs n, actions a
WHERE e.slug='trung_lap'
  AND n.slug='ket_noi'
  AND a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;