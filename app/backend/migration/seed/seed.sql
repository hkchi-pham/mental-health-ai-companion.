-- Seed data for emotion/need/action schema

-- Emotions
INSERT INTO emotions (slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('buon', 'Buồn', 'Cảm giác buồn bã, mất năng lượng', -0.7, 0.6, 'medium', 'đồng cảm', 'buon')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('lo_lang', 'Lo lắng', 'Cảm giác lo âu, căng thẳng', -0.5, 0.7, 'medium', 'trấn an', 'lo_lang')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('met_moi', 'Mệt mỏi', 'Kiệt sức, thiếu động lực', -0.6, 0.6, 'low', 'khích lệ nhẹ nhàng', 'met_moi')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('vui', 'Vui', 'Tích cực, hạnh phúc', 0.8, 0.6, 'low', 'tích cực', 'vui')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('co_dong_luc', 'Có động lực', 'Cảm thấy có mục tiêu và sẵn sàng hành động', 0.7, 0.8, 'low', 'khích lệ', 'co_dong_luc')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('tuc_gian', 'Tức giận', 'Cảm giác bực bội, muốn phản kháng',-0.8, 0.8, 'high', 'bình tĩnh', 'tuc_gian')
ON CONFLICT ( slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('toi_loi', 'Tội lỗi', 'Cảm giác hối hận vì đã làm điều sai',-0.6, 0.6, 'medium', 'tha thứ, cảm thông', 'toi_loi')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('boi_roi', 'Bối rối', 'Không rõ ràng, lẫn lộn trong suy nghĩ hoặc cảm xúc',-0.3, 0.5, 'low', 'giải thích, làm rõ', 'boi_roi')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('so_hai', 'Sợ hãi', 'Cảm giác sợ hãi, bất an, tránh né nguy hiểm',-0.7, 0.8, 'high', 'trấn an, đảm bảo an toàn', 'so_hai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO emotions ( slug, name, description, valence, intensity, risk_level, default_tone, category)
VALUES
  ('trung_lap', 'Trung lập', 'Trạng thái bình thường, không cảm xúc rõ ràng',0.0, 0.4, 'low', 'tự nhiên', 'trung_lap')
ON CONFLICT (slug) DO NOTHING;


-- Emotion keywords
CREATE TYPE text_weight AS (kw text, wt numeric);

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('buồn',0.75),
    ROW('buồn bã', 0.82),
    ROW('buồn nhiều', 0.85),
    ROW('buồn rầu', 0.83),
    ROW('buồn thắt lòng', 0.88),
    ROW('buồn man mác', 0.78),
    ROW('buồn tê tái', 0.87),
    ROW('buồn da diết', 0.88),
    ROW('buồn vô cớ', 0.75),
    ROW('buồn thẫn thờ', 0.8),
    ROW('chán nản',0.75),
    ROW('chán', 0.7),
    ROW('buồn quá', 0.95),
    ROW('buồn thật', 0.9),
    ROW('đau lòng',0.95),
    ROW('muốn khóc',1.0),
    ROW('tổn thương',0.9),
    ROW('hụt hẫng',0.75),
    ROW('mất mát',0.9),
    ROW('tuyệt vọng',0.95),
    ROW('mất năng lượng',0.67),
    ROW('tủi thân',0.8),
    ROW('sad',0.75),
    ROW('depressed',0.9),
    ROW('tụt mood',0.7),
    ROW('nản',0.6),
    ROW('phiền lòng',0.7),
    ROW('buồn buồn',0.7),
    ROW('hơi buồn',0.65),
    ROW('cảm thấy buồn',0.7),
    ROW('có chút buồn',0.65),
    ROW('buồn lòng',0.75),
    ROW('buồn chút',0.65),
    ROW('buồn một chút',0.65),
    ROW('chẳng vui',0.6),
    ROW('không ổn',0.6),
    ROW('không vui',0.65),
    ROW('thất vọng tẹo',0.7),
    ROW('thất vọng nhẹ',0.7),
    ROW('chán đời',0.7),
    ROW('lowkey sad',0.7),
    ROW('down mood', 0.8),
    ROW('tụt cảm xúc', 0.75),
    ROW('cô đơn', 0.85),
    ROW('đau khổ', 0.92),
    ROW('tan nát', 0.93),
    ROW('suy sụp', 0.94),
    ROW('gục ngã', 0.9),
    ROW('cô độc', 0.9),
    ROW('trống rỗng', 0.9),
    ROW('một mình', 0.7),
    ROW('nặng lòng', 0.77),
    ROW('nỗi buồn đè nặng', 0.85),
    ROW('lòng nặng trĩu', 0.85),
    ROW('tim chùng xuống', 0.82),
    ROW('lòng trống trải', 0.8),
    ROW('lòng nặng trĩu', 0.85),
    ROW('lạc lõng', 0.88),
    ROW('nhói lòng', 0.85),
    ROW('buồn nhẹ', 0.65),
    ROW('buồn sâu', 0.92),
    ROW('buồn dai dẳng', 0.88),
    ROW('mất động lực', 0.8),
    ROW('mất niềm tin', 0.87),
    ROW('mất phương hướng', 0.8),
    ROW('xuống tinh thần', 0.75),
    ROW('cảm xúc tụt dốc', 0.82),
    ROW('down quá', 0.80),
    ROW('tệ quá', 0.78),
    ROW('thất vọng', 0.90),
    ROW('thất vọng tràn trề', 0.92),
    ROW('nản lòng', 0.85),
    ROW('kiệt quệ', 0.88),
    ROW('mông lung', 0.75),
    ROW('xa cách', 0.72),
    ROW('căng thẳng buồn', 0.70),
    ROW('bất lực', 0.90),
    ROW('mệt mỏi tinh thần', 0.88),
    ROW('heartbroken', 0.91),
    ROW('sad', 0.75),
    ROW('very sad', 0.82),
    ROW('lowkey sad', 0.78),
    ROW('feeling down', 0.76),
    ROW('feel lonely', 0.88),
    ROW('nản vãi', 0.82),
    ROW('down bad', 0.75),
    ROW('xỉu up xỉu down', 0.70),
    ROW('khó chịu trong lòng', 0.80),
    ROW('trống rỗng', 0.88),
    ROW('vô định', 0.75),
    ROW('mượn rượu giải sầu', 0.92),
    ROW('tâm trạng tệ', 0.82),
    ROW('buồn thiu', 0.80),
    ROW('chịu đựng', 0.70),
    ROW('u ám', 0.85),
    ROW('sầu não', 0.90),
    ROW('xuống mood', 0.8),
    ROW('tụt dốc cảm xúc', 0.83),
    ROW('fail mood', 0.75),
    ROW('buồn vl', 0.85),
    ROW('buồn vcl', 0.87),
    ROW('buồn quá trời', 0.78),
    ROW('buồn ơi là buồn', 0.82),
    ROW('sad quá', 0.78),
    ROW('sad vl', 0.82),
    ROW('feeling down', 0.78),
    ROW('low energy', 0.7),
    ROW('feeling empty', 0.85),
    ROW('lonely', 0.8),
    ROW('broken', 0.88),
    ROW('mentally drained', 0.87),
    ROW('không muốn nói chuyện với ai',0.88),
    ROW('chỉ muốn ở một mình',0.90),
    ROW('mệt mà không biết vì sao',0.82),
    ROW('không có hứng làm gì cả',0.88),
    ROW('mọi thứ tự nhiên thấy nặng nề',0.90),
    ROW('cảm giác trống rỗng trong lòng',0.92),
    ROW('không thấy vui dù có chuyện tốt',0.90),
    ROW('cười nhưng trong lòng không ổn',0.92),
    ROW('im lặng nhiều hơn bình thường',0.85),
    ROW('không muốn giải thích gì hết',0.88),
    ROW('thấy mình không quan trọng lắm',0.90),
    ROW('chẳng mong đợi gì nữa',0.88),
    ROW('mọi thứ cứ đều đều trôi qua',0.80),
    ROW('khó tập trung vào bất cứ thứ gì',0.85),
    ROW('chỉ muốn ngủ cho qua ngày',0.90),
    ROW('cảm giác như thiếu mất thứ gì đó',0.88),
    ROW('không biết chia sẻ với ai',0.92),
    ROW('ở giữa mọi người mà vẫn thấy lạc lõng',0.93),
    ROW('không còn hào hứng như trước',0.88),
    ROW('làm gì cũng thấy chán',0.90),
    ROW('không có năng lượng để nói nhiều',0.85),
    ROW('thấy mình mệt mỏi từ bên trong',0.90),
    ROW('mọi thứ bỗng trở nên vô nghĩa',0.92),
    ROW('không biết phải bắt đầu từ đâu',0.85),
    ROW('ngồi yên rất lâu mà không làm gì',0.88),
    ROW('thấy lòng nặng trĩu',0.92),
    ROW('không muốn trả lời tin nhắn',0.90),

    ROW('sad', 0.75),
    ROW('very sad', 0.82),
    ROW('extremely sad', 0.95),
    ROW('deeply sad', 0.92),
    ROW('heartbroken', 0.91),
    ROW('feeling sad', 0.70),
    ROW('feeling very sad', 0.85),
    ROW('emotionally sad', 0.78),
    ROW('down', 0.70),
    ROW('feeling down', 0.76),
    ROW('really down', 0.80),
    ROW('emotionally down', 0.82),
    ROW('low mood', 0.70),
    ROW('mood is low', 0.72),
    ROW('mentally low', 0.75),
    ROW('disappointed', 0.75),
    ROW('deeply disappointed', 0.90),
    ROW('overwhelmed with disappointment', 0.92),
    ROW('hurt', 0.90),
    ROW('emotionally hurt', 0.92),
    ROW('pain inside', 0.95),
    ROW('lonely', 0.80),
    ROW('feeling lonely', 0.88),
    ROW('alone', 0.70),
    ROW('feeling alone', 0.78),
    ROW('isolated', 0.90),
    ROW('emotionally isolated', 0.92),
    ROW('empty', 0.85),
    ROW('feeling empty', 0.85),
    ROW('emotionally empty', 0.88),
    ROW('hollow inside', 0.90),
    ROW('hopeless', 0.95),
    ROW('feeling hopeless', 0.95),
    ROW('lost hope', 0.90),
    ROW('mentally exhausted', 0.88),
    ROW('emotionally drained', 0.87),
    ROW('burnt out', 0.85),
    ROW('no motivation', 0.80),
    ROW('lost motivation', 0.80),
    ROW('no energy', 0.70),
    ROW('low energy', 0.70),
    ROW('lost direction', 0.80),
    ROW('feeling lost', 0.75),
    ROW('confused about life', 0.78),
    ROW('heavy heart', 0.77),
    ROW('heart feels heavy', 0.82),
    ROW('emotional burden', 0.85),
    ROW('mentally broken', 0.88),
    ROW('emotionally shattered', 0.93),
    ROW('emotionally collapsed', 0.94),
    ROW('distressed', 0.85),
    ROW('emotionally distressed', 0.88),
    ROW('mentally struggling', 0.85),
    ROW('dark mood', 0.85),
    ROW('gloomy', 0.85),
    ROW('melancholic', 0.90),
    ROW('not okay', 0.60),
    ROW('not feeling okay', 0.65),
    ROW('not happy', 0.65),
    ROW('sad all over again', 0.82),
    ROW('sad for no reason', 0.75),
    ROW('sad for a while', 0.78),
    ROW('constantly sad', 0.88),
    ROW('emotionally weak', 0.85),
    ROW('feeling powerless', 0.90),
    ROW('helpless', 0.90),
    ROW('I don’t really want to talk to anyone',0.88),
    ROW('I just want to be alone for a while',0.90),
    ROW('I feel tired but not physically',0.82),
    ROW('nothing feels interesting right now',0.88),
    ROW('everything feels heavier than usual',0.90),
    ROW('there’s this empty feeling inside',0.92),
    ROW('even good things don’t feel exciting',0.90),
    ROW('I smile but it doesn’t feel real',0.92),
    ROW('I’ve been really quiet lately',0.85),
    ROW('I don’t feel like explaining myself',0.88),

    ROW('I feel kind of unimportant',0.90),
    ROW('I’m not really expecting anything anymore',0.88),
    ROW('days just keep passing by',0.80),
    ROW('it’s hard to focus on anything',0.85),
    ROW('I just want to sleep through the day',0.90),
    ROW('something feels missing and I can’t name it',0.88),
    ROW('I don’t know who to talk to',0.92),
    ROW('I feel alone even around people',0.93),
    ROW('I’m not as excited as I used to be',0.88),
    ROW('everything feels pointless right now',0.90),

    ROW('I don’t have the energy to talk much',0.85),
    ROW('I feel worn out from the inside',0.90),
    ROW('nothing really matters the way it used to',0.92),
    ROW('I don’t know where to start anymore',0.85),
    ROW('I just sit there doing nothing',0.88),
    ROW('it feels heavy in my chest',0.92),
    ROW('I keep ignoring messages',0.90)

  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='buon'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('lo lắng',0.8),
    ROW('lo quá',0.82),
    ROW('rất lo',0.85),
    ROW('vô cùng lo lắng',0.88),
    ROW('bất an',0.82),
    ROW('bất ổn',0.78),
    ROW('nơm nớp',0.8),
    ROW('đứng ngồi không yên',0.83),
    ROW('bất chắc',0.78),
    ROW('hồi hộp lo lắng',0.81),
    ROW('hơi lo',0.68),
    ROW('lo nhẹ',0.62),
    ROW('có chút lo lắng',0.65),
    ROW('hơi bất an',0.65),
    ROW('lăn tan',0.68),
    ROW('không yên tâm',0.72),
    ROW('không chắc chắn',0.7),
    ROW('hơi sợ',0.68),
    ROW('căng thẳng nhẹ',0.7),
    ROW('lo nghĩ',0.62),
    ROW('hoảng loạn',0.93),
    ROW('hoảng sợ',0.92),
    ROW('quá tải cảm xúc',0.93),
    ROW('căng thẳng tột độ',0.92),
    ROW('rối bời',0.85),
    ROW('rối loạn',0.8),
    ROW('áp lực nặng nề',0.92),
    ROW('stress nặng',0.9),
    ROW('mất tự f',0.89),
    ROW('tim đập nhanh',0.8),
    ROW('tim đập loạn',0.82),
    ROW('thở gấp',0.82),
    ROW('khó thở',0.86),
    ROW('nghẹt thở',0.9),
    ROW('run tay',0.78),
    ROW('run rẩy',0.85),
    ROW('đổ mồ hôi',0.75),
    ROW('nhói ngực',0.82),
    ROW('chóng mặt vì lo',0.8),
    ROW('nôn nao',0.82),
    ROW('overthinking',0.85),
    ROW('suy nghĩ quá nhiều',0.83),
    ROW('lo mình không đủ tốt',0.82),
    ROW('lo về tương lai',0.8),
    ROW('ám ảnh',0.9),
    ROW('tự gây áp lực',0.82),
    ROW('đầu óc quay cuồng',0.75),
    ROW('tâm trí rối loạn',0.85),
    ROW('cảm thấy ngột ngạt',0.82),
    ROW('cảm giác nặng đầu',0.72),
    ROW('cảm giác áp lực đè nặng',0.88),
    ROW('lòng như lửa đốt',0.8),
    ROW('đứng tim',0.78),
    ROW('không dám đối mặt',0.83),
    ROW('lo vl',0.86),
    ROW('anxiety quá trời',0.82),
    ROW('run xỉu',0.8),
    ROW('căng vl',0.85),
    ROW('tâm lý bất ổn',0.85),
    ROW('nát mood vì lo',0.78),
    ROW('đau đầu luôn',0.72),
    ROW('xỉu ngang vì lo',0.8),
    ROW('lo muốn xỉu',0.82),
    ROW('anxious',0.8),
    ROW('panic',0.88),
    ROW('panic attack',0.93),
    ROW('stress',0.82),
    ROW('overwhelmed',0.88),
    ROW('nervous',0.82),
    ROW('bồn chồn',0.8),
    ROW('căng thẳng',0.8),
    ROW('nóng ruột',0.7),
    ROW('tense',0.72),
    ROW('freaked out',0.9),
    ROW('worried',0.8),
    ROW('uneasy',0.75),
    ROW('đầu cứ nghĩ mãi không dừng được',0.88),
    ROW('không yên trong người',0.90),
    ROW('cứ thấy bất an mà không rõ vì sao',0.92),
    ROW('tim đập nhanh mỗi khi nghĩ tới chuyện đó',0.90),
    ROW('ngồi không yên',0.88),
    ROW('lúc nào cũng nghĩ đến tình huống xấu nhất',0.92),
    ROW('đầu óc cứ căng ra',0.90),
    ROW('khó tập trung vào việc đang làm',0.85),
    ROW('trong lòng cứ bồn chồn',0.88),
    ROW('cảm giác có gì đó sắp xảy ra',0.92),

    ROW('ngủ mà không sâu giấc',0.85),
    ROW('hay giật mình',0.88),
    ROW('nghĩ đi nghĩ lại một chuyện',0.90),
    ROW('chưa xảy ra mà đã thấy mệt',0.88),
    ROW('tay chân cứ bứt rứt',0.85),
    ROW('lúc nào cũng chuẩn bị tinh thần cho chuyện xấu',0.92),
    ROW('đầu nặng trĩu',0.85),
    ROW('không dám chắc điều gì',0.88),
    ROW('luôn cảm thấy chưa ổn',0.90),
    ROW('cứ thấy căng trong người',0.88),

    ROW('khó thở khi nghĩ nhiều',0.90),
    ROW('trong đầu lúc nào cũng ồn',0.92),
    ROW('không dám thả lỏng',0.88),
    ROW('luôn đề phòng mọi thứ',0.90),
    ROW('cảm giác bị đè nặng trong lòng',0.92),

    ROW('worried', 0.80),
    ROW('very worried', 0.82),
    ROW('extremely worried', 0.88),
    ROW('anxious', 0.80),
    ROW('very anxious', 0.85),
    ROW('extremely anxious', 0.88),
    ROW('uneasy', 0.75),
    ROW('feeling uneasy', 0.78),
    ROW('restless', 0.80),
    ROW('on edge', 0.83),
    ROW('unable to relax', 0.82),
    ROW('slightly worried', 0.68),
    ROW('a bit worried', 0.65),
    ROW('mild anxiety', 0.62),
    ROW('slightly anxious', 0.65),
    ROW('nervous', 0.82),
    ROW('feeling nervous', 0.82),
    ROW('tense', 0.72),
    ROW('feeling tense', 0.75),
    ROW('panic', 0.88),
    ROW('panicking', 0.90),
    ROW('panic attack', 0.93),
    ROW('freaked out', 0.90),
    ROW('overwhelmed', 0.88),
    ROW('emotionally overwhelmed', 0.93),
    ROW('emotionally overloaded', 0.93),
    ROW('stressed', 0.82),
    ROW('very stressed', 0.90),
    ROW('extremely stressed', 0.92),
    ROW('under heavy pressure', 0.92),
    ROW('overthinking', 0.85),
    ROW('thinking too much', 0.83),
    ROW('mind racing', 0.75),
    ROW('thoughts all over the place', 0.85),
    ROW('worried about the future', 0.80),
    ROW('worried about myself', 0.82),
    ROW('worried about not being good enough', 0.82),
    ROW('heart racing', 0.80),
    ROW('irregular heartbeat', 0.82),
    ROW('shortness of breath', 0.86),
    ROW('trouble breathing', 0.86),
    ROW('feeling suffocated', 0.90),
    ROW('shaking hands', 0.78),
    ROW('trembling', 0.85),
    ROW('sweating from anxiety', 0.75),
    ROW('chest tightness', 0.82),
    ROW('feeling dizzy from anxiety', 0.80),
    ROW('nauseous', 0.82),
    ROW('pressure in my head', 0.72),
    ROW('feeling heavy-headed', 0.72),
    ROW('mental pressure', 0.88),
    ROW('heart pounding', 0.82),
    ROW('heart skipping a beat', 0.78),
    ROW('afraid to face it', 0.83),
    ROW('scared to confront', 0.83),
    ROW('anxiety is overwhelming', 0.82),
    ROW('stress is too much', 0.85),
    ROW('mentally unstable', 0.85),
    ROW('head hurts from stress', 0.72),
    ROW('feel like collapsing from anxiety', 0.80),
    ROW('so anxious I feel faint', 0.82),
    ROW('my mind keeps racing nonstop',0.90),
    ROW('I can’t fully relax',0.88),
    ROW('something just doesn’t feel right',0.92),
    ROW('my heart speeds up when I think about it',0.90),
    ROW('I keep pacing around',0.88),
    ROW('my thoughts keep jumping to worst-case scenarios',0.92),
    ROW('my head feels tight all the time',0.90),
    ROW('it’s hard to stay focused',0.85),
    ROW('I feel on edge for no clear reason',0.92),
    ROW('it feels like something bad might happen',0.92),

    ROW('I don’t sleep deeply anymore',0.85),
    ROW('I startle really easily',0.88),
    ROW('I replay the same thoughts over and over',0.90),
    ROW('I feel exhausted before anything even happens',0.88),
    ROW('I can’t sit still',0.85),
    ROW('I keep preparing myself for the worst',0.92),
    ROW('my chest feels tight',0.90),
    ROW('I don’t feel confident about anything',0.88),
    ROW('something always feels off',0.90),
    ROW('I feel tense all the time',0.88),

    ROW('breathing feels harder when I overthink',0.90),
    ROW('my mind never feels quiet',0.92),
    ROW('I can’t let my guard down',0.88),
    ROW('I’m always on alert',0.90),
    ROW('there’s a heavy pressure inside',0.92)

  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='lo_lang'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('mệt',0.78),
    ROW('rất mệt',0.82),
    ROW('cực mệt',0.85),
    ROW('cực kỳ mệt',0.85),
    ROW('kiệt sức',0.86),
    ROW('mệt mỏi',0.8),
    ROW('uể oải',0.78),
    ROW('đuối',0.8),
    ROW('đuối sức',0.82),
    ROW('mệt rã rời',0.84),
    ROW('mệt quá trời',0.83),
    ROW('mỏi mệt',0.78),
    ROW('đau đầu',0.72),
    ROW('chóng mặt',0.75),
    ROW('buồn ngủ',0.7),
    ROW('thiếu ngủ',0.78),
    ROW('ngủ không đủ',0.75),
    ROW('không ngủ đủ',0.75),
    ROW('mệt lả',0.82),
    ROW('không còn sức',0.8),
    ROW('nhức người',0.72),
    ROW('nặng đầu',0.75),
    ROW('kiệt quệ',0.88),
    ROW('cạn kiệt năng lượng',0.9),
    ROW('cháy sạch năng lượng',0.92),
    ROW('burnout',0.92),
    ROW('suy sụp',0.9),
    ROW('hụt hơi',0.83),
    ROW('cạn sức',0.85),
    ROW('hết pin',0.88),
    ROW('muốn buông xuôi',0.9),
    ROW('muốn từ bỏ',0.9),
    ROW('không còn động lực',0.88),
    ROW('mất hứng',0.72),
    ROW('chán nản',0.82),
    ROW('chán đời',0.82),
    ROW('không muốn làm gì',0.85),
    ROW('không buồn làm gì',0.82),
    ROW('tụt mood',0.75),
    ROW('không thể tập trung',0.8),
    ROW('xuống tinh thần',0.82),
    ROW('quá tải',0.88),
    ROW('căng thẳng',0.78),
    ROW('áp lực',0.8),
    ROW('stress',0.82),
    ROW('quá sức',0.88),
    ROW('ngộp',0.85),
    ROW('ngột ngạt',0.88),
    ROW('nghẹt thở vì mệt',0.9),
    ROW('tâm trí rã rời',0.88),
    ROW('bế tắc vì mệt',0.9),
    ROW('kiệt tinh thần',0.92),
    ROW('cháy sạch năng lượng',0.92),
    ROW('hết hơi',0.72),
    ROW('xuống năng lượng',0.78),
    ROW('đuối như trái chuối',0.75),
    ROW('rã rời cả người',0.8),
    ROW('trống rỗng',0.85),
    ROW('như sắp gục',0.9),
    ROW('cảm giác muốn ngất',0.85),
    ROW('mệt muốn xỉu',0.82),
    ROW('muốn nằm xuống luôn',0.78),
    ROW('mệt đến mức không nói nổi',0.82),
    ROW('mệt vl',0.85),
    ROW('mệt vcl',0.88),
    ROW('mệt xỉu',0.8),
    ROW('heetspin vl',0.88),
    ROW('kiệt sức vl',0.88),
    ROW('hết năng lượng',0.8),
    ROW('mệt muốn khóc',0.85),
    ROW('đuối vl',0.85),
    ROW('thiếu ngủ vl',0.82),
    ROW('cạn mood',0.75),
    ROW('drain quá',0.8),
    ROW('drained',0.8),
    ROW('burnout xong luôn',0.92),
    ROW('low energy',0.72),
    ROW('overwhelmed',0.8),
    ROW('fatigue',0.8),
    ROW('mentally drained',0.92),
    ROW('emotionally tired',0.9),
    ROW('dead inside',0.92),
    ROW('thiếu năng lượng',0.8),
    ROW('tired',0.9),
    ROW('exhausted',0.8),
    ROW('người nặng trịch như không còn sức',0.90),
    ROW('chỉ muốn nằm im một chỗ',0.92),
    ROW('đầu óc chậm hẳn đi',0.88),
    ROW('không còn năng lượng để nói nhiều',0.90),
    ROW('làm gì cũng thấy tốn sức',0.92),
    ROW('cơ thể như bị rút hết pin',0.93),
    ROW('chỉ muốn nhắm mắt lại',0.90),
    ROW('mọi việc bình thường cũng thấy khó',0.88),
    ROW('đầu óc mờ mịt',0.90),
    ROW('không còn sức để tập trung',0.88),

    ROW('ngồi một lúc cũng thấy nặng người',0.90),
    ROW('cảm giác rã rời từ trong ra ngoài',0.92),
    ROW('chỉ muốn nghỉ thôi',0.90),
    ROW('không còn hứng làm gì',0.88),
    ROW('tay chân như không nghe lời',0.85),
    ROW('cả người như chậm hơn mọi ngày',0.88),
    ROW('làm một việc nhỏ cũng thấy đuối',0.90),
    ROW('chỉ muốn tắt não một lúc',0.92),
    ROW('đầu nặng và khó nghĩ',0.88),
    ROW('người như bị kéo xuống',0.92),

    ROW('không muốn nói chuyện lâu',0.85),
    ROW('chỉ muốn yên tĩnh',0.88),
    ROW('mọi thứ diễn ra chậm chạp',0.85),
    ROW('cảm giác trống rỗng về năng lượng',0.92),
    ROW('không còn sức bật lại',0.90),

    ROW('tired', 0.78),
    ROW('very tired', 0.82),
    ROW('extremely tired', 0.85),
    ROW('completely exhausted', 0.85),
    ROW('exhausted', 0.86),
    ROW('physically exhausted', 0.84),
    ROW('emotionally exhausted', 0.90),
    ROW('fatigued', 0.80),
    ROW('fatigue', 0.80),
    ROW('feeling fatigued', 0.80),
    ROW('worn out', 0.78),
    ROW('drained', 0.80),
    ROW('completely drained', 0.88),
    ROW('low energy', 0.72),
    ROW('out of energy', 0.80),
    ROW('no energy left', 0.88),
    ROW('burnout', 0.92),
    ROW('burned out', 0.92),
    ROW('severe burnout', 0.92),
    ROW('mentally drained', 0.92),
    ROW('mentally exhausted', 0.92),
    ROW('mentally worn out', 0.88),
    ROW('mental burnout', 0.92),
    ROW('emotionally tired', 0.90),
    ROW('emotionally drained', 0.90),
    ROW('emotionally worn out', 0.88),
    ROW('physically weak', 0.82),
    ROW('no strength left', 0.80),
    ROW('about to collapse', 0.90),
    ROW('feels like I might faint', 0.85),
    ROW('sleepy', 0.70),
    ROW('sleep deprived', 0.78),
    ROW('did not sleep enough', 0.75),
    ROW('lack of sleep', 0.78),
    ROW('headache', 0.72),
    ROW('dizzy', 0.75),
    ROW('heavy head', 0.75),
    ROW('body aches', 0.72),
    ROW('can’t focus', 0.80),
    ROW('unable to concentrate', 0.80),
    ROW('mentally foggy', 0.78),
    ROW('no motivation', 0.88),
    ROW('lost motivation', 0.88),
    ROW('don’t want to do anything', 0.85),
    ROW('feel like giving up', 0.90),
    ROW('overwhelmed', 0.80),
    ROW('overloaded', 0.88),
    ROW('pushed too hard', 0.88),
    ROW('stressed and tired', 0.82),
    ROW('pressure is exhausting', 0.88),
    ROW('feel empty', 0.85),
    ROW('completely worn down', 0.88),
    ROW('running on empty', 0.88),
    ROW('dead tired', 0.88),
    ROW('so tired it hurts', 0.85),
    ROW('too tired to talk', 0.82),
    ROW('need to lie down', 0.78),
    ROW('low stamina', 0.80),
    ROW('energy depleted', 0.90),
    ROW('my body feels really heavy',0.90),
    ROW('I just want to lie down and do nothing',0.92),
    ROW('my brain feels slow today',0.88),
    ROW('I don’t have much energy to talk',0.90),
    ROW('everything takes more effort than usual',0.92),
    ROW('it feels like my battery is empty',0.93),
    ROW('I keep wanting to close my eyes',0.90),
    ROW('even small tasks feel difficult',0.88),
    ROW('my head feels foggy',0.90),
    ROW('I can’t stay focused for long',0.88),

    ROW('just sitting feels like effort',0.90),
    ROW('my whole body feels worn down',0.92),
    ROW('I just want a break from everything',0.90),
    ROW('nothing really feels engaging',0.88),
    ROW('my body doesn’t feel responsive',0.85),
    ROW('everything feels slower today',0.88),
    ROW('small things drain me quickly',0.90),
    ROW('I want to shut my brain off for a bit',0.92),
    ROW('thinking feels heavy',0.88),
    ROW('it feels like something is weighing me down',0.92),

    ROW('I don’t feel like talking much',0.85),
    ROW('I need quiet right now',0.88),
    ROW('everything feels sluggish',0.85),
    ROW('there’s just no energy left inside',0.92),
    ROW('I don’t feel ready to push myself',0.90)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='met_moi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('vui',0.8),
    ROW('zui',0.8),
    ROW('zui zẻ',0.82),
    ROW('vve',0.78),
    ROW('vui vẻ',0.82),
    ROW('rất vui',0.85),
    ROW('rấc vui',0.85),
    ROW('cực vui',0.87),
    ROW('vui cực',0.87),
    ROW('vui lắm',0.83),
    ROW('hào hứng',0.83),
    ROW('hồ hởi',0.8),
    ROW('sung sướng',0.84),
    ROW('hoan hỉ',0.82),
    ROW('hơi vui',0.6),
    ROW('vui chút',0.62),
    ROW('cảm thấy tốt hơn',0.7),
    ROW('đỡ hơn',0.7),
    ROW('dễ chịu',0.68),
    ROW('nhẹ nhõm',0.7),
    ROW('thoải mái',0.72),
    ROW('ấm lòng',0.75),
    ROW('biết ơn',0.74),
    ROW('ổn áp',0.72),
    ROW('hạnh phúc',0.92),
    ROW('cực kì hạnh phúc',0.95),
    ROW('hạnh phúc cực kì',0.9),
    ROW('lâng lâng',0.9),
    ROW('vỡ òa',0.93),
    ROW('hân hoan',0.87),
    ROW('mãn nguyện',0.87),
    ROW('tràn đầy năng lượng',0.88),
    ROW('thăng hoa',0.92),
    ROW('nâng mood',0.9),
    ROW('cực kỳ phấn khích',0.94),
    ROW('rất hạnh phúc',0.93),
    ROW('tươi vui',0.8),
    ROW('phấn khởi',0.82),
    ROW('happy',0.8),
    ROW('cheerful',0.8),
    ROW('như được tiếp năng lượng',0.78),
    ROW('thấy cuộc đời tươi sáng',0.82),
    ROW('nâng tinh thần',0.76),
    ROW('cảm giác thấy đầy sức sống',0.8),
    ROW('thế nhẹ người',0.75),
    ROW('mọi thứ sáng sủa',0.78),
    ROW('vui từ trong lòng',0.82),
    ROW('cười vui',0.8),
    ROW('lên mood',0.8),
    ROW('up mood',0.82),
    ROW('vui v',0.8),
    ROW('vui vcl',0.85),
    ROW('vui vãi',0.82),
    ROW('vui hơn',0.8),
    ROW('vui vl',0.87),
    ROW('vui dã man',0.85),
    ROW('vui xỉu',0.84),
    ROW('vui quá trời',0.82),
    ROW('feel good',0.8),
    ROW('best mood',0.85),
    ROW('so happy',0.85),
    ROW('excited',0.82),
    ROW('super excited',0.9),
    ROW('hyped',0.88),
    ROW('feel great',0.83),
    ROW('energetic',0.8),
    ROW('thrilled',0.88),
    ROW('overjoyed',0.91),
    ROW('cảm giác an tâm',0.72),
    ROW('vui vì có bạn',0.78),
    ROW('cảm giác gắn kết',0.75),
    ROW('cảm giác nhẹ người hẳn ra',0.85),
    ROW('mọi thứ trông dễ chịu hơn',0.82),
    ROW('khóe miệng cứ muốn cong lên',0.88),
    ROW('tự nhiên thấy muốn cười',0.90),
    ROW('trong lòng thấy ấm áp',0.85),
    ROW('tinh thần thoải mái hẳn',0.83),
    ROW('cảm giác mọi thứ đang ổn',0.80),
    ROW('nhìn đâu cũng thấy dễ thương',0.88),
    ROW('tự nhiên thấy đời dễ thở',0.82),
    ROW('có năng lượng để làm nhiều thứ',0.85),

    ROW('thấy lòng nhẹ hơn mọi ngày',0.82),
    ROW('tự nhiên thấy yêu đời hơn',0.90),
    ROW('muốn nói chuyện với người khác',0.80),
    ROW('không còn cảm giác nặng nề',0.85),
    ROW('cảm giác được tiếp thêm năng lượng',0.88),
    ROW('tinh thần sáng hẳn lên',0.90),
    ROW('cảm thấy dễ mỉm cười',0.85),
    ROW('mọi chuyện diễn ra khá trơn tru',0.80),
    ROW('trong lòng thấy dễ chịu lạ',0.82),
    ROW('muốn chia sẻ điều này với ai đó',0.83),

    ROW('cảm giác được kết nối',0.80),
    ROW('thấy mình mở lòng hơn',0.78),
    ROW('mọi thứ có vẻ sáng sủa hơn',0.85),
    ROW('cảm giác hôm nay khá ổn áp',0.82),
    ROW('trong lòng có gì đó rất dễ chịu',0.88),

    ROW('happy', 0.80),
    ROW('very happy', 0.85),
    ROW('extremely happy', 0.90),
    ROW('cheerful', 0.80),
    ROW('joyful', 0.82),
    ROW('bright mood', 0.78),
    ROW('excited', 0.82),
    ROW('very excited', 0.90),
    ROW('super excited', 0.90),
    ROW('thrilled', 0.88),
    ROW('hyped', 0.88),
    ROW('content', 0.72),
    ROW('feeling content', 0.72),
    ROW('satisfied', 0.75),
    ROW('fulfilled', 0.87),
    ROW('relaxed', 0.72),
    ROW('comfortable', 0.72),
    ROW('at ease', 0.72),
    ROW('light-hearted', 0.75),
    ROW('grateful', 0.74),
    ROW('warm inside', 0.75),
    ROW('emotionally warm', 0.75),
    ROW('peaceful', 0.72),
    ROW('feeling safe', 0.72),
    ROW('emotionally safe', 0.72),
    ROW('energized', 0.88),
    ROW('full of energy', 0.88),
    ROW('recharged', 0.78),
    ROW('uplifted', 0.90),
    ROW('feeling better', 0.70),
    ROW('doing better', 0.70),
    ROW('things feel brighter', 0.82),
    ROW('overjoyed', 0.91),
    ROW('on cloud nine', 0.93),
    ROW('bursting with joy', 0.93),
    ROW('best mood', 0.85),
    ROW('great mood', 0.83),
    ROW('feel good', 0.80),
    ROW('feel great', 0.83),
    ROW('positive vibes', 0.80),
    ROW('good vibes', 0.80),
    ROW('emotionally connected', 0.75),
    ROW('feeling connected', 0.75),
    ROW('happy to have friends', 0.78),
    ROW('smiling inside', 0.82),
    ROW('laughing happily', 0.80),
    ROW('joy from within', 0.82),
    ROW('over the moon', 0.87),
    ROW('everything feels lighter somehow',0.85),
    ROW('I keep smiling without noticing',0.90),
    ROW('things feel easier today',0.82),
    ROW('there’s a warm feeling inside',0.85),
    ROW('I feel more open than usual',0.80),
    ROW('my mood feels lifted',0.88),
    ROW('I feel comfortable just being here',0.82),
    ROW('I want to talk and share things',0.80),
    ROW('there’s a calm positive energy',0.85),
    ROW('today feels kind of bright',0.88),

    ROW('I feel at ease with myself',0.82),
    ROW('small things feel enjoyable',0.85),
    ROW('I catch myself smiling',0.90),
    ROW('everything feels smoother today',0.80),
    ROW('I feel warm inside',0.85),
    ROW('there’s a lightness in my chest',0.88),
    ROW('I feel more connected to people',0.80),
    ROW('my energy feels steady and good',0.82),
    ROW('I’m more talkative than usual',0.78),
    ROW('things feel pleasant right now',0.82),

    ROW('I feel okay in a really good way',0.85),
    ROW('there’s a quiet positivity',0.80),
    ROW('I feel comfortable and relaxed',0.82),
    ROW('today feels nice overall',0.85),
    ROW('I feel like myself again',0.88)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='vui'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('có động lực',1.0),
    ROW('tràn đầy động lực',1.0),
    ROW('có hứng thú',0.95),
    ROW('có mục tiêu',0.95),
    ROW('sẵn sàng cố gắng',0.95),
    ROW('quyết tâm',1.0),
    ROW('quyết chí',0.8),
    ROW('hứng khởi',0.95),
    ROW('đầy năng lương',0.95),
    ROW('muốn bắt đầu',0.8),
    ROW('nhiệt huyết',0.95),
    ROW('muốn tiến lên',0.95),
    ROW('muốn thử sức',0.95),
    ROW('thúc đẩy bản thân',0.9),
    ROW('tự thúc đẩy',0.9),
    ROW('muốn đạt được',0.9),
    ROW('sẵn sàng hành động',0.95),
    ROW('chăm chỉ',0.9),
    ROW('cố gắng',0.87),
    ROW('cố gắng hết mình',0.95),
    ROW('nỗ lực',0.85),
    ROW('nỗ lực hết mình',0.95), 
    ROW('tích cực',0.8),
    ROW('hăng hái',0.8),
    ROW('motivated',0.9),
    ROW('determined',0.8),
    ROW('theo đuổi mục tiêu',0.90),
    ROW('kiên trì',0.90),
    ROW('có mục đích',0.85),
    ROW('tập trung',0.85),
    ROW('quyết đoán',0.80),
    ROW('chủ động',0.85),
    ROW('dám thử',0.80),
    ROW('hướng về mục tiêu',0.85),
    ROW('muốn cải thiện',0.80),
    ROW('muốn làm tốt hơn',0.80),
    ROW('tiến bộ',0.80),
    ROW('phấn đấu',0.85),
    ROW('sẵn sàng thay đổi',0.80),
    ROW('muốn hoàn thành',0.85),
    ROW('định hướng rõ ràng',0.80),
    ROW('bền bỉ',0.85),
    ROW('dồn sức',0.80),
    ROW('sung sức',0.80),
    ROW('đầy khí thế',0.85),
    ROW('khí thế',0.75),
    ROW('sẵn sàng bắt tay vào việc',0.80),
    ROW('có tâm trạng làm việc',0.75),
    ROW('máu lửa',0.80),
    ROW('bừng bừng',0.75),
    ROW('tỉnh táo và sẵn sàng',0.70),
    ROW('muốn hoạt động',0.75),
    ROW('muốn làm việc',0.75),
    ROW('muốn học bài',0.75),
    ROW('có tinh thần',0.70),
    ROW('sôi nổi',0.75),
    ROW('muốn phát triển',0.80),
    ROW('muốn tự hoàn thiện',0.80),
    ROW('phát triển bản thân',0.75),
    ROW('tự tin vào khả năng',0.75),
    ROW('tự thúc đẩy mình',0.75),
    ROW('muốn thử điều mới',0.70),
    ROW('muốn tiến xa hơn',0.75),
    ROW('điều khiển bản thân',0.65),
    ROW('hướng nội lực',0.65),
    ROW('lạc quan về tương lai',0.70),
    ROW('tin mình làm được',0.75),
    ROW('đặt kế hoạch',0.70),
    ROW('sẵn sàng thử lại',0.70),
    ROW('muốn vươn lên',0.75),
    ROW('cảm thấy có hy vọng',0.65),
    ROW('cảm thấy sẵn sàng',0.75),
    ROW('có tinh thần vượt khó',0.75),
    ROW('tự tin vào khả năng',0.75),
    ROW('thực sự muốn thay đổi',0.88),
    ROW('muốn thử điều mới',0.75),
    ROW('cảm thấy sẵn sàng',0.75),
    ROW('muốn bắt tay vào làm ngay',0.90),
    ROW('đầu óc đang rất rõ ràng',0.85),
    ROW('cảm giác sẵn sàng hành động',0.88),
    ROW('không muốn trì hoãn nữa',0.90),
    ROW('thấy mình chủ động hơn',0.85),
    ROW('muốn hoàn thành việc này',0.88),
    ROW('có năng lượng để bắt đầu',0.87),
    ROW('thấy mình kiểm soát được mọi thứ',0.83),
    ROW('đầu óc tập trung hơn hẳn',0.88),
    ROW('muốn làm cho xong',0.90),

    ROW('tự nhiên thấy muốn tiến lên',0.85),
    ROW('không còn muốn ngồi yên',0.88),
    ROW('thấy rõ mình cần làm gì',0.90),
    ROW('có cảm giác đang đi đúng hướng',0.83),
    ROW('muốn thử thêm lần nữa',0.87),
    ROW('thấy mình chủ động hơn trước',0.85),
    ROW('sẵn sàng đối mặt với việc khó',0.88),
    ROW('muốn tự đẩy bản thân lên',0.90),
    ROW('cảm giác không muốn bỏ cuộc',0.92),
    ROW('thấy mình tiến bộ từng chút',0.83),

    ROW('muốn tận dụng thời gian này',0.88),
    ROW('đầu óc hướng về mục tiêu',0.90),
    ROW('có cảm giác phải làm gì đó',0.87),
    ROW('không muốn để cơ hội trôi qua',0.92),
    ROW('thấy mình đang tăng tốc',0.88),

    ROW('motivated', 1.00),
    ROW('highly motivated', 1.00),
    ROW('full of motivation', 1.00),
    ROW('interested', 0.95),
    ROW('enthusiastic', 0.95),
    ROW('eager', 0.95),
    ROW('goal-oriented', 0.95),
    ROW('having goals', 0.95),
    ROW('clear goals', 0.95),
    ROW('ready to try', 0.95),
    ROW('ready to work hard', 0.95),
    ROW('ready to take action', 0.95),
    ROW('determined', 1.00),
    ROW('strong determination', 1.00),
    ROW('strong will', 0.80),
    ROW('inspired', 0.95),
    ROW('energized', 0.95),
    ROW('full of energy', 0.95),
    ROW('want to start', 0.80),
    ROW('ready to begin', 0.80),
    ROW('passionate', 0.95),
    ROW('driven', 0.95),
    ROW('want to move forward', 0.95),
    ROW('want to challenge myself', 0.95),
    ROW('self-driven', 0.90),
    ROW('pushing myself', 0.90),
    ROW('want to achieve', 0.90),
    ROW('hardworking', 0.90),
    ROW('trying my best', 0.87),
    ROW('giving my all', 0.95),
    ROW('making an effort', 0.85),
    ROW('giving full effort', 0.95),
    ROW('positive', 0.80),
    ROW('proactive', 0.85),
    ROW('focused', 0.85),
    ROW('persistent', 0.90),
    ROW('consistent', 0.85),
    ROW('decisive', 0.80),
    ROW('taking initiative', 0.85),
    ROW('willing to try', 0.80),
    ROW('goal-focused', 0.85),
    ROW('want to improve', 0.80),
    ROW('want to do better', 0.80),
    ROW('making progress', 0.80),
    ROW('striving forward', 0.85),
    ROW('ready for change', 0.80),
    ROW('want to finish', 0.85),
    ROW('clear direction', 0.80),
    ROW('resilient', 0.85),
    ROW('putting in full effort', 0.80),
    ROW('energetic', 0.80),
    ROW('high spirits', 0.85),
    ROW('motivated mindset', 0.75),
    ROW('ready to get to work', 0.80),
    ROW('in the mood to work', 0.75),
    ROW('fired up', 0.80),
    ROW('full of drive', 0.75),
    ROW('alert and ready', 0.70),
    ROW('want to be active', 0.75),
    ROW('want to work', 0.75),
    ROW('want to study', 0.75),
    ROW('in good spirits', 0.70),
    ROW('engaged', 0.75),
    ROW('want to grow', 0.80),
    ROW('want self-improvement', 0.80),
    ROW('personal growth', 0.75),
    ROW('confident in my abilities', 0.75),
    ROW('self-motivated', 0.75),
    ROW('want to try something new', 0.70),
    ROW('want to go further', 0.75),
    ROW('self-controlled', 0.65),
    ROW('inner drive', 0.65),
    ROW('optimistic about the future', 0.70),
    ROW('believe I can do it', 0.75),
    ROW('making plans', 0.70),
    ROW('ready to try again', 0.70),
    ROW('want to rise up', 0.75),
    ROW('feeling hopeful', 0.65),
    ROW('feeling ready', 0.75),
    ROW('mentally strong', 0.75),
    ROW('confident and ready', 0.75),
    ROW('truly want to change', 0.88),
    ROW('I feel ready to start',0.90),
    ROW('I want to get things done',0.92),
    ROW('my mind feels focused',0.88),
    ROW('I don’t want to put this off',0.90),
    ROW('I feel more proactive',0.85),
    ROW('I’m ready to take action',0.90),
    ROW('I feel a push to move forward',0.88),
    ROW('I know what I need to do',0.92),
    ROW('I want to make progress',0.90),
    ROW('I feel in control of my direction',0.85),

    ROW('I don’t want to stay stuck',0.88),
    ROW('I feel prepared to handle this',0.87),
    ROW('I want to push myself a bit more',0.92),
    ROW('I feel momentum building',0.90),
    ROW('I’m focused on moving ahead',0.88),
    ROW('I want to keep going',0.92),
    ROW('I feel ready to face challenges',0.90),
    ROW('I don’t feel like giving up',0.93),
    ROW('I’m leaning into the work',0.85),
    ROW('I feel a strong urge to act',0.88),

    ROW('I want to use this moment well',0.87),
    ROW('my thoughts are goal-oriented',0.90),
    ROW('I feel myself picking up pace',0.88),
    ROW('I don’t want to miss this chance',0.92),
    ROW('I’m moving with intention',0.90)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='co_dong_luc'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('tức giận',0.85),
    ROW('giận',0.8),
    ROW('rất giận',0.83),
    ROW('rất bực',0.82),
    ROW('rất khó chịu',0.82),
    ROW('rất cáu',0.83),
    ROW('bực mình',0.82),
    ROW('khó chịu',0.8),
    ROW('cáu',0.82),
    ROW('cáu gắt',0.85),
    ROW('phát cáu',0.85),
    ROW('điên người',0.88),
    ROW('nổi nóng',0.83),
    ROW('nóng tính',0.8),
    ROW('nổi cáu',0.85),
    ROW('gắt gỏng',0.78),
    ROW('mất kiên nhẫn',0.77),
    ROW('mất bình tĩnh',0.85),
    ROW('không chịu nổi',0.76),
    ROW('hơi bực',0.65),
    ROW('hơi khó chịu',0.63),
    ROW('khó ở',0.6),
    ROW('không vui',0.6),
    ROW('bực chút',0.62),
    ROW('phiền',0.7),
    ROW('phiền lòng',0.72),
    ROW('chán nản',0.7),
    ROW('khó chịu nhẹ',0.6),
    ROW('không hài lòng',0.72),
    ROW('thất vọng',0.7),
    ROW('giận dữ',0.9),
    ROW('cực kỳ giận',0.92),
    ROW('điên tiết',0.95),
    ROW('tức điên',0.95),
    ROW('thịnh nộ',0.95),
    ROW('nổi đóa',0.93),
    ROW('muốn đập đồ',0.95),
    ROW('muốn la lên',0.92),
    ROW('muốn chửi',0.93),
    ROW('phẫn nộ',0.95),
    ROW('điên cuồng',0.92),
    ROW('điên đầu',0.88),
    ROW('sục sôi',0.90),
    ROW('bị kích động',0.92),
    ROW('giận ai đó',0.80),
    ROW('giận bạn',0.78),
    ROW('giận bố mẹ',0.80),
    ROW('cảm thấy bị xúc phạm',0.88),
    ROW('cảm thấy bất công',0.85),
    ROW('cảm thấy bị đối xử tệ',0.82),
    ROW('bị làm tổn thương',0.75),
    ROW('tranh cãi',0.75),
    ROW('cãi nhau',0.78),
    ROW('xung đột',0.70),
    ROW('bực vì bị phớt lờ',0.80),
    ROW('bực vì điểm kém',0.78),
    ROW('bực vì làm sai',0.75),
    ROW('bực vì không được tôn trọng',0.85),
    ROW('bực vì bị áp lực',0.75),
    ROW('bực vì ai đó vô lý',0.85),
    ROW('bực vì không được nghe',0.80),
    ROW('không chịu nổi hành động của họ',0.82),
    ROW('sôi máu',0.90),
    ROW('máu dồn lên não',0.90),
    ROW('nóng máu',0.88),
    ROW('muốn nổ tung',0.92),
    ROW('muốn quát',0.85),
    ROW('đầu muốn bốc khói',0.95),
    ROW('tức muốn chết',0.92),
    ROW('muốn hét lên',0.85),
    ROW('cay',0.82),
    ROW('cay vãi',0.88),
    ROW('cay thật sự',0.90),
    ROW('tức vl',0.92),
    ROW('bực vcl',0.90),
    ROW('nóng vãi',0.85),
    ROW('điên vđ',0.92),
    ROW('tức á',0.80),
    ROW('cáu thật sự',0.88),
    ROW('khó chịu vãi',0.88),
    ROW('angry',0.80),
    ROW('pissed',0.90),
    ROW('pissed off',0.92),
    ROW('annoyed',0.78),
    ROW('irritated',0.75),
    ROW('mad',0.82),
    ROW('so mad',0.90),
    ROW('furious',0.92),
    ROW('bực bội',0.85),
    ROW('không còn kiên nhẫn nữa',0.92),
    ROW('dễ nổi nóng vì chuyện nhỏ',0.90),
    ROW('nghe thôi cũng thấy khó chịu',0.88),
    ROW('không muốn nghe thêm lời nào',0.92),
    ROW('cảm giác bị dồn nén',0.90),
    ROW('chỉ muốn mọi người im lặng',0.88),
    ROW('thấy mình đang rất căng',0.87),
    ROW('mấy chuyện nhỏ cũng làm mình khó chịu',0.90),
    ROW('không muốn giải thích thêm',0.88),
    ROW('cảm giác bị làm phiền liên tục',0.90),

    ROW('muốn tránh xa mọi người lúc này',0.85),
    ROW('thấy tim đập nhanh hơn bình thường',0.88),
    ROW('khó giữ bình tĩnh',0.92),
    ROW('nói chuyện dễ bị gắt',0.90),
    ROW('không muốn nhượng bộ',0.88),
    ROW('cảm giác bị đối xử không công bằng',0.92),
    ROW('chỉ cần thêm chút nữa là không chịu được',0.93),
    ROW('mọi thứ đang vượt quá giới hạn',0.90),
    ROW('cảm thấy bị ép quá mức',0.88),
    ROW('đầu óc toàn những suy nghĩ tiêu cực',0.85),

    ROW('không muốn ai động vào mình',0.90),
    ROW('thấy người nóng lên',0.88),
    ROW('khó chịu ngay cả khi không nói gì',0.90),
    ROW('cảm giác sắp bùng ra',0.93),
    ROW('không muốn tiếp tục cuộc nói chuyện này',0.92),

    ROW('angry', 0.80),
    ROW('very angry', 0.85),
    ROW('extremely angry', 0.92),
    ROW('annoyed', 0.78),
    ROW('slightly annoyed', 0.65),
    ROW('really annoyed', 0.82),
    ROW('irritated', 0.75),
    ROW('frustrated', 0.80),
    ROW('very frustrated', 0.85),
    ROW('upset', 0.72),
    ROW('really upset', 0.82),
    ROW('uncomfortable', 0.63),
    ROW('mad', 0.82),
    ROW('so mad', 0.90),
    ROW('furious', 0.92),
    ROW('enraged', 0.95),
    ROW('pissed', 0.90),
    ROW('pissed off', 0.92),
    ROW('losing patience', 0.77),
    ROW('lost my cool', 0.85),
    ROW('can’t stay calm', 0.85),
    ROW('on edge with anger', 0.83),
    ROW('hot-tempered', 0.80),
    ROW('short-tempered', 0.80),
    ROW('boiling with anger', 0.93),
    ROW('seething', 0.90),
    ROW('blood boiling', 0.90),
    ROW('feel like exploding', 0.92),
    ROW('want to scream', 0.85),
    ROW('feel overwhelmed with anger', 0.92),
    ROW('feeling disrespected', 0.88),
    ROW('feeling treated unfairly', 0.85),
    ROW('feeling hurt', 0.75),
    ROW('angry at someone', 0.80),
    ROW('angry at a friend', 0.78),
    ROW('angry at my parents', 0.80),
    ROW('argument', 0.75),
    ROW('arguing', 0.78),
    ROW('conflict', 0.70),
    ROW('angry about being ignored', 0.80),
    ROW('angry about bad grades', 0.78),
    ROW('angry about making mistakes', 0.75),
    ROW('angry about lack of respect', 0.85),
    ROW('angry about pressure', 0.75),
    ROW('angry at unreasonable behavior', 0.85),
    ROW('angry about not being heard', 0.80),
    ROW('can’t tolerate their actions', 0.82),
    ROW('heated', 0.88),
    ROW('worked up', 0.85),
    ROW('emotionally triggered', 0.92),
    ROW('salty', 0.82),
    ROW('really salty', 0.90),
    ROW('extremely salty', 0.92),
    ROW('annoyed as hell', 0.88),
    ROW('mad as hell', 0.90),
    ROW('furious mood', 0.92),
    ROW('fed up', 0.82),
    ROW('so irritated', 0.88),
    ROW('full of anger', 0.90),
    ROW('I’m running out of patience',0.92),
    ROW('small things are getting on my nerves',0.90),
    ROW('I don’t want to hear any more of this',0.92),
    ROW('I feel really on edge',0.88),
    ROW('everything feels irritating right now',0.90),
    ROW('I just want people to stop talking',0.88),
    ROW('I feel a lot of tension inside',0.90),
    ROW('I’m snapping more than usual',0.92),
    ROW('I don’t feel like explaining myself',0.88),
    ROW('it feels like too much pressure',0.90),

    ROW('I want some space from everyone',0.85),
    ROW('my body feels heated',0.88),
    ROW('it’s hard to stay calm',0.92),
    ROW('I’m getting defensive easily',0.90),
    ROW('I don’t want to back down',0.88),
    ROW('this feels really unfair',0.92),
    ROW('I’m close to losing control',0.93),
    ROW('this is crossing a line for me',0.90),
    ROW('I feel constantly provoked',0.88),
    ROW('my thoughts keep going in a negative loop',0.85),

    ROW('I don’t want anyone near me right now',0.90),
    ROW('I feel restless and tense',0.88),
    ROW('even silence feels irritating',0.90),
    ROW('I feel like I might explode',0.93),
    ROW('I don’t want to continue this conversation',0.92)
    
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='tuc_gian'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('tội lỗi',0.95),
    ROW('rất có lỗi',0.95),
    ROW('có lỗi',0.90),
    ROW('hối hận',0.90),
    ROW('ăn năn',0.92),
    ROW('hổ thẹn',0.90),
    ROW('cảm thấy tội lỗi',0.92),
    ROW('thấy có lỗi',0.90),
    ROW('cảm thấy ăn năn',0.92),
    ROW('lỗi lầm',0.88),
    ROW('sai',0.85),
    ROW('thấy mình sai',0.87),
    ROW('trách bản thân',0.88),
    ROW('tự trách mình',0.88),
    ROW('xấu hổ',0.85),
    ROW('áy náy',0.90),
    ROW('day dứt',0.92),
    ROW('hơi có lỗi',0.72),
    ROW('hơi hối hận',0.70),
    ROW('hơi áy náy',0.70),
    ROW('tiếc nuối',0.75),
    ROW('buồn vì sai',0.72),
    ROW('không yên tâm',0.70),
    ROW('không thoải mái',0.70),
    ROW('bối rối vì lỗi',0.72),
    ROW('không tự tin vì lỗi',0.70),
    ROW('cảm giác tội lỗi nhẹ',0.72),
    ROW('trách móc bản thân',0.85),
    ROW('tự dằn vặt',0.88),
    ROW('tự giày vò',0.90),
    ROW('tự trách mình vì sai',0.88),
    ROW('lỗi tại mình',0.85),
    ROW('cảm giác có lỗi với người khác',0.88),
    ROW('thấy mình sai',0.85),
    ROW('muốn sửa sai',0.80),
    ROW('nhận lỗi',0.82),
    ROW('cảm giác phải bù đắp',0.85),
    ROW('đau lòng',0.78),
    ROW('nặng lòng',0.80),
    ROW('áp lực tâm lý',0.75),
    ROW('khó chịu trong lòng',0.75),
    ROW('ngột ngạt',0.75),
    ROW('day dứt không yên',0.88),
    ROW('mất ngủ vì lỗi',0.85),
    ROW('lòng nặng trĩu',0.82),
    ROW('bứt rứt',0.80),
    ROW('căng thẳng vì lỗi',0.78),  
    ROW('cắn rứt',0.85),
    ROW('ăn năn day dứt',0.90),
    ROW('tâm trí không yên',0.80),
    ROW('trái tim nặng trĩu',0.82),
    ROW('như mang tội',0.85),
    ROW('dằn vặt trong lòng',0.88),
    ROW('muốn chuộc lỗi',0.85),
    ROW('hối hận sâu sắc',0.90),
    ROW('guilty',0.75),
    ROW('ashame',0.8),
    ROW('shameful',0.83),
    ROW('tội vl',0.88),
    ROW('tội vãi',0.88),
    ROW('hối hận vl',0.88),
    ROW('áy náy vl',0.85),
    ROW('hối vl',0.82),
    ROW('regret quá',0.80),
    ROW('day dứt vl',0.85),
    ROW('muốn sửa vl',0.80),
    ROW('lỗi vl',0.85),
    ROW('xấu hổ vl',0.80),
    ROW('sorry',0.75),
    ROW('cảm giác tội',0.78),
    ROW('nhận thức lỗi lầm',0.80),
    ROW('biết mình sai',0.80),
    ROW('muốn bù đắp',0.78),
    ROW('muốn xin lỗi',0.85),
    ROW('tự kiểm điểm',0.75),
    ROW('thấy hối hận sâu',0.82),
    ROW('mình cứ nghĩ mãi về chuyện đó',0.92),
    ROW('giá như làm khác đi',0.93),
    ROW('không nên nói như vậy',0.92),
    ROW('cảm giác đã làm sai điều gì đó',0.93),
    ROW('cứ tự trách bản thân',0.95),
    ROW('khó tha thứ cho chính mình',0.94),
    ROW('ước có thể quay lại lúc đó và sửa lại',0.92),
    ROW('chuyện đó cứ lặp lại trong đầu',0.90),
    ROW('làm người khác buồn',0.95),
    ROW('thấy mình không xứng đáng',0.92),

    ROW('đáng lẽ phải làm tốt hơn',0.93),
    ROW('không thể ngừng nghĩ về hậu quả',0.90),
    ROW('cảm giác như đã làm hỏng mọi thứ',0.94),
    ROW('cứ tự hỏi tại sao lại làm vậy',0.92),
    ROW('khó mà cảm thấy nhẹ lòng',0.90),
    ROW('thấy mình có trách nhiệm cho chuyện đó',0.95),
    ROW('không dám nhìn thẳng vào chuyện đó',0.88),
    ROW('sợ phải nhắc lại chuyện này',0.85),
    ROW('cảm thấy nặng trong lòng',0.90),
    ROW('không thể ngừng tự kiểm điểm',0.92),

    ROW('thấy mình đã làm ai đó thất vọng',0.95),
    ROW('cứ nghĩ nếu lúc đó khác đi thì sao',0.92),
    ROW('thấy khó mà thoải mái được',0.88),
    ROW('cảm thấy mắc kẹt với chuyện đó',0.90),
    ROW('không biết làm sao để bù đắp',0.94),
    ROW('không hiểu tại sao mình lại như vậy',0.94),

    ROW('guilt',0.95),
    ROW('very guilty',0.95),
    ROW('feeling guilty',0.90),
    ROW('regret',0.90),
    ROW('remorse',0.92),
    ROW('ashamed',0.90),
    ROW('feel guilty',0.92),
    ROW('feel at fault',0.90),
    ROW('feel remorseful',0.92),
    ROW('mistake',0.88),
    ROW('wrong',0.85),
    ROW('feel I was wrong',0.87),
    ROW('blame myself',0.88),
    ROW('self-blame',0.88),
    ROW('embarrassed',0.85),
    ROW('uneasy guilt',0.90),
    ROW('tormented',0.92),
    ROW('slightly guilty',0.72),
    ROW('slightly regretful',0.70),
    ROW('slightly uneasy',0.70),
    ROW('regretful longing',0.75),
    ROW('sad about my mistake',0.72),
    ROW('uneasy',0.70),
    ROW('uncomfortable',0.70),
    ROW('confused about my mistake',0.72),
    ROW('lack confidence because of my mistake',0.70),
    ROW('mild guilt',0.72),
    ROW('reproach myself',0.85),
    ROW('self-torment',0.88),
    ROW('self-torture',0.90),
    ROW('blame myself for being wrong',0.88),
    ROW('it was my fault',0.85),
    ROW('feel guilty toward others',0.88),
    ROW('realize I was wrong',0.85),
    ROW('want to make things right',0.80),
    ROW('admit my fault',0.82),
    ROW('feel the need to compensate',0.85),
    ROW('heartbroken',0.78),
    ROW('heavy-hearted',0.80),
    ROW('psychological pressure',0.75),
    ROW('inner discomfort',0.75),
    ROW('suffocating',0.75),
    ROW('restless guilt',0.88),
    ROW('lose sleep over guilt',0.85),
    ROW('heart feels heavy',0.82),
    ROW('restless',0.80),
    ROW('stressed because of my mistake',0.78),
    ROW('biting guilt',0.85),
    ROW('deep remorse',0.90),
    ROW('mind unsettled',0.80),
    ROW('heavy heart',0.82),
    ROW('feel like a sinner',0.85),
    ROW('inner torment',0.88),
    ROW('want to atone',0.85),
    ROW('deep regret',0.90),
    ROW('guilty',0.75),
    ROW('ashamed',0.80),
    ROW('shameful',0.83),
    ROW('feel damn guilty',0.88),
    ROW('guilty as hell',0.88),
    ROW('regret as hell',0.88),
    ROW('uneasy as hell',0.85),
    ROW('regret a lot',0.82),
    ROW('really regret it',0.80),
    ROW('tormented as hell',0.85),
    ROW('really want to fix it',0.80),
    ROW('so at fault',0.85),
    ROW('so embarrassed',0.80),
    ROW('sorry',0.75),
    ROW('sense of guilt',0.78),
    ROW('aware of my mistake',0.80),
    ROW('know I was wrong',0.80),
    ROW('want to make up for it',0.78),
    ROW('want to apologize',0.85),
    ROW('self-reflection',0.75),
    ROW('feel deeply regretful',0.82),
    ROW('I keep thinking about what I did',0.92),
    ROW('I wish I had handled that differently',0.93),
    ROW('I shouldn’t have said that',0.92),
    ROW('it feels like I crossed a line',0.93),
    ROW('I keep blaming myself',0.95),
    ROW('it’s hard to forgive myself',0.94),
    ROW('I wish I could go back and change it',0.92),
    ROW('that moment keeps replaying in my head',0.90),
    ROW('I hurt someone I care about',0.95),
    ROW('I don’t feel like I deserve much right now',0.92),

    ROW('I should have done better',0.93),
    ROW('I can’t stop thinking about the consequences',0.90),
    ROW('it feels like I messed everything up',0.94),
    ROW('I keep asking myself why I did that',0.92),
    ROW('I can’t really feel at ease',0.90),
    ROW('I feel responsible for what happened',0.95),
    ROW('I avoid thinking about it directly',0.88),
    ROW('I don’t want to bring it up again',0.85),
    ROW('there’s this heavy feeling inside',0.90),
    ROW('I keep overanalyzing my actions',0.92),

    ROW('I feel like I let someone down',0.95),
    ROW('I keep wondering what if I had chosen differently',0.92),
    ROW('it’s hard to feel okay with myself',0.88),
    ROW('I feel stuck with that memory',0.90),
    ROW('I don’t know how to make things right',0.94),
    ROW('I don’t know why I did that', 0.87)
  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='toi_loi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('bối rối',0.95),
    ROW('lúng túng',0.90),
    ROW('rất rối',0.9),
    ROW('rối',0.88),
    ROW('rối trí',0.90),
    ROW('rối bời',0.92),
    ROW('hoang mang',0.90),
    ROW('băn khoăn',0.88),
    ROW('bối rối không biết làm gì',0.92),
    ROW('mất phương hướng',0.9),
    ROW('mất định hướng',0.9),
    ROW('lạc lối',0.85),
    ROW('lạc lõng',0.85),
    ROW('lúng túng không biết nói gì',0.90),
    ROW('phân vân',0.88),
    ROW('hoang mang tột độ',0.92),
    ROW('rối tung',0.90),
    ROW('không biết xử lý',0.85),
    ROW('không biết phải làm sao',0.85),
    ROW('hơi bối rối',0.75),
    ROW('hơi lúng túng',0.72),
    ROW('hơi phân vân',0.70),
    ROW('hơi rối',0.72),
    ROW('có chút bối rối',0.75),
    ROW('không hiểu cho lắm',0.75),
    ROW('lúng túng chút',0.72),
    ROW('có chút phân vân',0.7),
    ROW('băn khoăn nhẹ',0.72),
    ROW('chưa chắc chắn',0.78),
    ROW('không biết chọn',0.75),
    ROW('do dự',0.78),
    ROW('lưỡng lự',0.78),
    ROW('chưa quyết định',0.75),
    ROW('không biết làm sao',0.85),
    ROW('không biết nói gì',0.85),
    ROW('bị bất ngờ',0.78),
    ROW('không hiểu chuyện gì',0.85),
    ROW('không rõ ràng',0.78),
    ROW('thiếu thông tin',0.75),
    ROW('rối vì lựa chọn',0.82),
    ROW('phân vân giữa hai lựa chọn',0.80),
    ROW('bối rối vì tình huống',0.82),
    ROW('lúng túng trong giao tiếp',0.78),
    ROW('bị sốc',0.91),
    ROW('tim đập nhanh',0.75),
    ROW('loay hoay',0.78),
    ROW('cảm giác hỗn loạn',0.80),
    ROW('mất cân bằng',0.75),
    ROW('chóng mặt',0.70),
    ROW('đầu óc quay cuồng',0.85),
    ROW('khó tập trung',0.78),
    ROW('bối rối trong lòng',0.78),
    ROW('lòng rối bời',0.80),
    ROW('hoang mang trong lòng',0.80),
    ROW('confused',0.75),
    ROW('confused af',0.77),
    ROW('lost af',0.8),
    ROW('lost',0.78),
    ROW('rối vl',0.88),
    ROW('rối vãi',0.88),
    ROW('rối v',0.85),
    ROW('chả hiểu kiểu gì',0.87),
    ROW('bối rối vl',0.85),
    ROW('lúng túng vl',0.85),
    ROW('phân vân vl',0.80),
    ROW('unsure',0.75),
    ROW('do dự vl',0.78),
    ROW('không biết làm gì cả',0.80),
    ROW('không hiểu mình muốn gì',0.78),
    ROW('chưa rõ',0.70),
    ROW('chưa quyết',0.70),
    ROW('không biết lựa chọn nào',0.80),
    ROW('rối vì thông tin',0.78),
    ROW('phân vân trong suy nghĩ',0.82),
    ROW('bối rối trong quyết định',0.82),
    ROW('không nắm rõ',0.75),
    ROW('chưa chắc',0.70),
    ROW('không rõ nên làm gì',0.78),
    ROW('đầu óc rối tung',0.90),
    ROW('tâm trí hỗn loạn',0.88),
    ROW('rối như tơ vò',0.92),
    ROW('lòng rối bời không yên',0.88),
    ROW('rối như mớ bòng bong',0.90),
    ROW('không ngừng thắc mắc',0.9),
    ROW('không thể nghĩ ra',0.88),
    ROW('không biết bắt đầu từ đâu',0.92),
    ROW('mọi thứ đến cùng lúc',0.90),
    ROW('đứng yên không làm được gì',0.88),
    ROW('không biết nên chọn cái nào',0.93),
    ROW('quá nhiều thứ phải nghĩ',0.90),
    ROW('đầu óc bị quá tải',0.92),
    ROW('không biết câu trả lời là gì',0.88),
    ROW('đổi ý liên tục',0.92),
    ROW('không chắc điều nào đúng',0.93),
    ROW('mọi thứ chồng chéo lên nhau',0.90),

    ROW('không biết phải phản ứng sao',0.92),
    ROW('bị đứng hình lúc đó',0.90),
    ROW('không hiểu chuyện đang đi theo hướng nào',0.88),
    ROW('khó sắp xếp suy nghĩ',0.92),
    ROW('kẹt giữa nhiều lựa chọn',0.93),
    ROW('không biết nên nói gì cho đúng',0.90),
    ROW('nghĩ vòng vòng mà không ra kết quả',0.92),
    ROW('không biết nên tin vào điều gì',0.93),
    ROW('mọi thứ không rõ ràng',0.88),
    ROW('không biết bước tiếp thế nào',0.92),

    ROW('đầu óc quay cuồng',0.90),
    ROW('không theo kịp chuyện đang xảy ra',0.88),
    ROW('khó đưa ra quyết định',0.93),
    ROW('không chắc suy nghĩ có đúng hay không',0.92),
    ROW('mọi thứ vẫn chưa đâu vào đâu',0.90),

    ROW('confused',0.95),
    ROW('awkward',0.90),
    ROW('very confused',0.90),
    ROW('confusion',0.88),
    ROW('mentally confused',0.90),
    ROW('overwhelmed',0.92),
    ROW('bewildered',0.90),
    ROW('uncertain',0.88),
    ROW('confused and don’t know what to do',0.92),
    ROW('lost direction',0.90),
    ROW('disoriented',0.90),
    ROW('lost',0.85),
    ROW('isolated',0.85),
    ROW('awkward and don’t know what to say',0.90),
    ROW('hesitant',0.88),
    ROW('extremely confused',0.92),
    ROW('totally mixed up',0.90),
    ROW('don’t know how to handle it',0.85),
    ROW('don’t know what to do',0.85),
    ROW('slightly confused',0.75),
    ROW('slightly awkward',0.72),
    ROW('slightly hesitant',0.70),
    ROW('a bit mixed up',0.72),
    ROW('a little confused',0.75),
    ROW('don’t really understand',0.75),
    ROW('a bit awkward',0.72),
    ROW('a little hesitant',0.70),
    ROW('mild uncertainty',0.72),
    ROW('not sure',0.78),
    ROW('don’t know which to choose',0.75),
    ROW('indecisive',0.78),
    ROW('torn between options',0.78),
    ROW('haven’t decided yet',0.75),
    ROW('don’t know what to do',0.85),
    ROW('don’t know what to say',0.85),
    ROW('caught off guard',0.78),
    ROW('don’t understand what’s going on',0.85),
    ROW('unclear',0.78),
    ROW('lack of information',0.75),
    ROW('confused by choices',0.82),
    ROW('torn between two options',0.80),
    ROW('confused by the situation',0.82),
    ROW('awkward in communication',0.78),
    ROW('shocked',0.91),
    ROW('heart racing',0.75),
    ROW('fumbling around',0.78),
    ROW('sense of chaos',0.80),
    ROW('off balance',0.75),
    ROW('dizzy',0.70),
    ROW('mind spinning',0.85),
    ROW('hard to focus',0.78),
    ROW('inner confusion',0.78),
    ROW('heart in turmoil',0.80),
    ROW('inner bewilderment',0.80),
    ROW('confused',0.75),
    ROW('confused af',0.77),
    ROW('lost af',0.80),
    ROW('lost',0.78),
    ROW('confused as hell',0.88),
    ROW('so damn confused',0.88),
    ROW('really confused',0.85),
    ROW('don’t get it at all',0.87),
    ROW('confused as hell',0.85),
    ROW('awkward as hell',0.85),
    ROW('hesitant as hell',0.80),
    ROW('unsure',0.75),
    ROW('indecisive as hell',0.78),
    ROW('don’t know what to do at all',0.80),
    ROW('don’t understand what I want',0.78),
    ROW('not clear yet',0.70),
    ROW('not decided yet',0.70),
    ROW('don’t know which option to choose',0.80),
    ROW('confused by information',0.78),
    ROW('mentally conflicted',0.82),
    ROW('confused about a decision',0.82),
    ROW('don’t fully grasp it',0.75),
    ROW('not certain',0.70),
    ROW('don’t know what I should do',0.78),
    ROW('mind totally tangled',0.90),
    ROW('chaotic mind',0.88),
    ROW('mind in knots',0.92),
    ROW('restless inner confusion',0.88),
    ROW('thoughts all tangled up',0.90),
    ROW('constantly questioning',0.90),
    ROW('can’t figure it out',0.88),
    ROW('no idea where to start',0.92),
    ROW('everything is happening at once',0.90),
    ROW('frozen in place',0.88),
    ROW('hard to tell which option makes sense',0.93),
    ROW('too much going on mentally',0.90),
    ROW('thoughts feel overloaded',0.92),
    ROW('no clear answer',0.88),
    ROW('changing decisions constantly',0.92),
    ROW('can’t tell what’s right anymore',0.93),
    ROW('everything feels tangled',0.90),

    ROW('no idea how to react',0.92),
    ROW('mind went blank',0.90),
    ROW('direction feels unclear',0.88),
    ROW('hard to organize thoughts',0.92),
    ROW('stuck between choices',0.93),
    ROW('hard to say the right thing',0.90),
    ROW('thinking in circles',0.92),
    ROW('no clue what to trust',0.93),
    ROW('nothing feels clear',0.88),
    ROW('next step feels unclear',0.92),

    ROW('head feels like it’s spinning',0.90),
    ROW('hard to keep up with what’s happening',0.88),
    ROW('decision-making feels difficult',0.93),
    ROW('thinking doesn’t feel solid',0.92),
    ROW('everything feels unresolved',0.90)
      ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='boi_roi'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('sợ',0.9),
    ROW('rất sợ',0.92),
    ROW('sợ vô cùng',0.95),
    ROW('sợ lắm',0.92),
    ROW('sợ hãi',0.95),
    ROW('hoảng sợ',0.92),
    ROW('hoảng loạn',0.92),
    ROW('hốt hoảng',0.90),
    ROW('khiếp sợ',0.90),
    ROW('kinh hãi',0.92),
    ROW('run sợ',0.88),
    ROW('sợ đến run người',0.90),
    ROW('ám ảnh',0.85),
    ROW('lo sợ',0.88),
    ROW('hoảng hoảng',0.88),
    ROW('khủng hoảng',0.90),
    ROW('sợ phát khóc',0.90),
    ROW('sợ chết khiếp',0.92),
    ROW('tim đập nhanh',0.80),
    ROW('run tay',0.80),
    ROW('đổ mồ hôi',0.78),
    ROW('buồn nôn vì sợ',0.80),
    ROW('chân tay lạnh',0.78),
    ROW('nghẹt thở',0.85),
    ROW('căng thẳng tột độ',0.85),
    ROW('tim đập mạnh',0.82),
    ROW('khó thở',0.85),
    ROW('sợ đến nghẹn lời',0.90),
    ROW('lo lắng chuyện xấu xảy ra',0.82),
    ROW('sợ tương lai',0.80),
    ROW('sợ thất bại',0.80),
    ROW('lo sợ kết quả',0.78),
    ROW('bất an',0.82),
    ROW('lo sợ vô lý',0.75),
    ROW('sợ mất kiểm soát',0.82),
    ROW('sợ người khác đánh giá',0.80),
    ROW('căng thẳng quá mức',0.80),
    ROW('sợ sai',0.75),
    ROW('sợ bị bỏ rơi',0.85),
    ROW('sợ bị tổn thương',0.85),
    ROW('sợ đau',0.80),
    ROW('sợ kết quả xấu',0.82),
    ROW('sợ không làm được',0.78),
    ROW('sợ nói chuyện',0.80),
    ROW('sợ đám đông',0.85),
    ROW('sợ thi',0.80),
    ROW('sợ trách nhiệm',0.78),
    ROW('sợ đối mặt',0.85),
    ROW('sợ vãi',0.88),
    ROW('hãi vcl',0.82),
    ROW('sợ vl',0.88),
    ROW('sợ vcl',0.90),
    ROW('scared',0.75),
    ROW('scared af',0.90),
    ROW('freaking out',0.90),
    ROW('anxious af',0.88),
    ROW('panic',0.82),
    ROW('panic mode',0.85),
    ROW('lowkey scared',0.75),
    ROW('sợ mọi thứ',0.82),
    ROW('sợ chuyện tồi tệ xảy ra',0.88),
    ROW('nghĩ tới là sợ',0.80),
    ROW('ám ảnh nặng',0.90),
    ROW('hoảng sợ trong lòng',0.85),
    ROW('tưởng tượng điều tệ nhất',0.82),
    ROW('sợ bị chỉ trích',0.78),
    ROW('sợ bị bỏ lại',0.85),
    ROW('sợ bị thất vọng',0.78),
    ROW('sợ bị phán xét',0.80),
    ROW('lạnh sống lưng',0.90),
    ROW('nổi da gà',0.88),
    ROW('tái mặt vì sợ',0.90),
    ROW('thót tim',0.85),
    ROW('như gặp ác mộng',0.88),
    ROW('run như cầy sấy',0.90),
    ROW('sợ toát mồ hôi',0.85),
    ROW('tim đập nhanh bất thường',0.92),
    ROW('tay lạnh toát',0.90),
    ROW('cảm giác nghẹt ở ngực',0.93),
    ROW('toàn thân cứng lại',0.90),
    ROW('đầu óc trống rỗng trong giây lát',0.88),
    ROW('phản xạ tránh né ngay lập tức',0.92),
    ROW('muốn rời khỏi chỗ đó ngay',0.93),
    ROW('khó thở trong chốc lát',0.90),
    ROW('mồ hôi ra nhiều dù không nóng',0.88),
    ROW('giật mình mạnh',0.90),

    ROW('không dám nhìn thẳng',0.92),
    ROW('né tránh tình huống đó',0.93),
    ROW('luôn nghĩ đến kịch bản xấu nhất',0.90),
    ROW('cơ thể phản ứng trước khi kịp nghĩ',0.92),
    ROW('không dám lên tiếng',0.90),
    ROW('muốn tìm nơi an toàn',0.93),
    ROW('luôn đề phòng xung quanh',0.90),
    ROW('khó giữ bình tĩnh',0.88),
    ROW('cảm giác bị đe dọa',0.93),
    ROW('không dám thử lại',0.92),

    ROW('đầu óc cảnh giác liên tục',0.90),
    ROW('khó ngủ vì hình ảnh lặp lại',0.88),
    ROW('tránh né người hoặc nơi quen thuộc',0.90),
    ROW('cơ thể phản ứng quá mức',0.92),
    ROW('không yên dù không có lý do rõ ràng',0.88),

    ROW('afraid',0.90),
    ROW('very afraid',0.92),
    ROW('extremely scared',0.95),
    ROW('really scared',0.92),
    ROW('terrified',0.95),
    ROW('panicked',0.92),
    ROW('panic-stricken',0.92),
    ROW('alarmed',0.90),
    ROW('fearful',0.90),
    ROW('horrified',0.92),
    ROW('trembling with fear',0.88),
    ROW('so scared I’m shaking',0.90),
    ROW('haunted',0.85),
    ROW('worried and scared',0.88),
    ROW('nervous',0.88),
    ROW('emotional crisis',0.90),
    ROW('scared to tears',0.90),
    ROW('scared out of my mind',0.92),
    ROW('heart racing',0.80),
    ROW('hands shaking',0.80),
    ROW('sweating',0.78),
    ROW('nauseous from fear',0.80),
    ROW('cold hands and feet',0.78),
    ROW('feeling suffocated',0.85),
    ROW('extreme tension',0.85),
    ROW('heart pounding',0.82),
    ROW('short of breath',0.85),
    ROW('too scared to speak',0.90),
    ROW('worried something bad will happen',0.82),
    ROW('afraid of the future',0.80),
    ROW('afraid of failure',0.80),
    ROW('anxious about the outcome',0.78),
    ROW('uneasy',0.82),
    ROW('irrational fear',0.75),
    ROW('afraid of losing control',0.82),
    ROW('afraid of being judged',0.80),
    ROW('overwhelming stress',0.80),
    ROW('afraid of making mistakes',0.75),
    ROW('afraid of being abandoned',0.85),
    ROW('afraid of getting hurt',0.85),
    ROW('afraid of pain',0.80),
    ROW('afraid of a bad result',0.82),
    ROW('afraid I can’t do it',0.78),
    ROW('afraid to speak up',0.80),
    ROW('afraid of crowds',0.85),
    ROW('exam anxiety',0.80),
    ROW('afraid of responsibility',0.78),
    ROW('afraid to face it',0.85),
    ROW('scared as hell',0.88),
    ROW('terrified as hell',0.82),
    ROW('so scared',0.88),
    ROW('scared out of control',0.90),
    ROW('scared',0.75),
    ROW('scared af',0.90),
    ROW('freaking out',0.90),
    ROW('anxious af',0.88),
    ROW('panic',0.82),
    ROW('panic mode',0.85),
    ROW('lowkey scared',0.75),
    ROW('afraid of everything',0.82),
    ROW('afraid something terrible will happen',0.88),
    ROW('just thinking about it scares me',0.80),
    ROW('severely haunted',0.90),
    ROW('inner panic',0.85),
    ROW('imagining the worst',0.82),
    ROW('afraid of criticism',0.78),
    ROW('afraid of being left behind',0.85),
    ROW('afraid of disappointment',0.78),
    ROW('afraid of being judged',0.80),
    ROW('spine-chilling fear',0.90),
    ROW('goosebumps',0.88),
    ROW('pale with fear',0.90),
    ROW('heart skipping a beat',0.85),
    ROW('like a nightmare',0.88),
    ROW('shaking badly',0.90),
    ROW('sweating from fear',0.85),
    ROW('heart racing suddenly',0.92),
    ROW('hands feel cold',0.90),
    ROW('tightness in the chest',0.93),
    ROW('body freezes in place',0.90),
    ROW('mind goes blank for a moment',0.88),
    ROW('immediate urge to avoid the situation',0.92),
    ROW('strong desire to leave immediately',0.93),
    ROW('breathing becomes difficult',0.90),
    ROW('sweating without physical effort',0.88),
    ROW('startles very easily',0.90),
    ROW('chill down my spine',0.90),
    ROW('avoids eye contact',0.92),
    ROW('keeps distance from the situation',0.93),
    ROW('worst-case scenarios keep appearing',0.90),
    ROW('body reacts before thinking',0.92),
    ROW('hesitates to speak up',0.90),
    ROW('searching for a safe place',0.93),
    ROW('constantly on guard',0.90),
    ROW('struggles to stay calm',0.88),
    ROW('sense of being threatened',0.93),
    ROW('reluctant to try again',0.92),
    ROW('hyper-aware of surroundings',0.90),
    ROW('sleep disrupted by repeating images',0.88),
    ROW('avoids familiar people or places',0.90),
    ROW('physical reactions feel exaggerated',0.92),
    ROW('uneasy without a clear reason',0.88)

  ]::text_weight[]
) AS t(kw text, wt numeric)
WHERE slug='so_hai'
ON CONFLICT DO NOTHING;

INSERT INTO emotion_keywords (emotion_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword' FROM emotions, unnest(
  ARRAY[
    ROW('trung lập',1.0),
    ROW('bình thường',0.95),
    ROW('không cảm xúc',0.9),
    ROW('không rõ cảm xúc',0.9),
    ROW('không có ý kiến',0.85),
    ROW('không chắc cảm giác',0.85),
    ROW('cảm thấy ổn',0.8),
    ROW('ổn thôi',0.8),
    ROW('cũng được',0.8),
    ROW('tạm được',0.8),
    ROW('ổn mà',0.78),
    ROW('không vui không buồn',0.95),
    ROW('không có gì đặc biệt',0.8),
    ROW('mọi thứ bình thường',0.85),
    ROW('cảm giác như mọi ngày',0.8),
    ROW('khá chill',0.86),
    ROW('chill',0.83),
    ROW('không có gì khác lạ',0.8),
    ROW('không có gì nổi bật',0.8),
    ROW('không để tâm',0.85),
    ROW('không quan tâm lắm',0.75),
    ROW('thờ ơ',0.7),
    ROW('lãnh đạm',0.7),
    ROW('khá bình lặng',0.85),
    ROW('cảm xúc phẳng lặng',0.9),
    ROW('không dao động',0.85),
    ROW('bình ổn',0.9),
    ROW('khá trung tính',0.9),
    ROW('trạng thái cân bằng',0.9),
    ROW('tâm lý ổn định',0.9),
    ROW('không bị tác động',0.8),
    ROW('cảm thấy đều đều',0.8),
    ROW('mọi thứ bình thường',0.8),
    ROW('cảm thấy không đặc biệt',0.75),
    ROW('cảm thấy không rõ ràng',0.8),
    ROW('không thay đổi cảm xúc',0.9),
    ROW('neutral',0.9),
    ROW('fine',0.75),
    ROW('okay',0.75),
    ROW('ok',0.73),
    ROW('unbothered',0.8),
    ROW('stable',0.85),
    ROW('relax',0.8),
    ROW('plain',0.84),
    ROW('cảm thấy bình bình',0.8),
    ROW('cảm thấy bình thường',0.82),
    ROW('chả có gì cả',0.9),
    ROW('mọi thứ diễn ra bình thường',0.92),
    ROW('không có gì đáng chú ý',0.90),
    ROW('không có phản ứng rõ ràng',0.88),
    ROW('trạng thái khá ổn định',0.92),
    ROW('không thấy khác so với mọi ngày',0.90),
    ROW('mọi việc trôi qua đều đều',0.88),
    ROW('không có thay đổi lớn',0.90),
    ROW('không bị ảnh hưởng nhiều',0.88),
    ROW('cảm giác khá phẳng',0.92),
    ROW('không nghiêng về hướng nào',0.90),

    ROW('mọi thứ ở mức vừa phải',0.88),
    ROW('không quá quan tâm',0.85),
    ROW('không có ý kiến đặc biệt',0.90),
    ROW('xảy ra cũng được mà không xảy ra cũng không sao',0.92),
    ROW('tiếp nhận thông tin một cách bình thường',0.88),
    ROW('không tạo phản ứng mạnh',0.90),
    ROW('không có gì thúc đẩy hay cản trở',0.88),
    ROW('trạng thái cân bằng',0.92),
    ROW('mọi thứ vẫn như cũ',0.90),
    ROW('không thấy cần phản hồi thêm',0.88),

    ROW('không có gì cần thay đổi',0.90),
    ROW('mọi thứ trong tầm kiểm soát',0.88),
    ROW('không thấy quá quan trọng',0.85),
    ROW('phản ứng khá nhẹ',0.88),
    ROW('không có cảm giác nổi bật',0.92),

    ROW('neutral',1.0),
    ROW('normal',0.95),
    ROW('emotionless',0.90),
    ROW('unclear emotions',0.90),
    ROW('no opinion',0.85),
    ROW('not sure how I feel',0.85),
    ROW('feeling okay',0.80),
    ROW('it’s fine',0.80),
    ROW('it’s alright',0.80),
    ROW('acceptable',0.80),
    ROW('pretty okay',0.78),
    ROW('not happy not sad',0.95),
    ROW('nothing special',0.80),
    ROW('everything is normal',0.85),
    ROW('feels like any other day',0.80),
    ROW('pretty chill',0.86),
    ROW('chill',0.83),
    ROW('nothing unusual',0.80),
    ROW('nothing stands out',0.80),
    ROW('not paying attention',0.85),
    ROW('don’t really care',0.75),
    ROW('indifferent',0.70),
    ROW('detached',0.70),
    ROW('quite calm',0.85),
    ROW('flat emotions',0.90),
    ROW('emotionally steady',0.85),
    ROW('stable mood',0.90),
    ROW('quite neutral',0.90),
    ROW('balanced state',0.90),
    ROW('mentally stable',0.90),
    ROW('not affected',0.80),
    ROW('feels average',0.80),
    ROW('everything feels normal',0.80),
    ROW('feels unremarkable',0.75),
    ROW('feels unclear',0.80),
    ROW('no emotional change',0.90),
    ROW('neutral',0.90),
    ROW('fine',0.83),
    ROW('okay',0.85),
    ROW('ok',0.83),
    ROW('unbothered',0.80),
    ROW('stable',0.85),
    ROW('relaxed',0.80),
    ROW('plain',0.84),
    ROW('feeling neutral',0.80),
    ROW('feeling normal',0.82),
    ROW('nothing at all',0.90),
    ROW('everything feels normal',0.92),
    ROW('nothing really stands out',0.90),
    ROW('no strong reaction either way',0.88),
    ROW('overall state feels steady',0.92),
    ROW('things feel the same as usual',0.90),
    ROW('events pass by without much impact',0.88),
    ROW('no noticeable change',0.90),
    ROW('not strongly affected',0.88),
    ROW('emotional response feels flat',0.92),
    ROW('no clear preference',0.90),
    ROW('everything stays in the middle',0.88),
    ROW('not very invested',0.85),
    ROW('no particular opinion',0.90),
    ROW('either outcome seems acceptable',0.92),
    ROW('information taken in calmly',0.88),
    ROW('no intense response triggered',0.90),
    ROW('nothing pushing or holding back',0.88),
    ROW('state feels balanced',0.92),
    ROW('things remain unchanged',0.90),
    ROW('no extra response needed',0.88),
    ROW('no reason to adjust anything',0.90),
    ROW('everything feels manageable',0.88),
    ROW('not especially important',0.85),
    ROW('reaction stays mild',0.88),
    ROW('nothing feels particularly strong',0.92)
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
     ROW('nghỉ ngơi',1.0),
    ROW('cần nghỉ ngơi',1.0),
    ROW('cần nghỉ một chút',0.95),
    ROW('muốn nghỉ',0.90),
    ROW('cần nghỉ xíu',0.9),
    ROW('muốn nghỉ xíu',0.85),
    ROW('muốn nghỉ giải lao',0.9),
    ROW('muốn nghỉ tạm',0.85),
    ROW('cần giải lao',0.95),
    ROW('nghỉ giải lao',0.95),
    ROW('nghỉ một lát',0.9),
    ROW('nghỉ cho khoẻ',0.95),
    ROW('thư giãn',0.85),
    ROW('cần thư giãn',0.95),
    ROW('muốn thư giãn',0.95),
    ROW('muốn xả hơi',0.95),
    ROW('xả hơi',0.9),
    ROW('thả lỏng',0.85),
    ROW('cần thả lỏng',0.95),
    ROW('muốn thả lỏng',0.95),

    ROW('kiệt sức',1.0),
    ROW('mệt mỏi quá',1.0),
    ROW('mệt quá',0.95),
    ROW('mệt rã rời',1.0),
    ROW('đuối quá',0.95),
    ROW('hết năng lượng',0.95),
    ROW('không còn sức',0.95),
    ROW('cháy pin',0.85),
    ROW('tụt pin',0.8),
    ROW('cạn pin',0.9),
    ROW('cạn năng lượng',0.95),
    ROW('hết hơi',0.85),
    ROW('căng thẳng quá',0.9),
    ROW('quá tải',0.95),
    ROW('đầu óc quá tải',1.0),
    ROW('não đơ',0.9),
    ROW('tâm trí mệt',0.95),
    ROW('kiệt tinh thần',1.0),
    ROW('nặng đầu',0.85),
    ROW('burnout',1.0),

    ROW('học nhiều quá',0.85),
    ROW('học căng quá',0.90),
    ROW('học suốt',0.85),
    ROW('làm việc quá sức',0.95),
    ROW('làm bài liên tục',0.90),
    ROW('chạy deadline',0.85),
    ROW('chạy dự án',0.80),
    ROW('bài vở dồn dập',0.90),
    ROW('lịch dày đặc',0.90),
    ROW('không có thời gian nghỉ',1.00),

    ROW('thiếu ngủ',0.95),
    ROW('mất ngủ',0.95),
    ROW('ngủ không đủ',0.90),
    ROW('ngủ muộn',0.80),
    ROW('buồn ngủ',0.85),
    ROW('ngủ gà gật',0.90),
    ROW('đầu óc mơ màng',0.90),
    ROW('thực sự cần ngủ',1.00),
    ROW('cần chợp mắt',0.95),
    ROW('muốn chợp mắt',0.95),

    ROW('không còn tâm trạng',0.85),
    ROW('cạn cảm xúc',0.90),
    ROW('không muốn làm gì',0.90),
    ROW('không buồn làm gì',0.90),
    ROW('không tập trung nổi',0.90),
    ROW('không nghĩ nổi',0.90),
    ROW('cảm thấy mệt trong người',0.95),
    ROW('chán nản vì mệt',0.95),
    ROW('kiệt quệ',1.00),
    ROW('cảm xúc xuống pin',0.85),

    ROW('tired',0.90),
    ROW('exhausted',1.00),
    ROW('drained',1.00),
    ROW('burned out',1.00),
    ROW('need rest',1.00),
    ROW('need a break',1.00),
    ROW('out of energy',0.95),
    ROW('mentally tired',1.00)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='nghi_ngoi'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('an toàn',1.00),
    ROW('cần an toàn',1.00),
    ROW('muốn an toàn',0.95),
    ROW('không an toàn',0.95),
    ROW('cảm giác không an toàn',1.00),
    ROW('cảm giác thiếu an toàn',0.95),
    ROW('thiếu an toàn',0.90),
    ROW('muốn cảm thấy an toàn',0.95),
    ROW('cần cảm giác an toàn',1.00),
    ROW('muốn được bảo vệ',1.00),
    ROW('cần được bảo vệ',1.00),
    ROW('cần được che chở',0.95),
    ROW('cảm giác dễ bị tổn thương',1.00),
    ROW('dễ bị tổn thương',0.95),
    ROW('cần sự chắc chắn',0.90),
    ROW('cần sự ổn định',0.90),
    ROW('muốn ổn định lại',0.85),
    ROW('tìm nơi an toàn',0.95),
    ROW('tìm cảm giác an toàn',1.00),
    ROW('tìm chỗ dựa',0.90),

    ROW('lo sợ',0.95),
    ROW('sợ bị tổn thương',1.00),
    ROW('sợ người khác',0.90),
    ROW('sợ chuyện xảy ra',0.90),
    ROW('sợ rủi ro',0.85),
    ROW('sợ mất kiểm soát',1.00),
    ROW('sợ không an toàn',1.00),
    ROW('cảm giác nguy hiểm',1.00),
    ROW('thấy nguy hiểm',0.95),
    ROW('môi trường không an toàn',1.00),
    ROW('bị đe doạ',1.00),
    ROW('cảm giác bị đe doạ',1.00),
    ROW('cảm thấy bị tấn công',0.90),
    ROW('bị tổn thương',0.85),
    ROW('không dám nói',0.85),
    ROW('không dám chia sẻ',0.85),
    ROW('sợ nói sai',0.85),
    ROW('sợ bị đánh giá',0.90),
    ROW('sợ bị hiểu lầm',0.85),
    ROW('sợ người khác phán xét',0.95),

    ROW('cần được trấn an',1.0),
    ROW('muốn được trấn an',1.0),
    ROW('muốn ai đó lắng nghe',0.8),
    ROW('muốn ai đó bên cạnh',0.8),
    ROW('cần cảm giác yên tâm',1.0),
    ROW('không yên tâm',0.95),
    ROW('cảm giác bất an',0.95),
    ROW('bất an',0.9),
    ROW('bất ổn trong lòng',0.85),
    ROW('cảm giác mong manh',0.9),
    ROW('dễ vỡ',0.8),
    ROW('cảm giác không chắc chắn',0.9),
    ROW('sợ tương lai',0.85),
    ROW('lo lắng về an toàn',1.0),
    ROW('cảm thấy bị đẩy ra xa',0.75),
    ROW('cảm thấy cô lập',0.85),

    ROW('không tin ai',0.85),
    ROW('không tin tưởng được',0.9),
    ROW('mất niềm tin',0.85),
    ROW('sợ bị phản bội',0.9),
    ROW('sợ bị bỏ rơi',0.9),
    ROW('sợ bị công kích online',1.0),
    ROW('bị tấn công mạng',1.0),
    ROW('sợ drama',0.75),
    ROW('sợ mâu thuẫn',0.85),
    ROW('cảm giác bị cô lập',0.85),
    ROW('cảm giác không có nơi nương tựa',0.95),

    ROW('hoảng loạn',1.0),
    ROW('hoảng sợ',1.0),
    ROW('tim đập nhanh',0.9),
    ROW('căng thẳng quá mức',0.85),
    ROW('run',0.8),
    ROW('loạn nhịp vì sợ',0.9),
    ROW('muốn trốn khỏi nơi này',0.95),
    ROW('muốn thoát khỏi tình huống này',0.95),
    ROW('muốn cảm giác yên bình',0.85),
    ROW('muốn an yên',0.85),

    ROW('feel unsafe',1.0),
    ROW('feel vulnerable',1.0),
    ROW('need safety',1.0),
    ROW('want safety',0.95),
    ROW('feel threatened',1.0),
    ROW('not safe',1.0),
    ROW('overwhelmed and scared',1.0),
    ROW('feeling exposed',0.9),
    ROW('need reassurance',1.0),
    ROW('feel anxious about safety',1.0)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='an_toan'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('định hướng',1.0),
    ROW('cần định hướng',1.0),
    ROW('muốn định hướng',0.9),
    ROW('thiếu định hướng',1.0),
    ROW('mất định hướng',1.0),
    ROW('không có định hướng',1.0),
    ROW('sai hướng',0.9),
    ROW('lạc hướng',1.0),
    ROW('mất phương hướng',1.0),
    ROW('lệch hướng',0.9),
    ROW('tìm hướng đi',1.0),
    ROW('chưa tìm được hướng đi',1.0),
    ROW('đổi hướng',0.8),
    ROW('hướng đi tương lai',1.0),
    ROW('chọn hướng đi',0.9),
    ROW('phân vân hướng đi',0.8),
    ROW('chưa biết hướng nào',0.9),
    ROW('không biết rẽ hướng nào',0.9),
    ROW('hướng dẫn',0.8),
    ROW('cần hướng dẫn',1.0),
    ROW('xin hướng dẫn',0.9),
    ROW('không biết phải làm gì',0.9),
    ROW('không hiểu chuyện gì',0.9),
    ROW('mục tiêu',0.9),
    ROW('đặt mục tiêu',1.0),
    ROW('cần mục tiêu rõ ràng',1.0),
    ROW('thiếu mục tiêu',0.9),
    ROW('không biết mục tiêu là gì',0.9),
    ROW('định mục tiêu',0.9),
    ROW('lựa chọn',0.8),
    ROW('phân vân lựa chọn',0.9),
    ROW('không quyết định được',1.0),
    ROW('cần quyết định',1.0),
    ROW('khó đưa ra quyết định',0.9),
    ROW('cần trợ giúp để quyết định',1.0),
    ROW('suy nghĩ về lựa chọn',0.8),
    ROW('tìm lựa chọn phù hợp',0.9),
    ROW('chọn hướng học',1.0),
    ROW('chọn trường',0.8),
    ROW('chọn nghề',1.0),
    ROW('chọn ngành',1.0),
    ROW('phân vân ngành học',1.0),
    ROW('kế hoạch',0.8),
    ROW('lập kế hoạch',0.9),
    ROW('lên kế hoạch',0.9),
    ROW('chưa có kế hoạch',1.0),
    ROW('không biết bắt đầu từ đâu',1.0),
    ROW('roadmap',0.7),
    ROW('vạch lộ trình',0.9),
    ROW('cần lộ trình rõ ràng',1.0),
    ROW('muốn kế hoạch rõ ràng',0.9),
    ROW('cần hướng phát triển',1.0),
    ROW('mục tiêu ngắn hạn',0.8),
    ROW('mục tiêu dài hạn',0.8),
    ROW('tự xác định hướng đi',0.9),
    ROW('muốn hiểu bản thân để chọn hướng',0.8),
    ROW('tìm điểm mạnh để định hướng',0.8),
    ROW('tìm khả năng để chọn nghề',0.8),
    ROW('cần xác định ưu tiên',0.9),
    ROW('không biết ưu tiên cái nào',0.9),
    ROW('muốn rõ ràng hơn',0.8),
    ROW('cần rõ ràng',0.8),
    ROW('đang rối trong việc lựa chọn',0.9),
    ROW('đang stuck',0.7),
    ROW('muốn tiếp tục nhưng chưa biết sao',0.7),
    ROW('need direction',0.6),
    ROW('need guidance',0.6),
    ROW('which path to take',0.6),
    ROW('confused about options',0.6),
    ROW('career direction',0.6),
    ROW('what should I choose',0.6),
    ROW('no clear plan',0.7),
    ROW('stuck with decisions',0.7)
    ROW('muốn tiến lên',0.90),
    ROW('muốn có ước mơ',0.90),
    ROW('ước mơ',0.85),
    ROW('cần ước mơ',0.85),
    ROW('có ảnh hưởng',0.85),
    ROW('muốn để lại dấu ấn',0.90),
    ROW('muốn trở thành ai đó',0.90),
    ROW('muốn thành đạt',0.90),
    ROW('có khát vọng',0.95),
    ROW('khát vọng lớn',0.95),
    ROW('muốn phát triển mạnh mẽ',0.90),
    ROW('muốn cố gắng hơn',0.90),
    ROW('muốn trưởng thành',0.90),
    ROW('phát triển kỹ năng',0.90),
    ROW('muốn học nhiều',0.85),
    ROW('muốn biết mình là ai',0.95),
    ROW('nhận biết bản thân',0.95),
    ROW('tự hiểu mình',0.90),
    ROW('khám phá bản thân',0.95),
    ROW('tìm chính mình',1.00),
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
    ROW('cần động lực',1.0),
    ROW('muốn cố gắng',0.95),
    ROW('muốn tiến bộ',0.95),
    ROW('muốn bắt đầu',0.95),
    ROW('cần cảm hứng',1.0),
    ROW('muốn được truyền cảm hứng',0.95),
    ROW('tìm nguồn động lực',0.95),
    ROW('muốn được khích lệ',0.95),
    ROW('cần ai đó thúc đẩy',0.95),
    ROW('cần ai nhắc nhở',0.95),
    ROW('cần push',0.9),
    ROW('cần boost',0.9),
    ROW('muốn quay lại quỹ đạo',0.9),
    ROW('tự tạo động lực',0.9),
    ROW('muốn tạo động lực cho bản thân',0.9),
    ROW('thiếu động lực',1.0),
    ROW('mất động lực',1.0),
    ROW('tụt động lực',0.95),
    ROW('hết động lực',1.0),
    ROW('không còn hứng thú',0.95),
    ROW('không còn năng lượng',0.95),
    ROW('chán nản',0.9),
    ROW('nản quá',0.9),
    ROW('đang stuck',0.9),
    ROW('không muốn làm gì',0.95),
    ROW('lười quá',0.9),
    ROW('trì hoãn hoài',0.9),
    ROW('không biết bắt đầu từ đâu',0.9),
    ROW('khó tập trung',0.9),
    ROW('ngồi vào bàn nhưng không làm',0.85),
    ROW('không muốn học',0.9),
    ROW('chán học',0.9),
    ROW('bài nhiều quá muốn bỏ',0.9),
    ROW('không muốn làm bài',0.9),
    ROW('không muốn ôn bài',0.85),
    ROW('học không vô',0.85),
    ROW('không muốn đi học',0.85),
    ROW('bối rối không biết làm gì trước',0.9),
    ROW('áp lực quá không muốn làm',0.9),
    ROW('ngại bắt đầu',0.85),
    ROW('chần chừ',0.85),
    ROW('sợ bắt đầu',0.85),
    ROW('chưa sẵn sàng',0.85),
    ROW('cần ai động viên',0.85),
    ROW('cần ai giúp mình bắt đầu',0.85),
    ROW('muốn tìm lý do để tiếp tục',0.85),
    ROW('cần gợi ý để làm tiếp',0.85),
    ROW('muốn ai nhắc nhở deadline',0.8),
    ROW('cần lời khích lệ',0.85),
    ROW('need motivation',0.8),
    ROW('no motivation',0.8),
    ROW('lost motivation',0.8),
    ROW('need inspiration',0.8),
    ROW('feeling unmotivated',0.8),
    ROW('stuck',0.7),
    ROW('can’t start',0.7),
    ROW('procrastinating',0.7),
    ROW('unproductive',0.7),
    ROW('need a push',0.8),
    ROW('need a boost',0.8),
    ROW('down quá',0.7),
    ROW('chán vl',0.7),
    ROW('mệt quá không làm gì',0.7),
    ROW('ngại quá',0.7),
    ROW('lười vl',0.6),
    ROW('nản vl',0.6),
    ROW('stuck quá',0.6)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='dong_luc'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần được công nhận',1.0),
    ROW('muốn được công nhận',1.0),
    ROW('mong được công nhận',0.95),
    ROW('cần ai đó nhìn thấy nỗ lực',0.95),
    ROW('muốn ai đó thấy thành quả',0.95),
    ROW('cần ai khen ngợi',1.0),
    ROW('muốn được khen',0.95),
    ROW('muốn được đánh giá cao',0.95),
    ROW('cần ai đó ghi nhận',0.95),
    ROW('cần lời động viên về thành tích',0.95),
    ROW('muốn ghi nhận nỗ lực',0.95),
    ROW('cần thành quả được công nhận',0.95),
    ROW('được khen', 1.0),
    ROW('được công nhận', 0.9),
    ROW('được thừa nhận', 0.9),
    ROW('cần ghi nhận', 0.9),
    ROW('được trân trọng', 0.8),
    ROW('cần sự đồng ý', 0.7),
    ROW('cảm thấy bị bỏ qua', 0.9),
    
    ROW('không được công nhận',1.0),
    ROW('bị bỏ qua',0.9),
    ROW('nỗ lực không ai thấy',0.9),
    ROW('làm mà không ai khen',0.9),
    ROW('cảm giác bị phớt lờ',0.9),
    ROW('ai cũng quên mình',0.85),
    ROW('bị đánh giá thấp',0.9),
    ROW('không được đánh giá đúng',0.9),
    ROW('cảm giác vô hình',0.85),
    ROW('thành quả bị bỏ qua',0.9),
    ROW('làm xong mà không ai chú ý',0.85),

    ROW('muốn được mọi người chú ý',0.9),
    ROW('muốn được mọi người công nhận',0.9),
    ROW('cần được bạn bè khen',0.85),
    ROW('cần được thầy cô công nhận',0.85),
    ROW('muốn được đồng nghiệp ghi nhận',0.85),
    ROW('muốn được ghi nhận trên mạng',0.8),
    ROW('cần like',0.8),
    ROW('cần comment',0.8),
    ROW('cần share',0.8),

    ROW('muốn được thấy giá trị của mình',0.85),
    ROW('cần ai đó thừa nhận mình',0.85),
    ROW('muốn được công nhận năng lực',0.85),
    ROW('muốn được đánh giá đúng khả năng',0.85),
    ROW('cần sự xác nhận từ người khác',0.85),
    ROW('cần lời khích lệ để thấy giá trị',0.85),

    ROW('need recognition',0.8),
    ROW('want appreciation',0.8),
    ROW('feeling ignored',0.8),
    ROW('nobody notices me',0.8),
    ROW('want credit',0.8),
    ROW('need acknowledgment',0.8),
    ROW('unrecognized',0.75),
    ROW('feel overlooked',0.75),
    ROW('need props',0.7),
    ROW('want someone to notice',0.75),
    ROW('need shoutout',0.7),
    ROW('need thumbs up',0.7),
    ROW('feel invisible',0.75),
    ROW('need likes',0.7),
    ROW('feel forgotten',0.7),
    ROW('need respect',0.75),
    ROW('feeling underappreciated',0.8),
    ROW('need validation',0.75),
    ROW('need some validation',0.7),
    ROW('need a pat on the back',0.7),

    ROW('ai để ý gì đâu',0.7),
    ROW('chẳng ai để ý',0.7),
    ROW('chán vì làm mà không ai khen',0.7),
    ROW('làm nhiều mà chẳng ai thèm nói gì',0.7),
    ROW('feel unnoticed',0.7),
    ROW('no one cares',0.6),
    ROW('nobody cares',0.6),
    ROW('cần ai đó ghi nhận chút thôi',0.65)
    ROW('không ai quan tâm',0.7),
    ROW('chả ai để ý',0.75),
    ROW('chả ai quan tâm',0.75),
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='cong_nhan'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('cần kết nối',1.0),
    ROW('muốn kết nối',1.0),
    ROW('cần nói chuyện với ai đó',0.95),
    ROW('cần ai đó lắng nghe',0.95),
    ROW('cần người tâm sự',1.0),
    ROW('muốn được chia sẻ',0.95),
    ROW('cần có người hiểu mình',0.95),
    ROW('muốn có ai đó ở bên',1.0),
    ROW('cần người đồng hành',0.95),
    ROW('cần một cuộc trò chuyện thật sự',0.95),
    ROW('muốn gần gũi với ai đó',0.95),
    ROW('muốn cảm giác thuộc về đâu đó',0.95),

    ROW('cảm thấy cô đơn',1.0),
    ROW('thấy lạc lõng',0.9),
    ROW('không có ai để nói chuyện',0.9),
    ROW('chẳng ai hiểu mình',0.9),
    ROW('cảm giác bị tách biệt',0.9),
    ROW('thấy lạc lõng giữa mọi người',0.9),
    ROW('bị tách rời khỏi mọi người',0.85),
    ROW('cảm thấy xa cách',0.9),
    ROW('mất kết nối với bạn bè',0.9),
    ROW('chẳng ai quan tâm',0.9),
    ROW('không ai để dựa vào',0.9),
    ROW('thấy mình không thuộc về nơi nào',0.9),
    ROW('cảm giác trống rỗng vì không có ai',0.9),
    ROW('bị bỏ rơi',0.9),
    ROW('bị phớt lờ',0.9),
    ROW('bị cô lập',0.9),

    ROW('muốn đi chơi cùng ai đó',0.85),
    ROW('muốn tâm sự với ai đó',0.9),
    ROW('muốn giao lưu',0.85),
    ROW('muốn nói chuyện nhiều hơn',0.85),
    ROW('muốn kết bạn',0.85),
    ROW('muốn tìm sự kết nối mới',0.85),
    ROW('muốn ở gần bạn bè',0.85),
    ROW('cần cảm giác thân thuộc',0.9),
    ROW('muốn được chấp nhận trong nhóm',0.85),
    ROW('muốn được hòa nhập',0.85),

    ROW('cần sự quan tâm',0.85),
    ROW('muốn được ôm',0.8),
    ROW('muốn có ai đó cạnh bên',0.85),
    ROW('cảm thấy cần tình cảm',0.8),
    ROW('muốn cảm giác gần gũi',0.85),
    ROW('muốn sự ấm áp',0.85),
    ROW('muốn ai đó lắng nghe thấu hiểu',0.85),
    ROW('muốn người tin tưởng mình',0.85),
    ROW('muốn ai đó stay with me',0.8),

    ROW('em không có ai để dựa',0.8),
    ROW('bạn bè xa lánh',0.8),
    ROW('không ai rảnh để nghe mình nói',0.75),
    ROW('khó kết nối với người khác',0.75),
    ROW('chẳng thân với ai',0.7),
    ROW('thấy mình bị bỏ lại',0.75),
    ROW('không hòa nhập được',0.75),
    ROW('cảm giác tránh xa mọi người',0.7),
    ROW('cảm giác disconnected',0.7),

    ROW('feel lonely',0.8),
    ROW('feeling alone',0.8),
    ROW('need someone to talk to',0.8),
    ROW('need connection',0.8),
    ROW('want to talk to someone',0.8),
    ROW('want company',0.75),
    ROW('want someone to listen',0.75),
    ROW('feel isolated',0.75),
    ROW('feel disconnected',0.75),
    ROW('need social support',0.75),
    ROW('need a friend',0.75),
    ROW('wanna talk',0.7),
    ROW('need someone here with me',0.7),
    ROW('want to feel belonged',0.75),
    ROW('no one to talk to',0.7),
    ROW('feel left out',0.7),
    ROW('no connections',0.7),
    ROW('socially drained',0.65),
    ROW('socially isolated',0.65),
    ROW('friendless',0.75)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='ket_noi'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
  ROW('bị hiểu lầm',1.0),
  ROW('bị hiểu sai',1.0),
  ROW('bị đánh giá nhầm',0.95),
  ROW('bị nhìn nhận sai',0.95),
  ROW('người ta nghĩ sai về tôi',0.9),
  ROW('bị gán cho điều không phải của mình',0.9),
  ROW('nói một đường người ta nghĩ một nẻo',0.9),
  ROW('bị xuyên tạc lời nói',0.9),
  ROW('bị nhìn sai bản chất',0.95),
  ROW('không ai hiểu lý do của tôi',0.9),
  ROW('tôi không như họ nghĩ',0.9),
  ROW('họ không hiểu tôi',0.9),
  ROW('cần được thấu cảm',1.0),
  ROW('cần sự thông cảm',1.0),
  ROW('muốn được hiểu mà không bị phán xét',1.0),
  ROW('muốn được nhìn từ góc nhìn của tôi',0.95),
  ROW('cần ai đó hiểu cảm xúc của tôi',0.95),
  ROW('cần sự đồng điệu cảm xúc',0.9),
  ROW('ước gì có ai hiểu tôi',0.9),
  ROW('muốn được lắng nghe chân thành',0.95),
  ROW('muốn được nghe mà không bị ngắt lời',0.95),
  ROW('cảm xúc của tôi bị bỏ qua',1.0),
  ROW('bị phớt lờ',1.0),
  ROW('lời tôi nói bị xem nhẹ',0.95),
  ROW('ý kiến của tôi không ai nghe',0.95),
  ROW('cảm thấy bị coi thường',0.9),
  ROW('bị làm ngơ',0.9),
  ROW('bị xem như không tồn tại',1.0),
  ROW('khó diễn đạt',0.8),
  ROW('khó nói hết lòng mình',0.8),
  ROW('nói không trọn ý',0.75),
  ROW('không biết truyền đạt',0.7),
  ROW('diễn đạt khó quá',0.7),
  ROW('không ai bắt được ý',0.75),
  ROW('nói sai một chút là bị hiểu lầm',0.85),
  ROW('mỗi lần nói đều gây hiểu lầm',0.85),
  ROW('muốn được lắng nghe',1.0),
  ROW('cần ai đó ngồi nghe tôi',0.95),
  ROW('muốn có người chịu nghe',0.9),
  ROW('muốn tâm sự',0.8),
  ROW('cần cuộc nói chuyện chân thành',0.9),
  ROW('cần người nghe không phán xét',1.0),
  ROW('muốn được nghe đến hết câu',0.95),
  ROW('không ai hiểu cảm xúc của tôi',1.0),
  ROW('cảm giác một mình trong cảm xúc',0.95),
  ROW('nỗi lòng không ai thấu',1.0),
  ROW('không ai cùng tần số với tôi',0.85),
  ROW('cảm xúc bị kẹt trong lòng',0.8),
  ROW('chỉ có mình tôi hiểu được cảm xúc này',0.9),
  ROW('chán vì phải giải thích hoài',0.9),
  ROW('mệt vì bị hiểu sai',1.0),
  ROW('mệt vì phải lặp lại',0.85),
  ROW('bực vì không ai hiểu ý',0.9),
  ROW('nản vì cố giải thích',0.85),
  ROW('bất lực khi người ta không hiểu',1.0),
  ROW('muốn được nhìn thấy con người thật',1.0),
  ROW('muốn được nhìn nhận đúng',1.0),
  ROW('muốn người khác hiểu tôi hơn',0.95),
  ROW('không ai biết tôi thật sự',0.9),
  ROW('muốn được hiểu nỗ lực của tôi',0.9),
  ROW('muốn được hiểu mà không bị định kiến',1.0),
  ROW('nói gì cũng không ai hiểu',1.0),
  ROW('như nói hai ngôn ngữ khác nhau',0.8),
  ROW('không chung tần số nói chuyện',0.75),
  ROW('tôi nói người ta hiểu theo ý họ',0.85),
  ROW('không truyền tải được cảm xúc',0.9),
  ROW('nói chuyện không đâu vào đâu',0.8)
  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='duoc_hieu'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('muốn được chấp nhận',1.0),
    ROW('muốn được công nhận',0.95),
    ROW('muốn được coi trọng',0.9),
    ROW('muốn được xem là một phần',0.95),
    ROW('muốn được chào đón',0.9),
    ROW('muốn được tiếp nhận',0.85),
    ROW('muốn được thừa nhận',0.95),
    ROW('muốn được đối xử như mọi người',0.9),
    ROW('muốn được chấp nhận như đúng bản thân mình',1.0),
    ROW('muốn được yêu thương như chính mình',1.0),
    ROW('muốn được công nhận nỗ lực',0.95),
    ROW('sợ bị từ chối',1.0),
    ROW('sợ bị loại bỏ',1.0),
    ROW('sợ bị xa lánh',0.95),
    ROW('sợ không được chấp nhận',0.95),
    ROW('lo bị đánh giá',0.95),
    ROW('sợ bị tẩy chay',1.0),
    ROW('sợ mọi người không thích mình',0.9),
    ROW('sợ không hợp nhóm',0.85),
    ROW('muốn được ghi nhận',0.95),
    ROW('muốn được khen ngợi',0.85),
    ROW('muốn được xác nhận',0.9),
    ROW('muốn được công nhận cảm xúc',0.95),
    ROW('cần được xác nhận rằng mình đủ tốt',0.95),
    ROW('cần ai đó đứng về phía tôi',0.95),
    ROW('cảm thấy không được chấp nhận',1.0),
    ROW('cảm thấy bị loại ra',1.0),
    ROW('cảm thấy không thuộc về nơi này',0.95),
    ROW('cảm thấy bị gạt ra ngoài',0.95),
    ROW('cảm thấy không được coi trọng',0.9),
    ROW('cảm thấy bị xa lánh',0.95),
    ROW('cảm thấy bị bỏ rơi',1.0),
    ROW('cảm thấy bị xem thường',0.9),
    ROW('ước được chấp nhận như chính mình',1.0),
    ROW('ước được yêu mà không bị so sánh',0.9),
    ROW('chỉ muốn ai đó chấp nhận mình',0.95),
    ROW('mong được công nhận giá trị',0.95),
    ROW('mong không bị đánh giá',0.9),
    ROW('muốn hòa nhập',0.85),
    ROW('muốn thuộc về một nhóm',0.9),
    ROW('muốn trở thành một phần',0.9),
    ROW('muốn được mời tham gia',0.85),
    ROW('muốn được xem như thành viên thật sự',0.9),
    ROW('không ai muốn chơi với tôi',1.0),
    ROW('bị loại khỏi nhóm',1.0),
    ROW('bị cho ra rìa',0.95),
    ROW('bị xa lánh',1.0),
    ROW('bị nói xấu sau lưng',0.9),
    ROW('cảm giác bị loại trừ',0.95),
    ROW('không ai tôn trọng tôi',0.9),
    ROW('tôi không đủ tốt',1.0),
    ROW('tôi không xứng đáng',1.0),
    ROW('tôi không đáng được yêu',0.95),
    ROW('tôi không giá trị',0.95),
    ROW('tôi thấy mình vô dụng',1.0),
    ROW('tôi thấy mình không quan trọng',0.95),
    ROW('muốn được chấp nhận cảm xúc',0.95),
    ROW('muốn được lắng nghe mà không bị chê cười',0.95),
    ROW('muốn ai đó nói tớ hiểu cậu',0.9),
    ROW('muốn được tha thứ',0.85)
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

    ROW('tự tin', 1.0),
    ROW('tự trọng', 1.0),
    ROW('tự tôn', 1.0),
    ROW('lòng tự trọng bị tổn thương', 1.0),
    ROW('muốn được tôn trọng', 0.95),
    ROW('muốn được ghi nhận', 0.9),
    ROW('cần sự công nhận', 0.9),
    ROW('giá trị bản thân', 0.95),
    ROW('cảm thấy bị coi thường', 0.95),
  ROW('cảm thấy bị hạ thấp', 0.9),
  ROW('khẳng định bản thân', 0.9),
  ROW('không muốn bị coi nhẹ', 0.9),
  ROW('cảm giác không có giá trị', 0.95),
  ROW('thấy bản thân kém cỏi', 0.9),
  ROW('cảm giác không đủ tốt', 0.8),
  ROW('sự tự hào cá nhân', 0.85),
  ROW('mong được đánh giá cao', 0.9),
  ROW('mong có sự tôn trọng', 0.9),
  ROW('tìm kiếm sự công nhận', 0.85),
  ROW('cần được lắng nghe', 0.8),
  ROW('cần được xem trọng', 0.9),
  ROW('cần sự đánh giá đúng', 0.85),
  ROW('tìm kiếm sự khẳng định', 0.85),
  ROW('sợ bị đánh giá thấp', 0.85),
  ROW('sợ bị xem thường', 0.9),
  ROW('ghét cảm giác bị coi nhẹ', 0.9),
  ROW('muốn chứng minh bản thân', 0.8),
  ROW('mong muốn được công nhận', 0.9),
  ROW('cảm giác bị bỏ qua', 0.75),
  ROW('cảm giác bị xem nhẹ', 0.8),
  ROW('mong được tôn vinh', 0.7),
  ROW('muốn được tán dương', 0.75),
  ROW('muốn được đánh giá đúng', 0.8),
  ROW('muốn được đối xử công bằng', 0.75),
  ROW('muốn được nhìn nhận nghiêm túc', 0.85),
  ROW('tự đánh giá bản thân thấp', 0.8),
  ROW('mất tự tin', 0.8),
  ROW('cảm thấy bị phủ nhận', 0.9),
  ROW('không được coi trọng', 0.9),
  ROW('cảm giác không được ghi nhận', 0.85),
  ROW('công nhận bản thân', 0.75),
  ROW('muốn nâng giá trị bản thân', 0.8),
  ROW('khát khao tự khẳng định', 0.85),
  ROW('bị xem thường', 0.9),
  ROW('tổn thương tự trọng', 1.0),
  ROW('tự tin vào khả năng', 0.7),
  ROW('tin vào giá trị bản thân', 0.8),
  ROW('xây dựng tự trọng', 0.75),
  ROW('khủng hoảng tự tôn', 1.0),

  ROW('self-esteem', 1.0),
  ROW('self-worth', 1.0),
  ROW('self-respect', 1.0),
  ROW('hurt pride', 1.0),
  ROW('feeling undervalued', 0.95),
  ROW('feeling worthless', 0.95),
  ROW('feeling unappreciated', 0.9),
  ROW('seeking validation', 0.9),
  ROW('need for recognition', 0.9),
  ROW('feeling disrespected', 0.95),
  ROW('feeling belittled', 0.9),
  ROW('feeling inferior', 0.9),
  ROW('need to prove worth', 0.85),
  ROW('proving oneself', 0.85),
  ROW('desire for acknowledgement', 0.9),
  ROW('need to be taken seriously', 0.9),
  ROW('feeling dismissed', 0.9),
  ROW('feeling unimportant', 0.8),
  ROW('doubt in self-worth', 0.9),
  ROW('low self-esteem', 0.9),
  ROW('questioning self-value', 0.9),
  ROW('searching for validation', 0.9),
  ROW('desire for respect', 0.9),
  ROW('lack of confidence', 0.75),
  ROW('wanting recognition', 0.85),
  ROW('craving respect', 0.85),
  ROW('wanting to be valued', 0.9),
  ROW('not feeling valued', 0.9),
  ROW('not being taken seriously', 0.9),
  ROW('being looked down on', 0.95),
  ROW('feeling inferior to others', 0.85),
  ROW('feeling overshadowed', 0.8),
  ROW('feeling insignificant', 0.8),
  ROW('seeking appreciation', 0.85),
  ROW('need for affirmation', 0.85),
  ROW('being underestimated', 0.9),
  ROW('hurt self-image', 0.9),
  ROW('protecting self-worth', 0.75),
  ROW('strengthening self-esteem', 0.75),
  ROW('personal value', 0.7),
  ROW('personal dignity', 0.8),
  ROW('feeling disregarded', 0.9),
  ROW('feeling minimized', 0.85),
  ROW('desire to feel proud', 0.8),
  ROW('need to be respected', 0.9),
  ROW('wanting fair treatment', 0.7),
  ROW('wanting appreciation', 0.8),
  ROW('craving recognition', 0.85),
  ROW('challenged pride', 0.95),
  ROW('threatened self-esteem', 1.0),
  ROW('boosting self-worth', 0.75)
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

    ROW('ý nghĩa cuộc sống', 0.95),
    ROW('cảm thấy vô nghĩa', 0.90),
    ROW('không thấy giá trị bản thân', 0.90),
    ROW('cảm thấy trống rỗng bên trong', 0.85),
    ROW('tự hỏi điều gì khiến mình quan trọng', 0.85),
    ROW('không biết điều gì làm mình có ích', 0.85),
    ROW('muốn cảm thấy có giá trị', 0.90),
    ROW('muốn cảm thấy mình quan trọng', 0.85),
    ROW('muốn có lý do để cố gắng', 0.85),
    ROW('muốn sống có ý nghĩa hơn', 0.90),
    ROW('cảm thấy đời mình nhạt nhẽo', 0.80),
    ROW('không thấy điều gì thúc đẩy bản thân', 0.80),
    ROW('cảm thấy mọi thứ mờ nhạt', 0.80),
    ROW('không thấy mình đóng góp gì', 0.85),
    ROW('muốn làm điều có ích', 0.85),
    ROW('cần tìm điều khiến mình sống tích cực', 0.85),
    ROW('cảm thấy mất kết nối với chính mình', 0.85),
    ROW('không thấy điều gì khiến mình hạnh phúc', 0.80),
    ROW('cảm thấy như đang tồn tại chứ không sống', 0.90),
    ROW('tự hỏi điều gì tạo giá trị cho bản thân', 0.85),
    ROW('cảm thấy cuộc sống vô vị', 0.80),
    ROW('muốn hiểu mình có giá trị gì', 0.85),
    ROW('cảm giác cuộc sống trôi qua vô nghĩa', 0.90),
    ROW('không thấy điều gì đáng để quan tâm', 0.85),
    ROW('muốn thấy mình có tác động tích cực', 0.85),
    ROW('cảm thấy cuộc sống thiếu linh hồn', 0.80),
    ROW('không thấy điều gì làm mình hứng thú', 0.80),
    ROW('muốn tìm điều làm bản thân thấy sống hơn', 0.85),
    ROW('cảm thấy như một phần bên trong bị rỗng', 0.85),
    ROW('không biết điều gì mang lại giá trị thật', 0.85),
    ROW('cảm thấy cuộc sống lặp lại vô nghĩa', 0.85),
    ROW('cần điều gì đó sâu sắc hơn', 0.80),
    ROW('cần cảm giác mình có tầm quan trọng', 0.85),
    ROW('muốn hiểu bản thân mang lại điều gì', 0.85),
    ROW('cảm thấy thiếu sức sống', 0.80),
    ROW('không biết bản thân có đóng góp gì không', 0.85),
    ROW('muốn cảm thấy mình xứng đáng', 0.85),
    ROW('cảm thấy mọi thứ nhàm chán', 0.75),
    ROW('không biết điều gì khiến mình có giá trị', 0.85),
    ROW('tự hỏi mình đang sống cho điều gì', 0.90),
    ROW('không thấy mục tiêu cảm xúc nào', 0.80),
    ROW('muốn có điều khiến mình thấy sống ý nghĩa', 0.90),
    ROW('không tìm được cảm giác ý nghĩa', 0.85),
    ROW('cảm thấy bản thân mờ nhạt', 0.80),
    ROW('không biết bản thân quan trọng với ai', 0.80),
    ROW('cần cảm cảm giác có ý nghĩa', 0.90),
    ROW('muốn tìm sự kết nối sâu sắc với cuộc sống', 0.85),
    ROW('thấy bản thân không nổi bật', 0.80),
    ROW('cảm thấy như đang bị trôi dạt trong cuộc sống', 0.85),\

    ROW('searching for meaning', 0.95),
    ROW('feeling empty inside', 0.90),
    ROW('feeling meaningless', 0.90),
    ROW('want to feel valuable', 0.90),
    ROW('don’t feel important', 0.85),
    ROW('can’t find meaning in things', 0.85),
    ROW('feel like nothing matters', 0.90),
    ROW('struggling to feel purpose', 0.85),
    ROW('feeling emotionally empty', 0.85),
    ROW('want to feel like I matter', 0.85),
    ROW('feeling unfulfilled', 0.85),
    ROW('nothing feels meaningful', 0.85),
    ROW('don’t feel connected to myself', 0.85),
    ROW('feeling hollow', 0.85),
    ROW('struggling to feel alive', 0.85),
    ROW('want to feel useful', 0.85),
    ROW('hard to care about things', 0.80),
    ROW('feel like I’m drifting emotionally', 0.85),
    ROW('don’t feel excited about life', 0.80),
    ROW('can’t find emotional purpose', 0.80),
    ROW('want something deeper', 0.80),
    ROW('don’t feel like I contribute anything', 0.85),
    ROW('feeling numb to everything', 0.85),
    ROW('nothing feels important', 0.85),
    ROW('feel like I’m just existing', 0.90),
    ROW('don’t know what gives me meaning', 0.85),
    ROW('can’t feel any joy or spark', 0.80),
    ROW('feeling lost emotionally', 0.85),
    ROW('feel like my life has no depth', 0.85),
    ROW('don’t know what makes me feel alive', 0.85),
    ROW('feeling unmotivated emotionally', 0.80),
    ROW('want to feel like I matter to something', 0.85),
    ROW('everything feels dull', 0.75),
    ROW('feel like I’m disappearing', 0.80),
    ROW('hard to connect with anything', 0.80),
    ROW('want to understand my emotional value', 0.85),
    ROW('feel disconnected from life', 0.85),
    ROW('nothing feels real emotionally', 0.85),
    ROW('feeling like a ghost in my own life', 0.85),
    ROW('struggling to find emotional meaning', 0.85),
    ROW('feeling emotionally directionless', 0.85),
    ROW('feel like I’m fading', 0.80),
    ROW('don’t feel like I belong anywhere emotionally', 0.80),
    ROW('want to feel emotionally alive', 0.85),
    ROW('hard to feel my own value', 0.85),
    ROW('feel like everything is empty', 0.85),
    ROW('searching for emotional meaning', 0.90),
    ROW('don’t know what makes my life meaningful', 0.85),
    ROW('feel like my presence doesn’t matter', 0.85)

  ]::text_weight[]
) AS t(kw, wt)
WHERE slug='y_nghia'
ON CONFLICT DO NOTHING;

INSERT INTO need_keywords (need_id, keyword, weight, type)
SELECT id, kw, wt, 'keyword'
FROM needs, unnest(
  ARRAY[
    ROW('bình ổn', 1.0),
    ROW('tâm trạng bình ổn', 1.0),
    ROW('giữ tâm vững', 0.95),
    ROW('cảm xúc ổn định', 0.95),
    ROW('tinh thần ổn định', 0.9),
    ROW('cần sự bình tĩnh', 0.9),
    ROW('tâm lý ổn định', 0.9),
    ROW('tinh thần yên ổn', 0.9),
    ROW('giữ sự bình yên', 0.9),
    ROW('muốn lòng yên lại', 0.9),
    ROW('đầu óc nhẹ nhàng', 0.85),
    ROW('tâm không xáo động', 0.9),
    ROW('muốn mọi thứ yên', 0.85),
    ROW('ổn định cảm xúc', 0.9),
    ROW('bớt căng thẳng lại', 0.85),
    ROW('bình tĩnh hơn chút', 0.85),
    ROW('không muốn rối nữa', 0.85),
    ROW('tránh bị quá tải', 0.85),
    ROW('muốn giảm áp lực', 0.85),
    ROW('cần sự nhẹ nhàng', 0.8),
    ROW('tâm lý thoải mái', 0.85),
    ROW('tinh thần thư thái', 0.85),
    ROW('mong được yên ổn', 0.9),
    ROW('đầu óc bình thản', 0.9),
    ROW('tìm sự cân bằng', 0.9),
    ROW('cuộc sống nhẹ nhàng', 0.8),
    ROW('không muốn stress', 0.8),
    ROW('tránh xung đột', 0.75),
    ROW('muốn sống chậm lại', 0.8),
    ROW('muốn tâm yên', 0.9),
    ROW('sống cho nhẹ đầu', 0.8),
    ROW('muốn đỡ rối hơn', 0.85),
    ROW('muốn chill lại chút', 0.75),
    ROW('vibe yên ổn hơn', 0.75),
    ROW('bớt drama lại', 0.75),
    ROW('cần reset tinh thần', 0.8),
    ROW('bị overwhelm quá', 0.7),
    ROW('đầu óc lộn xộn', 0.8),
    ROW('cần không gian thở', 0.8),
    ROW('quay về trạng thái ổn', 0.8),
    ROW('ngắt kết nối một chút', 0.7),
    ROW('đầu óc bớt nặng', 0.8),
    ROW('cần ổn ổn lại', 0.8),
    ROW('mọi thứ calm lại', 0.8),
    ROW('tinh thần không tụt mood', 0.75),
    ROW('lòng bình thì sống yên', 0.9),
    ROW('thả lỏng mà sống', 0.85),
    ROW('nhẹ đầu nhẹ lòng', 0.85),
    ROW('tĩnh thì an', 0.9),
    ROW('giữ lòng yên', 0.9),
    ROW('sống chậm cho an', 0.85),
    ROW('an thì mới ổn', 0.9),
    ROW('tâm yên thì đời yên', 0.95),
    ROW('thở sâu để bình an', 0.85),
    ROW('bình tĩnh là sức mạnh', 0.85),
    ROW('cứ từ từ rồi ổn', 0.8),
    ROW('lòng vững thì không lo', 0.85),
    ROW('chậm lại để ổn định', 0.8),
    ROW('cần yên tĩnh để ổn lại', 0.9),

    ROW('emotional stability', 1.0),
    ROW('feeling grounded', 0.95),
    ROW('inner calm', 0.95),
    ROW('stable mindset', 0.9),
    ROW('mental balance', 0.9),
    ROW('calm and steady', 0.9),
    ROW('need to calm down', 0.9),
    ROW('mind feels steady', 0.9),
    ROW('reset my mind', 0.85),
    ROW('need to slow down', 0.85),
    ROW('want things calmer', 0.85),
    ROW('keep myself grounded', 0.9),
    ROW('feeling overwhelmed', 0.8),
    ROW('too much going on', 0.8),
    ROW('mind feels messy', 0.85),
    ROW('need some quiet', 0.85),
    ROW('need a breather', 0.85),
    ROW('brain needs rest', 0.85),
    ROW('mental reset', 0.85),
    ROW('lower the stress', 0.8),
    ROW('stay calm and steady', 0.9),
    ROW('want peace of mind', 0.95),
    ROW('seeking balance', 0.9),
    ROW('want emotional peace', 0.95),
    ROW('mind feeling heavy', 0.85),
    ROW('need to decompress', 0.85),
    ROW('trying to stay calm', 0.85),
    ROW('feel mentally drained', 0.8),
    ROW('keep things peaceful', 0.85),
    ROW('head feels too full', 0.8),
    ROW('just want calm', 0.9),
    ROW('things feel chaotic', 0.85),
    ROW('need to breathe', 0.85),
    ROW('want everything steady', 0.9),
    ROW('trying to stay stable', 0.9),
    ROW('need mental quiet', 0.9),
    ROW('take it slow', 0.8),
    ROW('calm my thoughts', 0.9),
    ROW('clear my mind', 0.85),
    ROW('find some peace', 0.9),
    ROW('stay emotionally steady', 0.9),
    ROW('feel inner peace', 0.95),
    ROW('trying to stay centered', 0.9),
    ROW('want to feel balanced', 0.95),
    ROW('brain feels overloaded', 0.8),
    ROW('reduce the noise', 0.8),
    ROW('calm energy', 0.85),
    ROW('stay grounded', 0.9),
    ROW('mind needs calm', 0.9),
    ROW('want some stability', 1.0),
    ROW('mental calmness', 0.9)
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

    ROW('cảm thấy bế tắc', 1.0),
    ROW('không còn thấy lối ra', 1.0),
    ROW('mọi thứ đều mù mịt', 0.95),
    ROW('không biết rồi có khá lên không', 0.95),
    ROW('cảm thấy mất niềm tin', 0.95),
    ROW('tương lai trông tối quá', 0.9),
    ROW('lo sợ mọi thứ tệ hơn', 0.9),
    ROW('không biết vượt qua kiểu gì', 0.9),
    ROW('cảm giác bất lực', 0.95),
    ROW('nặng nề trong lòng', 0.85),
    ROW('cảm thấy không ổn chút nào', 0.85),
    ROW('mọi thứ đang sụp xuống', 0.9),
    ROW('cảm thấy bị mắc kẹt lâu rồi', 0.9),
    ROW('không dám hi vọng nữa', 0.95),
    ROW('cảm giác quá sức chịu', 0.9),
    ROW('không thấy điểm sáng nào', 0.95),
    ROW('khó mà tin mọi thứ sẽ ổn', 0.95),
    ROW('cảm giác hụt hẫng', 0.8),
    ROW('thấy cuộc sống nặng quá', 0.85),
    ROW('không biết phải làm sao để nhẹ hơn', 0.85),
    ROW('mệt vì phải cố gắng mãi', 0.9),
    ROW('mọi thứ cứ tệ dần', 0.9),
    ROW('sợ mình không vượt qua nổi', 0.95),
    ROW('nhìn đâu cũng thấy khó', 0.85),
    ROW('khó tin vào điều tốt', 0.9),
    ROW('tự hỏi khi nào mới ổn', 0.85),
    ROW('sợ ngày mai cũng như hôm nay', 0.9),
    ROW('cảm giác không còn gì để mong chờ', 1.0),
    ROW('không còn động lực tin vào điều tốt', 0.9),
    ROW('lúc nào cũng thấy mệt mỏi trong lòng', 0.85),
    ROW('thấy cuộc sống cứ nặng trĩu', 0.9),
    ROW('không biết mọi thứ có thay đổi không', 0.9),
    ROW('hay nghĩ đến chuyện bỏ cuộc', 1.0),
    ROW('khó đứng dậy sau nhiều chuyện', 0.9),
    ROW('cảm giác thiếu chỗ bấu víu', 0.95),
    ROW('cần ai đó nói mọi thứ sẽ ổn', 0.9),
    ROW('thấy tương lai toàn màu xám', 0.95),
    ROW('cảm giác hụt chân', 0.85),
    ROW('lòng cứ xuống dốc', 0.9),
    ROW('cảm giác không ai hiểu được mình đang trải qua gì', 0.9),
    ROW('tâm trạng rơi tự do', 0.9),
    ROW('không thấy gì để mong chờ phía trước', 1.0),
    ROW('cảm giác bị bỏ lại phía sau', 0.85),
    ROW('thấy tương lai xa vời', 0.85),
    ROW('nỗi buồn khó mà nguôi', 0.9),
    ROW('mọi thứ vượt ngoài tầm kiểm soát', 0.9),
    ROW('tâm trạng xuống đáy', 0.9),
    ROW('cảm giác muốn biến mất cho nhẹ', 1.0)

    ROW('feeling stuck forever', 1.0),
    ROW('can’t see a way out', 1.0),
    ROW('everything feels dark', 0.95),
    ROW('future looks blurry', 0.9),
    ROW('feeling helpless', 0.95),
    ROW('don’t know if things will get better', 0.95),
    ROW('losing trust in myself', 0.9),
    ROW('things keep getting worse', 0.9),
    ROW('emotionally exhausted', 0.85),
    ROW('nothing feels okay anymore', 0.9),
    ROW('can’t imagine things improving', 0.95),
    ROW('feeling weighed down', 0.85),
    ROW('everything feels heavy', 0.9),
    ROW('feeling like giving up', 1.0),
    ROW('can’t hold on anymore', 1.0),
    ROW('running out of strength', 0.9),
    ROW('don’t know how much longer I can keep going', 1.0),
    ROW('feeling overwhelmed', 0.9),
    ROW('future feels empty', 0.9),
    ROW('everything seems pointless lately', 0.95),
    ROW('struggling to stay positive', 0.9),
    ROW('hard to believe things will be okay', 0.95),
    ROW('stuck in a dark place', 1.0),
    ROW('feel like nothing will change', 0.95),
    ROW('lost all sense of direction emotionally', 0.9),
    ROW('feel like I’m drowning', 0.95),
    ROW('can’t find anything to look forward to', 1.0),
    ROW('emotionally drained', 0.85),
    ROW('feeling left behind', 0.85),
    ROW('heart feels heavy', 0.9),
    ROW('don’t know how to get back up', 0.9),
    ROW('everything feels too much', 0.9),
    ROW('having a hard time holding myself together', 0.9),
    ROW('feeling like I’m falling apart', 0.95),
    ROW('don’t see any light ahead', 1.0),
    ROW('wish someone could tell me it’ll be okay', 0.9),
    ROW('future feels too far away', 0.8),
    ROW('feeling lost emotionally', 0.85),
    ROW('hard to keep faith in anything', 0.9),
    ROW('struggling silently', 0.85),
    ROW('everything feels unstable', 0.85),
    ROW('it’s been rough for a long time', 0.9),
    ROW('don’t know how to cope anymore', 0.95),
    ROW('everything feels uncertain in a bad way', 0.9),
    ROW('feeling emotionally cold', 0.8),
    ROW('feeling disconnected from life', 0.9),
    ROW('nothing excites me anymore', 0.85),
    ROW('feeling empty inside', 0.9),
    ROW('feeling like I don’t belong anywhere', 0.85)
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

    ROW('không biết mình cần gì', 0.95),
    ROW('không hiểu cảm xúc của mình', 0.95),
    ROW('thấy khó diễn tả', 0.8),
    ROW('không rõ mình đang sao', 0.9),
    ROW('cảm xúc lẫn lộn', 0.9),
    ROW('tâm trạng mơ hồ', 0.9),
    ROW('thấy hơi kì kì', 0.75),
    ROW('không biết mình muốn gì', 0.9),
    ROW('cảm giác lạ lạ', 0.75),
    ROW('không gọi tên được cảm xúc', 0.9),
    ROW('hơi bối rối về cảm xúc', 0.85),
    ROW('không rõ điều mình thiếu', 0.85),
    ROW('khó hiểu chính mình', 0.9),
    ROW('không biết chuyện gì đang xảy ra bên trong', 0.95),
    ROW('cảm giác mông lung', 0.9),
    ROW('không chắc mình đang buồn hay mệt', 0.85),
    ROW('lòng hơi mơ màng', 0.8),
    ROW('trong người cứ sao sao', 0.8),
    ROW('khó diễn đạt cho ai nghe', 0.85),
    ROW('không biết bắt đầu từ đâu', 0.8),
    ROW('cảm xúc bị rối tung', 0.9),
    ROW('thấy không ổn nhưng không biết vì sao', 0.95),
    ROW('cảm thấy lạc trong cảm xúc', 0.9),
    ROW('tâm trạng trôi nổi', 0.85),
    ROW('khó xác định vấn đề', 0.9),
    ROW('mọi thứ trong đầu hơi lộn xộn', 0.9),
    ROW('không biết chuyện gì khiến mình vậy', 0.9),
    ROW('cảm giác không gọi tên', 0.9),
    ROW('thấy trống trống nhưng không rõ lý do', 0.9),
    ROW('cảm xúc không thẳng hàng', 0.85),
    ROW('đầu óc hơi mù mờ', 0.85),
    ROW('thấy mệt mà không hiểu tại sao', 0.9),
    ROW('cảm giác nửa buồn nửa không', 0.85),
    ROW('tâm trạng khó nắm bắt', 0.9),
    ROW('không chắc điều mình đang tìm', 0.85),
    ROW('không rõ mình cần ai hay cần gì', 0.9),
    ROW('không tìm được từ diễn tả', 0.85),
    ROW('hơi bất ổn trong lòng nhưng không rõ lý do', 0.9),
    ROW('cảm giác lệch nhịp', 0.8),
    ROW('kiểu… không biết nói sao', 0.75),

    ROW('i dont know what i need', 0.95),
    ROW('cant tell what im feeling', 0.95),
    ROW('my emotions feel blurry', 0.9),
    ROW('feeling weird but not sure why', 0.85),
    ROW('something feels off', 0.9),
    ROW('not sure whats wrong', 0.9),
    ROW('cant put it into words', 0.85),
    ROW('mixed feelings', 0.85),
    ROW('confused inside', 0.9),
    ROW('not sure whats going on with me', 0.95),
    ROW('dont know how to describe it', 0.85),
    ROW('emotionally unsure', 0.9),
    ROW('cant name the feeling', 0.9),
    ROW('something is bothering me but i dont know what', 0.95),
    ROW('mood feels undefined', 0.9),
    ROW('emotionally messy', 0.9),
    ROW('my mind feels foggy', 0.85),
    ROW('cant figure myself out', 0.9),
    ROW('feeling off balance', 0.85),
    ROW('cant explain what is happening', 0.85),
    ROW('not exactly sad not exactly okay', 0.85),
    ROW('dont know what im missing', 0.9),
    ROW('vague emotional discomfort', 0.9),
    ROW('not sure what im looking for', 0.85),
    ROW('feeling a bit lost inside', 0.9),
    ROW('something doesnt feel right', 0.9),
    ROW('emotions feel tangled', 0.9),
    ROW('everything feels unclear', 0.9),
    ROW('hard to understand myself', 0.9),
    ROW('feeling unsettled', 0.85),
    ROW('not sure what i want', 0.9),
    ROW('i feel weirdly neutral', 0.8),
    ROW('i dont know what this feeling is', 0.9),
    ROW('hard to tell how i feel', 0.9),
    ROW('just confused emotionally', 0.9),
    ROW('feeling neither good nor bad', 0.8),
    ROW('cant figure out the problem', 0.9),
    ROW('my mind feels unfocused', 0.85),
    ROW('cant define my mood', 0.9),
    ROW('i just feel weird', 0.8)
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
   60, 5, 'emotional'),

  ('question_value_check', 'Xác định giá trị cá nhân', 'Giúp tìm lại định hướng và mục tiêu', 
   'question', 3, 2, 3, 'Điều gì quan trọng nhất với bạn hiện tại, và bạn có thể làm gì nhỏ để tiến gần hơn?', 
   'Tăng định hướng và ý nghĩa sống', 
   '{"emotion":"confused"}', '{"emotion":"purposeful"}', 
   120, 3, 'emotional');


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
  ROW('khó thở', 1.0),
  ROW('nghẹt thở', 1.0),
  ROW('không thở được', 1.0),
  ROW('hụt hơi', 0.95),
  ROW('thở gấp', 0.95),
  ROW('thở dồn dập', 0.95),
  ROW('thở không đều', 0.9),
  ROW('không lấy được hơi', 1.0),
  ROW('thở nông', 0.9),
  ROW('muốn hít sâu mà không được', 0.9),
  ROW('tim đập nhanh', 0.9),
  ROW('tim đập loạn', 0.9),
  ROW('tim muốn văng ra', 0.85),
  ROW('hồi hộp mạnh', 0.85),
  ROW('đánh trống ngực', 0.9),
  ROW('nhịp tim tăng', 0.85),
  ROW('tim đập dồn', 0.85),
  ROW('tim đập không kiểm soát', 0.9),
  ROW('hồi hộp dữ dội', 0.85),
  ROW('tim đập liên tục', 0.85),
  ROW('tức ngực', 0.95),
  ROW('nặng ngực', 0.9),
  ROW('bó ngực', 0.9),
  ROW('ép ngực', 0.9),
  ROW('nghẹn ở ngực', 0.9),
  ROW('đau ngực vì lo', 0.85),
  ROW('ngực bị siết', 0.9),
  ROW('khó chịu ở ngực', 0.85),
  ROW('cảm giác nghẹt ngực', 0.95),
  ROW('thở bị chặn', 0.9),
  ROW('hoảng', 0.85),
  ROW('hoảng loạn', 0.9),
  ROW('hoảng quá', 0.85),
  ROW('sợ quá không thở được', 1.0),
  ROW('bấn loạn', 0.85),
  ROW('cuống', 0.8),
  ROW('rối vì hoảng', 0.8),
  ROW('lo đến mức khó thở', 0.9),
  ROW('không kịp thở', 0.95),
  ROW('hoảng cấp', 0.9),
  ROW('làm sao để thở lại', 1.0),
  ROW('giúp mình thở', 1.0),
  ROW('làm sao để hít thở bình thường', 0.95),
  ROW('cách thở cho đỡ hoảng', 0.95),
  ROW('thở sao cho đỡ lo', 0.9),
  ROW('giúp mình bình tĩnh lại ngay', 0.9),
  ROW('cần thở lại', 1.0),
  ROW('thở thế nào cho đỡ sợ', 0.9),
  ROW('không kiểm soát được hơi thở', 1.0),
  ROW('cần lấy lại nhịp thở', 0.95),
  ROW('mệt mỏi vì căng thẳng', 0.6),
  ROW('stress kéo dài', 0.8),
  ROW('lo lắng không rõ lý do', 0.65),
  ROW('cảm giác bất an', 0.65),
  ROW('khó chịu trong người', 0.65),
  ROW('không thở thoải mái', 0.65),
  ROW('cần hít thở sâu', 0.7),
  ROW('cần bình tĩnh lại ngay', 0.7),
  ROW('muốn làm dịu cơ thể', 0.7),
  ROW('muốn giảm căng thẳng', 0.7),
  ROW('cảm giác quá tải cảm xúc', 0.7),
  ROW('thở nông', 0.75),
  ROW('cảm giác thiếu không khí', 0.75),
  ROW('áp lực trong người', 0.8),
  ROW('stress nặng', 0.8),

  ROW('cant calm down', 0.85),
  ROW('very restless', 0.85),
  ROW('body feels tense', 0.85),
  ROW('on edge constantly', 0.85),
  ROW('shaking a bit', 0.85),
  ROW('can’t breathe', 1.0),
  ROW('short of breath', 0.95),
  ROW('struggling to breathe', 1.0),
  ROW('breathing too fast', 0.95),
  ROW('shallow breathing', 0.9),
  ROW('gasping for air', 1.0),
  ROW('breath feels stuck', 0.95),
  ROW('can’t get enough air', 1.0),
  ROW('breathing feels wrong', 0.9),
  ROW('out of breath', 0.9),
  ROW('heart racing', 0.9),
  ROW('pounding heart', 0.9),
  ROW('heart beating fast', 0.9),
  ROW('rapid heartbeat', 0.9),
  ROW('palpitations', 0.9),
  ROW('heart won’t slow down', 0.95),
  ROW('racing pulse', 0.85),
  ROW('heartbeat out of control', 0.9),
  ROW('heart feels loud', 0.85),
  ROW('chest pounding', 0.85),
  ROW('tight chest', 0.95),
  ROW('chest pressure', 0.9),
  ROW('chest feels heavy', 0.9),
  ROW('chest feels tight', 0.95),
  ROW('pressure in my chest', 0.9),
  ROW('chest feels squeezed', 0.9),
  ROW('chest discomfort from anxiety', 0.85),
  ROW('tightness in chest', 0.95),
  ROW('chest feels blocked', 0.9),
  ROW('breathing blocked in chest', 0.95),
  ROW('panic', 0.85),
  ROW('panicking', 0.9),
  ROW('panic attack', 1.0),
  ROW('panic rising', 0.9),
  ROW('sudden panic', 0.9),
  ROW('panic wave', 0.85),
  ROW('intense panic', 0.9),
  ROW('panic spike', 0.85),
  ROW('losing control of my body', 0.9),
  ROW('body won’t calm down', 0.9),
  ROW('help me breathe', 1.0),
  ROW('how do I breathe', 1.0),
  ROW('help me calm my breathing', 0.95),
  ROW('how to slow my breathing', 0.95),
  ROW('I need to breathe properly', 0.95),
  ROW('I need help breathing', 1.0),
  ROW('breathing help now', 1.0),
  ROW('help me stop panicking physically', 0.95),
  ROW('how to calm my body fast', 0.95),
  ROW('need to slow my breath', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('bình tĩnh hơn', 1.0),
  ROW('thả lỏng hơn', 1.0),
  ROW('mình bình tĩnh hơn rồi', 1.0),
  ROW('thở dễ hơn rồi', 1.0),
  ROW('đỡ căng thẳng hơn', 0.95),
  ROW('cảm giác nhẹ hơn', 0.95),
  ROW('đỡ nhiều rồi', 0.95),
  ROW('đỡ hơn rồi', 0.85),
  ROW('đỡ một chút', 0.8),
  ROW('tim không đập nhanh nữa', 0.95),
  ROW('ổn hơn rồi', 0.95),
  ROW('cơ thể dịu lại', 0.9),
  ROW('hơi thở chậm lại', 0.9),
  ROW('đầu óc dễ chịu hơn', 0.9),
  ROW('không còn hoảng nữa', 0.9),
  ROW('đỡ lo', 0.8),
  ROW('bớt lo lắng', 0.8),
  ROW('người bớt căng', 0.9),
  ROW('cảm giác an toàn hơn', 0.9),
  ROW('thở sâu được rồi', 0.9),
  ROW('mình kiểm soát được nhịp thở', 0.9),
  ROW('cơ thể thư giãn hơn', 0.85),
  ROW('mình chậm lại rồi', 0.85),
  ROW('nhịp tim ổn định hơn', 0.85),
  ROW('mình thấy dễ chịu hơn', 0.85),
  ROW('không còn nghẹt thở', 0.85),
  ROW('mình thả lỏng được rồi', 0.85),
  ROW('bớt áp lực trong người', 0.85),
  ROW('mình cảm thấy ok hơn', 0.85),
  ROW('hơi thở đều hơn', 0.85),
  ROW('cảm giác căng giảm xuống', 0.85),
  ROW('mình ổn hơn lúc nãy', 0.8),
  ROW('bớt run rồi', 0.8),
  ROW('không còn quá lo', 0.8),
  ROW('cơ thể không còn căng cứng', 0.8),
  ROW('dễ thở hơn nhiều', 0.9),
  ROW('cảm giác bình ổn hơn', 0.8),
  ROW('thấy nhẹ người', 0.8),
  ROW('đầu óc không còn rối', 0.8),
  ROW('thở bình thường lại rồi', 0.8),
  ROW('kiểm soát được cơ thể', 0.8),
  ROW('thấy ổn hơn một chút', 0.75),
  ROW('có tác dụng', 0.8),
  ROW('bài thở giúp mình', 0.75),
  ROW('mình cảm thấy tốt hơn', 0.75),
  ROW('mình đỡ căng nhiều rồi', 0.75),
  ROW('mình sẵn sàng làm tiếp', 0.7),
  ROW('mình có thể tiếp tục', 0.7),
  ROW('giờ mình ổn hơn', 0.8),
  ROW('mình thấy dễ chịu đủ rồi', 0.8),
  ROW('có thể nói chuyện tiếp', 0.7),

  ROW('feel calmer', 1.0),
  ROW('calmer', 1.0),
  ROW('more relax', 1.0),
  ROW('breathing feels easier', 1.0),
  ROW('my body feels calmer', 0.95),
  ROW('heart rate slowed down', 0.95),
  ROW('i feel more relaxed', 0.95),
  ROW('i am okay now', 0.95),
  ROW('the panic passed', 0.95),
  ROW('i can breathe normally again', 0.95),
  ROW('able to breath', 0.96),
  ROW('i feel steadier', 0.95),
  ROW('less anxious', 0.95),
  ROW('my chest feels lighter', 0.9),
  ROW('my breathing is slower', 0.9),
  ROW('more in control', 0.9),
  ROW('my body settled down', 0.9),
  ROW('not panicking anymore', 0.9),
  ROW('feel safer', 0.9),
  ROW('my muscles relaxed', 0.9),
  ROW('i feel grounded enough', 0.9),
  ROW('more comfortable', 0.9),
  ROW('that helped a lot', 0.9),
  ROW('feel much better', 0.85),
  ROW('my heartbeat is normal again', 0.85),
  ROW('calmer than before', 0.85),
  ROW('i can think more clearly now', 0.85),
  ROW('i feel okay again', 0.85),
  ROW('breathing worked', 0.85),
  ROW('i feel relaxed enough', 0.85),
  ROW('the tension reduced', 0.85),
  ROW('my body feels lighter', 0.85),
  ROW('i feel more balanced', 0.85),
  ROW('i feel stable now', 0.8),
  ROW('the stress eased', 0.8),
  ROW('i am not overwhelmed anymore', 0.8),
  ROW('i feel regulated', 0.8),
  ROW('i am breathing comfortably', 0.8),
  ROW('i feel a bit better now', 0.75),
  ROW('this helped me calm down', 0.75),
  ROW('i feel okay to continue', 0.75),
  ROW('i am ready for the next step', 0.75),
  ROW('i feel settled enough', 0.75),
  ROW('we can keep going', 0.7),
  ROW('i am good for now', 0.7),
  ROW('i can talk now', 0.7),
  ROW('i am stable enough', 0.7),
  ROW('ready to move on', 0.7)
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
  ROW('thở không giúp gì', 1.0),
  ROW('mình thở mà không đỡ', 1.0),
  ROW('càng thở càng khó chịu', 0.95),
  ROW('thở làm mình căng hơn', 0.95),
  ROW('mình không thấy hiệu quả', 0.95),
  ROW('mình thấy tệ hơn', 0.95),
  ROW('thở làm mình bồn chồn', 0.95),
  ROW('không tập trung vào hơi thở được', 0.95),
  ROW('thở khiến mình hoảng hơn', 0.95),
  ROW('không kiểm soát được hơi thở', 0.95),
  ROW('mình thấy trôi đi', 0.75),
  ROW('mình không ở đây', 0.75),
  ROW('mình bị tách ra', 0.75),
  ROW('cảm giác không thật', 0.85),
  ROW('thở làm mình choáng', 0.9),
  ROW('mình thấy đầu óc mờ đi', 0.9),
  ROW('mình không cảm nhận được cơ thể', 0.9),
  ROW('thở làm mình mất tập trung', 0.9),
  ROW('mình thấy lơ lửng', 0.9),
  ROW('mình không giữ được sự chú ý', 0.9),
  ROW('mình thấy khó chịu hơn', 0.85),
  ROW('thở khiến mình lo hơn', 0.85),
  ROW('không muốn tiếp tục thở kiểu này', 0.85),
  ROW('thấy không ổn khi thở', 0.85),
  ROW('thấy bất an hơn', 0.85),
  ROW('thở không hợp với mình', 0.85),
  ROW('không sẵn sàng cho bài thở', 0.85),
  ROW('thấy không an toàn khi thở sâu', 0.85),
  ROW('thấy mất kiểm soát', 0.85),
  ROW('thở làm mình căng người', 0.85),
  ROW('không muốn tiếp tục', 0.8),
  ROW('bài thở không phù hợp', 0.8),
  ROW('cần cách khác', 0.85),
  ROW('thở không phải lúc này', 0.8),
  ROW('thấy quá tải khi thở', 0.8),
  ROW('cần làm gì đó khác', 0.85),
  ROW('không thể làm bài thở', 0.75),
  ROW('thở làm mình rối hơn', 0.85),
  ROW('không thấy dễ chịu', 0.75),
  ROW('muốn dừng lại', 0.75),

  ROW('breathing does not help', 1.0),
  ROW('this isnt helping', 1.0),
  ROW('breathing makes it worse', 0.95),
  ROW('i feel worse when i breathe', 0.95),
  ROW('this is not working', 0.95),
  ROW('it makes me more anxious', 0.95),
  ROW('i cant focus on breathing', 0.95),
  ROW('breathing increases panic', 0.95),
  ROW('i cant control my breath', 0.95),
  ROW('this feels uncomfortable', 0.95),
  ROW('i feel disconnected', 0.9),
  ROW('i am zoning out', 0.9),
  ROW('i dont feel present', 0.9),
  ROW('everything feels unreal', 0.9),
  ROW('breathing makes me dizzy', 0.9),
  ROW('my mind feels foggy', 0.9),
  ROW('i cant feel my body', 0.9),
  ROW('i feel detached', 0.9),
  ROW('i feel like im drifting', 0.9),
  ROW('i lose focus quickly', 0.9),
  ROW('i feel more uncomfortable', 0.85),
  ROW('this makes me uneasy', 0.85),
  ROW('i dont want to keep doing this', 0.85),
  ROW('this doesnt feel safe', 0.85),
  ROW('i feel less in control', 0.85),
  ROW('breathing is not for me right now', 0.85),
  ROW('i am not ready for breathing exercises', 0.85),
  ROW('this technique does not fit', 0.85),
  ROW('i feel overwhelmed doing this', 0.85),
  ROW('my body resists this', 0.85),
  ROW('i want to stop', 0.8),
  ROW('i need a different approach', 0.8),
  ROW('this is too much', 0.8),
  ROW('breathing is not helping now', 0.8),
  ROW('i need another way', 0.8),
  ROW('i cannot continue', 0.75),
  ROW('this feels wrong for me', 0.75),
  ROW('i dont feel better', 0.9),
  ROW('i want to pause', 0.75),
  ROW('lets try something else', 0.85)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_breathing_478'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử hít thở sâu một chút không', 1.0),
  ROW('chúng ta có thể thử thở chậm lại cùng nhau không', 1.0),
  ROW('bạn đã thử tập trung vào hơi thở chưa', 1.0),
  ROW('mình thử thở sâu vài nhịp nhé', 0.95),
  ROW('bạn có muốn làm một bài thở ngắn không', 0.95),

  ROW('bạn có thể thử hít vào thật chậm và thở ra từ từ', 0.95),
  ROW('mình có thể hướng dẫn bạn thở nếu bạn muốn', 0.95),
  ROW('bạn muốn thử một cách thở nhẹ nhàng không', 0.95),
  ROW('chúng ta thử làm dịu cơ thể bằng hơi thở nhé', 0.95),
  ROW('bạn có sẵn sàng thử một bài thở đơn giản không', 0.95),

  ROW('nếu được, bạn hãy thử chú ý vào nhịp thở', 0.9),
  ROW('bạn có thể thở chậm hơn một chút được không', 0.9),
  ROW('mình thử thở sâu trong vài giây nhé', 0.9),
  ROW('bạn muốn thử làm dịu nhịp thở không', 0.9),
  ROW('bạn có thể thử thở theo nhịp mình hướng dẫn', 0.9),

  ROW('không cần cố gắng, chỉ cần thở chậm lại thôi', 0.9),
  ROW('mình cùng thở nhẹ nhàng nhé', 0.9),
  ROW('bạn có muốn tập trung vào hơi thở ngay lúc này không', 0.9),
  ROW('nếu thấy ổn, bạn hãy thử thở sâu hơn một chút', 0.9),
  ROW('bạn có thể cho cơ thể nghỉ bằng cách thở chậm', 0.9),

  ROW('mình có một bài thở ngắn, bạn muốn thử không', 0.85),
  ROW('bạn muốn thử một cách thở giúp giảm căng thẳng không', 0.85),
  ROW('bạn có thể thử thở ra dài hơn hít vào', 0.85),
  ROW('mình sẽ ở đây hướng dẫn bạn thở', 0.85),
  ROW('bạn có muốn làm dịu nhịp tim bằng hơi thở không', 0.85),

  ROW('nếu bạn muốn, ta có thể bắt đầu bằng một hơi thở sâu', 0.85),
  ROW('bạn có thể thử thở chậm trong vài giây tới', 0.85),
  ROW('mình thử một bài thở rất nhẹ nhé', 0.85),
  ROW('bạn có sẵn sàng dành một chút để thở không', 0.85),
  ROW('bạn có thể thở cùng mình ngay bây giờ', 0.85),

  ROW('không cần đúng hay sai, chỉ cần thở đều thôi', 0.8),
  ROW('mình có thể hướng dẫn bạn thở theo nhịp', 0.8),
  ROW('bạn có muốn làm dịu cơ thể trước không', 0.8),
  ROW('mình thử thở chậm trong vài nhịp nhé', 0.8),
  ROW('bạn có thể dừng lại và chú ý vào hơi thở', 0.8),

  ROW('nếu bạn đồng ý, mình bắt đầu bài thở nhé', 0.75),
  ROW('bạn có muốn thử bây giờ không', 0.75),
  ROW('chúng ta có thể thử một chút thôi', 0.75),
  ROW('bạn muốn mình hướng dẫn thở chứ', 0.75),
  ROW('mình bắt đầu nhẹ nhàng nhé', 0.75),

  ROW('would you like to try taking a deep breath', 1.0),
  ROW('can we slow your breathing together', 1.0),
  ROW('have you tried focusing on your breath', 1.0),
  ROW('lets try a slow breath together', 0.95),
  ROW('would you like to do a short breathing exercise', 0.95),

  ROW('you can try breathing in slowly and out gently', 0.95),
  ROW('i can guide your breathing if you want', 0.95),
  ROW('would you like to try a gentle breathing technique', 0.95),
  ROW('lets help your body calm down with breathing', 0.95),
  ROW('are you open to trying a simple breathing exercise', 0.95),

  ROW('if it feels okay, notice your breath', 0.9),
  ROW('can you try slowing your breath a little', 0.9),
  ROW('lets take a slow breath for a few seconds', 0.9),
  ROW('would you like to calm your breathing now', 0.9),
  ROW('you can try breathing at the pace i suggest', 0.9),

  ROW('no need to force it, just slow the breath', 0.9),
  ROW('lets breathe gently together', 0.9),
  ROW('are you okay focusing on your breath right now', 0.9),
  ROW('if it feels safe, try a deeper breath', 0.9),
  ROW('you can give your body a break by breathing slowly', 0.9),

  ROW('i have a short breathing exercise if you want', 0.85),
  ROW('would you like to try breathing to reduce tension', 0.85),
  ROW('you could try making the exhale longer', 0.85),
  ROW('i will stay with you while you breathe', 0.85),
  ROW('do you want to use breathing to slow your heart rate', 0.85),

  ROW('if you agree, we can start with one slow breath', 0.85),
  ROW('you can try slowing your breath for a few moments', 0.85),
  ROW('lets try a very gentle breathing exercise', 0.85),
  ROW('are you willing to spend a moment breathing', 0.85),
  ROW('you can breathe along with me now', 0.85),

  ROW('there is no right or wrong way to breathe', 0.8),
  ROW('i can guide you through the breathing', 0.8),
  ROW('would you like to calm your body first', 0.8),
  ROW('lets slow the breath for a few cycles', 0.8),
  ROW('you can pause and focus on breathing', 0.8),

  ROW("if you're okay with it, we can begin now", 0.75),
  ROW('would you like to try this now', 0.75),
  ROW('we can try just a little', 0.75),
  ROW('do you want me to guide your breathing', 0.75),
  ROW('lets start gently', 0.75)
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
  ROW('mất kiểm soát', 0.9),
  ROW('không ngừng nghĩ về chuyện đó', 1.0),
  ROW('ý nghĩ cứ lặp lại', 1.0),
  ROW('bị cuốn vào suy nghĩ', 1.0),
  ROW('đầu óc không chịu dừng lại', 1.0),
  ROW('không thoát ra được khỏi suy nghĩ', 1.0),
  ROW('cứ nghĩ mãi', 0.95),
  ROW('ý nghĩ tiêu cực cứ quay lại', 0.95),
  ROW('không kiểm soát được dòng suy nghĩ', 0.95),
  ROW('bị mắc kẹt trong đầu', 0.95),
  ROW('không tập trung được vì suy nghĩ', 0.95),
  ROW('bị ám ảnh bởi chuyện đó', 0.9),
  ROW('cứ nhớ lại mãi', 0.9),
  ROW('không ngừng lo sợ', 0.9),
  ROW('nỗi sợ cứ hiện lên', 0.9),
  ROW('ký ức đó cứ quay lại', 0.9),
  ROW('đang bị cuốn vào nỗi sợ', 0.9),
  ROW('không thoát được khỏi lo lắng', 0.9),
  ROW('cứ tưởng tượng điều xấu', 0.9),
  ROW('đầu óc đầy những suy nghĩ không mong muốn', 0.9),
  ROW('bị ngập trong suy nghĩ', 0.9),
  ROW('không ở trong hiện tại', 0.85),
  ROW('không chú ý được xung quanh', 0.85),
  ROW('bị kéo về những chuyện cũ', 0.85),
  ROW('đang sống trong đầu', 0.85),
  ROW('không tập trung vào bây giờ', 0.85),
  ROW('cần phân tán đầu óc', 0.85),
  ROW('muốn thoát khỏi suy nghĩ này', 0.85),
  ROW('muốn ngừng nghĩ', 0.85),
  ROW('cần kéo bản thân ra khỏi nỗi sợ', 0.85),
  ROW('cần chú ý vào cái khác', 0.85),
  ROW('bị cuốn vào ký ức', 0.8),
  ROW('cứ nhớ lại chuyện không vui', 0.8),
  ROW('đầu óc bị chiếm hết', 0.8),
  ROW('đang mắc kẹt trong lo lắng', 0.8),
  ROW('không rời được khỏi suy nghĩ đó', 0.8),
  ROW('cần kéo sự chú ý ra ngoài', 0.8),
  ROW('cần quay lại thực tại', 0.8),
  ROW('không thể ngừng suy nghĩ', 0.8),
  ROW('bị cuốn vào trí nhớ', 0.8),
  ROW('không thoát khỏi đầu mình được', 0.8),
  ROW('cần bám vào hiện tại', 0.8),
  ROW('muốn đầu óc yên lại', 0.75),
  ROW('đang bị suy nghĩ dẫn đi', 0.8),
  ROW('không ngắt được dòng suy nghĩ', 0.85),
  ROW('cần kéo mình về bây giờ', 0.85),

  ROW('i cant stop thinking about it', 1.0),
  ROW('the thoughts keep looping', 1.0),
  ROW('my mind is stuck on this', 1.0),
  ROW('my thoughts wont slow down', 1.0),
  ROW('i cant get out of my head', 1.0),
  ROW('i keep thinking about it', 0.95),
  ROW('the thoughts keep coming back', 0.95),
  ROW('i cant control my thoughts', 0.95),
  ROW('i feel trapped in my mind', 0.95),
  ROW('i cant focus because of my thoughts', 0.95),
  ROW('i feel stuck on this fear', 0.9),
  ROW('i keep replaying it in my head', 0.9),
  ROW('i cant stop worrying', 0.9),
  ROW('the fear keeps popping up', 0.9),
  ROW('the memory keeps coming back', 0.9),
  ROW('im getting pulled into fear', 0.9),
  ROW('i cant escape the worry', 0.9),
  ROW('i keep imagining bad things', 0.9),
  ROW('my mind is full of unwanted thoughts', 0.9),
  ROW('i feel flooded with thoughts', 0.9),
  ROW('im not in the present moment', 0.85),
  ROW('i cant pay attention to whats around me', 0.85),
  ROW('my mind keeps going back to the past', 0.85),
  ROW('im living in my head', 0.85),
  ROW('i cant focus on right now', 0.85),
  ROW('i need to distract my mind', 0.85),
  ROW('i want to break out of this thought', 0.85),
  ROW('i want my thoughts to stop', 0.85),
  ROW('i need to pull myself out of fear', 0.85),
  ROW('i need to focus on something else', 0.85),
  ROW('im stuck in memories', 0.8),
  ROW('i keep thinking about something upsetting', 0.8),
  ROW('my mind feels taken over', 0.8),
  ROW('im trapped in worry', 0.8),
  ROW('i cant let go of the thought', 0.8),
  ROW('i need to shift my attention', 0.8),
  ROW('i need to come back to the present', 0.8),
  ROW('i cant stop my mind', 0.8),
  ROW('im stuck in my thoughts', 0.8),
  ROW('i cant get out of my headspace', 0.8),
  ROW('i need to anchor to the present', 0.85),
  ROW('i want my mind to calm down', 0.75),
  ROW('my thoughts are pulling me away', 0.8),
  ROW('i cant interrupt the thought loop', 0.8),
  ROW('i need to ground myself', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('ổn hơn', 1.0),
  ROW('ổn định lại', 1.0),
  ROW('bớt căng thẳng', 1.0),
  ROW('thấy đỡ hơn rồi', 1.0),
  ROW('đầu óc mình bớt rối hơn', 1.0),
  ROW('quay lại hiện tại được rồi', 1.0),
  ROW('cảm thấy đang ở đây', 1.0),
  ROW('không còn bị cuốn vào suy nghĩ nữa', 1.0),
  ROW('bình tĩnh hơn rồi', 0.95),
  ROW('cảm thấy ổn hơn', 0.95),
  ROW('đầu óc nhẹ ra', 0.95),
  ROW('tập trung lại được rồi', 0.95),
  ROW('không còn bị ngập trong suy nghĩ', 0.95),
  ROW('chú ý được xung quanh rồi', 0.9),
  ROW('cảm nhận được môi trường xung quanh', 0.9),
  ROW('thấy mình đang ở trong phòng', 0.9),
  ROW('thấy mọi thứ rõ ràng hơn', 0.9),
  ROW('không còn bị kéo đi nữa', 0.9),
  ROW('nỗi sợ dịu xuống rồi', 0.9),
  ROW('ý nghĩ không còn mạnh như trước', 0.9),
  ROW('kiểm soát được sự chú ý hơn', 0.9),
  ROW('bớt hoảng rồi', 0.9),
  ROW('không còn chìm trong đầu mình', 0.9),
  ROW('đang ở hiện tại', 0.85),
  ROW('cảm thấy vững hơn', 0.85),
  ROW('đã kéo bản thân về lại', 0.85),
  ROW('thấy an toàn hơn', 0.85),
  ROW('không còn bị suy nghĩ dẫn đi', 0.85),
  ROW('nhìn thấy xung quanh rõ hơn', 0.8),
  ROW('nghe được âm thanh xung quanh', 0.8),
  ROW('cảm nhận được cơ thể', 0.8),
  ROW('đang chú ý vào những thứ trước mắt', 0.8),
  ROW('không còn quá tải nữa', 0.8),
  ROW('cảm thấy đầu óc yên lại', 0.8),
  ROW('đã ngắt được dòng suy nghĩ', 0.8),
  ROW('không còn bị mắc kẹt', 0.8),
  ROW('đã bám được vào hiện tại', 0.8),
  ROW('thấy ổn trong lúc này', 0.8),
  ROW('thấy dễ chịu hơn trong người', 0.75),
  ROW('không còn bị kéo về nỗi sợ nữa', 0.75),
  ROW('đang chú ý vào thực tế', 0.75),
  ROW('quay lại với xung quanh', 0.75),
  ROW('thấy mọi thứ bình thường hơn', 0.75),
  ROW('không còn bị cuốn theo ký ức', 0.75),
  ROW('đang tập trung vào hiện tại', 0.75),
  ROW('thấy đầu óc bớt căng', 0.75),
  ROW('thấy nhẹ hơn so với lúc nãy', 0.75),
  ROW('có thể tiếp tục được rồi', 0.75),
  ROW('đầu óc yên hơn', 0.9),
  ROW('không còn suy nghĩ lung tung', 0.9),
  ROW('ý nghĩ đã dịu xuống', 0.9),
  ROW('không còn bị suy nghĩ làm choáng', 0.9),
  ROW('đầu óc bớt ồn', 0.9),
  ROW('ngắt được vòng lặp suy nghĩ', 0.85),
  ROW('không còn bị cuốn vào trí nhớ', 0.85),
  ROW('suy nghĩ không còn lấn át nữa', 0.85),
  ROW('kiểm soát được sự chú ý', 0.85),
  ROW('cảm thấy đầu óc nhẹ ra', 0.85),
  ROW('giờ ổn hơn để làm tiếp', 0.8),
  ROW('sẵn sàng làm việc khác', 0.8),
  ROW('có thể quay lại việc đang làm', 0.8),
  ROW('thấy đủ ổn để tiếp tục', 0.8),
  ROW('có thể chuyển sang chuyện khác', 0.8),
  ROW('không cần làm thêm nữa', 0.8),
  ROW('đã ổn để dừng lại', 0.8),
  ROW('thấy làm được rồi', 0.8),
  ROW('đã quay lại trạng thái bình thường', 0.8),
  
  ROW('in the present', 0.9),
  ROW('feel here', 0.9),
  ROW('back in the moment', 1.0),
  ROW('no longer drifting', 1.0),
  ROW('here right now', 1.0),
  ROW('i feel present again', 0.95),
  ROW('aware of this moment', 0.95),
  ROW('back to now', 0.95),
  ROW('no longer pulled away', 0.95),
  ROW('brought myself back', 0.95),
  ROW('the thoughts arent pulling me anymore', 0.9),
  ROW('my mind isnt stuck anymore', 0.9),
  ROW('im out of the thought loop', 0.9),
  ROW('my thoughts have loosened', 0.9),
  ROW('im not trapped in my head', 0.9),
  ROW('my thoughts have slowed down', 0.85),
  ROW('the mental pull is weaker', 0.85),
  ROW('im not dragged into fear', 0.85),
  ROW('the thoughts arent overwhelming', 0.85),
  ROW('i broke out of that thought', 0.85),
  ROW('i can notice my surroundings', 0.9),
  ROW('i can hear sounds around me', 0.9),
  ROW('i can see things clearly', 0.9),
  ROW('i feel connected to my environment', 0.9),
  ROW('i know where i am', 0.9),
  ROW('i can feel my body again', 0.85),
  ROW('im aware of whats in front of me', 0.85),
  ROW('i can sense whats around me', 0.85),
  ROW('im connected to the space around me', 0.85),
  ROW('i feel grounded in my surroundings', 0.85),
  ROW('i feel more at ease', 0.9),
  ROW('i feel okay now', 0.9),
  ROW('i feel lighter', 0.9),
  ROW('im not as tense', 0.9),
  ROW('i feel steady', 0.9),
  ROW('my body feels calmer', 0.85),
  ROW('i feel more stable', 0.85),
  ROW('im not overwhelmed anymore', 0.85),
  ROW('i feel settled', 0.85),
  ROW('i feel alright in this moment', 0.85),
  ROW('i feel safer now', 0.9),
  ROW('im not panicking anymore', 0.9),
  ROW('things feel stable', 0.9),
  ROW('im not being swept away', 0.9),
  ROW('i feel anchored', 0.9),
  ROW('i feel supported by the present', 0.85),
  ROW('i feel secure where i am', 0.85),
  ROW('im not disoriented anymore', 0.85),
  ROW('i feel more in control', 0.85),
  ROW('i know im okay right now', 0.85),
   ROW('my mind feels quieter', 0.9),
  ROW('my thoughts are calmer', 0.9),
  ROW('the mental noise has reduced', 0.9),
  ROW('im not mentally overloaded', 0.9),
  ROW('my head feels clearer', 0.9),
  ROW('i interrupted the thought loop', 0.85),
  ROW('im not lost in memories', 0.85),
  ROW('my thoughts arent dominating', 0.85),
  ROW('i can direct my attention', 0.85),
  ROW('my mind feels lighter', 0.85),
  ROW('i can continue now', 0.8),
  ROW('i feel okay to move on', 0.8),
  ROW('im ready to do something else', 0.8),
  ROW('i can go back to what i was doing', 0.8),
  ROW('i feel stable enough to continue', 0.8),
  ROW('i can shift to another task', 0.8),
  ROW('i dont need more help right now', 0.8),
  ROW('i feel done with this step', 0.8),
  ROW('i feel capable again', 0.8),
  ROW('i feel back to normal', 0.8)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn căng thẳng', 1.0),
  ROW('chưa bình tĩnh hơn', 1.0),
  ROW('chưa bình tĩnh lại', 1.0), 
  ROW('chưa ổn định lại', 1.0), 
  ROW('chưa ổn định được', 1.0), 
  ROW('không thấy khác gì', 1.0),
  ROW('vẫn lo âu', 1.0),
  ROW('vẫn bồn chồn', 1.0),
  ROW('không tập trung được', 0.95),
  ROW('đầu óc vẫn rối', 0.95),
  ROW('cảm giác không thay đổi', 0.95),
  ROW('vẫn khó chịu', 0.95),
  ROW('vẫn hoảng', 0.95),
  ROW('cảm xúc vẫn dâng cao', 0.9),
  ROW('không giúp ích', 0.9),
  ROW('không hiệu quả', 0.9),
  ROW('vẫn bị cuốn theo suy nghĩ', 0.9),
  ROW('khó quay về hiện tại', 0.9),
  ROW('vẫn mất kiểm soát', 0.9),
  ROW('chưa giúp ổn hơn', 0.9),
  ROW('chưa thấy đỡ', 0.9),
  ROW('vẫn thấy ngợp', 0.9),
  ROW('vẫn không ổn', 0.9),
  ROW('ký ức vẫn ùa về', 0.85),
  ROW('suy nghĩ không dừng lại', 0.85),
  ROW('cảm giác tách rời vẫn còn', 0.85),
  ROW('vẫn thấy không thật', 0.85),
  ROW('vẫn bị cuốn khỏi thực tại', 0.85),
  ROW('vẫn bị kích hoạt', 0.85),
  ROW('cơ thể chưa dịu xuống', 0.85),
  ROW('tim vẫn đập nhanh', 0.85),
  ROW('căng người', 0.85),
  ROW('vẫn còn khó thở', 0.85),
  ROW('bài tập không giúp', 0.8),
  ROW('chưa kết nối lại được', 0.8),
  ROW('vẫn thấy bất an', 0.8),
  ROW('chưa thấy an toàn hơn', 0.8),
  ROW('cảm giác nguy hiểm vẫn còn', 0.8),
  ROW('không giúp quay lại hiện tại', 0.8),
  ROW('vẫn thấy lạc lõng', 0.8),
  ROW('vẫn bị ám ảnh', 0.8),
  ROW('khó giữ sự chú ý', 0.8),
  ROW('tâm trí vẫn chạy nhanh', 0.8),
  ROW('vẫn bị choáng', 0.75),
  ROW('vẫn khó chịu trong người', 0.75),
  ROW('cảm giác nặng nề vẫn còn', 0.75),
  ROW('chưa ổn định lại', 0.75),
  ROW('vẫn thấy căng cứng', 0.75),
  ROW('cảm giác tách rời vẫn còn', 0.85),        
  ROW('vẫn thấy không thật', 0.85),               -- 32
  ROW('vẫn như đang ở xa', 0.85),                 -- 33
  ROW('vẫn lạc khỏi hiện tại', 0.85),              -- 34
  ROW('khó cảm nhận môi trường', 0.85),            -- 35
  ROW('vẫn mơ hồ', 0.85),                          -- 36
  ROW('vẫn choáng', 0.85),                         -- 37
  ROW('chưa kết nối lại', 0.85),                   -- 38
  ROW('vẫn mất cảm giác hiện diện', 0.85),         -- 39
  ROW('vẫn bị trôi', 0.85),  
  ROW('bài tập không hiệu quả', 0.8),              -- 41
  ROW('không giúp quay lại hiện tại', 0.8),        -- 42
  ROW('không tạo cảm giác vững', 0.8),             -- 43
  ROW('vẫn không bám được thực tại', 0.8),         -- 44
  ROW('chưa giúp neo lại', 0.8),                   -- 45
  ROW('vẫn mất phương hướng', 0.8),                -- 46
  ROW('vẫn thấy lạc lõng', 0.8),                   -- 47
  ROW('vẫn không yên', 0.8),                       -- 48
  ROW('không giúp giảm sợ', 0.8),                  -- 49
  ROW('vẫn chưa ổn', 0.8),    
  ROW('vẫn bị quá tải', 0.75),                     -- 51
  ROW('cảm giác nặng nề vẫn còn', 0.75),           -- 52
  ROW('vẫn căng trong người', 0.75),               
  ROW('vẫn khó chịu bên trong', 0.75),             
  ROW('chưa dịu lại', 0.75),                       
  ROW('vẫn rối loạn', 0.75),                       
  ROW('vẫn chao đảo', 0.75),                       
  ROW('vẫn bất ổn', 0.75),                         
  ROW('chưa lấy lại cân bằng', 0.75),   
  ROW('cảm giác hiện diện chưa quay lại', 0.7),    
  ROW('vẫn không neo được', 0.7),                  
  ROW('vẫn xa rời thực tại', 0.7),                 
  ROW('vẫn khó đứng vững tinh thần', 0.7),         
  ROW('vẫn không bớt rối', 0.7),                   
  ROW('vẫn không dịu xuống', 0.7),                 
  ROW('vẫn bị kéo đi', 0.7),                       
  ROW('vẫn mất kết nối', 0.7),                     
  ROW('vẫn trống rỗng', 0.7),                      
  ROW('vẫn không ổn định lại', 0.7),           
  ROW('vẫn bị cuốn đi', 0.75), 

  ROW('still overwhelmed', 1.0),                   
  ROW('still anxious', 1.0),                       
  ROW('not calmer yet', 1.0),                      
  ROW('no improvement felt', 1.0),                 
  ROW('no change noticed', 1.0),                   
  ROW('still distressed', 1.0),                    
  ROW('still panicked', 1.0),                      
  ROW('not settled', 1.0),                         
  ROW('still uneasy', 1.0),                        
  ROW('grounding did not help', 1.0),               
  ROW('mind still racing', 0.95),                  
  ROW('thoughts still looping', 0.95),             
  ROW('unable to focus', 0.95),                    
  ROW('still not present', 0.95),                  
  ROW('attention still scattered', 0.95),          
  ROW('still out of control', 0.95),               
  ROW('still mentally flooded', 0.95),             
  ROW('still distracted', 0.95),                  
  ROW('still mentally overwhelmed', 0.95),         
  ROW('no mental relief', 0.95),                   
  ROW('memories still intruding', 0.9),            
  ROW('still triggered', 0.9),                     -- 22
  ROW('still pulled into thoughts', 0.9),          -- 23
  ROW('still unsafe', 0.9),                        -- 24
  ROW('sense of danger remains', 0.9),             -- 25
  ROW('still mentally stuck', 0.9),                -- 26
  ROW('still overwhelmed by images', 0.9),         -- 27
  ROW('still stuck in head', 0.9),                 -- 28
  ROW('unable to return to present', 0.9),         -- 29
  ROW('still absorbed in fear', 0.9),              -- 30
  ROW('still dissociated', 0.85),                  -- 31
  ROW('still detached', 0.85),                     -- 32
  ROW('feeling unreal remains', 0.85),             -- 33
  ROW('still spaced out', 0.85),                   -- 34
  ROW('still disconnected', 0.85),                 -- 35
  ROW('still floating', 0.85),                     -- 36
  ROW('not anchored', 0.85),                       -- 37
  ROW('still not grounded', 0.85),                 -- 38
  ROW('still distant from surroundings', 0.85),   -- 39
  ROW('still unreal feeling', 0.85),               -- 40
  ROW('exercise ineffective', 0.8),                -- 41
  ROW('grounding ineffective', 0.8),               -- 42
  ROW('no sense of stability', 0.8),               -- 43
  ROW('still unanchored', 0.8),                    -- 44
  ROW('still lost in moment', 0.8),                -- 45
  ROW('still disoriented', 0.8),                   -- 46
  ROW('still unsettled inside', 0.8),              -- 47
  ROW('still uncomfortable mentally', 0.8),       -- 48
  ROW('still emotionally overloaded', 0.8),       -- 49
  ROW('still not okay', 0.8),                      -- 50
  ROW('still overloaded', 0.75),                   -- 51
  ROW('still shaken', 0.75),                       -- 52
  ROW('still unstable', 0.75),                     
  ROW('still mentally off balance', 0.75),         
  ROW('still dysregulated', 0.75),                 
  ROW('still rattled', 0.75),                      
  ROW('still not steady', 0.75),                   
  ROW('still overwhelmed internally', 0.75),      
  ROW('still uneasy internally', 0.75),            
  ROW('still overloaded inside', 0.75),            
  ROW('sense of presence not back', 0.7),          
  ROW('still not anchored to present', 0.7),       
  ROW('still detached from present', 0.7),         
  ROW('still mentally adrift', 0.7),               
  ROW('still not grounded in reality', 0.7),       
  ROW('still pulled away from now', 0.7),          
  ROW('still disconnected internally', 0.7),      
  ROW('still drifting mentally', 0.7),             
  ROW('still not regulated', 0.7),                 
  ROW('still not stabilized', 0.7)                 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('có thể thử nhìn quanh và gọi tên 5 vật đang thấy', 1.0),        
  ROW('thử tập trung vào những gì đang ở xung quanh', 1.0),           
  ROW('có thể mô tả không gian hiện tại không', 1.0),                 
  ROW('thử chú ý đến âm thanh gần nhất', 1.0),                        
  ROW('có thể chạm vào một vật gần đó không', 1.0),                   
  ROW('thử cảm nhận bàn chân đang chạm đất', 1.0),                   
  ROW('có thể kể tên 3 màu đang thấy không', 1.0),                    
  ROW('thử nói tên địa điểm hiện tại', 1.0),                          
  ROW('có thể nhắc lại ngày hôm nay là ngày nào không', 1.0),         
  ROW('thử nhìn quanh và nhận diện ánh sáng', 1.0),                  

  ROW('có thể tập trung vào nhiệt độ xung quanh không', 0.95),        
  ROW('thử cảm nhận quần áo đang chạm vào da', 0.95),                 
  ROW('có thể mô tả một âm thanh đang nghe thấy', 0.95),              
  ROW('thử chú ý đến mùi trong không gian này', 0.95),                
  ROW('có thể đặt chân vững xuống sàn và cảm nhận lực đỡ', 0.95),     
  ROW('thử gọi tên 5 thứ đang ở trước mắt', 0.95),                   
  ROW('có thể nhìn quanh và chọn một vật an toàn', 0.95),             
  ROW('thử nói tên thành phố hoặc căn phòng hiện tại', 0.95),        
  ROW('có thể chạm vào bàn hoặc ghế gần đó không', 0.95),             
  ROW('thử xoay đầu nhẹ và quan sát xung quanh', 0.95),              

  ROW('có thể tập trung vào cảm giác cơ thể lúc này', 0.9),          
  ROW('thử để ý nhịp chuyển động xung quanh', 0.9),                  -- 22
  ROW('có thể nói tên 2 âm thanh đang nghe', 0.9),                   -- 23
  ROW('thử nhìn một vật cố định trong vài giây', 0.9),               -- 24
  ROW('có thể cảm nhận điểm tựa của cơ thể', 0.9),                   -- 25
  ROW('thử nhận diện bề mặt đang ngồi hoặc đứng', 0.9),              -- 26
  ROW('có thể chú ý đến bàn tay đang làm gì', 0.9),                  -- 27
  ROW('thử nhìn xung quanh và tìm vật quen thuộc', 0.9),             -- 28
  ROW('có thể kể tên một thứ đang nghe thấy', 0.9),                  -- 29
  ROW('thử nói tên thời gian trong ngày', 0.9),                      -- 30

  ROW('có thể đặt một vật mát hoặc ấm lên tay', 0.85),               -- 31
  ROW('thử nhúc nhích các ngón chân', 0.85),                         -- 32
  ROW('có thể quan sát chuyển động của ánh sáng', 0.85),             -- 33
  ROW('thử để ý cảm giác tiếp xúc của lưng', 0.85),                  -- 34
  ROW('có thể chú ý đến không gian phía trước', 0.85),               -- 35
  ROW('thử nghe kỹ âm thanh xa nhất', 0.85),                         -- 36
  ROW('có thể nói tên đồ vật đang chạm vào', 0.85),                  -- 37
  ROW('thử xác định hướng trái và phải', 0.85),                      -- 38
  ROW('có thể chú ý đến sàn nhà', 0.85),                              -- 39
  ROW('thử nhìn quanh và chọn một chi tiết nhỏ', 0.85),              -- 40

  ROW('có thể đứng lên và cảm nhận trọng lượng cơ thể', 0.8),        -- 41
  ROW('thử di chuyển nhẹ để cảm nhận không gian', 0.8),              -- 42
  ROW('có thể tập trung vào một giác quan duy nhất', 0.8),           -- 43
  ROW('thử gọi tên ba vật có hình dạng khác nhau', 0.8),             -- 44
  ROW('có thể chú ý đến nhịp chuyển động xung quanh', 0.8),          -- 45
  ROW('thử cảm nhận hơi thở nhưng không điều khiển', 0.8),           -- 46
  ROW('có thể nhìn quanh và nhận diện vật quen', 0.8),               -- 47
  ROW('thử đặt tay lên bề mặt chắc chắn', 0.8),                      -- 48
  ROW('có thể chú ý đến âm thanh gần nhất', 0.8),                    -- 49
  ROW('thử xác nhận vị trí hiện tại', 0.8),                          -- 50

  ROW('có thể quay lại bài 5-4-3-2-1 chậm hơn', 0.75),                -- 51
  ROW('thử làm từng bước một', 0.75),                                -- 52
  ROW('có thể chọn một giác quan dễ nhất trước', 0.75),              
  ROW('thử làm bài tập trong vài giây nữa', 0.75),                   
  ROW('có thể thử lại theo nhịp chậm', 0.75),                        
  ROW('thử chú ý đến sự vững chắc của không gian', 0.75),            
  ROW('có thể tập trung vào cảm giác an toàn', 0.75),                
  ROW('thử nhìn quanh và xác nhận đang ở hiện tại', 0.75),           
  ROW('có thể điều chỉnh cách làm cho thoải mái hơn', 0.75),         
  ROW('thử chọn một chi tiết dễ nhận biết', 0.75),                  

  ROW('có thể thử một cách grounding khác', 0.7),                   
  ROW('thử kết hợp chuyển động nhẹ', 0.7),                           
  ROW('có thể dừng lại và quan sát xung quanh', 0.7),                
  ROW('thử nói tên mọi thứ đang thấy', 0.7),                         
  ROW('có thể chọn cách grounding phù hợp hơn', 0.7),                
  ROW('thử quay lại hiện tại bằng giác quan', 0.7),                  
  ROW('có thể làm lại khi sẵn sàng', 0.7),                            
  ROW('thử tập trung vào không gian an toàn', 0.7),                  
  ROW('có thể tiếp tục grounding theo cách khác', 0.7),              
  ROW('thử ở lại với hiện tại thêm một chút', 0.7), 

  ROW('try looking around and naming five things visible', 1.0),     
  ROW('try focusing on the surroundings', 1.0),                      
  ROW('can the current space be described', 1.0),                    
  ROW('try noticing the closest sound', 1.0),                        
  ROW('try touching something nearby', 1.0),                         
  ROW('try feeling feet on the ground', 1.0),                        
  ROW('try naming three colors in view', 1.0),                       
  ROW('try stating the current location', 1.0),                     
  ROW('try identifying today’s date', 1.0),                          
  ROW('try noticing the light in the room', 1.0),                    

  ROW('try noticing the temperature', 0.95),                         
  ROW('try feeling clothes against skin', 0.95),                    
  ROW('try describing one sound', 0.95),                              
  ROW('try noticing any scent', 0.95),                                
  ROW('try pressing feet firmly into the floor', 0.95),              
  ROW('try naming five objects in front', 0.95),                     
  ROW('try focusing on a safe object', 0.95),                         
  ROW('try stating the room or place', 0.95),                         
  ROW('try touching a chair or table', 0.95),                         
  ROW('try slowly looking around', 0.95),                             

  ROW('try noticing body sensations', 0.9),                           
  ROW('try observing movement nearby', 0.9),                         -- 22
  ROW('try naming two sounds', 0.9),                                  -- 23
  ROW('try focusing on one object briefly', 0.9),                    -- 24
  ROW('try feeling physical support', 0.9),                           -- 25
  ROW('try noticing the surface underneath', 0.9),                   -- 26
  ROW('try noticing what hands are touching', 0.9),                  -- 27
  ROW('try identifying something familiar', 0.9),                    -- 28
  ROW('try naming one sound', 0.9),                                   -- 29
  ROW('try stating the time of day', 0.9),                            -- 30

  ROW('try holding something warm or cool', 0.85),                   -- 31
  ROW('try gently moving toes', 0.85),                                -- 32
  ROW('try observing light movement', 0.85),                          -- 33
  ROW('try noticing contact with back or seat', 0.85),               -- 34
  ROW('try focusing on the space ahead', 0.85),                      -- 35
  ROW('try listening for the farthest sound', 0.85),                 -- 36
  ROW('try naming what is being touched', 0.85),                     -- 37
  ROW('try identifying left and right', 0.85),                       -- 38
  ROW('try noticing the floor', 0.85),                                -- 39
  ROW('try focusing on a small detail', 0.85),                        -- 40

  ROW('try standing and feeling body weight', 0.8),                  -- 41
  ROW('try gentle movement to feel space', 0.8),                     -- 42
  ROW('try focusing on one sense at a time', 0.8),                   -- 43
  ROW('try naming three different shapes', 0.8),                     -- 44
  ROW('try noticing movement around', 0.8),                          -- 45
  ROW('try noticing breathing without control', 0.8),               -- 46
  ROW('try identifying familiar objects', 0.8),                      -- 47
  ROW('try placing hands on a solid surface', 0.8),                  -- 48
  ROW('try noticing the closest sound', 0.8),                        -- 49
  ROW('try confirming current location', 0.8),                      -- 50

  ROW('try the 5-4-3-2-1 steps more slowly', 0.75),                   -- 51
  ROW('try taking it one step at a time', 0.75),                     -- 52
  ROW('try starting with the easiest sense', 0.75),                 
  ROW('try continuing for a few more seconds', 0.75),               
  ROW('try adjusting the pace', 0.75),                               
  ROW('try noticing the stability of the space', 0.75),              
  ROW('try focusing on safety cues', 0.75),                          
  ROW('try confirming being in the present', 0.75),                 
  ROW('try adjusting the exercise', 0.75),                           
  ROW('try choosing an easier detail', 0.75),                        

  ROW('try a different grounding approach', 0.7),                   
  ROW('try adding gentle movement', 0.7),                            
  ROW('try pausing to observe surroundings', 0.7),                  
  ROW('try naming everything visible', 0.7),                         
  ROW('try choosing a grounding method that fits better', 0.7),      
  ROW('try returning to the present through senses', 0.7),           
  ROW('try again when ready', 0.7),                                   
  ROW('try focusing on a safe space', 0.7),                           
  ROW('try continuing grounding differently', 0.7),                 
  ROW('try staying with the present a bit longer', 0.7)     
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_grounding_54321'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('ngột ngạt', 1.0),                          
  ROW('bí bách', 1.0),                            
  ROW('tù túng', 1.0),                            
  ROW('khó chịu trong người', 1.0),               
  ROW('ở trong nhà quá lâu', 1.0),                
  ROW('cảm giác bị kẹt', 1.0),                    
  ROW('không khí ngột ngạt', 1.0),                
  ROW('muốn ra ngoài', 1.0),                      
  ROW('muốn đổi không gian', 1.0),                
  ROW('cần không khí mới', 1.0),                  
  ROW('bức bối', 0.95),                           
  ROW('mệt mỏi tinh thần', 0.95),                 
  ROW('đầu óc nặng nề', 0.95),                    
  ROW('khó chịu vì không gian', 0.95),            
  ROW('cảm giác tù đọng', 0.95),                  
  ROW('thiếu năng lượng', 0.95),                  
  ROW('uể oải', 0.95),                             
  ROW('lười vận động', 0.95),                     
  ROW('ngồi quá lâu', 0.95),                      
  ROW('ở yên một chỗ lâu', 0.95),                  
  ROW('đầu óc mờ mịt', 0.9),                       
  ROW('khó tập trung', 0.9),                      -- 22
  ROW('cảm giác ì ạch', 0.9),                     -- 23
  ROW('tâm trí trì trệ', 0.9),                    -- 24
  ROW('thiếu tỉnh táo', 0.9),                     -- 25
  ROW('muốn thay đổi không khí', 0.9),             -- 26
  ROW('cần vận động nhẹ', 0.9),                   -- 27
  ROW('muốn đi dạo', 0.9),                         -- 28
  ROW('cảm giác nặng đầu', 0.9),                  -- 29
  ROW('mệt vì ở trong phòng', 0.9),               -- 30
  ROW('buồn chán', 0.85),                          -- 31
  ROW('thiếu hứng thú', 0.85),                    -- 32
  ROW('chán không gian hiện tại', 0.85),          -- 33
  ROW('cảm giác tù túng trong phòng', 0.85),      -- 34
  ROW('không thoải mái khi ở trong nhà', 0.85),   -- 35
  ROW('cần thay đổi nhịp sinh hoạt', 0.85),       -- 36
  ROW('cảm giác trì trệ', 0.85),                  -- 37
  ROW('thiếu ánh sáng', 0.85),                    -- 38
  ROW('ở trong phòng kín', 0.85),                 -- 39
  ROW('cảm giác bí', 0.85),                       -- 40
  ROW('muốn vận động', 0.8),                      -- 41
  ROW('cần giãn người', 0.8),                     -- 42
  ROW('cảm giác nặng cơ thể', 0.8),               -- 43
  ROW('khó ngồi yên', 0.8),                       -- 44
  ROW('muốn thay đổi vị trí', 0.8),               -- 45
  ROW('cần đi lại', 0.8),                          -- 46
  ROW('cảm giác bó buộc', 0.8),                   -- 47
  ROW('thiếu tiếp xúc thiên nhiên', 0.8),         -- 48
  ROW('không ra ngoài lâu rồi', 0.8),             -- 49
  ROW('ở trong phòng suốt', 0.8),                 -- 50
  ROW('tâm trạng nặng nề', 0.75),                 -- 51
  ROW('cảm giác ì', 0.75),                         -- 52
  ROW('thiếu sinh khí', 0.75),                    
  ROW('không khí tù đọng', 0.75),                 
  ROW('thiếu chuyển động', 0.75),                 
  ROW('cần đổi môi trường', 0.75),                
  ROW('cảm giác không thoát ra được', 0.75),      
  ROW('ở trong nhà quá nhiều', 0.75),             
  ROW('thiếu ánh nắng', 0.75),                    
  ROW('cảm giác mệt mỏi kéo dài', 0.75),          
  ROW('muốn hít không khí ngoài trời', 0.7),      
  ROW('cần ra ngoài một chút', 0.7),              
  ROW('cảm giác bị gò bó', 0.7),                  
  ROW('không gian hiện tại ngột ngạt', 0.7),      
  ROW('cần đổi góc nhìn', 0.7),                   
  ROW('muốn tách khỏi phòng', 0.7),               
  ROW('cần thoát khỏi không gian kín', 0.7),      
  ROW('thiếu sự thoáng đãng', 0.7),               
  ROW('cảm giác bức bí trong nhà', 0.7),          
  ROW('muốn ra chỗ thoáng hơn', 0.7),

  ROW('feeling trapped', 1.0),                     
  ROW('feeling stuck indoors', 1.0),               
  ROW('claustrophobic', 1.0),                      
  ROW('restless', 1.0),                            
  ROW('need fresh air', 1.0),                      
  ROW('want to go outside', 1.0),                  
  ROW('need a change of space', 1.0),              
  ROW('feeling boxed in', 1.0),                    
  ROW('need to step outside', 1.0),                
  ROW('air feels stale', 1.0),                     
  ROW('mentally drained', 0.95),                   
  ROW('low energy', 0.95),                         
  ROW('feeling sluggish', 0.95),                   
  ROW('body feels heavy', 0.95),                   
  ROW('too much time indoors', 0.95),              
  ROW('need movement', 0.95),                      
  ROW('need to stretch', 0.95),                    
  ROW('hard to sit still', 0.95),                  
  ROW('need a break from room', 0.95),             
  ROW('feeling stagnant', 0.95),                   
  ROW('mentally foggy', 0.9),                      
  ROW('hard to focus', 0.9),                       -- 22
  ROW('brain feels stuck', 0.9),                   -- 23
  ROW('need a mental reset', 0.9),                 -- 24
  ROW('feeling dull', 0.9),                        -- 25
  ROW('want a change of scenery', 0.9),            -- 26
  ROW('need light movement', 0.9),                 -- 27
  ROW('want to take a walk', 0.9),                 -- 28
  ROW('feeling weighed down', 0.9),                -- 29
  ROW('tired of being inside', 0.9),               -- 30
  ROW('bored', 0.85),                              -- 31
  ROW('unmotivated', 0.85),                        -- 32
  ROW('environment feels dull', 0.85),             -- 33
  ROW('room feels suffocating', 0.85),              -- 34
  ROW('need environmental change', 0.85),          -- 35
  ROW('feeling inert', 0.85),                      -- 36
  ROW('lack of stimulation', 0.85),                -- 37
  ROW('lack of sunlight', 0.85),                   -- 38
  ROW('indoors too long', 0.85),                   -- 39
  ROW('need nature exposure', 0.85),               -- 40
  ROW('need to move body', 0.8),                   -- 41
  ROW('need to loosen up', 0.8),                   -- 42
  ROW('feeling stiff', 0.8),                       -- 43
  ROW('want to change position', 0.8),             -- 44
  ROW('need to walk around', 0.8),                 -- 45
  ROW('need physical reset', 0.8),                 -- 46
  ROW('feeling constrained', 0.8),                 -- 47
  ROW('lack of outdoor time', 0.8),                -- 48
  ROW('haven’t been outside', 0.8),                -- 49
  ROW('inside all day', 0.8),                      -- 50
  ROW('feeling heavy inside', 0.75),               -- 51
  ROW('energy feels low', 0.75),                   -- 52
  ROW('feeling stale', 0.75),                      
  ROW('environment feels closed', 0.75),           
  ROW('lack of movement', 0.75),                   
  ROW('need environmental shift', 0.75),           
  ROW('feeling boxed up', 0.75),                   
  ROW('too much indoor time', 0.75),               
  ROW('need sunlight', 0.75),                      
  ROW('prolonged tiredness', 0.75),                
  ROW('need outdoor air', 0.7),                    
  ROW('need to step out briefly', 0.7),            
  ROW('feeling confined', 0.7),                    
  ROW('space feels tight', 0.7),                   
  ROW('need perspective shift', 0.7),              
  ROW('want distance from room', 0.7),             
  ROW('need to leave enclosed space', 0.7),        
  ROW('lack of openness', 0.7),                    
  ROW('home feels suffocating', 0.7),               
  ROW('want a more open space', 0.7)
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
  ROW('tâm trạng nhẹ hơn', 1.0),          
  ROW('cảm giác thoải mái hơn ', 1.0),       
  ROW('đầu óc thông thoáng hơn', 1.0),                    
  ROW('bớt căng thẳng khi ở ngoài trời', 1.0),            
  ROW('thấy nhẹ người hơn khi ra ngoài', 1.0),            
  ROW('tinh thần khá hơn', 1.0),           
  ROW('cảm thấy thoáng đãng hơn', 1.0),                   
  ROW('bớt ngột ngạt', 1.0),             
  ROW('dễ thở hơn khi hít không khí bên ngoài', 1.0),     
  ROW('đỡ bí bách hơn', 0.95),                             
  ROW('không khí bên ngoài làm dễ chịu hơn', 0.95),       
  ROW('đi ra ngoài giúp tinh thần thoải mái hơn', 0.95),  
  ROW('cảm giác nặng nề giảm bớt', 0.95),                 
  ROW('đầu óc bớt rối hơn sau khi ra ngoài', 0.95),       
  ROW('tâm trí nhẹ hơn ', 0.95),        
  ROW('đầu óc rõ ràng hơn', 0.95),             
  ROW('tinh thần được cải thiện', 0.95),     
  ROW('cảm giác được làm mới', 0.95),    
  ROW('đỡ mệt mỏi', 0.95),               
  ROW('bớt áp lực', 0.9),                 
  ROW('tâm trạng ổn định hơn', 0.9),     -- 22
  ROW('đi bộ ngoài trời giúp dễ chịu hơn', 0.9),          -- 23
  ROW('bớt nặng đầu hơn', 0.9),                            -- 24
  ROW('tinh thần bớt căng', 0.9),            -- 25
  ROW('thư giãn hơn', 0.9),         -- 26
  ROW('cảm giác căng thẳng giảm xuống', 0.9),             -- 27
  ROW('bình tĩnh hơn', 0.9),              -- 28
  ROW('tâm trí thoáng hơn', 0.9),             -- 29
  ROW('bớt khó chịu', 0.9),        -- 30
  ROW('thả lỏng cơ thể', 0.85),              -- 31
  ROW('đi dạo giúp giảm bớt căng thẳng', 0.85),            -- 32
  ROW('cảm giác thư giãn hơn', 0.85),            -- 33
  ROW('tinh thần bớt nặng nề hơn', 0.85),                  -- 34
  ROW('bớt tù túng', 0.85),                   -- 35
  ROW('tinh thần khá hơn', 0.85),      -- 36
  ROW('đầu óc dễ chịu', 0.85),            -- 37
  ROW('cảm giác dễ thở hơn', 0.85),      -- 38
  ROW('tâm trạng sáng hơn', 0.85),         -- 39
  ROW('bớt căng trong người', 0.85),         -- 40
  ROW('cân bằng lại cảm xúc', 0.8),         -- 41
  ROW('ổn định tinh thần', 0.8),    -- 42
  ROW('cảm giác nhẹ nhõm lan tỏa hơn', 0.8),               -- 43
  ROW('đầu óc dễ chịu hơn', 0.8),      -- 44
  ROW('tinh thần thư thái hơn', 0.8),                      -- 45
  ROW('bớt bức bối', 0.8),                -- 46
  ROW('giải tỏa áp lực', 0.8),            -- 47
  ROW('tinh thần ổn hơn', 0.8),        -- 48
  ROW('bớt mệt trong đầu', 0.8),                -- 49
  ROW('thấy dễ chịu hơn', 0.8),           -- 50
  ROW('tinh thần lắng lại', 0.8),             -- 51
  ROW('không khí ngoài trời giúp thư giãn đầu óc', 0.85), -- 52
  ROW('bớt nặng lòng', 0.85),                 
  ROW('tâm trí thoải mái hơn', 0.8),           
  ROW('giảm cảm giác căng', 0.8),           
  ROW('tinh thần nhẹ hơn', 0.8),              
  ROW('làm tâm trạng dịu xuống', 0.8),             
  ROW('bớt bí trong đầu', 0.8),        
  ROW('thở phào nhẹ nhõm', 0.8),             
  ROW('cảm giác thoải mái tăng lên', 0.85), 
  ROW('dễ chịu về tinh thần', 0.85), 
  ROW('tâm trạng tốt hơn', 0.85),        
  ROW('đầu óc nghỉ ngơi', 0.85),               
  ROW('tinh thần phục hồi', 0.85),               
  ROW('tâm trạng ổn hơn', 0.8),             
  ROW('bớt áp lực tinh thần ', 0.85),            
  ROW('làm dịu cảm xúc', 0.85),        
  ROW('tinh thần cân bằng hơn', 0.85),           
  ROW('đầu óc nhẹ nhàng hơn', 0.85),          
  ROW('cảm giác dễ chịu rõ rệt', 0.9),

  ROW('feels better', 1.0),            
  ROW('feels calmer', 1.0),                   
  ROW('head feels clearer ', 1.0),  
  ROW('mood improved', 1.0),          
  ROW('feels lighter', 1.0),        
  ROW('less tense', 1.0),          
  ROW('feels more relaxed', 1.0),                 
  ROW('mind feels less crowded', 1.0),        
  ROW('feels refreshed', 1.0),         
  ROW('breathing feels easier', 1.0),              
  ROW('less overwhelmed', 0.95),        
  ROW('helped calm things down', 0.95),          
  ROW('feels steadier ', 0.95),               
  ROW('helped ease tension', 0.95),            
  ROW('felt good to leave the room', 0.95),                
  ROW('feels more open', 0.95),         
  ROW('helped clear the mind', 0.95),        
  ROW('feels more balanced', 0.95),   
  ROW('helped settle things', 0.95),       
  ROW('felt refreshed', 0.95),              
  ROW('less pressure', 0.9),                  
  ROW('felt calmer', 0.9),                  -- 22
  ROW('helped reset', 0.9),            -- 23
  ROW('feels less stuct', 0.9),            -- 24
  ROW('felt grounding', 0.9),               -- 25
  ROW('mental fog lifted', 0.9),               -- 26
  ROW('felt lighter', 0.9),          -- 27
  ROW('improved mood', 0.9),                     -- 28
  ROW('helped calm the mind', 0.9),             -- 29
  ROW('felt more at ease ', 0.9),                   -- 30
  ROW('tension reduced', 0.85),    -- 31
  ROW('felt more relaxed ', 0.85),            -- 32
  ROW('helped decompress', 0.85),             -- 33
  ROW('felt calmer', 0.85),                    -- 34
  ROW('helped relax the body', 0.85),     -- 35
  ROW('reset mentally', 0.85),              -- 36
  ROW('reset mentality', 0.85),
  ROW('felt less boxed', 0.85),                -- 37
  ROW('helped ease stress', 0.85),               -- 38   
  ROW('helped settle thoughts', 0.85),       -- 40
  ROW('less cramped', 0.8),         -- 41
  ROW('felt better away from indoors', 0.8),               -- 42
  ROW('outdoor light improved mood', 0.8),                 -- 43
  ROW('felt mentally lighter ', 0.8),        -- 44
  ROW('helped restore calm', 0.8),                 -- 45
  ROW('reduced tension', 0.8),             -- 46
  ROW('felt more settled', 0.8),              -- 47
  ROW('helped relax', 0.8),               -- 48
  ROW('supported emotional relief', 0.8),       -- 49
  ROW('felt more stable', 0.8),                   -- 50
  ROW('ease mental strain', 0.8),          -- 51
  ROW('felt relieving', 0.8),            -- 52
  ROW('felt calmer after exposure to open space', 0.85),  
  ROW('helped regulate mood', 0.75),           
  ROW('felt more at peace', 0.85),     
  ROW('improved emotional state', 0.75),     
  ROW('felt more relaxed', 0.85), 
  ROW('walking helped release tension', 0.85),             
  ROW('outdoor break helped reset thoughts', 0.9),        
  ROW('felt mentally refreshed', 0.85),           
  ROW('helped soothe stress', 0.85),               
  ROW('supported calm', 0.8),              
  ROW('felt less overwhelmed outdoors', 0.8),              
  ROW('eased discomfort', 0.8),       
  ROW('fresh air contributed to relief', 0.8),             
  ROW('felt more relaxed after time ', 0.8),       
  ROW('walking helped stabilize mood', 0.85),               
  ROW(' space reduced mental tension', 0.8),       
  ROW('felt clearer', 0.7),        
  ROW('overall feeling improved  ', 0.9) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không thấy khá hơn', 1.0),               
  ROW('vẫn căng thẳng', 1.0),                     
  ROW('tâm trạng không cải thiện', 1.0),   
  ROW('không giúp dễ chịu hơn', 1.0),                 
  ROW('vẫn thấy nặng đầu', 1.0),                   
  ROW('không giúp ích', 1.0),              
  ROW('vẫn bí bách', 1.0),                     
  ROW('không thấy nhẹ hơn', 1.0),                  
  ROW('không làm giảm căng thẳng', 1.0),              
  ROW('đầu óc vẫn rối', 1.0),                     
  ROW('vẫn khó chịu', 0.95),                
  ROW('vẫn thấy ngột ngạt', 0.95),              
  ROW('không hiệu quả', 0.95),            
  ROW('cảm giác không đổi', 0.95),              
  ROW('vẫn mệt trong đầu', 0.95),                 
  ROW('không giúp thư giãn', 0.95),       
  ROW('tâm trí vẫn nặng', 0.95),                
  ROW('không thấy bình tĩnh hơn', 0.95),          
  ROW('vẫn cảm thấy áp lực', 0.95),              
  ROW('không làm tâm trạng tốt hơn', 0.95),           
  ROW('vẫn thấy căng', 0.9),                    
  ROW('không giúp giảm stress', 0.9),            -- 22
  ROW('đầu óc không thoáng', 0.9),              -- 23
  ROW('vẫn thấy bức bối', 0.9),                      -- 24
  ROW('không giúp ổn định cảm xúc', 0.9),             -- 25
  ROW('vẫn thấy khó chịu', 0.9),                   -- 26
  ROW('tinh thần vẫn nặng nề', 0.9),               -- 27
  ROW('không dễ chịu hơn', 0.9),          -- 28
  ROW('vẫn không thư giãn', 0.9),               -- 29
  ROW('vẫn thấy mệt mỏi', 0.9),                      -- 30
  ROW('không giúp đầu óc nhẹ hơn', 0.85),              -- 31
  ROW('căng thẳng không giảm', 0.85),              -- 32
  ROW('vẫn thấy bức bối', 0.85),               -- 33
  ROW('không tạo cảm giác thoải mái', 0.85),          -- 34
  ROW('tâm trạng vẫn xấu', 0.85),                 -- 35
  ROW('không làm dịu cảm xúc', 0.85),      -- 36
  ROW('vẫn thấy áp lực tinh thần', 0.85),       -- 37
  ROW('vẫn thấy ngột ngạt trong người', 0.85),        -- 38
  ROW('không giúp giải tỏa', 0.85),                   -- 39
  ROW('đầu óc vẫn căng', 0.85),           -- 40
  ROW('không thấy thư thái', 0.8),              -- 41
  ROW('vẫn cảm thấy bí', 0.8),                       -- 42
  ROW('vẫn khó thở tinh thần', 0.8),        -- 43
  ROW('cảm giác khó chịu không giảm', 0.8),        -- 44
  ROW('không thấy đỡ hơn', 0.8),                   -- 45
  ROW('tâm trạng vẫn nặng', 0.8),                  -- 46
  ROW('không giúp dễ chịu hơn', 0.8),            -- 47
  ROW('vẫn thấy tù túng', 0.8),                      -- 48
  ROW('vẫn không ổn', 0.8),                     -- 49
  ROW('không giúp giảm áp lực', 0.8),                    -- 50
  ROW('cảm xúc vẫn căng', 0.85),                -- 51
  ROW('tinh thần không nhẹ hơn', 0.8),              -- 52
  ROW('vẫn thấy mệt tinh thần', 0.85),           
  ROW('không mang lại cảm giác dễ chịu', 0.8),       
  ROW('đi bộ mà vẫn thấy rối', 0.75),                          
  ROW('không giúp làm dịu đầu óc', 0.75),       
  ROW('không thấy hiệu quả', 0.75),       
  ROW('cảm giác căng vẫn còn', 0.75),              
  ROW('tâm trí vẫn không yên', 0.75),             
  ROW('không thấy nhẹ lòng', 0.75),             
  ROW('không cải thiện', 0.8),          
  ROW('tinh thần vẫn bất ổn', 0.82),                
  ROW('không giúp thư giãn đầu óc', 0.81),        
  ROW('vẫn thấy căng trong người', 0.8),          
  ROW('cảm giác nặng vẫn còn', 0.83),               
  ROW('đi bộ nhưng tâm trạng không tốt hơn', 0.8),             
  ROW('không giúp giảm mệt tinh thần', 0.8),          
  ROW('không thấy nhẹ hơn', 0.8),         
  ROW('cảm xúc không dịu xuống', 0.85),          
  ROW('vẫn không dễ chịu', 0.78),    

  ROW('did not help', 1.0),                      
  ROW('did not make things better', 1.0),                
  ROW('still tense', 1.0),                
  ROW('no improvement', 1.0),                    
  ROW('still stressed', 1.0),         
  ROW('not helpful', 1.0),                          
  ROW('did not relieve tension', 1.0),       
  ROW('still feeling overwhelmed', 1.0),            
  ROW('no relief', 1.0),                  
  ROW('did not calm things down', 1.0),                  

  ROW('still uncomfortable', 0.95),                       
  ROW('no change in feeling', 0.95),             
  ROW('still mentally tense', 0.95),                 
  ROW('did not improve mood', 0.95),        
  ROW('did not clear the mind', 0.95),                   
  ROW('still pressured', 0.95),          
  ROW('made no difference', 0.95),                  
  ROW('did not help relax', 0.95),               
  ROW('still feeling stuck', 0.95),              

  ROW('no mental relief', 0.9),                      
  ROW('did not reduce stress', 0.9),                     -- 22
  ROW('still overwhelmed', 0.9),             -- 23
  ROW('did not help settle thoughts', 0.9),    -- 24
  ROW('still uneasy', 0.9),           -- 25
  ROW('did not calm nerves', 0.9),           -- 26
  ROW('no emotional improvement', 0.9),         -- 27
  ROW('did not ease discomfort', 0.9),               -- 28
  ROW('still tense', 0.9),                -- 29
  ROW('did not bring relief', 0.9),                      -- 30

  ROW('still mentally tense', 0.85),                -- 31
  ROW('did not ease stress', 0.85),                -- 32
  ROW('did not help decompress', 0.85),                 -- 33
  ROW('did not improve emotional state', 0.85),     -- 34
  ROW('still uncomfortable', 0.85),           -- 35
  ROW('movement did not help relax', 0.85),          -- 36
  ROW('still feeling pressure', 0.85),         -- 37
  ROW('no calming effect', 0.85),        -- 38
  ROW('did not reduce mental strain', 0.85),            -- 39
  ROW(' did not help settle emotions', 0.85),   -- 40                      -- 41
  ROW('did not improve comfort', 0.8),                 -- 42
  ROW('did not bring relief', 0.8),            -- 43
  ROW('still uneasy', 0.8),           -- 44
  ROW('did not calm the mind', 0.8),               -- 45
  ROW('did not help mood', 0.8),
  ROW('still not okay', 0.8),             -- 46
        -- 47
  ROW('no noticeable benefit', 0.8),           -- 48
  ROW('did not help stabilize emotions', 0.8),      -- 49
  ROW('did not reduce discomfort', 0.8),               -- 50

  ROW('still mentally unsettled', 0.8),       -- 51
  ROW('did not help emotionally', 0.8),        -- 52
  ROW('no easing of tension', 0.8),                   
  ROW('did not make things easier', 0.75),          
  ROW('still feeling strained', 0.8),                   
  ROW('did not help reset', 0.75),            
  ROW('still uncomfortable', 0.8),        

  ROW('walking outside did not help emotionally', 0.7),     
  ROW('still feeling tense despite fresh air', 0.7),       
  ROW('outside environment did not reduce stress', 0.7),   
  ROW('walk did not bring calm', 0.7),                      
  ROW('still pressured after stepping outdoors', 0.7),     
  ROW('fresh air did not relieve discomfort', 0.7),        
  ROW('walking outside had no effect', 0.7),               
  ROW('outside time did not ease mental tension', 0.7),    
  ROW('walk did not help settle emotions', 0.7),            
  ROW('still not feeling better after going outside', 0.7)                 

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('thấy dễ chịu hơn chưa', 1.0),
  ROW('đi dạo bao lâu rồi', 0.8),
  ROW('cứ đi chậm rãi thôi, không cần vội', 1.0),              
  ROW('có thể để cơ thể tự điều chỉnh nhịp đi', 1.0),         
  ROW('chỉ cần chú ý cảm giác chuyển động', 1.0),             
  ROW('không cần suy nghĩ gì lúc này', 1.0),                  
  ROW('nếu thấy mệt có thể dừng lại', 1.0),                   
  ROW('cứ để không khí xung quanh bao lấy', 1.0),             
  ROW('chú ý cảm giác bàn chân chạm đất', 1.0),               
  ROW('không cần đạt mục tiêu nào cả', 1.0),                  
  ROW('đi bao lâu cũng được', 1.0),                            
  ROW('chỉ cần ở ngoài một cách thoải mái', 1.0),             

  ROW('có thể để ý ánh sáng xung quanh', 0.95),               
  ROW('cứ giữ nhịp đi tự nhiên', 0.95),                       
  ROW('nếu có tiếng động xung quanh, chỉ cần nghe', 0.95),   
  ROW('không cần thay đổi cảm xúc ngay', 0.95),               
  ROW('đi vài bước rồi dừng cũng ổn', 0.95),                  
  ROW('cứ để cơ thể dẫn dắt', 0.95),                           
  ROW('chỉ cần hiện diện ở đây thôi', 0.95),                  
  ROW('không cần ép bản thân thư giãn', 0.95),                
  ROW('nếu có suy nghĩ xuất hiện, cứ để trôi qua', 0.95),     
  ROW('đi chậm hay nhanh đều không sao', 0.95),               

  ROW('có thể để ý nhiệt độ không khí', 0.9),                 
  ROW('cứ thả lỏng vai và tay', 0.9),                          -- 22
  ROW('không cần tập trung quá mức', 0.9),                    -- 23
  ROW('chỉ cần cho đầu óc nghỉ ngơi', 0.9),                   -- 24
  ROW('nếu muốn đứng yên một chút cũng được', 0.9),           -- 25
  ROW('cứ để bước chân đều đặn', 0.9),                         -- 26
  ROW('chú ý cảm giác cơ thể khi di chuyển', 0.9),            -- 27
  ROW('không có đúng hay sai ở đây', 0.9),                    -- 28
  ROW('có thể nhìn xung quanh một cách nhẹ nhàng', 0.9),     -- 29
  ROW('chỉ cần ở ngoài trong khoảnh khắc này', 0.9),          -- 30

  ROW('nếu thấy căng, có thể giảm tốc độ', 0.85),             -- 31
  ROW('cứ để nhịp đi tự ổn định', 0.85),                      -- 32
  ROW('không cần nói chuyện hay làm gì thêm', 0.85),          -- 33
  ROW('chỉ cần cho cơ thể được di chuyển', 0.85),             -- 34
  ROW('có thể dừng lại để quan sát xung quanh', 0.85),        -- 35
  ROW('nếu có cảm giác khó chịu, cứ ghi nhận', 0.85),         -- 36
  ROW('không cần phán xét trải nghiệm này', 0.85),            -- 37
  ROW('cứ để không gian làm phần việc của nó', 0.85),         -- 38
  ROW('đi một đoạn ngắn cũng đã đủ', 0.85),                   -- 39
  ROW('chỉ cần cho bản thân ở ngoài trời', 0.85),             -- 40

  ROW('có thể để ý cảm giác gió trên da', 0.8),               -- 41
  ROW('không cần cố gắng cảm thấy tốt hơn', 0.8),             -- 42
  ROW('cứ để mọi thứ diễn ra tự nhiên', 0.8),                -- 43
  ROW('nếu muốn đổi hướng đi cũng không sao', 0.8),           -- 44
  ROW('chỉ cần tiếp tục di chuyển nhẹ nhàng', 0.8),           -- 45
  ROW('có thể dừng lại bất cứ lúc nào', 0.8),                 -- 46
  ROW('không cần chú ý đến thời gian', 0.8),                  -- 47
  ROW('cứ để bước chân dẫn lối', 0.8),                         -- 48
  ROW('chỉ cần ở trong không gian mở', 0.8),                  -- 49
  ROW('mọi cảm giác đều được phép tồn tại', 0.8),             -- 50

  ROW('có thể tiếp tục nếu còn thấy ổn', 0.75),               -- 51
  ROW('nếu muốn quay lại cũng hoàn toàn ổn', 0.75),           -- 52
  ROW('không cần kéo dài hơn mức cần thiết', 0.75),           
  ROW('cứ để cơ thể tự quyết định khi nào đủ', 0.75),         
  ROW('chỉ cần cho bản thân một khoảng ngoài trời', 0.75),    
  ROW('có thể chú ý cảm giác tiếp xúc với mặt đất', 0.75),    
  ROW('không cần phân tích trải nghiệm này', 0.75),           
  ROW('cứ giữ mọi thứ đơn giản', 0.75),                       
  ROW('chỉ cần để đầu óc được yên một chút', 0.75),           
  ROW('nếu thấy đủ rồi thì có thể dừng', 0.75),               

  ROW('có thể kết thúc bất cứ lúc nào thấy phù hợp', 0.7),   
  ROW('không có yêu cầu nào thêm lúc này', 0.7),              
  ROW('chỉ cần hiện diện trong chuyển động', 0.7),            
  ROW('cứ để cơ thể tự điều chỉnh', 0.7),                     
  ROW('nếu có suy nghĩ quay lại, cứ ghi nhận', 0.7),          
  ROW('không cần kéo dài nếu không muốn', 0.7),               
  ROW('cứ để trải nghiệm diễn ra', 0.7),                      
  ROW('chỉ cần cho bản thân một khoảng thở ngoài trời', 0.7), 
  ROW('không cần làm gì thêm', 0.7),                           
  ROW('mọi thứ đang ổn theo cách riêng', 0.7), 

  ROW('no need to rush, a slow pace is fine', 1.0),            
  ROW('let the body choose the pace', 1.0),                   
  ROW('just notice the movement', 1.0),                       
  ROW('nothing needs to be fixed right now', 1.0),            
  ROW('it is okay to pause if needed', 1.0),                  
  ROW('let the outdoor air be present', 1.0),                 
  ROW('notice the feeling of feet on the ground', 1.0),       
  ROW('no goal is required here', 1.0),                       
  ROW('any duration is enough', 1.0),                         
  ROW('just being outside is enough', 1.0),                   

  ROW('notice the light around', 0.95),                       
  ROW('allow the pace to stay natural', 0.95),                
  ROW('if sounds appear, just let them be heard', 0.95),     
  ROW('no need to change feelings immediately', 0.95),        
  ROW('a few steps or a pause are both okay', 0.95),          
  ROW('let the body lead for now', 0.95),                     
  ROW('just stay present in this moment', 0.95),              
  ROW('there is no need to force relaxation', 0.95),          
  ROW('thoughts can come and go freely', 0.95),               
  ROW('any walking speed is acceptable', 0.95),               

  ROW('notice the temperature of the air', 0.9),              
  ROW('let the shoulders and arms stay loose', 0.9),          -- 22
  ROW('no need to concentrate too hard', 0.9),                -- 23
  ROW('allow the mind to rest', 0.9),                          -- 24
  ROW('standing still for a moment is okay', 0.9),            -- 25
  ROW('let the steps stay steady', 0.9),                      -- 26
  ROW('notice how the body feels while moving', 0.9),         -- 27
  ROW('there is no right or wrong here', 0.9),                -- 28
  ROW('looking around gently is enough', 0.9),                -- 29
  ROW('just be outside in this moment', 0.9),                 -- 30

  ROW('slowing down is okay if tension appears', 0.85),       -- 31
  ROW('allow the pace to settle naturally', 0.85),            -- 32
  ROW('nothing else needs to be done', 0.85),                 -- 33
  ROW('movement alone is enough right now', 0.85),            -- 34
  ROW('pausing to observe is fine', 0.85),                    -- 35
  ROW('discomfort can simply be noticed', 0.85),              -- 36
  ROW('no judgment is needed for this experience', 0.85),     -- 37
  ROW('let the space do its work', 0.85),                     -- 38
  ROW('a short walk can already be enough', 0.85),            -- 39
  ROW('being outdoors is sufficient', 0.85),                  -- 40

  ROW('notice the feeling of air on the skin', 0.8),          -- 41
  ROW('no need to feel better right away', 0.8),              -- 42
  ROW('let things unfold naturally', 0.8),                    -- 43
  ROW('changing direction is okay', 0.8),                     -- 44
  ROW('gentle movement is enough', 0.8),                      -- 45
  ROW('stopping at any point is allowed', 0.8),               -- 46
  ROW('time does not need attention right now', 0.8),         -- 47
  ROW('let the steps guide the way', 0.8),                    -- 48
  ROW('open space alone can be helpful', 0.8),                -- 49
  ROW('all sensations are allowed to exist', 0.8),            -- 50

  ROW('continuing is optional', 0.75),                        -- 51
  ROW('returning is also okay', 0.75),                        -- 52
  ROW('there is no need to extend this', 0.75),               
  ROW('the body can decide when it is enough', 0.75),         
  ROW('a moment outdoors is already valuable', 0.75),        
  ROW('notice contact with the ground', 0.75),                
  ROW('analysis is not required right now', 0.75),            
  ROW('keeping things simple is enough', 0.75),               
  ROW('allow the mind a quiet pause', 0.75),                  
  ROW('stopping when it feels right is fine', 0.75),          

  ROW('ending at any point is acceptable', 0.7),              
  ROW('nothing more is required right now', 0.7),             
  ROW('presence within movement is enough', 0.7),             
  ROW('let the body self-adjust', 0.7),                        
  ROW('thoughts about returning can be noted', 0.7),          
  ROW('there is no obligation to continue', 0.7),             
  ROW('allow the experience to simply happen', 0.7),          
  ROW('a moment of outdoor breathing space is enough', 0.7),  
  ROW('nothing else needs attention', 0.7),                   
  ROW('things are okay as they are right now', 0.7)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_walk_outdoor'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('suy nghĩ lặp lại', 1.0),              
  ROW('nghĩ hoài không dứt', 1.0),            
  ROW('mắc kẹt trong suy nghĩ', 1.0),         
  ROW('không thoát khỏi ý nghĩ', 1.0),        
  ROW('đầu óc xoay vòng', 1.0),               
  ROW('suy nghĩ tiêu cực liên tục', 1.0),     
  ROW('tự trách bản thân', 1.0),              
  ROW('đổ lỗi cho bản thân', 1.0),            
  ROW('mọi thứ là lỗi của mình', 1.0),        
  ROW('cảm giác bản thân tệ', 1.0),           

  ROW('nghĩ mình vô dụng', 0.95),             
  ROW('cho rằng mình thất bại', 0.95),        
  ROW('luôn nghĩ kết quả xấu', 0.95),         
  ROW('tưởng tượng kịch bản tệ', 0.95),       
  ROW('suy nghĩ theo hướng xấu', 0.95),       
  ROW('cho rằng không có cách khác', 0.95),   
  ROW('cảm giác bế tắc', 0.95),               
  ROW('suy nghĩ cực đoan', 0.95),              
  ROW('nhìn mọi thứ trắng đen', 0.95),        
  ROW('chỉ có đúng hoặc sai', 0.95),           

  ROW('nghĩ mình luôn sai', 0.9),              
  ROW('người khác luôn đúng', 0.9),            -- 22
  ROW('so sánh tiêu cực', 0.9),                -- 23
  ROW('nghĩ mình kém hơn', 0.9),               -- 24
  ROW('không đủ tốt', 0.9),                    -- 25
  ROW('không xứng đáng', 0.9),                 -- 26
  ROW('tự phán xét nặng nề', 0.9),             -- 27
  ROW('tự gắn nhãn tiêu cực', 0.9),            -- 28
  ROW('một lỗi hỏng tất cả', 0.9),             -- 29
  ROW('phóng đại vấn đề', 0.9),                -- 30

  ROW('chỉ nhìn điểm xấu', 0.85),              -- 31
  ROW('bỏ qua điều tích cực', 0.85),           -- 32
  ROW('coi nhẹ điều tốt', 0.85),               -- 33
  ROW('chỉ nhớ chuyện tệ', 0.85),              -- 34
  ROW('coi cảm xúc là sự thật', 0.85),         -- 35
  ROW('tin suy nghĩ ngay lập tức', 0.85),      -- 36
  ROW('không đặt câu hỏi cho suy nghĩ', 0.85), -- 37
  ROW('coi suy nghĩ là chân lý', 0.85),        -- 38
  ROW('khó nhìn góc khác', 0.85),               -- 39
  ROW('không xem xét hướng khác', 0.85),       -- 40

  ROW('cho rằng mình biết chắc', 0.8),         -- 41
  ROW('dự đoán tương lai xấu', 0.8),            -- 42
  ROW('nghĩ người khác đánh giá', 0.8),        -- 43
  ROW('đọc suy nghĩ người khác', 0.8),         -- 44
  ROW('nghĩ người khác thất vọng', 0.8),       -- 45
  ROW('cho rằng mình làm phiền', 0.8),         -- 46
  ROW('diễn giải theo hướng xấu', 0.8),        -- 47
  ROW('suy nghĩ gây mệt mỏi', 0.8),             -- 48
  ROW('đầu óc quá tải', 0.8),                   -- 49
  ROW('bị suy nghĩ kiểm soát', 0.8),            -- 50

  ROW('không phân biệt suy nghĩ và thực tế', 0.8), -- 51
  ROW('tin suy nghĩ hơn bằng chứng', 0.8),         -- 52
  ROW('suy diễn quá mức', 0.8),                    
  ROW('nghĩ mọi chuyện đều tệ', 0.8),              
  ROW('khó dừng dòng suy nghĩ', 0.8),              
  ROW('suy nghĩ không kiểm soát', 0.8),            
  ROW('tự kết luận tiêu cực', 0.8),                
  ROW('mắc kẹt trong kết luận', 0.8),              
  ROW('suy nghĩ chi phối cảm xúc', 0.8),           
  ROW('tâm trí bị cuốn vào suy nghĩ', 0.8),        

  ROW('nghĩ mọi thứ sẽ thất bại', 0.8),            
  ROW('cho rằng không thể thay đổi', 0.8),         
  ROW('tự áp đặt tiêu chuẩn cao', 0.8),            
  ROW('sợ suy nghĩ đó là sự thật', 0.8),           
  ROW('bị kẹt trong phán đoán', 0.8),               
  ROW('suy nghĩ làm mất năng lượng', 0.8),         
  ROW('nghĩ hoài một kết luận', 0.8),               
  ROW('không mở ra cách nhìn khác', 0.8),          
  ROW('suy nghĩ mang tính tuyệt đối', 0.8),        
  ROW('tin chắc suy nghĩ là đúng', 0.8),

  ROW('thoughts keep looping', 1.0),                
  ROW('cannot stop thinking', 1.0),                 
  ROW('stuck in thoughts', 1.0),                    
  ROW('unable to move past thoughts', 1.0),         
  ROW('mind keeps spinning', 1.0),                  
  ROW('repeating negative thoughts', 1.0),          
  ROW('constant self blame', 1.0),                  
  ROW('blaming oneself', 1.0),                      
  ROW('everything feels like my fault', 1.0),       
  ROW('feeling like a bad person', 1.0),             

  ROW('thinking of self as useless', 0.95),         
  ROW('believing failure defines everything', 0.95),
  ROW('expecting the worst', 0.95),                 
  ROW('imagining worst case scenarios', 0.95),      
  ROW('thinking in negative directions', 0.95),     
  ROW('believing no other options exist', 0.95),    
  ROW('feeling mentally trapped', 0.95),            
  ROW('extreme thinking patterns', 0.95),           
  ROW('black and white thinking', 0.95),            
  ROW('only right or wrong thinking', 0.95),        

  ROW('thinking always wrong', 0.9),                
  ROW('others are always right', 0.9),              -- 22
  ROW('negative self comparison', 0.9),             -- 23
  ROW('believing others are better', 0.9),          -- 24
  ROW('not good enough', 0.9),                      -- 25
  ROW('feeling unworthy', 0.9),                     -- 26
  ROW('harsh self judgment', 0.9),                  -- 27
  ROW('negative self labeling', 0.9),               -- 28
  ROW('one mistake ruins everything', 0.9),         -- 29
  ROW('magnifying problems', 0.9),                  -- 30

  ROW('focusing only on negatives', 0.85),          -- 31
  ROW('ignoring positive evidence', 0.85),          -- 32
  ROW('dismissing good things', 0.85),              -- 33
  ROW('remembering only bad events', 0.85),         -- 34
  ROW('believing feelings are facts', 0.85),        -- 35
  ROW('trusting thoughts immediately', 0.85),      -- 36
  ROW('not questioning thoughts', 0.85),            -- 37
  ROW('treating thoughts as truth', 0.85),          -- 38
  ROW('difficulty seeing other views', 0.85),       -- 39
  ROW('unable to consider alternatives', 0.85),    -- 40

  ROW('assuming certainty about outcomes', 0.8),   -- 41
  ROW('predicting a negative future', 0.8),        -- 42
  ROW('assuming others are judging', 0.8),         -- 43
  ROW('mind reading others', 0.8),                  -- 44
  ROW('assuming disappointment', 0.8),             -- 45
  ROW('feeling like a burden', 0.8),                -- 46
  ROW('negative interpretation of events', 0.8),   -- 47
  ROW('thoughts causing exhaustion', 0.8),         -- 48
  ROW('mental overload', 0.8),                      -- 49
  ROW('feeling controlled by thoughts', 0.8),      -- 50

  ROW('confusing thoughts with reality', 0.8),     -- 51
  ROW('trusting thoughts over evidence', 0.8),     -- 52
  ROW('overinterpreting situations', 0.8),         
  ROW('thinking everything is bad', 0.8),          
  ROW('difficulty stopping thoughts', 0.8),        
  ROW('uncontrolled thinking patterns', 0.8),      
  ROW('jumping to negative conclusions', 0.8),     
  ROW('stuck on one conclusion', 0.8),              
  ROW('thoughts driving emotions', 0.8),            
  ROW('mind pulled into thinking', 0.8),            

  ROW('believing everything will fail', 0.8),      
  ROW('thinking change is impossible', 0.8),       
  ROW('holding unrealistically high standards', 0.8), 
  ROW('fearing thoughts are true', 0.8),            
  ROW('trapped in judgment', 0.8),                  
  ROW('thoughts draining energy', 0.8),             
  ROW('replaying one conclusion', 0.8),             
  ROW('unable to open new perspectives', 0.8),     
  ROW('absolute thinking patterns', 0.8),           
  ROW('believing thoughts are correct', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('đúng là mình nhìn lệch hướng', 1.0),
  ROW('thấy nhẹ lòng hơn', 0.9),
  ROW('nghĩ theo cách khác rồi', 1.0),
  ROW('nhìn ra góc khác', 0.95),
  ROW('thấy nhẹ hơn khi đổi góc nhìn', 0.95),
  ROW('không còn nghĩ một chiều nữa', 0.9),
  ROW('hiểu vấn đề khác đi', 0.9),
  ROW('thấy không tệ như ban đầu', 0.9),
  ROW('nhận ra mình đang nghĩ hơi cực đoan', 1.0),
  ROW('có cách nhìn hợp lý hơn', 0.95),
  ROW('thấy có nhiều khả năng khác', 0.95),
  ROW('nhận ra không phải chỉ có một kết quả', 1.0),
  ROW('hiểu rằng suy nghĩ ban đầu chưa chắc đúng', 1.0),
  ROW('thấy có thể thông cảm hơn', 0.9),
  ROW('nghĩ lại thì thấy ổn hơn', 0.9),
  ROW('không còn quá tiêu cực nữa', 0.95),
  ROW('nhìn lại thấy bớt căng', 0.9),
  ROW('thấy vấn đề nhỏ hơn', 0.9),
  ROW('hiểu là có nhiều cách hiểu khác nhau', 1.0),
  ROW('nhận ra suy nghĩ này không hoàn toàn đúng', 1.0),
  ROW('thấy mình có thể linh hoạt hơn', 0.95),
  ROW('bắt đầu nhìn vấn đề thoáng hơn', 0.95),
  ROW('hiểu rằng không cần quá khắt khe', 0.9),
  ROW('nhìn lại thì thấy đỡ áp lực', 0.9),
  ROW('nhận ra mình đang tự làm khó bản thân', 1.0),
  ROW('thấy suy nghĩ này không công bằng lắm', 1.0),
  ROW('hiểu là có thể cho bản thân cơ hội', 0.95),
  ROW('nhìn vấn đề mềm hơn', 0.9),
  ROW('thấy bản thân không cần hoàn hảo', 0.95),
  ROW('nhận ra lỗi không nói lên tất cả', 1.0),
  ROW('hiểu rằng một chuyện không định nghĩa mọi thứ', 1.0),
  ROW('nghĩ khác đi thì thấy dễ thở hơn', 0.95),
  ROW('thấy không cần tự trách nhiều như vậy', 1.0),
  ROW('hiểu rằng cảm xúc này rồi sẽ qua', 0.95),
  ROW('nhận ra mình đang phóng đại vấn đề', 1.0),
  ROW('thấy mọi chuyện không trắng đen như vậy', 1.0),
  ROW('hiểu là có vùng xám ở giữa', 1.0),
  ROW('nhìn ra mặt tích cực hơn', 0.9),
  ROW('thấy có điều học được từ chuyện này', 0.95),
  ROW('hiểu là không phải mọi thứ đều do mình', 1.0),
  ROW('thấy nhẹ đầu hơn sau khi nghĩ lại', 0.95),
  ROW('nhận ra suy nghĩ cũ không còn hợp nữa', 1.0),
  ROW('hiểu rằng mình có quyền nghĩ khác', 0.95),
  ROW('thấy bản thân bớt gay gắt hơn', 0.9),
  ROW('nhìn lại thì thấy không đáng sợ như tưởng', 1.0),
  ROW('hiểu rằng sai không có nghĩa là thất bại', 1.0),
  ROW('thấy có thể chấp nhận chuyện này', 0.95),
  ROW('nhận ra mình đang tự gây áp lực', 1.0),
  ROW('hiểu rằng không cần nghĩ theo kiểu tất cả hoặc không gì', 1.0),
  ROW('thấy suy nghĩ này thực tế hơn', 0.95),
  ROW('nhìn vấn đề cân bằng hơn', 0.95),
  ROW('hiểu rằng có thể từ từ', 0.9),
  ROW('thấy không cần phải vội kết luận', 0.95),
  ROW('nhận ra có nhiều yếu tố khác', 0.95),
  ROW('hiểu rằng bản thân không tệ như nghĩ', 1.0),
  ROW('thấy có thể đối xử nhẹ nhàng hơn với bản thân', 1.0),
  ROW('nhìn lại thì thấy có hy vọng hơn', 0.95),
  ROW('hiểu rằng suy nghĩ chỉ là suy nghĩ', 1.0),
  ROW('thấy không cần tin mọi suy nghĩ xuất hiện', 1.0),
  ROW('nhận ra mình có quyền chọn cách nghĩ khác', 1.0),
  ROW('hiểu rằng mình không bị kẹt mãi', 0.95),  
  ROW('thấy đầu óc rõ ràng hơn', 0.9),
  ROW('nhìn vấn đề bình tĩnh hơn', 0.9),
  ROW('hiểu rằng cảm xúc không phải sự thật', 1.0),
  ROW('thấy suy nghĩ này bớt nặng nề', 0.95),
  ROW('nhận ra mình có thể thay đổi cách nhìn', 1.0),
  ROW('hiểu rằng chuyện này không quyết định tương lai', 1.0),
  ROW('thấy mọi thứ có thể linh hoạt', 0.95),
  ROW('nhìn lại thì thấy ổn hơn nhiều', 0.9),
  ROW('hiểu rằng không cần tự dán nhãn tiêu cực', 1.0),
  ROW('thấy có thể cho bản thân thêm thời gian', 0.95),
  ROW('nhận ra suy nghĩ mới dễ chịu hơn', 1.0),

  ROW('nghĩ theo cách khác rồi', 1.0),
  
  ROW('nhìn ra góc khác', 0.95),
  
  ROW('thấy nhẹ hơn khi đổi góc nhìn', 0.95),
  
  ROW('không còn nghĩ một chiều nữa', 0.9),
  
  ROW('hiểu vấn đề khác đi', 0.9),
  
  ROW('thấy không tệ như ban đầu', 0.9),
  
  ROW('nhận ra mình đang nghĩ hơi cực đoan', 1.0),
  
  ROW('có cách nhìn hợp lý hơn', 0.95),
  
  ROW('thấy có nhiều khả năng khác', 0.95),
  
  ROW('nhận ra không phải chỉ có một kết quả', 1.0),

  
  ROW('hiểu rằng suy nghĩ ban đầu chưa chắc đúng', 1.0),
  
  ROW('thấy có thể thông cảm hơn', 0.9),
  
  ROW('nghĩ lại thì thấy ổn hơn', 0.9),
  
  ROW('không còn quá tiêu cực nữa', 0.95),
  
  ROW('nhìn lại thấy bớt căng', 0.9),
  
  ROW('thấy vấn đề nhỏ hơn', 0.9),
  
  ROW('hiểu là có nhiều cách hiểu khác nhau', 1.0),
  
  ROW('nhận ra suy nghĩ này không hoàn toàn đúng', 1.0),
  
  ROW('thấy mình có thể linh hoạt hơn', 0.95),
  
  ROW('bắt đầu nhìn vấn đề thoáng hơn', 0.95),

  
  ROW('hiểu rằng không cần quá khắt khe', 0.9),
  -- 22
  ROW('nhìn lại thì thấy đỡ áp lực', 0.9),
  -- 23
  ROW('nhận ra mình đang tự làm khó bản thân', 1.0),
  -- 24
  ROW('thấy suy nghĩ này không công bằng lắm', 1.0),
  -- 25
  ROW('hiểu là có thể cho bản thân cơ hội', 0.95),
  -- 26
  ROW('nhìn vấn đề mềm hơn', 0.9),
  -- 27
  ROW('thấy bản thân không cần hoàn hảo', 0.95),
  -- 28
  ROW('nhận ra lỗi không nói lên tất cả', 1.0),
  -- 29
  ROW('hiểu rằng một chuyện không định nghĩa mọi thứ', 1.0),
  -- 30
  ROW('nghĩ khác đi thì thấy dễ thở hơn', 0.95),

  -- 31
  ROW('thấy không cần tự trách nhiều như vậy', 1.0),
  -- 32
  ROW('hiểu rằng cảm xúc này rồi sẽ qua', 0.95),
  -- 33
  ROW('nhận ra mình đang phóng đại vấn đề', 1.0),
  -- 34
  ROW('thấy mọi chuyện không trắng đen như vậy', 1.0),
  -- 35
  ROW('hiểu là có vùng xám ở giữa', 1.0),
  -- 36
  ROW('nhìn ra mặt tích cực hơn', 0.9),
  -- 37
  ROW('thấy có điều học được từ chuyện này', 0.95),
  -- 38
  ROW('hiểu là không phải mọi thứ đều do mình', 1.0),
  -- 39
  ROW('thấy nhẹ đầu hơn sau khi nghĩ lại', 0.95),
  -- 40
  ROW('nhận ra suy nghĩ cũ không còn hợp nữa', 1.0),

  -- 41
  ROW('hiểu rằng mình có quyền nghĩ khác', 0.95),
  -- 42
  ROW('thấy bản thân bớt gay gắt hơn', 0.9),
  -- 43
  ROW('nhìn lại thì thấy không đáng sợ như tưởng', 1.0),
  -- 44
  ROW('hiểu rằng sai không có nghĩa là thất bại', 1.0),
  -- 45
  ROW('thấy có thể chấp nhận chuyện này', 0.95),
  -- 46
  ROW('nhận ra mình đang tự gây áp lực', 1.0),
  -- 47
  ROW('hiểu rằng không cần nghĩ theo kiểu tất cả hoặc không gì', 1.0),
  -- 48
  ROW('thấy suy nghĩ này thực tế hơn', 0.95),
  -- 49
  ROW('nhìn vấn đề cân bằng hơn', 0.95),
  -- 50
  ROW('hiểu rằng có thể từ từ', 0.9),

  -- 51
  ROW('thấy không cần phải vội kết luận', 0.95),
  -- 52
  ROW('nhận ra có nhiều yếu tố khác', 0.95),
  -- 53
  ROW('hiểu rằng bản thân không tệ như nghĩ', 1.0),
  -- 54
  ROW('thấy có thể đối xử nhẹ nhàng hơn với bản thân', 1.0),
  -- 55
  ROW('nhìn lại thì thấy có hy vọng hơn', 0.95),
  -- 56
  ROW('hiểu rằng suy nghĩ chỉ là suy nghĩ', 1.0),
  -- 57
  ROW('thấy không cần tin mọi suy nghĩ xuất hiện', 1.0),
  -- 58
  ROW('nhận ra mình có quyền chọn cách nghĩ khác', 1.0),
  -- 59
  ROW('hiểu rằng mình không bị kẹt mãi', 0.95),
  -- 60
  ROW('thấy đầu óc rõ ràng hơn', 0.9),

  -- 61
  ROW('nhìn vấn đề bình tĩnh hơn', 0.9),
  -- 62
  ROW('hiểu rằng cảm xúc không phải sự thật', 1.0),
  -- 63
  ROW('thấy suy nghĩ này bớt nặng nề', 0.95),
  -- 64
  ROW('nhận ra mình có thể thay đổi cách nhìn', 1.0),
  -- 65
  ROW('hiểu rằng chuyện này không quyết định tương lai', 1.0),
  -- 66
  ROW('thấy mọi thứ có thể linh hoạt', 0.95),
  -- 67
  ROW('nhìn lại thì thấy ổn hơn nhiều', 0.9),
  -- 68
  ROW('hiểu rằng không cần tự dán nhãn tiêu cực', 1.0),
  -- 69
  ROW('thấy có thể cho bản thân thêm thời gian', 0.95),
  -- 70
  ROW('nhận ra suy nghĩ mới dễ chịu hơn', 1.0),

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn tiêu cực', 0.9),
  ROW('không nghĩ khác được', 0.8),
  ROW('không thấy khác gì', 1.0),
  ROW('vẫn nghĩ vậy thôi', 1.0),
  ROW('không đổi được suy nghĩ', 1.0),
  ROW('vẫn thấy y như cũ', 0.95),
  ROW('không thấy góc nhìn khác', 1.0),
  ROW('không hiểu nhìn khác kiểu gì', 1.0),
  ROW('thấy mấy cách này không hợp', 0.9),
  ROW('vẫn thấy rất tiêu cực', 1.0),
  ROW('không thấy cách nghĩ này đúng', 0.95),
  ROW('cảm giác vẫn vậy', 0.95),
  ROW('đổi góc nhìn khó quá', 1.0),
  ROW('không nghĩ ra được cách khác', 1.0),
  ROW('vẫn tin suy nghĩ ban đầu', 1.0),
  ROW('thấy mấy câu hỏi này không giúp', 0.9),
  ROW('không thấy hợp lý', 0.95),
  ROW('vẫn thấy chuyện này rất tệ', 1.0),
  ROW('không thay đổi được gì', 1.0),
  ROW('thấy rối hơn', 0.95),
  ROW('nghĩ càng thêm mệt', 1.0),
  ROW('không biết nghĩ sao cho khác', 1.0),
  ROW('vẫn bị kẹt trong suy nghĩ đó', 1.0),
  ROW('không thấy nhẹ hơn', 0.95),
  ROW('cảm giác vẫn nặng', 0.95),
  ROW('không tin vào cách nghĩ mới', 1.0),
  ROW('thấy cách này không hiệu quả', 0.95),
  ROW('vẫn thấy mọi thứ rất tệ', 1.0),
  ROW('không thuyết phục được bản thân', 1.0),
  ROW('vẫn thấy suy nghĩ cũ đúng hơn', 1.0),
  ROW('không chấp nhận được góc nhìn khác', 1.0),
  ROW('thấy khó tin', 0.95),
  ROW('không thấy logic', 0.95),
  ROW('cảm giác như đang tự lừa mình', 1.0),
  ROW('vẫn không ổn', 0.9),
  ROW('không thấy thuyết phục', 1.0),
  ROW('vẫn thấy bản thân tệ', 1.0),
  ROW('không thấy có gì thay đổi', 1.0),
  ROW('nghĩ vậy nghe giả', 0.95),
  ROW('không thấy phù hợp với tình huống', 0.95),
  ROW('vẫn bị suy nghĩ này chi phối', 1.0),
  ROW('chưa sẵn sàng nghĩ khác', 1.0),
  ROW('không thấy dễ hơn', 0.95),
  ROW('vẫn rất cứng nhắc', 1.0),
  ROW('không thay đổi được cảm nhận', 1.0),
  ROW('vẫn thấy bế tắc', 1.0),
  ROW('không thấy cách nhìn này có ích', 0.95),
  ROW('không cảm nhận được gì mới', 0.95),
  ROW('vẫn thấy mọi thứ đen tối', 1.0),
  ROW('không thể tin suy nghĩ khác', 1.0),
  ROW('thấy suy nghĩ này gượng ép', 1.0),
  ROW('chưa thể nhìn khác lúc này', 1.0),
  ROW('vẫn bị cuốn theo suy nghĩ cũ', 1.0),
  ROW('không thấy nhẹ đầu hơn', 0.95),
  ROW('vẫn bị mắc kẹt', 1.0),
  ROW('không thấy thoải mái hơn', 0.95),
  ROW('chưa sẵn sàng thay đổi góc nhìn', 1.0),
  ROW('vẫn thấy mọi thứ rất nặng nề', 1.0),
  ROW('không thể nghĩ tích cực hơn', 1.0),
  ROW('chưa thể thoát khỏi suy nghĩ này', 1.0),
  ROW('cảm giác suy nghĩ này quá thật', 1.0),
  ROW('không thể nhìn xa hơn', 0.95),
  ROW('vẫn bị dính vào suy nghĩ đó', 1.0),
  ROW('chưa thể tách cảm xúc khỏi suy nghĩ', 1.0),
  ROW('thấy khó mà tin cách nghĩ khác', 1.0),
  ROW('chưa thể mở lòng với góc nhìn mới', 1.0),

  ROW('does not feel different', 1.0),
  ROW('still thinking the same way', 1.0),
  ROW('cannot change the thought', 1.0),
  ROW('feels exactly the same', 0.95),
  ROW('cannot see another perspective', 1.0),
  ROW('does not know how to reframe this', 1.0),
  ROW('this approach does not help', 0.95),
  ROW('still feels very negative', 1.0),
  ROW('cannot accept the new perspective', 1.0),
  ROW('feels unchanged', 0.95),
  ROW('reframing feels too hard', 1.0),
  ROW('cannot think of another way', 1.0),
  ROW('still believes the original thought', 1.0),
  ROW('these questions do not help', 0.95),
  ROW('does not feel convincing', 1.0),
  ROW('still feels really bad', 1.0),
  ROW('nothing has changed', 1.0),
  ROW('feels more confused', 0.95),
  ROW('thinking makes it worse', 1.0),
  ROW('does not know how to think differently', 1.0),
  ROW('still stuck in the same thought', 1.0),
  ROW('does not feel lighter', 0.95),
  ROW('still feels heavy', 0.95),
  ROW('does not trust the new thought', 1.0),
  ROW('this does not feel effective', 0.95),
  ROW('still sees everything negatively', 1.0),
  ROW('cannot convince oneself', 1.0),
  ROW('old thought feels more true', 1.0),
  ROW('cannot accept another view', 1.0),
  ROW('feels hard to believe', 0.95),
  ROW('does not make sense', 0.95),
  ROW('feels like lying to oneself', 1.0),
  ROW('still not okay', 0.9),
  ROW('does not feel realistic', 1.0),
  ROW('still feels like a bad person', 1.0),
  ROW('no noticeable change', 1.0),
  ROW('this feels forced', 1.0),
  ROW('does not fit the situation', 0.95),
  ROW('still controlled by the thought', 1.0),
  ROW('not ready to think differently', 1.0),
  ROW('does not feel easier', 0.95),
  ROW('thinking still feels rigid', 1.0),
  ROW('cannot change the feeling', 1.0),
  ROW('still feels stuck', 1.0),
  ROW('this perspective does not help', 0.95),
  ROW('nothing new is felt', 0.95),
  ROW('everything still feels dark', 1.0),
  ROW('cannot believe another interpretation', 1.0),
  ROW('this thought feels fake', 1.0),
  ROW('cannot reframe right now', 1.0),
  ROW('still pulled into old thinking', 1.0),
  ROW('does not feel mentally lighter', 0.95),
  ROW('still trapped in the thought', 1.0),
  ROW('does not feel calmer', 0.95),
  ROW('not ready to change perspective', 1.0),
  ROW('still feels overwhelming', 1.0),
  ROW('cannot let go of the thought', 1.0),
  ROW('this thought feels too real', 1.0),
  ROW('unable to step back mentally', 1.0),
  ROW('still fused with the thought', 1.0),
  ROW('cannot separate feelings from thoughts', 1.0),
  ROW('not open to a new perspective yet', 1.0),
  ROW('this way of thinking feels fixed', 1.0),
  ROW('unable to see beyond this thought', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có nhận ra điều gì mới không', 1.0),
  ROW('muốn thử nghĩ theo hướng khác nữa không', 0.8),
  ROW('có thể thử nhìn chuyện này theo một cách khác không', 1.0),
  ROW('nếu đổi góc nhìn một chút thì sao', 0.95),
  ROW('có khả năng nào khác cho tình huống này không', 1.0),
  ROW('điều gì khiến suy nghĩ này xuất hiện', 0.95),
  ROW('có bằng chứng nào ủng hộ suy nghĩ đó không', 1.0),
  ROW('có bằng chứng nào đi ngược lại suy nghĩ này không', 1.0),
  ROW('nếu một người khác gặp chuyện này thì sẽ nghĩ sao', 1.0),
  ROW('có đang nhìn mọi thứ hơi cực đoan không', 1.0),
  ROW('liệu có cách diễn giải nhẹ hơn không', 0.95),
  ROW('điều tệ nhất có chắc chắn sẽ xảy ra không', 1.0),
  ROW('điều này có còn đúng trong vài ngày nữa không', 0.95),
  ROW('suy nghĩ này giúp hay làm khó bản thân hơn', 1.0),
  ROW('nếu bỏ bớt một phần áp lực thì suy nghĩ sẽ thế nào', 0.95),
  ROW('có đang tự đặt tiêu chuẩn quá cao không', 1.0),
  ROW('có đang tự trách quá nhiều không', 1.0),
  ROW('chuyện này có nói lên toàn bộ con người không', 1.0),
  ROW('liệu đây có phải là kết luận quá nhanh không', 1.0),
  ROW('có đang giả định điều gì mà chưa chắc đúng không', 1.0),
  ROW('có thể chia nhỏ vấn đề này ra không', 0.95),
  ROW('nếu nhìn từ xa hơn thì sao', 0.95),

  ROW('điều gì nằm trong tầm kiểm soát lúc này', 1.0),
  ROW('điều gì không nằm trong tầm kiểm soát', 0.95),
  ROW('có đang gộp mọi thứ thành một không', 1.0),
  ROW('liệu có đang tự gắn nhãn tiêu cực không', 1.0),
  ROW('nếu nghĩ theo cách trung lập hơn thì sao', 1.0),
  ROW('suy nghĩ này có 100 phần trăm đúng không', 1.0),
  ROW('có thể giảm mức độ nghiêm trọng xuống không', 0.95),
  ROW('điều này có thật sự nói lên tương lai không', 1.0),
  ROW('nếu cho phép bản thân sai thì sao', 0.95),
  ROW('có đang so sánh quá nhiều không', 0.95),
  ROW('có thể tạm hoãn kết luận không', 1.0),
  ROW('liệu cảm xúc đang ảnh hưởng đến suy nghĩ không', 1.0),
  ROW('nếu cảm xúc dịu lại thì suy nghĩ có đổi không', 0.95),
  ROW('có thể viết suy nghĩ này ra và nhìn lại không', 0.9),
  ROW('điều gì khiến suy nghĩ này nghe rất thật', 1.0),
  ROW('có đang đánh đồng một chuyện với tất cả không', 1.0),
  ROW('nếu thay đổi một từ trong suy nghĩ thì sao', 0.95),
  ROW('có thể thêm chữ “có thể” vào suy nghĩ này không', 1.0),
  ROW('liệu đây có phải là suy nghĩ quen thuộc không', 0.95),
  ROW('suy nghĩ này xuất hiện thường xuyên hay chỉ lúc này', 0.95),

  ROW('nếu nhìn bằng con mắt của người ngoài thì sao', 1.0),
  ROW('có thể thử nhìn nhẹ nhàng hơn không', 0.95),
  ROW('điều gì đang bị bỏ sót trong cách nhìn này', 1.0),
  ROW('liệu có đang tự đổ lỗi quá mức không', 1.0),
  ROW('nếu đặt suy nghĩ này sang một bên tạm thời thì sao', 0.95),
  ROW('có thể xem đây là một giả thuyết thay vì sự thật không', 1.0),
  ROW('nếu thay đổi cách diễn đạt thì cảm giác có khác không', 0.95),
  ROW('có thể hỏi thêm một câu trước khi kết luận không', 1.0),
  ROW('điều gì sẽ xảy ra nếu suy nghĩ này không hoàn toàn đúng', 1.0),
  ROW('có thể cho bản thân thêm thời gian để nghĩ lại không', 0.95),
  ROW('nếu không cần trả lời ngay thì sao', 0.9),
  ROW('suy nghĩ này có đang bảo vệ hay làm tổn thương', 1.0),
  ROW('có thể thử giữ hai khả năng cùng lúc không', 1.0),
  ROW('liệu có đang nhìn mọi thứ theo kiểu tất cả hoặc không gì', 1.0),
  ROW('nếu thay đổi câu hỏi thì sao', 0.95),
  ROW('có thể thử một góc nhìn trung gian không', 1.0),
  ROW('điều gì sẽ nói với một người bạn trong trường hợp này', 1.0),
  ROW('có thể thử nghĩ theo cách đó cho bản thân không', 1.0),
  ROW('nếu không tự trách thì suy nghĩ sẽ thế nào', 1.0),
  ROW('liệu có thể chấp nhận chưa cần chắc chắn không', 0.95),

  ROW('can we look at this from a different angle', 1.0),
  ROW('what if there is another way to see this', 1.0),
  ROW('what evidence supports this thought', 1.0),
  ROW('what evidence might challenge it', 1.0),
  ROW('is there another possible explanation', 1.0),
  ROW('how would someone else see this situation', 1.0),
  ROW('is this an all-or-nothing thought', 1.0),
  ROW('could this be an assumption rather than a fact', 1.0),
  ROW('what might be missing from this perspective', 1.0),
  ROW('is this thought helping or hurting right now', 1.0),
  ROW('what happens if the intensity is lowered', 0.95),
  ROW('does this thought apply all the time', 1.0),
  ROW('could there be a middle ground', 1.0),
  ROW('what would a neutral observer notice', 1.0),
  ROW('is this the only possible conclusion', 1.0),
  ROW('could this be a habit of thinking', 0.95),
  ROW('what part of this is in control right now', 1.0),
  ROW('what part is outside of control', 0.95),
  ROW('is this thought influenced by emotion', 1.0),
  ROW('how might this look later on', 0.95),

  ROW('what if this thought is only partly true', 1.0),
  ROW('can this thought be softened', 0.95),
  ROW('what would be said to a friend in this situation', 1.0),
  ROW('can that same kindness be applied here', 1.0),
  ROW('is this a quick conclusion', 1.0),
  ROW('what happens if judgment is paused', 1.0),
  ROW('could this thought be rewritten slightly', 0.95),
  ROW('what if the wording is changed', 0.95),
  ROW('is this thought too absolute', 1.0),
  ROW('what happens if certainty is reduced', 0.95),
  ROW('is there room for another explanation', 1.0),
  ROW('what does this thought assume', 1.0),
  ROW('is there a more balanced version', 1.0),
  ROW('what if this is not permanent', 1.0),
  ROW('how would this sound in a calmer moment', 0.95),
  ROW('is this thought predicting the future', 1.0),
  ROW('what if the prediction is wrong', 1.0),
  ROW('could this be viewed as one moment only', 1.0),
  ROW('what if this does not define everything', 1.0),
  ROW('is there another question worth asking', 1.0),

  ROW('what happens if this thought is held loosely', 1.0),
  ROW('can this be treated as a possibility', 1.0),
  ROW('what else could be true at the same time', 1.0),
  ROW('is this thought kind or harsh', 1.0),
  ROW('what would a more supportive thought sound like', 1.0),
  ROW('can this be slowed down', 0.95),
  ROW('what if certainty is not required right now', 0.95),
  ROW('is this thought reacting or reflecting', 1.0),
  ROW('could this be emotional reasoning', 1.0),
  ROW('what happens if this thought is questioned', 1.0),
  ROW('what is the cost of holding this belief', 1.0),
  ROW('what is the benefit of loosening it', 1.0),
  ROW('is there a gentler interpretation', 1.0),
  ROW('can two things be true at once', 1.0),
  ROW('what if this is not personal', 1.0),
  ROW('how would this look from a distance', 0.95),
  ROW('is there another story that fits', 1.0),
  ROW('what if this thought is temporary', 1.0),
  ROW('what happens if pressure is reduced', 0.95),
  ROW('is there a more flexible way to see this', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_reframe'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết vì sao lại nghĩ như vậy', 0.9),
  ROW('trong tình huống này tự nhiên nghĩ thế', 1.0),
  ROW('sau chuyện đó thì suy nghĩ bắt đầu', 1.0),
  ROW('có một suy nghĩ lặp đi lặp lại', 0.95),
  ROW('xảy ra chuyện này rồi cảm thấy rất tệ', 1.0),
  ROW('nghĩ vậy xong thì thấy buồn', 1.0),
  ROW('có suy nghĩ làm cảm xúc nặng hơn', 1.0),
  ROW('không rõ cảm xúc đến từ đâu', 0.9),
  ROW('chuyện này khiến suy nghĩ rối lên', 1.0),
  ROW('mỗi lần gặp tình huống này lại nghĩ vậy', 1.0),
  ROW('suy nghĩ xuất hiện ngay sau đó', 1.0),
  ROW('nghĩ hoài một chuyện không dứt ra được', 0.95),
  ROW('sau khi chuyện xảy ra thì cảm xúc lên rất nhanh', 1.0),
  ROW('khó hiểu vì sao lại phản ứng mạnh vậy', 0.95),
  ROW('cảm xúc đến kèm theo suy nghĩ đó', 1.0),
  ROW('có suy nghĩ khiến tâm trạng tụt xuống', 1.0),
  ROW('không biết suy nghĩ này từ đâu ra', 0.9),
  ROW('chuyện nhỏ nhưng suy nghĩ lại rất lớn', 1.0),
  ROW('nghĩ vậy rồi cảm thấy áp lực', 1.0),
  ROW('mỗi lần nhớ lại chuyện đó là suy nghĩ quay lại', 1.0),

  ROW('tình huống này làm đầu óc rối', 0.95),
  ROW('có cảm xúc mạnh kèm theo suy nghĩ', 1.0),
  ROW('không chắc suy nghĩ này có hợp lý không', 0.9),
  ROW('phản ứng cảm xúc mạnh hơn mong đợi', 1.0),
  ROW('suy nghĩ này làm cảm xúc tăng lên', 1.0),
  ROW('khó tách suy nghĩ ra khỏi cảm xúc', 1.0),
  ROW('một chuyện xảy ra kéo theo nhiều suy nghĩ', 1.0),
  ROW('cảm xúc thay đổi sau khi nghĩ vậy', 1.0),
  ROW('suy nghĩ này ảnh hưởng đến cách nhìn mọi thứ', 0.95),
  ROW('tình huống đó làm xuất hiện suy nghĩ tiêu cực', 1.0),
  ROW('không rõ là do chuyện hay do suy nghĩ', 1.0),
  ROW('cảm xúc mạnh xuất hiện sau một suy nghĩ', 1.0),
  ROW('suy nghĩ này làm mọi thứ tệ hơn', 1.0),
  ROW('mỗi lần gặp chuyện tương tự lại nghĩ vậy', 1.0),
  ROW('cảm xúc đến ngay sau khi suy nghĩ xuất hiện', 1.0),
  ROW('suy nghĩ này gắn liền với một sự kiện cụ thể', 1.0),
  ROW('khó hiểu phản ứng của bản thân trong tình huống này', 0.95),
  ROW('có một suy nghĩ khiến cảm xúc mất kiểm soát', 1.0),
  ROW('suy nghĩ xuất hiện rất nhanh trong tình huống đó', 1.0),
  ROW('không kịp nhận ra mình đang nghĩ gì', 0.9),

  ROW('sau sự việc này thì cảm xúc thay đổi hẳn', 1.0),
  ROW('một tình huống nhỏ nhưng cảm xúc rất lớn', 1.0),
  ROW('có suy nghĩ khiến bản thân phản ứng mạnh', 1.0),
  ROW('không chắc suy nghĩ hay cảm xúc đến trước', 1.0),
  ROW('cảm xúc bị kéo theo bởi suy nghĩ', 1.0),
  ROW('suy nghĩ này xuất hiện trong đầu rất rõ', 0.9),
  ROW('tình huống đó làm suy nghĩ trở nên tiêu cực', 1.0),
  ROW('cảm xúc xuất hiện ngay khi nghĩ đến chuyện đó', 1.0),
  ROW('khó dừng suy nghĩ sau sự việc', 1.0),
  ROW('một chuyện kích hoạt cả suy nghĩ lẫn cảm xúc', 1.0),
  ROW('suy nghĩ này làm phản ứng trở nên quá mức', 1.0),
  ROW('có một khoảnh khắc kích hoạt suy nghĩ', 1.0),
  ROW('cảm xúc thay đổi ngay sau suy nghĩ đó', 1.0),
  ROW('không hiểu vì sao tình huống này ảnh hưởng nhiều vậy', 0.95),
  ROW('suy nghĩ này khiến tâm trạng đi xuống nhanh', 1.0),
  ROW('có mối liên hệ giữa chuyện xảy ra và suy nghĩ', 1.0),
  ROW('suy nghĩ đó làm cảm xúc trở nên mạnh hơn', 1.0),
  ROW('phản ứng cảm xúc không tương xứng với tình huống', 1.0),
  ROW('khó hiểu phản ứng của bản thân sau chuyện này', 0.95),
  ROW('suy nghĩ xuất hiện tự động trong tình huống đó', 1.0),

  ROW('not sure why this thought appeared', 0.9),
  ROW('after that situation the thought showed up', 1.0),
  ROW('this situation triggered the thought', 1.0),
  ROW('a thought keeps repeating', 0.95),
  ROW('the event led to a strong feeling', 1.0),
  ROW('thinking this made the emotion worse', 1.0),
  ROW('the thought and feeling came together', 1.0),
  ROW('not sure where the feeling came from', 0.9),
  ROW('this situation made the mind spiral', 1.0),
  ROW('every time this happens the same thought appears', 1.0),
  ROW('the thought showed up right after the event', 1.0),
  ROW('cannot stop thinking about what happened', 0.95),
  ROW('after the event the emotion spiked', 1.0),
  ROW('reaction feels stronger than expected', 1.0),
  ROW('the emotion followed the thought', 1.0),
  ROW('this thought lowered the mood', 1.0),
  ROW('not sure where this thought came from', 0.9),
  ROW('small event but big reaction', 1.0),
  ROW('thinking this caused pressure', 1.0),
  ROW('remembering the event brings the thought back', 1.0),

  ROW('this situation caused mental confusion', 0.95),
  ROW('a strong emotion came with the thought', 1.0),
  ROW('not sure if the thought is realistic', 0.9),
  ROW('emotional reaction feels intense', 1.0),
  ROW('the thought increased the emotion', 1.0),
  ROW('hard to separate thought and feeling', 1.0),
  ROW('one event led to many thoughts', 1.0),
  ROW('emotion changed after the thought', 1.0),
  ROW('this thought affects how everything is seen', 0.95),
  ROW('the situation triggered negative thinking', 1.0),
  ROW('not sure if it is the event or the thought', 1.0),
  ROW('emotion appeared after a thought', 1.0),
  ROW('this thought makes things feel worse', 1.0),
  ROW('similar situations trigger the same thought', 1.0),
  ROW('emotion followed the thought quickly', 1.0),
  ROW('the thought is tied to a specific event', 1.0),
  ROW('reaction to the situation feels confusing', 0.95),
  ROW('a thought caused loss of emotional control', 1.0),
  ROW('the thought appeared instantly in that moment', 1.0),
  ROW('did not notice the thought right away', 0.9),

  ROW('after the event the mood changed completely', 1.0),
  ROW('small situation but strong emotion', 1.0),
  ROW('a thought led to an intense reaction', 1.0),
  ROW('not sure which came first thought or feeling', 1.0),
  ROW('emotion was driven by the thought', 1.0),
  ROW('the thought feels very clear in the mind', 0.9),
  ROW('the situation pushed thinking negative', 1.0),
  ROW('emotion shows up when thinking about the event', 1.0),
  ROW('hard to stop thinking after what happened', 1.0),
  ROW('one moment triggered thoughts and feelings', 1.0),
  ROW('this thought caused an overreaction', 1.0),
  ROW('there was a moment that triggered the thought', 1.0),
  ROW('emotion changed right after the thought', 1.0),
  ROW('not sure why this situation affects so much', 0.95),
  ROW('this thought quickly pulled the mood down', 1.0),
  ROW('there is a link between the event and the thought', 1.0),
  ROW('the thought made the emotion stronger', 1.0),
  ROW('emotional response does not match the situation', 1.0),
  ROW('reaction after the event feels confusing', 0.95),
  ROW('the thought appeared automatically in that situation', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
ROW('hiểu rõ hơn rồi', 1.0),
ROW('thấy rõ ràng hơn', 1.0),
ROW('hiểu rõ hơn rồi', 1.0),
ROW('thấy rõ ràng hơn', 1.0),
ROW('nhẹ lòng hơn', 1.0),
ROW('đỡ rối đầu hơn', 1.0),
ROW('đầu óc thoáng hơn', 0.95),
ROW('suy nghĩ gọn hơn', 0.95),
ROW('bớt lộn xộn trong đầu', 0.95),
ROW('không còn rối như trước', 0.95),
ROW('đỡ bị cuốn trong suy nghĩ', 0.95),
ROW('không còn xoay vòng trong đầu', 0.95),
ROW('viết xuống thấy có tác dụng', 0.95),
ROW('ghi ra giúp dễ chịu hơn', 0.95),
ROW('viết ra xong thấy ổn hơn', 0.95),
ROW('ghi lại xong thấy nhẹ hơn', 0.95),
ROW('viết xuống giúp dễ hiểu hơn', 0.95),
ROW('nhìn vấn đề rõ hơn', 0.9),
ROW('thấy suy nghĩ rõ ràng hơn', 0.9),
ROW('dễ nhìn nhận hơn', 0.9),
ROW('đỡ bị mắc kẹt trong đầu', 0.9),
ROW('suy nghĩ không còn đè nặng', 0.9),
ROW('bớt áp lực trong đầu', 0.9),
ROW('đỡ căng trong suy nghĩ', 0.9),
ROW('đỡ nặng đầu hơn', 0.9),
ROW('cảm giác nhẹ hơn trong đầu', 0.9),
ROW('tâm trí thoải mái hơn', 0.9),
ROW('dễ suy nghĩ tiếp hơn', 0.85),
ROW('đỡ mơ hồ hơn', 0.85),
ROW('bớt bị rối vì suy nghĩ', 0.85),
ROW('có cảm giác kiểm soát hơn', 0.85),
ROW('suy nghĩ dễ chịu hơn', 0.85),
ROW('viết ra giúp nhìn khác đi', 0.85),
ROW('ghi ra xong thấy đỡ hơn', 0.85),
ROW('viết ra giúp đầu óc thoáng hơn', 0.85),
ROW('ghi lại giúp không bị nghẹt đầu', 0.85),
ROW('suy nghĩ bớt căng thẳng', 0.85),
ROW('dễ hiểu bản thân hơn', 0.8),
ROW('biết rõ đang nghĩ gì', 0.8),
ROW('không còn mơ hồ như trước', 0.8),
ROW('đỡ bị suy nghĩ chi phối', 0.8),
ROW('tách được suy nghĩ ra', 0.8),
ROW('viết xong thấy ổn hơn chút', 0.8),
ROW('ghi ra rồi thấy nhẹ hơn chút', 0.8),
ROW('đầu óc bớt căng', 0.8),
ROW('cảm giác dễ chịu hơn', 0.8),
ROW('thấy đỡ hơn rồi', 0.8),
ROW('không còn nặng đầu như lúc đầu', 0.75),
ROW('đỡ bị xoáy trong suy nghĩ', 0.75),
ROW('cảm giác đầu óc yên hơn', 0.75),
ROW('dễ tiếp tục làm việc khác hơn', 0.75),
ROW('tạm ổn hơn rồi', 0.75),
ROW('viết ra giúp bớt áp lực', 0.75),
ROW('ghi suy nghĩ ra thấy nhẹ đầu', 0.75),
ROW('suy nghĩ không còn dồn dập', 0.75),
ROW('cảm giác thông suốt hơn', 0.75),
ROW('đầu óc không còn bí', 0.75),
ROW('ghi ra xong thấy dễ thở hơn', 0.75),
ROW('suy nghĩ bớt chồng chéo', 0.75),
ROW('tâm trí đỡ mệt hơn', 0.75),
ROW('cảm giác ổn định hơn', 0.75),
ROW('suy nghĩ dễ quản lý hơn', 0.75),

ROW('feels clearer now', 1.0),
ROW('understand it better now', 1.0),
ROW('feels lighter', 1.0),
ROW('mind feels clearer', 1.0),
ROW('thoughts feel less messy', 0.95),
ROW('head feels less crowded', 0.95),
ROW('things feel more organized', 0.95),
ROW('not as confusing anymore', 0.95),
ROW('less stuck in my thoughts', 0.95),
ROW('not spiraling as much', 0.95),
ROW('writing helped', 0.95),
ROW('writing it down helped', 0.95),
ROW('putting it into words helped', 0.95),
ROW('getting it out helped', 0.95),
ROW('writing made it easier', 0.95),
ROW('see things more clearly', 0.9),
ROW('thoughts make more sense now', 0.9),
ROW('easier to understand what’s going on', 0.9),
ROW('not as overwhelming anymore', 0.9),
ROW('thoughts feel clearer', 0.9),
ROW('feels less heavy', 0.9),
ROW('mental pressure feels lighter', 0.9),
ROW('less tension in my head', 0.9),
ROW('mind feels calmer', 0.9),
ROW('feels more at ease mentally', 0.9),
ROW('easier to think now', 0.85),
ROW('thoughts feel more manageable', 0.85),
ROW('not as jumbled as before', 0.85),
ROW('mind feels more in control', 0.85),
ROW('thoughts feel less intense', 0.85),
ROW('writing helped me see it differently', 0.85),
ROW('getting thoughts out made a difference', 0.85),
ROW('feels better after writing', 0.85),
ROW('writing helped sort things out', 0.85),
ROW('feels less stuck after writing', 0.85),
ROW('understand myself better', 0.8),
ROW('know what I’m thinking now', 0.8),
ROW('thoughts feel more separated', 0.8),
ROW('not trapped in my head anymore', 0.8),
ROW('thinking feels steadier', 0.8),
ROW('feel a bit better now', 0.8),
ROW('feel slightly relieved', 0.8),
ROW('mental load feels lighter', 0.8),
ROW('feel more okay now', 0.8),
ROW('feels calmer overall', 0.8),
ROW('head feels calmer than before', 0.75),
ROW('not looping as much', 0.75),
ROW('thoughts slowed down', 0.75),
ROW('mind feels more settled', 0.75),
ROW('easier to move on now', 0.75),
ROW('writing reduce the pressure', 0.75),
ROW('getting it down cleared my head', 0.75),
ROW('thoughts feel less piled up', 0.75),
ROW('mind feels more open', 0.75),
ROW('thinking feels smoother', 0.75),
ROW('writing helped calm my thoughts', 0.75),
ROW('thoughts feel less chaotic', 0.75),
ROW('mind feels less overwhelmed', 0.75),
ROW('easier to breathe mentally', 0.75),
ROW('feels more balanced', 0.75)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết viết gì', 1.0),
  ROW('không biết nên ghi gì', 1.0),
  ROW('chưa biết bắt đầu từ đâu', 1.0),
  ROW('không rõ nên viết cái gì', 1.0),
  ROW('đầu trống rỗng', 1.0),
  ROW('không nghĩ ra suy nghĩ cụ thể', 1.0),
  ROW('không biết suy nghĩ chính là gì', 1.0),
  ROW('suy nghĩ quá rối', 0.95),
  ROW('đầu óc rối tung', 0.95),
  ROW('khó sắp xếp suy nghĩ', 0.95),
  ROW('suy nghĩ chạy lung tung', 0.95),
  ROW('mọi thứ lộn xộn', 0.95),
  ROW('không gom được suy nghĩ', 0.95),
  ROW('khó hệ thống suy nghĩ', 0.95),
  ROW('khó diễn đạt suy nghĩ', 0.95),
  ROW('không biết dùng từ thế nào', 0.95),
  ROW('viết không thành câu', 0.95),
  ROW('suy nghĩ mơ hồ', 0.95),
  ROW('không rõ ràng', 0.95),
  ROW('viết mà không thấy đỡ', 0.9),
  ROW('ghi ra nhưng vẫn rối', 0.9),
  ROW('viết xong vẫn nặng đầu', 0.9),
  ROW('ghi mà không thấy khác gì', 0.9),
  ROW('chưa thấy tác dụng', 0.9),
  ROW('viết mà không thấy hiệu quả', 0.9),
  ROW('ghi xong vẫn bế tắc', 0.9),
  ROW('cảm giác bị kẹt', 0.9),
  ROW('đầu óc bí', 0.9),
  ROW('không thông', 0.9),
  ROW('bị đứng lại', 0.9),
  ROW('khó tiến triển', 0.9),
  ROW('viết mà càng rối hơn', 0.85),
  ROW('ghi ra thấy mệt hơn', 0.85),
  ROW('viết xuống thấy nặng hơn', 0.85),
  ROW('ghi mà thấy khó chịu hơn', 0.85),
  ROW('không hiểu rõ suy nghĩ', 0.85),
  ROW('khó nhận diện suy nghĩ', 0.85),
  ROW('không phân biệt được suy nghĩ và cảm xúc', 0.85),
  ROW('cảm giác viết chưa đúng', 0.85),
  ROW('không chắc viết vậy có đúng không', 0.85),
  ROW('sợ ghi sai', 0.85),
  ROW('đầu óc quá mệt để viết', 0.85),
  ROW('khó tập trung để ghi', 0.85),
  ROW('viết được một chút rồi kẹt', 0.85),
  ROW('không biết nên viết tiếp gì', 0.8),
  ROW('bí ý', 0.8),
  ROW('không nghĩ ra thêm', 0.8),
  ROW('suy nghĩ rời rạc', 0.8),
  ROW('ghi mà thấy vô nghĩa', 0.8),
  ROW('viết mà không hiểu để làm gì', 0.8),
  ROW('chưa thấy lợi ích rõ ràng', 0.8),
  ROW('cảm giác chưa xong', 0.8),
  ROW('viết nhưng chưa ổn', 0.8),
  ROW('vẫn thấy bế tắc', 0.8),
  ROW('chưa thông ra', 0.8),
  ROW('khó viết khi đầu quá rối', 0.8),
  ROW('không biết phải ghi theo cách nào', 0.8),

  ROW('do not know what to write', 1.0),
  ROW('not sure what to write down', 1.0),
  ROW('do not know where to start', 1.0),
  ROW('mind feels blank', 1.0),
  ROW('cannot think of anything specific', 1.0),
  ROW('not clear what the thought is', 1.0),
  ROW('thoughts are too messy', 0.95),
  ROW('mind feels chaotic', 0.95),
  ROW('hard to organize thoughts', 0.95),
  ROW('thoughts are all over the place', 0.95),
  ROW('everything feels jumbled', 0.95),
  ROW('cannot gather thoughts', 0.95),
  ROW('thoughts feel scattered', 0.95),
  ROW('hard to put thoughts into words', 0.95),
  ROW('cannot describe thoughts clearly', 0.95),
  ROW('sentences do not come out right', 0.95),
  ROW('thoughts feel vague', 0.95),
  ROW('writing does not seem to help', 0.9),
  ROW('wrote it down but feel the same', 0.9),
  ROW('still feel stuck after writing', 0.9),
  ROW('writing did not change much', 0.9),
  ROW('benefit is not clear', 0.9),
  ROW('does not feel effective', 0.9),
  ROW('feel stuck', 0.9),
  ROW('mind feels blocked', 0.9),
  ROW('cannot move forward', 0.9),
  ROW('hit a mental block', 0.9),
  ROW('writing made it worse', 0.85),
  ROW('felt more overwhelmed after writing', 0.85),
  ROW('writing increased stress', 0.85),
  ROW('do not understand my thoughts', 0.85),
  ROW('hard to identify thoughts', 0.85),
  ROW('cannot tell thoughts from feelings', 0.85),
  ROW('feel like doing it wrong', 0.85),
  ROW('worried about writing incorrectly', 0.85),
  ROW('not confident in what was written', 0.85),
  ROW('too tired to write', 0.85),
  ROW('cannot focus enough to write', 0.85),
  ROW('started writing but got stuck', 0.85),
  ROW('do not know what to write next', 0.8),
  ROW('ran out of ideas', 0.8),
  ROW('thoughts feel disconnected', 0.8),
  ROW('writing feels pointless', 0.8),
  ROW('do not see the point of writing', 0.8),
  ROW('purpose is unclear', 0.8),
  ROW('feels unfinished', 0.8),
  ROW('writing does not feel complete', 0.8),
  ROW('still feel blocked', 0.8),
  ROW('hard to write when thoughts are racing', 0.8),
  ROW('do not know how to structure this', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_thought_log'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có nhận ra mẫu suy nghĩ nào không', 1.0),
  ROW('muốn ghi thêm điều gì nữa không', 0.8),
  ROW('có thể thử viết từng ý nhỏ thôi', 1.0),
  ROW('không cần viết đầy đủ câu đâu', 1.0),
  ROW('có thể ghi ra vài từ cũng được', 1.0),
  ROW('thử bắt đầu bằng một suy nghĩ bất kỳ', 1.0),
  ROW('không cần đúng hay sai', 1.0),
  ROW('có thể viết điều đang lặp lại trong đầu', 0.95),
  ROW('thử ghi lại suy nghĩ xuất hiện nhiều nhất', 0.95),
  ROW('chỉ cần ghi suy nghĩ đang làm khó chịu', 0.95),
  ROW('viết ra điều khiến đầu óc nặng nhất', 0.95),
  ROW('nếu khó viết, có thể ghi theo gạch đầu dòng', 0.95),
  ROW('có thể chia nhỏ suy nghĩ ra', 0.95),
  ROW('thử tách từng suy nghĩ riêng ra', 0.95),
  ROW('không cần giải quyết ngay', 0.95),
  ROW('chỉ cần ghi nhận thôi', 0.95),
  ROW('ghi lại để nhìn rõ hơn là đủ rồi', 0.95),
  ROW('có thể bắt đầu bằng “đang nghĩ rằng…”', 0.9),
  ROW('có thể bắt đầu bằng “mình lo là…”', 0.9),
  ROW('có thể bắt đầu bằng “điều làm khó chịu là…”', 0.9),
  ROW('nếu bí, thử viết cảm giác trước', 0.9),
  ROW('có thể ghi cảm xúc rồi quay lại suy nghĩ sau', 0.9),
  ROW('ghi bất cứ thứ gì đang nổi lên cũng được', 0.9),
  ROW('không cần viết dài', 0.9),
  ROW('vài dòng là đủ rồi', 0.9),
  ROW('ghi ngắn gọn thôi cũng được', 0.9),
  ROW('có thể dừng lại nếu thấy mệt', 0.9),
  ROW('không cần ép bản thân viết nhiều', 0.9),
  ROW('nghỉ một chút rồi quay lại cũng ổn', 0.9),
  ROW('thử hỏi bản thân suy nghĩ này đến từ đâu', 0.85),
  ROW('có thể tự hỏi điều gì làm suy nghĩ này xuất hiện', 0.85),
  ROW('thử xem suy nghĩ này có lặp lại không', 0.85),
  ROW('không cần viết cho ai đọc', 0.85),
  ROW('chỉ là ghi cho bản thân thôi', 0.85),
  ROW('không ai chấm điểm đâu', 0.85),
  ROW('có thể viết theo kiểu rất riêng', 0.85),
  ROW('viết theo cách thoải mái nhất là được', 0.85),
  ROW('nếu chưa rõ, thử viết những gì không chắc', 0.85),
  ROW('có thể ghi cả những suy nghĩ mâu thuẫn', 0.85),
  ROW('chỉ cần tiếp tục từng chút một', 0.8),
  ROW('mỗi lần một suy nghĩ thôi', 0.8),
  ROW('không cần hoàn hảo', 0.8),
  ROW('có thể quay lại sau nếu chưa sẵn sàng', 0.8),
  ROW('việc chưa xong cũng không sao', 0.8),
  ROW('ghi ra để nhìn từ bên ngoài thử xem', 0.8),
  ROW('viết ra để tạm đưa suy nghĩ ra khỏi đầu', 0.8),
  ROW('nếu khó quá, có thể đổi cách viết', 0.8),
  ROW('thử viết theo dạng câu hỏi cũng được', 0.8),
  ROW('không cần phải hiểu hết ngay', 0.8),
  ROW('chỉ cần bắt đầu là đã đủ rồi', 0.8),

  ROW('you can try writing just small points', 1.0),
  ROW('it does not have to be full sentences', 1.0),
  ROW('a few words are enough', 1.0),
  ROW('you can start anywhere', 1.0),
  ROW('there is no right or wrong way to write', 1.0),
  ROW('try writing the thought that repeats the most' 0.95),
  ROW('you can write the thought that feels heaviest', 0.95),
  ROW('just note the thought that feels uncomfortable', 0.95),
  ROW('write the one that stands out the most', 0.95),
  ROW('you can use bullet points if that helps', 0.95),
  ROW('try breaking the thoughts into pieces', 0.95),
  ROW('you can separate each thought', 0.95),
  ROW('you do not need to solve it now', 0.95),
  ROW('just noticing it is enough', 0.95),
  ROW('writing it down to see it clearly is enough', 0.95),
  ROW('you can start with “i am thinking that…”', 0.9),
  ROW('you can start with “i am worried that…”', 0.9),
  ROW('you can start with “what bothers me is…”', 0.9),
  ROW('if writing thoughts is hard, start with feelings', 0.9),
  ROW('you can write feelings first and thoughts later', 0.9),
  ROW('write whatever comes up', 0.9),
  ROW('it does not need to be long', 0.9),
  ROW('a few lines are enough', 0.9),
  ROW('short notes are okay', 0.9),
  ROW('you can pause if it feels tiring', 0.9),
  ROW('no need to push yourself', 0.9),
  ROW('you can come back to it later', 0.9),
  ROW('you can ask where this thought comes from', 0.85),
  ROW('try asking what triggered this thought', 0.85),
  ROW('see if this thought shows up often', 0.85),
  ROW('this is just for yourself', 0.85),
  ROW('no one else needs to see it', 0.85),
  ROW('nothing is being judged', 0.85),
  ROW('you can write in your own way', 0.85),
  ROW('write in whatever style feels easiest', 0.85),
  ROW('you can include thoughts that feel unclear', 0.85),
  ROW('it is okay if thoughts feel mixed', 0.85),
  ROW('take it one step at a time', 0.8),
  ROW('one thought at a time is enough', 0.8),
  ROW('it does not need to be perfect', 0.8),
  ROW('you can stop and return later', 0.8),
  ROW('it is okay if this is unfinished', 0.8),
  ROW('writing helps move thoughts out of your head', 0.8),
  ROW('try looking at the thought from outside', 0.8),
  ROW('you can change how you write if needed', 0.8),
  ROW('you can write it as questions too', 0.8),
  ROW('you do not need to understand everything now', 0.8),
  ROW('starting is already enough', 0.8)
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
  ROW('khó chú ý', 0.8),
  ROW('không tập trung được', 1.0),
  ROW('mất tập trung', 1.0),
  ROW('đầu óc lan man', 1.0),
  ROW('khó tập trung', 1.0),
  ROW('không chú ý được', 1.0),
  ROW('cứ nghĩ mãi một chuyện', 0.95),
  ROW('nghĩ hoài không dứt', 0.95),
  ROW('nghĩ đi nghĩ lại', 0.95),
  ROW('suy nghĩ lặp lại', 0.95),
  ROW('đầu cứ xoay vòng', 0.95),
  ROW('không ngừng suy nghĩ', 0.95),
  ROW('đầu không chịu yên', 0.9),
  ROW('suy nghĩ chạy liên tục', 0.95),
  ROW('khó ngắt dòng suy nghĩ', 0.95),
  ROW('bị cuốn vào suy nghĩ', 0.95),
  ROW('kẹt trong suy nghĩ', 0.95),
  ROW('mắc kẹt trong đầu', 0.95),
  ROW('suy nghĩ chiếm hết đầu', 0.95),
  ROW('đầu bị suy nghĩ chiếm', 0.95),
  ROW('suy nghĩ không chịu dừng', 0.95),
  ROW('toàn nghĩ chuyện không kiểm soát được', 0.9),
  ROW('nghĩ về điều không thay đổi được', 0.9),
  ROW('nghĩ về thứ không làm gì được', 0.9),
  ROW('cứ nghĩ mấy chuyện ngoài tầm tay', 0.9),
  ROW('tập trung vào điều không kiểm soát được', 0.9),
  ROW('cứ lo xa', 0.9),
  ROW('lo những chuyện chưa xảy ra', 0.9),
  ROW('nghĩ quá nhiều về tương lai', 0.9),
  ROW('toàn nghĩ nếu như', 0.9),
  ROW('nghĩ nếu thì liên tục', 0.9),
  ROW('đầu cứ chạy lung tung', 0.9),
  ROW('suy nghĩ tản mạn', 0.9),
  ROW('khó giữ suy nghĩ ở hiện tại', 0.9),
  ROW('khó tập trung vào hiện tại', 0.9),
  ROW('đầu lúc nào cũng nghĩ chuyện khác', 0.9),
  ROW('đang làm mà đầu nghĩ lung tung', 0.85),
  ROW('khó chú ý việc đang làm', 0.85),
  ROW('không để ý xung quanh', 0.85),
  ROW('dễ bị xao nhãng', 0.85),
  ROW('bị phân tâm liên tục', 0.85),
  ROW('khó tập trung học', 0.85),
  ROW('khó tập trung làm bài', 0.85),
  ROW('học mà đầu nghĩ chuyện khác', 0.85),
  ROW('làm bài mà không tập trung', 0.85),
  ROW('khó chú ý lâu', 0.85),
  ROW('cứ bị kéo vào suy nghĩ tiêu cực', 0.85),
  ROW('khó thoát khỏi suy nghĩ đó', 0.85),
  ROW('đầu cứ quay về chuyện đó', 0.85),
  ROW('khó rời suy nghĩ đó ra', 0.85),
  ROW('đầu quá bận để tập trung', 0.8),
  ROW('suy nghĩ chen ngang liên tục', 0.8),
  ROW('đầu không yên', 0.8),
  ROW('khó kéo sự chú ý lại', 0.8),
  ROW('khó quay lại việc đang làm', 0.8),
  ROW('nghĩ quá nhiều thứ cùng lúc', 0.8),
  ROW('đầu bị quá tải suy nghĩ', 0.8),
  ROW('suy nghĩ dồn dập', 0.8),
  ROW('khó kiểm soát suy nghĩ', 0.8),
  ROW('suy nghĩ không theo ý muốn', 0.8),
  ROW('đầu lúc nào cũng bận', 0.8),
  ROW('khó giữ sự chú ý', 0.8),
  ROW('không giữ được tập trung', 0.8),
  ROW('tập trung được chút là mất', 0.8),
  ROW('chú ý bị trôi đi', 0.8),
  ROW('suy nghĩ cứ chen vào', 0.8),
  ROW('đầu không chịu nghỉ', 0.8),
  ROW('khó làm chủ sự chú ý', 0.8),
  ROW('suy nghĩ lấn át', 0.8),
  ROW('đầu bị cuốn đi', 0.8),
  ROW('tập trung rất khó', 0.8),
  ROW('đầu khó yên', 0.8),
  ROW('suy nghĩ chi phối', 0.8),
  ROW('khó giữ đầu óc tỉnh táo', 0.8),
  ROW('chú ý không ổn định', 0.8),
  ROW('dễ bị kéo khỏi hiện tại', 0.8),
  ROW('khó neo sự chú ý', 0.8),
  ROW('suy nghĩ kéo đi liên tục', 0.8),
  ROW('đầu không đứng yên', 0.8),
  ROW('khó giữ tâm trí ở đây', 0.8),

  ROW('cannot focus', 1.0),
ROW('hard to focus', 1.0),
ROW('unable to concentrate', 1.0),
ROW('mind keeps wandering', 1.0),
ROW('keep losing focus', 1.0),
ROW('keep thinking about the same thing', 0.95),
ROW('thinking about it over and over', 0.95),
ROW('thoughts keep looping', 0.95),
ROW('same thoughts repeating', 0.95),
ROW('mind stuck on one thing', 0.95),
ROW('cannot stop thinking', 0.95),
ROW('mind will not slow down', 0.95),
ROW('thoughts keep racing', 0.95),
ROW('hard to interrupt thoughts', 0.95),
ROW('pulled into thoughts', 0.95),
ROW('stuck in thoughts', 0.95),
ROW('trapped in thinking', 0.95),
ROW('thoughts take over', 0.95),
ROW('mind feels occupied', 0.95),
ROW('thoughts refuse to stop', 0.95),
ROW('thinking about things out of control', 0.9),
ROW('focused on things I cannot change', 0.9),
ROW('thinking about what I cannot control', 0.9),
ROW('dwelling on uncontrollable things', 0.9),
ROW('attention stuck on the wrong things', 0.9),
ROW('worrying too far ahead', 0.9),
ROW('thinking too much about the future', 0.9),
ROW('caught in what ifs', 0.9),
ROW('overthinking possibilities', 0.9),
ROW('worrying about things that have not happened', 0.9),
ROW('mind jumping everywhere', 0.9),
ROW('thoughts feel scattered', 0.9),
ROW('cannot stay present', 0.9),
ROW('attention keeps drifting', 0.9),
ROW('mind keeps shifting', 0.9),
ROW('easily distracted', 0.85),
ROW('constantly distracted', 0.85),
ROW('attention breaks easily', 0.85),
ROW('hard to stay on task', 0.85),
ROW('focus does not last', 0.85),
ROW('hard to focus on studying', 0.85),
ROW('hard to focus on schoolwork', 0.85),
ROW('studying but mind elsewhere', 0.85),
ROW('working but thinking about other things', 0.85),
ROW('cannot focus for long', 0.85),
ROW('pulled into negative thoughts', 0.85),
ROW('hard to break away from thoughts', 0.85),
ROW('thoughts pull attention away', 0.85),
ROW('mind keeps returning to the same thought', 0.85),
ROW('attention stuck on one thought', 0.85),
ROW('mind feels overloaded', 0.8),
ROW('too many thoughts at once', 0.8),
ROW('thoughts crowd the mind', 0.8),
ROW('mental noise is high', 0.8),
ROW('hard to regain focus', 0.8),
ROW('hard to bring attention back', 0.8),
ROW('attention slips away', 0.8),
ROW('mind will not settle', 0.8),
ROW('thoughts keep interrupting', 0.8),
ROW('mind refuses to rest', 0.8),
ROW('focus feels unstable', 0.8),
ROW('attention feels shaky', 0.8),
ROW('mind keeps drifting off', 0.8),
ROW('focus breaks repeatedly', 0.8),
ROW('hard to anchor attention', 0.8),
ROW('thinking about too many things', 0.8),
ROW('mind pulled in many directions', 0.8),
ROW('attention feels split', 0.8),
ROW('thoughts compete for attention', 0.8),
ROW('mind feels restless', 0.8),
ROW('cannot hold attention', 0.8),
ROW('focus slips quickly', 0.8),
ROW('mind rarely stays still', 0.8),
ROW('attention constantly moves', 0.8),
ROW('mind does not stay here', 0.8),
ROW('hard to stay mentally present', 0.8),
ROW('attention feels pulled away', 0.8),
ROW('mind keeps pulling off task', 0.8),
ROW('thoughts dominate attention', 0.8),
ROW('focus feels out of control', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('tập trung hơn', 1.0),
  ROW('đỡ rối trí', 0.9),
  ROW('cảm thấy kiểm soát được', 0.8),
  ROW('tập trung hơn', 1.0),            -- 1
  ROW('dễ tập trung hơn', 1.0),         -- 2
  ROW('đầu óc rõ ràng hơn', 1.0),       -- 3
  ROW('bớt lan man rồi', 1.0),          -- 4
  ROW('đỡ nghĩ lung tung', 1.0),        -- 5
  ROW('suy nghĩ chậm lại', 0.95),       -- 6
  ROW('đầu bớt chạy', 0.95),            -- 7
  ROW('đầu yên hơn', 0.95),             -- 8
  ROW('suy nghĩ bớt dồn dập', 0.95),    -- 9
  ROW('không còn xoay vòng nữa', 0.95), -- 10
  ROW('quay lại việc đang làm được rồi', 0.95), -- 11
  ROW('chú ý lại được rồi', 0.95),               -- 12
  ROW('kéo sự chú ý về được', 0.95),              -- 13
  ROW('đỡ bị cuốn vào suy nghĩ', 0.95),           -- 14
  ROW('thoát khỏi suy nghĩ đó rồi', 0.95),        -- 15
  ROW('ở hiện tại tốt hơn', 0.9),       -- 16
  ROW('đỡ nghĩ về mấy chuyện không kiểm soát', 0.9), -- 17
  ROW('ngưng lo xa một chút', 0.9),      -- 18
  ROW('bớt nghĩ nếu như', 0.9),          -- 19
  ROW('đầu không còn bị kéo đi nữa', 0.9), -- 20
  ROW('dễ chú ý hơn', 0.9),              -- 21
  ROW('ít bị phân tâm hơn', 0.9),        -- 22
  ROW('đỡ xao nhãng', 0.9),              -- 23
  ROW('giữ được sự chú ý lâu hơn', 0.9), -- 24
  ROW('chú ý ổn định hơn', 0.9),         -- 25
  ROW('đỡ bị suy nghĩ chen ngang', 0.9), -- 26
  ROW('suy nghĩ không kéo đi nữa', 0.9), -- 27
  ROW('đầu không còn quá bận', 0.9),     -- 28
  ROW('đỡ bị ngập trong suy nghĩ', 0.9), -- 29
  ROW('đầu thoáng hơn', 0.9),            -- 30
  ROW('quay về hiện tại được rồi', 0.85), -- 31
  ROW('tập trung lại được', 0.85),        -- 32
  ROW('đỡ bị kẹt trong đầu', 0.85),       -- 33
  ROW('thoát ra được một chút', 0.85),    -- 34
  ROW('đầu không còn rối như trước', 0.85), -- 35
  ROW('học dễ tập trung hơn', 0.85),      -- 36
  ROW('làm bài đỡ bị phân tâm', 0.85),    -- 37
  ROW('chú ý vào việc trước mắt hơn', 0.85), -- 38
  ROW('không còn nghĩ lung tung khi làm việc', 0.85), -- 39
  ROW('tập trung học tốt hơn', 0.85),     -- 40
  ROW('đầu dịu lại', 0.85),               -- 41
  ROW('tâm trí ổn hơn', 0.85),             -- 42
  ROW('đỡ bị kéo bởi suy nghĩ tiêu cực', 0.85), -- 43
  ROW('suy nghĩ không còn lấn át', 0.85),  -- 44
  ROW('kiểm soát được sự chú ý hơn', 0.85), -- 45
  ROW('ở yên với việc đang làm', 0.8),    -- 46
  ROW('tập trung được từng chút', 0.8),   -- 47
  ROW('đỡ bị xao động', 0.8),              -- 48
  ROW('đầu không chạy lung tung nữa', 0.8), -- 49
  ROW('giữ được nhịp tập trung', 0.8),    -- 50
  ROW('dễ quay lại khi bị phân tâm', 0.8), -- 51
  ROW('chú ý không trôi đi nhanh như trước', 0.8), -- 52
  ROW('tâm trí bớt bất ổn', 0.8),          -- 53
  ROW('đầu không bị kéo quá xa', 0.8),     -- 54
  ROW('đỡ bị chi phối bởi suy nghĩ', 0.8), -- 55
  ROW('tập trung dễ hơn lúc đầu', 0.8),   -- 56
  ROW('đầu không còn quá loạn', 0.8),      -- 57
  ROW('suy nghĩ nằm yên hơn', 0.8),        -- 58
  ROW('chú ý rõ ràng hơn', 0.8),            -- 59
  ROW('ở lại với hiện tại lâu hơn', 0.8),  -- 60
  ROW('cảm giác kiểm soát tốt hơn', 0.8),  -- 61
  ROW('đầu không còn bị kéo liên tục', 0.8), -- 62
  ROW('tập trung ổn hơn lúc nãy', 0.8),    -- 63
  ROW('đỡ bị suy nghĩ chi phối', 0.8),     -- 64
  ROW('tâm trí đỡ rối', 0.8),               -- 65
  ROW('chú ý quay lại dễ hơn', 0.8),       -- 66
  ROW('đầu không còn trôi đi', 0.8),        -- 67
  ROW('giữ được sự chú ý', 0.8),            -- 68
  ROW('tập trung vững hơn', 0.8),           -- 69
  ROW('ở hiện tại rõ hơn', 0.8),

  ROW('more focused', 1.0),                 -- 71
  ROW('able to focus better', 1.0),         -- 72
  ROW('mind feels clearer', 1.0),           -- 73
  ROW('less distracted now', 1.0),          -- 74
  ROW('not as scattered', 1.0),             -- 75
  ROW('thoughts slowed down', 0.95),        -- 76
  ROW('mind feels calmer', 0.95),            -- 77
  ROW('head feels steadier', 0.95),          -- 78
  ROW('thinking less chaotically', 0.95),   -- 79
  ROW('not looping anymore', 0.95),          -- 80
  ROW('back to what I was doing', 0.95),    -- 81
  ROW('attention came back', 0.95),          -- 82
  ROW('able to pull focus back', 0.95),      -- 83
  ROW('less pulled into thoughts', 0.95),   -- 84
  ROW('broke out of the loop', 0.95),        -- 85
  ROW('more present now', 0.9),              -- 86
  ROW('thinking less about uncontrollable things', 0.9), -- 87
  ROW('worry eased a bit', 0.9),              -- 88
  ROW('fewer what if thoughts', 0.9),        -- 89
  ROW('mind not drifting as much', 0.9),     -- 90
  ROW('attention feels stronger', 0.9),      -- 91
  ROW('less distracted while working', 0.9), -- 92
  ROW('focus feels steadier', 0.9),           -- 93
  ROW('able to stay on task longer', 0.9),   -- 94
  ROW('focus feels more stable', 0.9),        -- 95
  ROW('thoughts interrupt less', 0.9),       -- 96
  ROW('mind feels less busy', 0.9),           -- 97
  ROW('not overwhelmed by thoughts', 0.9),   -- 98
  ROW('head feels lighter', 0.9),             -- 99
  ROW('attention is clearer', 0.9),           -- 100
  ROW('able to stay present', 0.85),          -- 101
  ROW('focus returned', 0.85),                -- 102
  ROW('not stuck in my head anymore', 0.85),  -- 103
  ROW('thinking feels smoother', 0.85),       -- 104
  ROW('mind feels less cluttered', 0.85),     -- 105
  ROW('studying feels easier', 0.85),         -- 106
  ROW('less distracted while studying', 0.85), -- 107
  ROW('attention on what matters', 0.85),     -- 108
  ROW('able to focus on the task', 0.85),     -- 109
  ROW('mind stays on track better', 0.85),    -- 110
  ROW('mental space feels calmer', 0.85),     -- 111
  ROW('negative thoughts pull less', 0.85),   -- 112
  ROW('attention feels controlled', 0.85),    -- 113
  ROW('thoughts no longer dominate', 0.85),   -- 114
  ROW('mind feels balanced', 0.85),            -- 115
  ROW('able to focus bit by bit', 0.8),       -- 116
  ROW('less mentally restless', 0.8),         -- 117
  ROW('focus holds better', 0.8),              -- 118
  ROW('mind does not drift far', 0.8),         -- 119
  ROW('attention feels anchored', 0.8),        -- 120
  ROW('easier to refocus when distracted', 0.8), -- 121
  ROW('focus returns faster', 0.8),            -- 122
  ROW('mind feels steadier than before', 0.8), -- 123
  ROW('attention does not slip as much', 0.8), -- 124
  ROW('thoughts feel quieter', 0.8),           -- 125
  ROW('focus improved a bit', 0.8),             -- 126
  ROW('thinking feels less noisy', 0.8),        -- 127
  ROW('mind stays here longer', 0.8),            -- 128
  ROW('attention feels manageable', 0.8),       -- 129
  ROW('focus feels under control', 0.8)
  
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn xao nhãng', 0.9),
  ROW('không kiểm soát được', 0.8),
  ROW('vẫn không tập trung được', 1.0),        -- 1
  ROW('đầu óc còn rối', 1.0),                   -- 2
  ROW('chưa kiểm soát được suy nghĩ', 1.0),     -- 3
  ROW('ý nghĩ vẫn chạy lung tung', 0.98),       -- 4
  ROW('khó giữ sự chú ý', 0.98),                 -- 5
  ROW('vẫn bị phân tâm', 0.98),                 -- 6
  ROW('tập trung không nổi', 0.96),              -- 7
  ROW('càng nghĩ càng rối', 0.96),               -- 8
  ROW('đầu óc quá tải', 0.96),                   -- 9
  ROW('chưa thấy đỡ hơn', 0.95),                 -- 10
  ROW('khó kéo sự chú ý lại', 0.95),              -- 11
  ROW('vẫn mất kiểm soát suy nghĩ', 0.95),       -- 12
  ROW('ý nghĩ không chịu dừng', 0.94),           -- 13
  ROW('tâm trí vẫn chạy nhanh', 0.94),           -- 14
  ROW('chưa ổn định lại được', 0.94),            -- 15
  ROW('không gom được suy nghĩ', 0.93),          -- 16
  ROW('đầu óc vẫn mệt', 0.93),                   -- 17
  ROW('tập trung rất khó', 0.93),                -- 18
  ROW('vẫn bị cuốn theo suy nghĩ', 0.92),        -- 19
  ROW('ý nghĩ quay vòng', 0.92),                 -- 20
  ROW('khó quay lại hiện tại', 0.92),            -- 21
  ROW('chưa kéo được sự chú ý về', 0.91),        -- 22
  ROW('tâm trí vẫn phân tán', 0.91),             -- 23
  ROW('đầu óc chưa yên', 0.91),                  -- 24
  ROW('vẫn thấy rối bên trong', 0.90),           -- 25
  ROW('chưa thấy tập trung hơn', 0.90),          -- 26
  ROW('suy nghĩ chen ngang liên tục', 0.90),    -- 27
  ROW('ý nghĩ khó kiểm soát', 0.89),             -- 28
  ROW('vẫn bị kéo đi bởi suy nghĩ', 0.89),       -- 29
  ROW('tâm trí không chịu đứng yên', 0.89),      -- 30
  ROW('khó tập trung vào một thứ', 0.88),        -- 31
  ROW('ý nghĩ lấn át mọi thứ', 0.88),            -- 32
  ROW('vẫn bị nhiễu', 0.88),                     -- 33
  ROW('chưa điều chỉnh được sự chú ý', 0.87),   -- 34
  ROW('đầu óc vẫn quay cuồng', 0.87),            -- 35
  ROW('khó giữ tâm trí ở hiện tại', 0.87),       -- 36
  ROW('vẫn thấy khó kiểm soát', 0.86),           -- 37
  ROW('ý nghĩ không theo ý muốn', 0.86),         -- 38
  ROW('chưa làm chủ được sự chú ý', 0.86),       -- 39
  ROW('tập trung bị đứt quãng', 0.85),           -- 40
  ROW('ý nghĩ cứ trôi đi', 0.85),                -- 41
  ROW('tâm trí chưa quay lại', 0.85),            -- 42
  ROW('vẫn bị xao nhãng', 0.84),                 -- 43
  ROW('khó kéo tâm trí về', 0.84),               -- 44
  ROW('ý nghĩ tràn ngập', 0.84),                 -- 45
  ROW('đầu óc vẫn căng', 0.83),                  -- 46
  ROW('chưa kiểm soát tốt', 0.83),               -- 47
  ROW('tâm trí chưa rõ ràng', 0.83),             -- 48
  ROW('ý nghĩ chồng chéo', 0.82),                -- 49
  ROW('vẫn thấy rối trí', 0.82),                 -- 50
  ROW('khó sắp xếp suy nghĩ', 0.82),             -- 51
  ROW('tâm trí chưa ổn', 0.81),                  -- 52
  ROW('ý nghĩ chưa lắng xuống', 0.81),           -- 53
  ROW('vẫn chưa gom được suy nghĩ', 0.81),       -- 54
  ROW('khó giữ sự chú ý lâu', 0.80),             -- 55
  ROW('tâm trí còn nhiễu', 0.80),                -- 56
  ROW('ý nghĩ chưa chịu chậm lại', 0.80),        -- 57
  ROW('vẫn chưa tập trung lại', 0.79),           -- 58
  ROW('đầu óc chưa nhẹ hơn', 0.79),              -- 59
  ROW('khó làm chủ dòng suy nghĩ', 0.79),        -- 60
  ROW('tâm trí vẫn bị kéo đi', 0.78),             -- 61
  ROW('ý nghĩ khó dừng', 0.78),                  -- 62
  ROW('vẫn chưa kiểm soát tốt sự chú ý', 0.78),  -- 63
  ROW('đầu óc chưa rõ ràng hơn', 0.77),           -- 64
  ROW('khó giữ tâm trí ổn định', 0.77),          -- 65
  ROW('ý nghĩ vẫn lấn át', 0.77),                -- 66
  ROW('tâm trí chưa tập trung lại', 0.76),       -- 67
  ROW('vẫn chưa thấy kiểm soát được', 0.76),    -- 68
  ROW('khó đưa sự chú ý trở lại', 0.76),         -- 69
  ROW('ý nghĩ vẫn chi phối mạnh', 0.75),         -- 70

  ROW('still cannot focus', 1.0),                -- 71
  ROW('mind still feels scattered', 1.0),        -- 72
  ROW('thoughts still out of control', 1.0),     -- 73
  ROW('attention keeps drifting', 0.98),         -- 74
  ROW('hard to focus right now', 0.98),           -- 75
  ROW('mind keeps wandering', 0.98),              -- 76
  ROW('still feeling distracted', 0.96),         -- 77
  ROW('thoughts are all over the place', 0.96),  -- 78
  ROW('cannot stay focused', 0.96),               -- 79
  ROW('head feels overloaded', 0.95),             -- 80
  ROW('focus has not improved', 0.95),            -- 81
  ROW('still losing concentration', 0.95),       -- 82
  ROW('thoughts keep racing', 0.94),              -- 83
  ROW('mind will not settle', 0.94),               -- 84
  ROW('attention feels unstable', 0.94),          -- 85
  ROW('still mentally scattered', 0.93),          -- 86
  ROW('hard to control attention', 0.93),         -- 87
  ROW('focus keeps breaking', 0.93),               -- 88
  ROW('thoughts interrupt constantly', 0.92),    -- 89
  ROW('still pulled by thoughts', 0.92),          -- 90
  ROW('mind feels noisy', 0.92),                   -- 91
  ROW('cannot bring focus back', 0.91),            -- 92
  ROW('attention slips away', 0.91),               -- 93
  ROW('still mentally overwhelmed', 0.91),        -- 94
  ROW('focus feels weak', 0.90),                   -- 95
  ROW('thoughts feel uncontrollable', 0.90),      -- 96
  ROW('still mentally tense', 0.90),               -- 97
  ROW('hard to stay present', 0.89),               -- 98
  ROW('attention feels scattered', 0.89),         -- 99
  ROW('mind keeps pulling away', 0.89),            -- 100
  ROW('focus not holding', 0.88),                  -- 101
  ROW('thoughts keep intruding', 0.88),            -- 102
  ROW('still unable to concentrate', 0.88),       -- 103
  ROW('mind feels restless', 0.87),                -- 104
  ROW('attention still unstable', 0.87),           -- 105
  ROW('focus is inconsistent', 0.87),              -- 106
  ROW('thoughts keep flooding in', 0.86),          -- 107
  ROW('still distracted mentally', 0.86),         -- 108
  ROW('cannot steady attention', 0.86),            -- 109
  ROW('mind refuses to slow down', 0.85),          -- 110
  ROW('focus keeps slipping', 0.85),               -- 111
  ROW('still mentally unfocused', 0.85),           -- 112
  ROW('thoughts feel overwhelming', 0.84),        -- 113
  ROW('attention keeps breaking', 0.84),           -- 114
  ROW('mind still feels busy', 0.84),               -- 115
  ROW('hard to regain focus', 0.83),                -- 116
  ROW('attention not under control', 0.83),       -- 117
  ROW('still mentally scattered', 0.83),           -- 118
  ROW('thoughts keep pulling attention', 0.82),   -- 119
  ROW('focus feels fragile', 0.82),                -- 120
  ROW('mind keeps jumping', 0.82),                  -- 121
  ROW('still struggling to focus', 0.81),          -- 122
  ROW('attention feels loose', 0.81),               -- 123
  ROW('thoughts have not settled', 0.81),          -- 124
  ROW('mind still drifting', 0.80),                -- 125
  ROW('focus still unstable', 0.80),               -- 126
  ROW('attention not steady yet', 0.80),           -- 127
  ROW('thoughts still dominant', 0.79),            -- 128
  ROW('mind still pulling away', 0.79),            -- 129
  ROW('focus has not returned', 0.79),             -- 130
  ROW('attention still scattered', 0.78),          -- 131
  ROW('thoughts hard to stop', 0.78),               -- 132
  ROW('mind still unfocused', 0.78),                -- 133
  ROW('focus still difficult', 0.77),              -- 134
  ROW('attention keeps slipping back', 0.77),      -- 135
  ROW('thoughts still interfering', 0.77),         -- 136
  ROW('mind not centered yet', 0.76),               -- 137
  ROW('focus still shaky', 0.76),                   -- 138
  ROW('attention not regained', 0.76),             -- 139
  ROW('thoughts still taking over', 0.75)          -- 140
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử lại cách tập trung khác không', 1.0),
  ROW('có dễ chịu hơn chút nào không', 0.8),
  ROW('thử quay lại một điểm nhỏ nhé', 1.0),                 -- 1
  ROW('có thể chọn một điều đơn giản để chú ý', 1.0),       -- 2
  ROW('không sao nếu chưa tập trung ngay', 1.0),            -- 3
  ROW('thử kéo sự chú ý về hiện tại một chút', 0.98),       -- 4
  ROW('có thể tạm dừng và hít thở chậm', 0.98),              -- 5
  ROW('thử chú ý vào cảm giác xung quanh', 0.98),           -- 6
  ROW('không cần ép buộc sự tập trung', 0.97),              -- 7
  ROW('có thể bắt đầu từ một chi tiết rất nhỏ', 0.97),      -- 8
  ROW('thử quan sát một thứ đang ở gần', 0.97),             -- 9
  ROW('sự chú ý có thể quay lại từ từ', 0.96),              -- 10
  ROW('có thể chọn một âm thanh để lắng nghe', 0.96),      -- 11
  ROW('thử tập trung vào nhịp thở hiện tại', 0.96),         -- 12
  ROW('không sao nếu tâm trí còn trôi', 0.95),              -- 13
  ROW('có thể nhẹ nhàng đưa sự chú ý trở lại', 0.95),       -- 14
  ROW('thử chú ý vào cảm giác cơ thể', 0.95),               -- 15
  ROW('chỉ cần tập trung trong vài giây cũng được', 0.94), -- 16
  ROW('có thể thử lại theo cách nhẹ hơn', 0.94),            -- 17
  ROW('thử chọn một điểm cố định để nhìn', 0.94),           -- 18
  ROW('không cần hoàn hảo lúc này', 0.93),                  -- 19
  ROW('sự chú ý có thể rèn dần', 0.93),                     -- 20
  ROW('thử quay lại với điều đang diễn ra', 0.93),          -- 21
  ROW('có thể bắt đầu lại một cách chậm rãi', 0.92),        -- 22
  ROW('thử tập trung vào một chuyển động nhỏ', 0.92),      -- 23
  ROW('không cần vội vàng', 0.92),                          -- 24
  ROW('có thể cho tâm trí thêm thời gian', 0.91),           -- 25
  ROW('thử đưa sự chú ý về cảm giác hiện tại', 0.91),      -- 26
  ROW('chỉ cần một khoảnh khắc tập trung cũng ổn', 0.91), -- 27
  ROW('có thể thử lại khi sẵn sàng', 0.90),                 -- 28
  ROW('thử chú ý vào nhịp chuyển động xung quanh', 0.90), -- 29
  ROW('không sao nếu phải làm lại nhiều lần', 0.90),        -- 30
  ROW('sự chú ý có thể quay lại từng chút', 0.89),          -- 31
  ROW('thử tập trung vào một cảm giác quen thuộc', 0.89), -- 32
  ROW('có thể làm chậm nhịp lại', 0.89),                    -- 33
  ROW('thử quan sát môi trường xung quanh', 0.88),         -- 34
  ROW('không cần ép tâm trí đứng yên', 0.88),               -- 35
  ROW('có thể chọn một điều dễ chịu để chú ý', 0.88),      -- 36
  ROW('thử quay lại với nhịp thở', 0.87),                   -- 37
  ROW('chỉ cần giữ sự chú ý trong chốc lát', 0.87),        -- 38
  ROW('có thể thử lại theo cách khác', 0.87),              -- 39
  ROW('sự tập trung không cần hoàn hảo', 0.86),            -- 40
  ROW('thử chú ý vào cảm giác tiếp xúc', 0.86),            -- 41
  ROW('không sao nếu tâm trí còn động', 0.86),              -- 42
  ROW('có thể quay lại từng bước nhỏ', 0.85),              -- 43
  ROW('thử giữ sự chú ý thêm vài giây', 0.85),             -- 44
  ROW('chỉ cần bắt đầu lại nhẹ nhàng', 0.85),              -- 45
  ROW('có thể chọn một điểm an toàn để tập trung', 0.84), -- 46
  ROW('thử chú ý vào hiện tại ngay lúc này', 0.84),       -- 47
  ROW('không cần phải kiểm soát hoàn toàn', 0.84),         -- 48
  ROW('sự chú ý có thể quay lại bất cứ lúc nào', 0.83),   -- 49
  ROW('thử tập trung vào cảm giác ổn định', 0.83),        -- 50
  ROW('có thể cho phép tâm trí chậm lại', 0.83),           -- 51
  ROW('chỉ cần một chút chú ý cũng đủ', 0.82),             -- 52
  ROW('thử quay lại với một điều quen thuộc', 0.82),      -- 53
  ROW('không sao nếu cần nhiều lần', 0.82),                -- 54
  ROW('có thể tiếp tục theo nhịp riêng', 0.81),            -- 55
  ROW('thử chú ý vào cảm giác đang có', 0.81),            -- 56
  ROW('sự tập trung có thể đến dần', 0.81),               -- 57
  ROW('chỉ cần giữ lại một điểm chú ý', 0.80),            -- 58
  ROW('có thể thử lại khi cảm thấy phù hợp', 0.80),       -- 59
  ROW('thử để tâm trí nghỉ một chút', 0.80),              -- 60
  ROW('không cần ép kết quả ngay', 0.79),                 -- 61
  ROW('sự chú ý có thể quay lại chậm rãi', 0.79),         -- 62
  ROW('thử quay về hiện tại thêm lần nữa', 0.79),         -- 63
  ROW('có thể tiếp tục từng bước nhỏ', 0.78),             -- 64
  ROW('chỉ cần bắt đầu lại từ đây', 0.78),                -- 65
  ROW('thử giữ sự chú ý ngắn thôi', 0.78),                -- 66
  ROW('không cần phải làm ngay', 0.77),                   -- 67
  ROW('sự tập trung có thể rèn dần dần', 0.77),           -- 68
  ROW('thử quay lại với khoảnh khắc này', 0.77),          -- 69
  ROW('có thể tiếp tục nhẹ nhàng', 0.76),

  ROW('try returning to one small point', 1.0),           -- 71
  ROW('it is okay if focus is not there yet', 1.0),       -- 72
  ROW('try bringing attention back gently', 1.0),         -- 73
  ROW('focus can return slowly', 0.98),                   -- 74
  ROW('try noticing one simple thing', 0.98),             -- 75
  ROW('no need to force concentration', 0.98),            -- 76
  ROW('attention can come back bit by bit', 0.97),        -- 77
  ROW('try focusing for just a few seconds', 0.97),       -- 78
  ROW('it is okay to try again', 0.97),                    -- 79
  ROW('try noticing the present moment', 0.96),           -- 80
  ROW('focus does not need to be perfect', 0.96),         -- 81
  ROW('try bringing attention back slowly', 0.96),        -- 82
  ROW('it is okay if the mind drifts', 0.95),              -- 83
  ROW('attention can be trained over time', 0.95),        -- 84
  ROW('try returning to something simple', 0.95),         -- 85
  ROW('no rush is needed', 0.94),                          -- 86
  ROW('try focusing on one sensation', 0.94),             -- 87
  ROW('it is fine to start again', 0.94),                  -- 88
  ROW('attention can settle gradually', 0.93),            -- 89
  ROW('try holding focus briefly', 0.93),                 -- 90
  ROW('no pressure to get it right', 0.93),               -- 91
  ROW('try noticing what is happening now', 0.92),       -- 92
  ROW('focus can return in small steps', 0.92),           -- 93
  ROW('try slowing the pace slightly', 0.92),             -- 94
  ROW('it is okay to take time', 0.91),                    -- 95
  ROW('try gently guiding attention back', 0.91),         -- 96
  ROW('focus does not have to last long', 0.91),          -- 97
  ROW('try again when ready', 0.90),                       -- 98
  ROW('attention can come back naturally', 0.90),         -- 99
  ROW('no need to control everything', 0.90),             -- 100
  ROW('try focusing on something nearby', 0.89),          -- 101
  ROW('focus can be rebuilt slowly', 0.89),               -- 102
  ROW('it is okay if thoughts keep moving', 0.89),        -- 103
  ROW('try bringing awareness to the body', 0.88),        -- 104
  ROW('no need to force stillness', 0.88),                -- 105
  ROW('attention can return when ready', 0.88),           -- 106
  ROW('try noticing a steady sensation', 0.87),           -- 107
  ROW('focus can come back gently', 0.87),                -- 108
  ROW('it is fine to pause and try again', 0.87),         -- 109
  ROW('try holding attention a moment longer', 0.86),    -- 110
  ROW('focus does not need to be strong', 0.86),          -- 111
  ROW('attention can settle with time', 0.86),            -- 112
  ROW('try returning to the present again', 0.85),       -- 113
  ROW('no need to rush progress', 0.85),                  -- 114
  ROW('focus can rebuild step by step', 0.85),            -- 115
  ROW('try noticing one calm point', 0.84),               -- 116
  ROW('attention can come back gradually', 0.84),        -- 117
  ROW('it is okay to keep trying', 0.84),                 -- 118
  ROW('try allowing the mind to slow down', 0.83),       -- 119
  ROW('focus can return in its own time', 0.83),          -- 120
  ROW('no need for immediate results', 0.83),            -- 121
  ROW('try reconnecting with the moment', 0.82),         -- 122
  ROW('attention can steady slowly', 0.82),               -- 123
  ROW('it is okay to repeat the process', 0.82),          -- 124
  ROW('try starting again gently', 0.81),                 -- 125
  ROW('focus can improve over time', 0.81),               -- 126
  ROW('no pressure to succeed instantly', 0.81),         -- 127
  ROW('try staying with one point briefly', 0.80),       -- 128
  ROW('attention can return little by little', 0.80),    -- 129
  ROW('it is fine to move at a slow pace', 0.80),         -- 130
  ROW('try grounding attention again', 0.79),            -- 131
  ROW('focus does not need to be forced', 0.79),          -- 132
  ROW('attention can come back softly', 0.79),            -- 133
  ROW('try reconnecting once more', 0.78),                -- 134
  ROW('no need to push too hard', 0.78),                  -- 135
  ROW('focus can be gentle and brief', 0.78),             -- 136
  ROW('try staying with the moment again', 0.77),        -- 137
  ROW('attention can stabilize over time', 0.77),        -- 138
  ROW('it is okay to continue gently', 0.77),             -- 139
  ROW('try allowing focus to return naturally', 0.76)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_focus_control'
ON CONFLICT DO NOTHING;

---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('viết cảm xúc', 1.0),                    -- 1
  ROW('ghi lại cảm xúc', 1.0),                 -- 2
  ROW('nhật ký cảm xúc', 1.0),                 -- 3
  ROW('viết ra cho nhẹ lòng', 0.98),           -- 4
  ROW('muốn viết ra', 0.98),                   -- 5
  ROW('ghi lại những gì đang cảm thấy', 0.98),-- 6
  ROW('viết cho đỡ nặng', 0.97),               -- 7
  ROW('muốn trút ra cảm xúc', 0.97),           -- 8
  ROW('ghi lại suy nghĩ và cảm xúc', 0.97),    -- 9
  ROW('viết nhật ký', 0.96),                   -- 10
  ROW('viết cho rõ cảm xúc', 0.96),            -- 11
  ROW('muốn xả cảm xúc', 0.96),                -- 12
  ROW('ghi lại tâm trạng', 0.95),              -- 13
  ROW('viết ra những gì đang có trong đầu', 0.95), -- 14
  ROW('cảm xúc đang lộn xộn', 0.95),            -- 15
  ROW('khó nói thành lời', 0.94),              -- 16
  ROW('không biết diễn tả thế nào', 0.94),     -- 17
  ROW('có nhiều cảm xúc bên trong', 0.94),     -- 18
  ROW('muốn ghi lại cho dễ hiểu hơn', 0.93),   -- 19
  ROW('viết xuống để nhìn rõ hơn', 0.93),      -- 20
  ROW('cảm xúc đang dồn lại', 0.93),            -- 21
  ROW('muốn nói ra nhưng khó', 0.92),           -- 22
  ROW('ghi lại cho đỡ rối', 0.92),              -- 23
  ROW('cảm xúc chưa rõ ràng', 0.92),            -- 24
  ROW('viết ra cho dễ thở hơn', 0.91),          -- 25
  ROW('muốn sắp xếp cảm xúc', 0.91),            -- 26
  ROW('cảm xúc đang chồng chéo', 0.91),         -- 27
  ROW('ghi lại để hiểu bản thân', 0.90),        -- 28
  ROW('viết ra cho nhẹ đầu', 0.90),             -- 29
  ROW('muốn nhìn lại cảm xúc', 0.90),           -- 30
  ROW('cảm xúc đang đầy', 0.89),                -- 31
  ROW('ghi lại những điều đang cảm nhận', 0.89),-- 32
  ROW('viết cho dễ đối diện', 0.89),            -- 33
  ROW('muốn xả bớt cảm xúc', 0.88),             -- 34
  ROW('cảm xúc khó giữ trong đầu', 0.88),       -- 35
  ROW('ghi ra để không bị dồn nén', 0.88),      -- 36
  ROW('viết ra để nhẹ lòng hơn', 0.87),         -- 37
  ROW('muốn nói ra bằng chữ', 0.87),            -- 38
  ROW('cảm xúc đang tích tụ', 0.87),            -- 39
  ROW('ghi lại để hiểu rõ hơn', 0.86),           -- 40
  ROW('viết để giải tỏa', 0.86),                -- 41
  ROW('muốn đối diện cảm xúc', 0.86),            -- 42
  ROW('cảm xúc đang lắng đọng', 0.85),           -- 43
  ROW('ghi lại cho rõ ràng hơn', 0.85),          -- 44
  ROW('viết ra để không giữ trong lòng', 0.85), -- 45
  ROW('muốn nhìn thẳng vào cảm xúc', 0.84),     -- 46
  ROW('cảm xúc đang nặng', 0.84),                -- 47
  ROW('ghi lại cho dễ hiểu', 0.84),              -- 48
  ROW('viết ra cho bớt áp lực', 0.83),           -- 49
  ROW('muốn để cảm xúc ra ngoài', 0.83),         -- 50
  ROW('cảm xúc chưa được giải tỏa', 0.83),       -- 51
  ROW('ghi lại cho nhẹ hơn', 0.82),              -- 52
  ROW('viết ra để nhìn lại', 0.82),              -- 53
  ROW('muốn làm rõ cảm xúc', 0.82),               -- 54
  ROW('cảm xúc đang bị dồn nén', 0.81),          -- 55
  ROW('ghi lại để bớt căng', 0.81),               -- 56
  ROW('viết cho dễ chịu hơn', 0.81),              -- 57
  ROW('muốn ghi lại tâm trạng hiện tại', 0.80),  -- 58
  ROW('cảm xúc đang khó hiểu', 0.80),             -- 59
  ROW('ghi ra cho rõ trong đầu', 0.80),           -- 60
  ROW('viết để không rối nữa', 0.79),             -- 61
  ROW('muốn xả những gì đang cảm thấy', 0.79),   -- 62
  ROW('cảm xúc đang chật chội', 0.79),            -- 63
  ROW('ghi lại để tự hiểu', 0.78),                -- 64
  ROW('viết ra cho đỡ bí', 0.78),                 -- 65
  ROW('muốn ghi lại suy nghĩ cảm xúc', 0.78),    -- 66
  ROW('cảm xúc đang khó chịu', 0.77),             -- 67
  ROW('ghi ra để nhẹ người hơn', 0.77),           -- 68
  ROW('viết ra để giải tỏa bên trong', 0.77),    -- 69
  ROW('muốn ghi lại để nhìn rõ', 0.76),

  ROW('write feelings down', 1.0),                -- 71
  ROW('emotion journal', 1.0),                    -- 72
  ROW('write about emotions', 1.0),               -- 73
  ROW('put feelings into words', 0.98),           -- 74
  ROW('want to write feelings', 0.98),            -- 75
  ROW('journal emotions', 0.98),                  -- 76
  ROW('write to feel lighter', 0.97),             -- 77
  ROW('need to express emotions', 0.97),          -- 78
  ROW('write emotions out', 0.97),                -- 79
  ROW('keep an emotion journal', 0.96),           -- 80
  ROW('write feelings out', 0.96),                -- 81
  ROW('need emotional release', 0.96),            -- 82
  ROW('record emotions', 0.95),                   -- 83
  ROW('write what is felt inside', 0.95),         -- 84
  ROW('emotions feel messy', 0.95),               -- 85
  ROW('hard to put feelings into words', 0.94),   -- 86
  ROW('do not know how to explain feelings', 0.94), -- 87
  ROW('many emotions inside', 0.94),              -- 88
  ROW('write to understand emotions', 0.93),      -- 89
  ROW('write things out to see clearly', 0.93),   -- 90
  ROW('emotions building up', 0.93),              -- 91
  ROW('need to let emotions out', 0.92),          -- 92
  ROW('write to reduce confusion', 0.92),         -- 93
  ROW('feelings not clear', 0.92),                -- 94
  ROW('write to feel relief', 0.91),               -- 95
  ROW('want to organize emotions', 0.91),         -- 96
  ROW('emotions overlapping', 0.91),              -- 97
  ROW('write to understand self', 0.90),          -- 98
  ROW('write to clear the mind', 0.90),            -- 99
  ROW('want to reflect on emotions', 0.90),       -- 100
  ROW('emotions feel full', 0.89),                -- 101
  ROW('write about current feelings', 0.89),      -- 102
  ROW('write to face emotions', 0.89),             -- 103
  ROW('need to vent emotions', 0.88),              -- 104
  ROW('feelings hard to keep inside', 0.88),      -- 105
  ROW('write to avoid bottling up', 0.88),        -- 106
  ROW('write to feel lighter inside', 0.87),      -- 107
  ROW('express emotions through writing', 0.87), -- 108
  ROW('emotions piling up', 0.87),                -- 109
  ROW('write to gain clarity', 0.86),             -- 110
  ROW('write for emotional release', 0.86),       -- 111
  ROW('want to face emotions', 0.86),             -- 112
  ROW('emotions feel heavy', 0.85),               -- 113
  ROW('write to make sense of feelings', 0.85),   -- 114
  ROW('write to not keep inside', 0.85),          -- 115
  ROW('want to look at emotions honestly', 0.84),-- 116
  ROW('feelings feel heavy', 0.84),               -- 117
  ROW('write to understand better', 0.84),        -- 118
  ROW('write to reduce pressure', 0.83),          -- 119
  ROW('need to let feelings out', 0.83),          -- 120
  ROW('emotions not released yet', 0.83),         -- 121
  ROW('write to feel calmer', 0.82),              -- 122
  ROW('write to reflect', 0.82),                  -- 123
  ROW('want to clarify emotions', 0.82),          -- 124
  ROW('emotions feel bottled up', 0.81),          -- 125
  ROW('write to ease tension', 0.81),             -- 126
  ROW('write to feel better', 0.81),               -- 127
  ROW('journal current mood', 0.80),              -- 128
  ROW('emotions feel confusing', 0.80),           -- 129
  ROW('write to organize thoughts and feelings', 0.80), -- 130
  ROW('write to stop mental clutter', 0.79),      -- 131
  ROW('need to unload emotions', 0.79),           -- 132
  ROW('emotions feel cramped', 0.79),             -- 133
  ROW('write to understand inner state', 0.78),   -- 134
  ROW('write to release inside', 0.78),           -- 135
  ROW('journal emotional thoughts', 0.78),        -- 136
  ROW('emotions feel uncomfortable', 0.77),      -- 137
  ROW('write to feel lighter mentally', 0.77),    -- 138
  ROW('write to release inner pressure', 0.77),   -- 139
  ROW('write to see emotions clearly', 0.76)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhận ra cảm xúc', 1.0),
  ROW('hiểu cảm xúc hơn', 0.9),
  ROW('nhẹ lòng hơn', 1.0),                      -- 1
  ROW('cảm xúc dịu xuống', 1.0),                 -- 2
  ROW('đỡ nặng trong lòng', 1.0),                -- 3
  ROW('hiểu rõ cảm xúc hơn', 0.98),              -- 4
  ROW('đầu óc nhẹ hơn', 0.98),                   -- 5
  ROW('cảm thấy dễ thở hơn', 0.98),              -- 6
  ROW('bớt rối cảm xúc', 0.97),                  -- 7
  ROW('cảm xúc rõ ràng hơn', 0.97),              -- 8
  ROW('viết ra có tác dụng', 0.97),              -- 9
  ROW('bớt bị dồn nén', 0.96),                   -- 10
  ROW('cảm xúc ổn hơn', 0.96),                   -- 11
  ROW('đỡ căng bên trong', 0.96),                -- 12
  ROW('nhìn rõ vấn đề hơn', 0.95),               -- 13
  ROW('cảm xúc được giải tỏa', 0.95),            -- 14
  ROW('tâm trạng nhẹ hơn', 0.95),                -- 15
  ROW('bớt lộn xộn trong đầu', 0.94),             -- 16
  ROW('cảm xúc được sắp xếp', 0.94),             -- 17
  ROW('viết ra giúp dễ hiểu hơn', 0.94),         -- 18
  ROW('đỡ bị nghẹn cảm xúc', 0.93),              -- 19
  ROW('cảm xúc lắng xuống', 0.93),               -- 20
  ROW('nhìn mọi thứ rõ hơn', 0.93),              -- 21
  ROW('bớt áp lực trong lòng', 0.92),            -- 22
  ROW('viết ra thấy nhẹ hơn', 0.92),             -- 23
  ROW('cảm xúc không còn dồn lại', 0.92),        -- 24
  ROW('đầu óc bớt căng', 0.91),                  -- 25
  ROW('hiểu bản thân hơn', 0.91),                -- 26
  ROW('viết giúp giải tỏa', 0.91),               -- 27
  ROW('cảm xúc được nhìn nhận', 0.90),           -- 28
  ROW('tâm trí đỡ mệt', 0.90),                   -- 29
  ROW('bớt giữ trong lòng', 0.90),               -- 30
  ROW('viết ra làm nhẹ đầu', 0.89),              -- 31
  ROW('cảm xúc dễ chịu hơn', 0.89),              -- 32
  ROW('bớt rối trí', 0.89),                      -- 33
  ROW('viết giúp bình tĩnh hơn', 0.88),          -- 34
  ROW('cảm xúc không còn quá nặng', 0.88),       -- 35
  ROW('đỡ bí cảm xúc', 0.88),                    -- 36
  ROW('nhìn cảm xúc rõ ràng hơn', 0.87),         -- 37
  ROW('viết ra thấy ổn hơn', 0.87),              -- 38
  ROW('tâm trạng được điều chỉnh', 0.87),        -- 39
  ROW('cảm xúc được xử lý', 0.86),               -- 40
  ROW('bớt khó chịu bên trong', 0.86),           -- 41
  ROW('viết giúp thông suốt hơn', 0.86),         -- 42
  ROW('cảm xúc không còn chồng chéo', 0.85),     -- 43
  ROW('đỡ căng thẳng cảm xúc', 0.85),            -- 44
  ROW('viết ra giúp nhìn lại', 0.85),            -- 45
  ROW('cảm xúc được tháo gỡ', 0.84),             -- 46
  ROW('tâm trí nhẹ nhõm hơn', 0.84),              -- 47
  ROW('bớt áp lực cảm xúc', 0.84),               -- 48
  ROW('viết giúp rõ suy nghĩ', 0.83),            -- 49
  ROW('cảm xúc ổn định hơn', 0.83),              -- 50
  ROW('đỡ dồn nén bên trong', 0.83),              -- 51
  ROW('viết ra giúp hiểu rõ', 0.82),             -- 52
  ROW('cảm xúc được xả bớt', 0.82),              -- 53
  ROW('tâm trạng dễ chịu hơn', 0.82),             -- 54
  ROW('bớt nặng nề cảm xúc', 0.81),               -- 55
  ROW('viết ra giúp thông cảm xúc', 0.81),       -- 56
  ROW('cảm xúc không còn bí', 0.81),             -- 57
  ROW('đỡ căng trong lòng', 0.80),                -- 58
  ROW('viết giúp sắp xếp lại', 0.80),             -- 59
  ROW('cảm xúc được làm rõ', 0.80),               -- 60
  ROW('tâm trí đỡ rối', 0.79),                    -- 61
  ROW('bớt nghẹn cảm xúc', 0.79),                -- 62
  ROW('viết ra thấy nhẹ người', 0.79),           -- 63
  ROW('cảm xúc không còn quá tải', 0.78),         -- 64
  ROW('đỡ mệt cảm xúc', 0.78),                    -- 65
  ROW('viết giúp nhìn rõ bên trong', 0.78),      -- 66
  ROW('cảm xúc được giải phóng', 0.77),           -- 67
  ROW('tâm trạng lắng dịu hơn', 0.77),             -- 68
  ROW('bớt rối cảm xúc bên trong', 0.77),        -- 69
  ROW('viết ra giúp cân bằng hơn', 0.76),

  ROW('feel lighter', 1.0),                       -- 71
  ROW('emotions feel calmer', 1.0),               -- 72
  ROW('less emotional weight', 1.0),              -- 73
  ROW('understand emotions better', 0.98),        -- 74
  ROW('mind feels lighter', 0.98),                -- 75
  ROW('feel more at ease', 0.98),                 -- 76
  ROW('emotions less tangled', 0.97),             -- 77
  ROW('feelings clearer', 0.97),                  -- 78
  ROW('writing helped', 0.97),                    -- 79
  ROW('less bottled up', 0.96),                   -- 80
  ROW('emotions feel steadier', 0.96),            -- 81
  ROW('less inner tension', 0.96),                -- 82
  ROW('see things more clearly', 0.95),           -- 83
  ROW('emotional release felt', 0.95),            -- 84
  ROW('mood feels lighter', 0.95),                -- 85
  ROW('less mental clutter', 0.94),               -- 86
  ROW('emotions feel organized', 0.94),           -- 87
  ROW('writing brings clarity', 0.94),            -- 88
  ROW('less emotional pressure', 0.93),           -- 89
  ROW('emotions settle down', 0.93),              -- 90
  ROW('perspective feels clearer', 0.93),         -- 91
  ROW('less emotional strain', 0.92),             -- 92
  ROW('writing feels relieving', 0.92),           -- 93
  ROW('emotions no longer stuck', 0.92),          -- 94
  ROW('mind feels calmer', 0.91),                 -- 95
  ROW('better self-understanding', 0.91),         -- 96
  ROW('writing helps release', 0.91),             -- 97
  ROW('emotions acknowledged', 0.90),             -- 98
  ROW('mental fatigue reduced', 0.90),            -- 99
  ROW('less held inside', 0.90),                  -- 100
  ROW('writing clears the mind', 0.89),            -- 101
  ROW('feelings more manageable', 0.89),          -- 102
  ROW('less emotional confusion', 0.89),          -- 103
  ROW('writing brings calm', 0.88),               -- 104
  ROW('emotions less heavy', 0.88),               -- 105
  ROW('less emotional blockage', 0.88),           -- 106
  ROW('emotions more visible', 0.87),             -- 107
  ROW('writing feels grounding', 0.87),           -- 108
  ROW('emotional balance improving', 0.87),       -- 109
  ROW('emotions processed', 0.86),                -- 110
  ROW('less inner discomfort', 0.86),             -- 111
  ROW('writing feels clarifying', 0.86),           -- 112
  ROW('emotions less overlapping', 0.85),         -- 113
  ROW('less emotional tension', 0.85),            -- 114
  ROW('writing helps reflection', 0.85),          -- 115
  ROW('emotional knots loosened', 0.84),          -- 116
  ROW('mind feels relieved', 0.84),               -- 117
  ROW('less emotional pressure', 0.84),           -- 118
  ROW('writing organizes thoughts', 0.83),        -- 119
  ROW('emotions more stable', 0.83),               -- 120
  ROW('less emotional buildup', 0.83),            -- 121
  ROW('writing increases understanding', 0.82),  -- 122
  ROW('emotions released somewhat', 0.82),        -- 123
  ROW('mood feels easier', 0.82),                  -- 124
  ROW('less emotional heaviness', 0.81),          -- 125
  ROW('writing improves flow', 0.81),             -- 126
  ROW('emotions less blocked', 0.81),             -- 127
  ROW('inner tension reduced', 0.80),             -- 128
  ROW('writing helps structure feelings', 0.80),  -- 129
  ROW('emotions clarified', 0.80),                -- 130
  ROW('mind less tangled', 0.79),                 -- 131
  ROW('less emotional tightness', 0.79),          -- 132
  ROW('writing feels freeing', 0.79),             -- 133
  ROW('emotions no longer overwhelming', 0.78),  -- 134
  ROW('emotional fatigue reduced', 0.78),         -- 135
  ROW('writing reveals inner state', 0.78),       -- 136
  ROW('emotions discharged', 0.77),               -- 137
  ROW('mood feels softer', 0.77),                  -- 138
  ROW('less emotional confusion inside', 0.77),  -- 139
  ROW('writing brings balance', 0.76)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết ghi gì', 0.9),
  ROW('vẫn bối rối', 0.8),
  ROW('khó viết ra cảm xúc', 0.95),                     -- 1
  ROW('không biết nên viết gì', 0.95),                  -- 2
  ROW('viết mà vẫn rối', 0.9),                          -- 3
  ROW('viết xong vẫn nặng lòng', 0.9),                  -- 4
  ROW('không quen ghi nhật ký', 0.85),                  -- 5
  ROW('viết không ra chữ', 0.95),                       -- 6
  ROW('không diễn tả được cảm xúc', 0.95),              -- 7
  ROW('cảm xúc lộn xộn quá', 0.9),                      -- 8
  ROW('viết mà không thấy đỡ hơn', 0.9),                -- 9
  ROW('không biết bắt đầu từ đâu', 0.95),               -- 10
  ROW('càng viết càng rối', 0.9),                       -- 11
  ROW('viết mà không hiểu rõ hơn', 0.9),                -- 12
  ROW('khó gọi tên cảm xúc', 0.95),                     -- 13
  ROW('không rõ đang cảm thấy gì', 0.95),               -- 14
  ROW('viết mà vẫn căng thẳng', 0.9),                   -- 15
  ROW('không quen nhìn lại cảm xúc', 0.85),             -- 16
  ROW('ghi lại mà thấy khó chịu', 0.9),                 -- 17
  ROW('viết xong vẫn lo lắng', 0.9),                    -- 18
  ROW('viết mà không có cảm giác gì', 0.85),            -- 19
  ROW('không thấy tác dụng rõ ràng', 0.9),              -- 20
  ROW('cảm xúc mơ hồ', 0.95),                           -- 21
  ROW('khó thành thật khi viết', 0.9),                  -- 22
  ROW('viết mà thấy gượng gạo', 0.9),                   -- 23
  ROW('viết nhưng không đúng ý', 0.9),                  -- 24
  ROW('không biết viết sao cho đúng', 0.9),             -- 25
  ROW('viết mà không rõ ràng', 0.9),                    -- 26
  ROW('vẫn thấy bức bối', 0.9),                         -- 27
  ROW('viết xong mà vẫn stress', 0.9),                  -- 28
  ROW('viết nhưng không giải tỏa', 0.9),                -- 29
  ROW('khó đối diện cảm xúc', 0.95),                    -- 30
  ROW('viết ra mà thấy nặng hơn', 0.9),                 -- 31
  ROW('cảm xúc không sắp xếp được', 0.95),              -- 32
  ROW('viết mà thấy lạc hướng', 0.9),                   -- 33
  ROW('viết nhưng không rõ vấn đề', 0.9),               -- 34
  ROW('khó viết đều đặn', 0.85),                        -- 35
  ROW('viết mà không tập trung', 0.85),                 -- 36
  ROW('cảm xúc bị kẹt', 0.95),                          -- 37
  ROW('viết nhưng không nhẹ hơn', 0.9),                 -- 38
  ROW('viết mà vẫn bồn chồn', 0.9),                     -- 39
  ROW('khó nhìn thẳng vào cảm xúc', 0.95),              -- 40
  ROW('viết mà thấy mệt hơn', 0.9),                     -- 41
  ROW('không quen viết về cảm xúc', 0.85),              -- 42
  ROW('viết mà không kết nối được', 0.9),               -- 43
  ROW('cảm xúc quá nhiều để viết', 0.95),               -- 44
  ROW('viết mà không ra ý', 0.9),                       -- 45
  ROW('không biết nên viết chi tiết hay không', 0.85),  -- 46
  ROW('viết mà không thấy rõ ràng hơn', 0.9),           -- 47
  ROW('viết nhưng không hiểu bản thân hơn', 0.9),       -- 48
  ROW('cảm xúc bị rối tung', 0.95),                     -- 49
  ROW('viết mà thấy bí', 0.9),                          -- 50
  ROW('viết nhưng không giúp ích', 0.9),                -- 51
  ROW('viết mà thấy khó mở lòng', 0.9),                 -- 52
  ROW('viết nhưng không có hướng', 0.9),                -- 53
  ROW('cảm xúc chưa sẵn sàng để viết', 0.85),           -- 54
  ROW('viết mà thấy áp lực', 0.9),                      -- 55
  ROW('viết mà vẫn thấy mơ hồ', 0.95),                  -- 56
  ROW('khó diễn đạt suy nghĩ', 0.95),                   -- 57
  ROW('viết nhưng không ra vấn đề chính', 0.9),         -- 58
  ROW('viết mà thấy không thoải mái', 0.9),             -- 59
  ROW('viết mà cảm xúc không giảm', 0.9),               -- 60
  ROW('viết nhưng không có tiến triển', 0.9),           -- 61
  ROW('viết mà không hiểu thêm gì', 0.9),               -- 62
  ROW('cảm xúc chưa rõ ràng', 0.95),                    -- 63
  ROW('viết mà thấy bối rối', 0.95),                    -- 64
  ROW('viết nhưng không giúp sắp xếp suy nghĩ', 0.9),   -- 65
  ROW('viết mà vẫn còn căng', 0.9),                     -- 66
  ROW('khó tiếp cận cảm xúc khi viết', 0.95),            -- 67
  ROW('viết mà không thấy khác biệt', 0.9),             -- 68
  ROW('viết nhưng không hiệu quả', 0.9),                -- 69
  ROW('viết mà cảm xúc vẫn kẹt', 0.95),                 -- 70
  ROW('viết mà chưa sẵn sàng đối diện', 0.95),

  ROW('hard to write feelings down', 0.95),             -- 72
  ROW('dont know what to write', 0.95),                 -- 73
  ROW('writing feels confusing', 0.9),                  -- 74
  ROW('still feel heavy after writing', 0.9),           -- 75
  ROW('not used to journaling', 0.85),                  -- 76
  ROW('cant find the right words', 0.95),               -- 77
  ROW('cant describe emotions well', 0.95),             -- 78
  ROW('feel emotionally messy', 0.9),                   -- 79
  ROW('writing doesnt help much', 0.9),                 -- 80
  ROW('dont know where to start', 0.95),                -- 81
  ROW('feel more confused after writing', 0.9),         -- 82
  ROW('writing doesnt bring clarity', 0.9),             -- 83
  ROW('hard to name emotions', 0.95),                   -- 84
  ROW('not sure what feeling this is', 0.95),           -- 85
  ROW('still feel tense', 0.9),                          -- 86
  ROW('not used to reflecting on emotions', 0.85),      -- 87
  ROW('writing feels uncomfortable', 0.9),              -- 88
  ROW('still worried after writing', 0.9),              -- 89
  ROW('feel nothing while writing', 0.85),              -- 90
  ROW('dont feel any benefit', 0.9),                    -- 91
  ROW('emotions feel unclear', 0.95),                   -- 92
  ROW('hard to be honest on paper', 0.9),               -- 93
  ROW('writing feels forced', 0.9),                     -- 94
  ROW('doesnt match what is felt', 0.9),                -- 95
  ROW('dont know how to write it properly', 0.9),       -- 96
  ROW('thoughts feel messy', 0.9),                      -- 97
  ROW('still feel overwhelmed', 0.9),                   -- 98
  ROW('journaling doesnt relieve stress', 0.9),         -- 99
  ROW('hard to face emotions', 0.95),                   -- 100
  ROW('writing makes it feel heavier', 0.9),            -- 101
  ROW('cant organize emotions', 0.95),                  -- 102
  ROW('writing feels directionless', 0.9),              -- 103
  ROW('cant identify the main issue', 0.9),             -- 104
  ROW('hard to journal consistently', 0.85),            -- 105
  ROW('hard to focus while writing', 0.85),             -- 106
  ROW('feel emotionally stuck', 0.95),                  -- 107
  ROW('no sense of relief', 0.9),                        -- 108
  ROW('still feel restless', 0.9),                      -- 109
  ROW('writing feels draining', 0.9),                   -- 110
  ROW('not comfortable writing emotions', 0.9),         -- 111
  ROW('cant connect with feelings', 0.9),               -- 112
  ROW('too many emotions to write', 0.95),              -- 113
  ROW('words dont come out right', 0.9),                -- 114
  ROW('unsure how detailed to write', 0.85),            -- 115
  ROW('writing doesnt clarify thoughts', 0.9),          -- 116
  ROW('dont understand self better', 0.9),              -- 117
  ROW('emotions feel tangled', 0.95),                   -- 118
  ROW('feel blocked when writing', 0.9),                -- 119
  ROW('journaling feels unhelpful', 0.9),               -- 120
  ROW('hard to open up through writing', 0.9),          -- 121
  ROW('writing has no clear direction', 0.9),           -- 122
  ROW('not emotionally ready to write', 0.85),          -- 123
  ROW('writing feels pressuring', 0.9),                 -- 124
  ROW('still feel unclear', 0.95),                      -- 125
  ROW('hard to express thoughts', 0.95),                -- 126
  ROW('cant get to the main point', 0.9),               -- 127
  ROW('writing feels uncomfortable emotionally', 0.9), -- 128
  ROW('emotions dont ease', 0.9),                        -- 129
  ROW('no progress from writing', 0.9),                 -- 130
  ROW('dont gain insight', 0.9),                        -- 131
  ROW('emotions not settled', 0.95),                    -- 132
  ROW('feel mentally confused', 0.95),                  -- 133
  ROW('writing doesnt organize thoughts', 0.9),         -- 134
  ROW('still feel tense inside', 0.9),                  -- 135
  ROW('hard to access emotions', 0.95),                 -- 136
  ROW('no noticeable change', 0.9),                     -- 137
  ROW('writing feels ineffective', 0.9),                -- 138
  ROW('emotions still stuck', 0.95),                    -- 139
  ROW('not ready to face feelings', 0.95),              -- 140
  ROW('journaling doesnt feel right', 0.9),             -- 141
  ROW('writing doesnt help clarify emotions', 0.9)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử viết thêm điều gì không', 1.0),
  ROW('cảm thấy nhẹ nhõm hơn chưa', 0.8),
  ROW('viết thư cho bản thân', 1.0),
  ROW('thư tự an ủi', 0.9),
  ROW('có thể bắt đầu bằng việc ghi lại cảm xúc mạnh nhất lúc này không', 0.95),      -- 1
  ROW('không cần viết hay, chỉ cần viết thật', 0.9),                                   -- 2
  ROW('có thể thử viết ngắn thôi cũng được', 0.9),                                     -- 3
  ROW('viết vài từ mô tả cảm xúc hiện tại nhé', 0.95),                                 -- 4
  ROW('không cần rõ ràng ngay từ đầu đâu', 0.9),                                       -- 5
  ROW('có thể ghi lại điều đang làm lúc cảm xúc xuất hiện', 0.9),                     -- 6
  ROW('thử viết mà không cần suy nghĩ nhiều', 0.9),                                    -- 7
  ROW('có thể bắt đầu bằng câu rất đơn giản', 0.9),                                    -- 8
  ROW('chỉ cần ghi lại, không cần phân tích vội', 0.95),                               -- 9
  ROW('cảm xúc nào xuất hiện rõ nhất lúc này', 0.95),                                  -- 10
  ROW('có thể viết theo dạng gạch đầu dòng', 0.85),                                    -- 11
  ROW('không cần đúng hay sai khi viết', 0.9),                                         -- 12
  ROW('viết cho bản thân, không ai đánh giá', 0.95),                                   -- 13
  ROW('có thể viết theo dòng suy nghĩ đang chạy', 0.9),                                -- 14
  ROW('thử mô tả cảm xúc bằng một từ trước nhé', 0.95),                                -- 15
  ROW('không cần hiểu hết cảm xúc ngay', 0.9),                                         -- 16
  ROW('viết chậm lại cũng không sao', 0.85),                                           -- 17
  ROW('có thể ghi lại cảm giác trong cơ thể', 0.9),                                    -- 18
  ROW('thử viết điều khiến cảm xúc xuất hiện', 0.95),                                  -- 19
  ROW('không cần viết dài, vài dòng là đủ', 0.9),                                      -- 20
  ROW('có thể tạm dừng rồi viết tiếp sau', 0.85),                                      -- 21
  ROW('viết để hiểu, không phải để giải quyết ngay', 0.95),                            -- 22
  ROW('cảm xúc này đến từ đâu nhỉ', 0.95),                                             -- 23
  ROW('thử ghi lại suy nghĩ đi kèm cảm xúc', 0.9),                                     -- 24
  ROW('có thể viết theo câu hỏi và câu trả lời', 0.85),                                -- 25
  ROW('không cần ép bản thân phải rõ ràng', 0.9),                                      -- 26
  ROW('chỉ cần thành thật với cảm xúc', 0.95),                                         -- 27
  ROW('viết ra để nhìn thấy cảm xúc rõ hơn', 0.95),                                    -- 28
  ROW('thử ghi lại cảm xúc trước khi nghĩ tới lý do', 0.9),                            -- 29
  ROW('có thể quay lại chỉnh sửa sau', 0.85),                                          -- 30
  ROW('viết giúp tạo khoảng cách với cảm xúc', 0.9),                                   -- 31
  ROW('không cần viết liên tục, nghỉ giữa chừng cũng được', 0.85),                     -- 32
  ROW('cảm xúc này xuất hiện khi nào', 0.95),                                          -- 33
  ROW('thử ghi lại hoàn cảnh xung quanh', 0.9),                                        -- 34
  ROW('viết để quan sát, không cần phán xét', 0.95),                                   -- 35
  ROW('có thể viết như đang nói chuyện với chính mình', 0.9),                          -- 36
  ROW('viết ra để nhẹ bớt trong đầu', 0.95),                                           -- 37
  ROW('thử viết điều khó nói thành lời', 0.9),                                         -- 38
  ROW('không cần hoàn hảo khi viết', 0.9),                                             -- 39
  ROW('có thể bắt đầu bằng việc mô tả tình huống', 0.9),                               -- 40
  ROW('viết giúp sắp xếp lại cảm xúc', 0.95),                                          -- 41
  ROW('thử viết trong vài phút thôi', 0.85),                                          -- 42
  ROW('cảm xúc này ảnh hưởng thế nào', 0.9),                                          -- 43
  ROW('viết để hiểu bản thân hơn từng chút', 0.95),                                    -- 44
  ROW('không cần tìm giải pháp lúc này', 0.95),                                        -- 45
  ROW('viết như đang ghi chú cho bản thân', 0.85),                                     -- 46
  ROW('thử viết ra điều đang lo nhất', 0.95),                                          -- 47
  ROW('có thể viết bất cứ thứ gì xuất hiện trong đầu', 0.9),                           -- 48
  ROW('viết giúp làm chậm lại dòng suy nghĩ', 0.95),                                   -- 49
  ROW('cảm xúc này có quen không', 0.9),                                               -- 50
  ROW('viết để nhận ra cảm xúc rõ hơn', 0.95),                                        -- 51
  ROW('không cần viết đúng chính tả hay câu cú', 0.85),                                -- 52
  ROW('thử viết mà không chỉnh sửa ngay', 0.85),                                       -- 53
  ROW('viết để tạo không gian an toàn cho cảm xúc', 0.95),                             -- 54
  ROW('có thể viết rồi đọc lại sau', 0.85),                                            -- 55
  ROW('viết giúp cảm xúc có chỗ đi ra', 0.95),                                        -- 56
  ROW('thử viết khi chưa rõ cảm xúc là gì', 0.9),                                      -- 57
  ROW('không cần vội vàng khi viết', 0.85),                                            -- 58
  ROW('viết ra để nhìn cảm xúc từ bên ngoài', 0.95),                                   -- 59
  ROW('có thể dừng nếu thấy quá nhiều', 0.9),                                          -- 60
  ROW('viết để hiểu, không phải để đánh giá', 0.95),                                   -- 61
  ROW('thử ghi lại cảm xúc theo từng khoảnh khắc', 0.9),                               -- 62
  ROW('viết giúp giảm áp lực trong đầu', 0.95),                                        -- 63
  ROW('có thể viết lại sau khi nghỉ một chút', 0.85),                                  -- 64
  ROW('viết là một cách lắng nghe bản thân', 0.95),                                    -- 65
  ROW('không cần ép cảm xúc phải rõ ràng', 0.9),                                       -- 66
  ROW('viết để hiểu cảm xúc đang cần gì', 0.95),                                       -- 67
  ROW('có thể viết theo từng câu ngắn', 0.85),                                         -- 68
  ROW('viết ra để bớt giữ trong lòng', 0.95),                                         -- 69
  ROW('chỉ cần bắt đầu, mọi thứ có thể rõ hơn sau', 0.95),                             -- 70
  ROW('viết giúp tạo bước đầu để hiểu cảm xúc', 0.95),

  ROW('you can start by writing the strongest feeling right now', 0.95),              -- 72
  ROW('it does not have to sound good', 0.9),                                          -- 73
  ROW('short writing is completely fine', 0.9),                                       -- 74
  ROW('try writing a few words about how it feels', 0.95),                             -- 75
  ROW('clarity does not need to come first', 0.9),                                     -- 76
  ROW('you can describe what was happening when it showed up', 0.9),                  -- 77
  ROW('try writing without overthinking', 0.9),                                       -- 78
  ROW('starting with a simple sentence is okay', 0.9),                                 -- 79
  ROW('just writing it down is enough for now', 0.95),                                 -- 80
  ROW('what feeling stands out the most right now', 0.95),                             -- 81
  ROW('bullet points are totally okay', 0.85),                                        -- 82
  ROW('there is no right or wrong way to write', 0.9),                                  -- 83
  ROW('this writing is only for you', 0.95),                                           -- 84
  ROW('you can write as thoughts come', 0.9),                                         -- 85
  ROW('try naming the feeling with one word', 0.95),                                   -- 86
  ROW('you do not need to fully understand it yet', 0.9),                              -- 87
  ROW('writing slowly is fine', 0.85),                                                 -- 88
  ROW('you can describe physical sensations too', 0.9),                               -- 89
  ROW('try writing what triggered the feeling', 0.95),                                 -- 90
  ROW('a few lines are more than enough', 0.9),                                        -- 91
  ROW('you can pause and come back later', 0.85),                                      -- 92
  ROW('this is about understanding not fixing', 0.95),                                 -- 93
  ROW('where might this feeling be coming from', 0.95),                                -- 94
  ROW('try writing the thoughts that come with it', 0.9),                               -- 95
  ROW('you can write in a question and answer style', 0.85),                           -- 96
  ROW('there is no need to force clarity', 0.9),                                       -- 97
  ROW('honesty matters more than structure', 0.95),                                    -- 98
  ROW('writing helps make feelings visible', 0.95),                                    -- 99
  ROW('try writing the feeling before the reason', 0.9),                               -- 100
  ROW('you can always revise later', 0.85),                                            -- 101
  ROW('writing can create distance from emotions', 0.9),                               -- 102
  ROW('breaks are okay while writing', 0.85),                                          -- 103
  ROW('when did this feeling show up', 0.95),                                          -- 104
  ROW('you can describe what was around you', 0.9),                                   -- 105
  ROW('observe without judging while writing', 0.95),                                  -- 106
  ROW('you can write like talking to yourself', 0.9),                                  -- 107
  ROW('writing can lighten the mental load', 0.95),                                    -- 108
  ROW('try putting hard to say feelings on paper', 0.9),                               -- 109
  ROW('it does not need to be perfect', 0.9),                                          -- 110
  ROW('you can start by describing the situation', 0.9),                               -- 111
  ROW('writing helps organize emotions', 0.95),                                        -- 112
  ROW('even a few minutes is enough', 0.85),                                           -- 113
  ROW('how does this feeling affect things', 0.9),                                     -- 114
  ROW('writing helps understand yourself bit by bit', 0.95),                           -- 115
  ROW('you do not need solutions right now', 0.95),                                    -- 116
  ROW('think of this as notes for yourself', 0.85),                                    -- 117
  ROW('try writing what feels heaviest', 0.95),                                        -- 118
  ROW('anything that comes up can be written', 0.9),                                   -- 119
  ROW('writing can slow racing thoughts', 0.95),                                       -- 120
  ROW('does this feeling feel familiar', 0.9),                                         -- 121
  ROW('writing helps notice emotions clearly', 0.95),                                  -- 122
  ROW('spelling and grammar do not matter', 0.85),                                      -- 123
  ROW('try writing without editing', 0.85),                                            -- 124
  ROW('writing creates a safe space for emotions', 0.95),                               -- 125
  ROW('you can read it again later', 0.85),                                            -- 126
  ROW('writing gives emotions a place to go', 0.95),                                    -- 127
  ROW('you can write even if it feels unclear', 0.9),                                  -- 128
  ROW('there is no rush when writing', 0.85),                                          -- 129
  ROW('writing lets you see emotions from outside', 0.95),                              -- 130
  ROW('you can stop if it feels like too much', 0.9),                                  -- 131
  ROW('this is about understanding not judging', 0.95),                                 -- 132
  ROW('try noticing emotions moment by moment', 0.9),                                   -- 133
  ROW('writing can reduce mental pressure', 0.95),                                     -- 134
  ROW('you can return after taking a break', 0.85),                                     -- 135
  ROW('writing is a way of listening to yourself', 0.95),                               -- 136
  ROW('emotions do not need to be clear to write', 0.9),                                 -- 137
  ROW('writing helps notice what emotions need', 0.95),                                  -- 138
  ROW('short sentences work just fine', 0.85),                                         -- 139
  ROW('writing helps release what is held inside', 0.95),                                -- 140
  ROW('starting is often the hardest part', 0.95),                                      -- 141
  ROW('writing is a first step toward understanding', 0.95)
  
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_emotion_journal'
ON CONFLICT DO NOTHING;

-------------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('tự trách bản thân', 1.0),                       -- 1
  ROW('nói chuyện với chính mình', 0.95),              -- 2
  ROW('ghét bản thân', 1.0),                           -- 3
  ROW('thất vọng về bản thân', 0.95),                  -- 4
  ROW('muốn nhắn nhủ bản thân', 0.9),                  -- 5
  ROW('tự phê bình bản thân', 0.95),                   -- 6
  ROW('không hài lòng với bản thân', 0.9),             -- 7
  ROW('ước gì bản thân tốt hơn', 0.9),                 -- 8
  ROW('muốn nói điều gì đó với bản thân', 0.9),        -- 9
  ROW('tự làm mình buồn', 0.95),                       -- 10
  ROW('tự so sánh với người khác', 0.95),              -- 11
  ROW('cảm thấy mình kém cỏi', 1.0),                   -- 12
  ROW('không tự tin vào bản thân', 0.95),              -- 13
  ROW('tự nói những lời tiêu cực', 0.95),              -- 14
  ROW('muốn an ủi bản thân', 0.9),                     -- 15
  ROW('tự ép bản thân quá mức', 0.9),                  -- 16
  ROW('tự trách vì sai lầm', 0.95),                    -- 17
  ROW('không tha thứ cho bản thân', 1.0),              -- 18
  ROW('muốn động viên bản thân', 0.9),                 -- 19
  ROW('cảm thấy bản thân không đủ tốt', 1.0),          -- 20
  ROW('nói xấu bản thân trong đầu', 0.95),             -- 21
  ROW('tự dằn vặt', 1.0),                              -- 22
  ROW('tự áp lực bản thân', 0.9),                      -- 23
  ROW('muốn viết cho chính mình', 0.9),                -- 24
  ROW('tự chỉ trích', 1.0),                            -- 25
  ROW('không chấp nhận bản thân', 1.0),                -- 26
  ROW('cảm thấy bản thân vô dụng', 1.0),               -- 27
  ROW('tự nghi ngờ bản thân', 0.95),                   -- 28
  ROW('muốn xin lỗi bản thân', 0.95),                  -- 29
  ROW('luôn thấy mình sai', 0.95),                     -- 30
  ROW('tự làm tổn thương bản thân bằng lời nói', 1.0), -- 31
  ROW('khó tha thứ cho chính mình', 1.0),              -- 32
  ROW('muốn gửi lời nhắn cho bản thân', 0.9),          -- 33
  ROW('cảm thấy bản thân thất bại', 1.0),              -- 34
  ROW('tự gây áp lực', 0.9),                           -- 35
  ROW('tự hạ thấp bản thân', 1.0),                     -- 36
  ROW('không hài lòng với con người mình', 0.95),      -- 37
  ROW('tự trách mình vì quá khứ', 0.95),               -- 38
  ROW('cảm thấy bản thân không xứng đáng', 1.0),       -- 39
  ROW('tự mắng mình', 1.0),                            -- 40
  ROW('luôn khắt khe với bản thân', 0.95),             -- 41
  ROW('muốn nói lời tử tế với bản thân', 0.9),         -- 42
  ROW('làm mình tổn thương', 1.0),                  -- 43
  ROW('không biết cách yêu bản thân', 0.95),           -- 44
  ROW('tạo áp lực hoàn hảo', 0.9),                  -- 45
  ROW('luôn nghĩ mình chưa đủ', 1.0),                  -- 46
  ROW('phủ nhận nỗ lực của mình', 0.95),            -- 47
  ROW('muốn viết thư cho chính mình', 0.9),            -- 48
  ROW('tự chỉ trích trong đầu', 1.0),                  -- 49
  ROW('khó chấp nhận điểm yếu', 0.95),                 -- 50
  ROW('tự trách vì không đạt kỳ vọng', 0.95),          -- 51
  ROW('cảm thấy bản thân không ổn', 0.9),              -- 52
  ROW('nói chuyện tiêu cực', 1.0),                  -- 53
  ROW('muốn an ủi chính mình', 0.9),                   -- 54
  ROW('tự tạo áp lực quá lớn', 0.9),                   -- 55
  ROW('không hài lòng với chính mình', 0.95),          -- 56
  ROW('làm mình nặng nề', 0.9),                     -- 57
  ROW('cảm thấy mình không đủ giỏi', 1.0),             -- 58
  ROW('tự chê bản thân', 1.0),                         -- 59
  ROW('trách mình hoài', 0.95),                     -- 60
  ROW('không biết nói gì với bản thân', 0.9),          -- 61
  ROW('phán xét bản thân', 1.0),                    -- 62
  ROW('làm mình tổn thương tinh thần', 1.0),        -- 63
  ROW('khó nói lời tử tế với bản thân', 0.95),         -- 64
  ROW('ép mình phải mạnh mẽ', 0.9),                 -- 65
  ROW('cảm thấy bản thân quá tệ', 1.0),                -- 66
  ROW('luôn quay lại trách bản thân', 0.95),           -- 67
  ROW('hối hận về bản thân', 0.95),                 -- 68
  ROW('tha thứ cho bản thân', 0.95),              -- 69
  ROW('không biết cách động viên bản thân', 0.9),     -- 70
  ROW('àm mình buồn bằng suy nghĩ', 0.95),         -- 71
  ROW('nói lời nặng nề với mình', 1.0),
   
  ROW('self blame', 1.0),                               -- 73
  ROW('talking to myself', 0.95),                      -- 74
  ROW('hate myself', 1.0),                             -- 75
  ROW('disappointed in myself', 0.95),                 -- 76
  ROW('want to say something to myself', 0.9),         -- 77
  ROW('self criticism', 1.0),                          -- 78
  ROW('not happy with myself', 0.95),                  -- 79
  ROW('wish i were better', 0.9),                      -- 80
  ROW('need to tell myself something', 0.9),           -- 81
  ROW('being hard on myself', 1.0),                    -- 82
  ROW('comparing myself to others', 0.95),             -- 83
  ROW('feel worthless', 1.0),                          -- 84
  ROW('lack confidence in myself', 0.95),              -- 85
  ROW('negative self talk', 1.0),                      -- 86
  ROW('need to comfort myself', 0.9),                  -- 87
  ROW('pushing myself too hard', 0.9),                 -- 88
  ROW('blaming myself for mistakes', 0.95),            -- 89
  ROW('cannot forgive myself', 1.0),                   -- 90
  ROW('need to encourage myself', 0.9),                -- 91
  ROW('feel not good enough', 1.0),                    -- 92
  ROW('putting myself down', 1.0),                     -- 93
  ROW('self guilt', 1.0),                               -- 94
  ROW('self pressure', 0.9),                           -- 95
  ROW('want to write to myself', 0.9),                 -- 96
  ROW('self judgment', 1.0),                           -- 97
  ROW('cannot accept myself', 1.0),                    -- 98
  ROW('feel useless', 1.0),                            -- 99
  ROW('self doubt', 0.95),                              -- 100
  ROW('need to apologize to myself', 0.95),            -- 101
  ROW('always feel at fault', 0.95),                   -- 102
  ROW('hurting myself with words', 1.0),               -- 103
  ROW('hard to forgive myself', 1.0),                  -- 104
  ROW('want to send a message to myself', 0.9),        -- 105
  ROW('feel like a failure', 1.0),                     -- 106
  ROW('putting pressure on myself', 0.9),              -- 107
  ROW('self devaluation', 1.0),                        -- 108
  ROW('unhappy with who i am', 0.95),                  -- 109
  ROW('blaming myself for the past', 0.95),             -- 110
  ROW('feel undeserving', 1.0),                        -- 111
  ROW('talking harshly to myself', 1.0),               -- 112
  ROW('being overly harsh on myself', 0.95),           -- 113
  ROW('want to be kinder to myself', 0.9),             -- 114
  ROW('emotionally hurting myself', 1.0),              -- 115
  ROW('dont know how to love myself', 0.95),            -- 116
  ROW('perfection pressure', 0.9),                    -- 117
  ROW('feel never enough', 1.0),                       -- 118
  ROW('invalidating my own effort', 0.95),             -- 119
  ROW('want to write a letter to myself', 0.9),        -- 120
  ROW('constant self criticism', 1.0),                 -- 121
  ROW('hard to accept flaws', 0.95),                   -- 122
  ROW('blaming myself for expectations', 0.95),        -- 123
  ROW('feel emotionally not okay', 0.9),               -- 124
  ROW('toxic self talk', 1.0),                         -- 125
  ROW('need to soothe myself', 0.9),                   -- 126
  ROW('overwhelming self pressure', 0.9),              -- 127
  ROW('not satisfied with myself', 0.95),              -- 128
  ROW('mentally exhausting myself', 0.9),              -- 129
  ROW('feel not capable', 1.0),                        -- 130
  ROW('self shaming', 1.0),                            -- 131
  ROW('keep blaming myself', 0.95),                    -- 132
  ROW('dont know what to tell myself', 0.9),           -- 133
  ROW('self judgment loop', 1.0),                      -- 134
  ROW('mentally hurting myself', 1.0),                 -- 135
  ROW('hard to be kind to myself', 0.95),               -- 136
  ROW('forcing myself to be strong', 0.9),             -- 137
  ROW('feel terrible about myself', 1.0),              -- 138
  ROW('constantly blaming myself', 0.95),              -- 139
  ROW('regret about myself', 0.95),                    -- 140
  ROW('want to forgive myself', 0.95),                 -- 141
  ROW('dont know how to encourage myself', 0.9),       -- 142
  ROW('hurting myself with thoughts', 1.0),            -- 143
  ROW('harsh inner voice', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy an ủi', 1.0),
  ROW('nhẹ nhõm hơn', 0.87),
  ROW('viết xong thấy nhẹ hơn', 1.0),        -- 1
  ROW('cảm giác dễ chịu hơn rồi', 1.0),     -- 2
  ROW('hiểu mình hơn một chút', 1.0),       -- 3
  ROW('viết ra được cũng tốt', 1.0),        -- 4
  ROW('thấy mọi thứ rõ ràng hơn', 1.0),     -- 5
  ROW('đỡ rối hơn trước', 1.0),              -- 6
  ROW('cảm giác được nói ra', 1.0),          -- 7
  ROW('tự nhiên thấy nhẹ lòng', 1.0),       -- 8
  ROW('cũng có ích thật', 1.0),              -- 9
  ROW('không còn bị kẹt nữa', 1.0),          -- 10
  ROW('đầu óc thoáng hơn', 1.0),               -- 11
  ROW('viết xong thấy dễ thở', 1.0),         -- 12
  ROW('có vẻ tốt hơn lúc đầu', 1.0),         -- 13
  ROW('ít căng hơn', 1.0),                     -- 14
  ROW('thấy ổn hơn một chút', 1.0),           -- 15
  ROW('có cảm giác được giải tỏa', 1.0),   -- 16
  ROW('viết ra thấy dễ hiểu hơn', 1.0),      -- 17
  ROW('đỡ nặng nề hơn', 1.0),                  -- 18
  ROW('có tác dụng thật', 1.0),               -- 19
  ROW('thấy mình bình tĩnh hơn', 1.0),       -- 20
  ROW('không còn rối như trước', 1.0),        -- 21
  ROW('viết xong thấy khá hơn', 1.0),         -- 22
  ROW('có cảm giác được lắng nghe', 1.0),   -- 23
  ROW('dễ chịu hơn một chút', 1.0),           -- 24
  ROW('tự nhiên thấy nhẹ đầu', 1.0),          -- 25
  ROW('viết ra thấy đỡ hơn', 1.0),             -- 26
  ROW('có vẻ hiệu quả', 1.0),                 -- 27
  ROW('thấy mọi thứ chậm lại', 1.0),         -- 28
  ROW('không còn căng như trước', 1.0),        -- 29
  ROW('viết xong thấy yên tâm hơn', 1.0),      -- 30
  ROW('có cảm giác an toàn hơn', 1.0),       -- 31
  ROW('thấy mình dễ chịu hơn', 1.0),          -- 32
  ROW('không còn bị áp lực nhiều', 1.0),    -- 33
  ROW('viết ra thấy nhẹ hơn thật', 1.0),     -- 34
  ROW('thấy ổn hơn lúc nãy', 1.0),            -- 35
  ROW('có vẻ giải tỏa được gì đó', 1.0),  -- 36
  ROW('tự nhiên thấy dễ chịu hơn', 1.0),     -- 37
  ROW('viết ra thấy đỡ rối', 1.0),            -- 38
  ROW('thấy mình hiểu rõ hơn', 1.0),          -- 39
  ROW('có cảm giác nhẹ nhàng hơn', 1.0),   -- 40
  ROW('không còn nặng lòng như trước', 1.0), -- 41
  ROW('viết xong thấy khá dễ chịu', 1.0),   -- 42
  ROW('có vẻ giúp được', 1.0),                -- 43
  ROW('thấy đỡ bị kẹt trong suy nghĩ', 1.0),-- 44
  ROW('viết ra thấy sáng tỏ hơn', 1.0),      -- 45
  ROW('cảm giác tốt hơn một chút', 1.0),   -- 46
  ROW('không còn quá rối', 1.0),              -- 47
  ROW('viết xong thấy dễ hơn', 1.0),           -- 48
  ROW('có vẻ hiệu quả thật', 1.0),           -- 49
  ROW('thấy mình bình thường lại', 1.0),    -- 50
  ROW('viết ra thấy nhẹ nhàng', 1.0),         -- 51
  ROW('không còn căng đầu nữa', 1.0),          -- 52
  ROW('thấy đỡ hơn khá nhiều', 1.0),          -- 53
  ROW('có cảm giác giải tỏa', 1.0),         -- 54
  ROW('viết xong thấy dễ nghĩ hơn', 1.0),    -- 55
  ROW('thấy ổn áp hơn', 1.0),                  -- 56
  ROW('không còn bị rối nhiều', 1.0),         -- 57
  ROW('viết ra thấy có hướng hơn', 1.0),     -- 58
  ROW('thấy mình dễ thở hơn', 1.0),           -- 59
  ROW('có vẻ đã giảm áp lực', 1.0),        -- 60
  ROW('viết xong thấy nhẹ cảm xúc', 1.0),  -- 61
  ROW('thấy đỡ bị dồn nén', 1.0),             -- 62
  ROW('có cảm giác dễ chịu thật', 1.0),   -- 63
  ROW('viết ra thấy bớt nặng', 1.0),          -- 64
  ROW('thấy mình bình tĩnh hơn rồi', 1.0),  -- 65
  ROW('có vẻ giúp mình suy nghĩ rõ hơn', 1.0), -- 66
  ROW('viết xong thấy ổn hơn khá nhiều', 1.0),  -- 67
  ROW('thấy mình dễ chịu lại', 1.0),         -- 68
  ROW('viết ra thấy đỡ căng', 1.0),            -- 69
  ROW('có cảm giác mọi thứ nhẹ hơn', 1.0), -- 70

  ROW('I feel a bit lighter after writing', 1.0),           -- 1
  ROW('this helped more than I expected', 1.0),             -- 2
  ROW('I feel calmer now', 1.0),                             -- 3
  ROW('writing it out actually helped', 1.0),                -- 4
  ROW('things feel clearer now', 1.0),                       -- 5
  ROW('I feel less stuck', 1.0),                              -- 6
  ROW('that took some weight off', 1.0),                     -- 7
  ROW('I feel a bit more at ease', 1.0),                     -- 8
  ROW('this was useful', 1.0),                                -- 9
  ROW('my thoughts feel more organised', 1.0),               -- 10
  ROW('I feel less tense', 1.0),                              -- 11
  ROW('that helped me slow down', 1.0),                      -- 12
  ROW('I feel better than before', 1.0),                     -- 13
  ROW('my head feels clearer', 1.0),                          -- 14
  ROW('I feel a bit more balanced', 1.0),                    -- 15
  ROW('that actually worked', 1.0),                           -- 16
  ROW('I feel more grounded now', 1.0),                      -- 17
  ROW('this helped me think more clearly', 1.0),              -- 18
  ROW('I feel less overwhelmed', 1.0),                        -- 19
  ROW('writing helped me process things', 1.0),               -- 20
  ROW('I feel calmer than before', 1.0),                     -- 21
  ROW('this made things feel lighter', 1.0),                 -- 22
  ROW('I feel a bit more in control', 1.0),                  -- 23
  ROW('that eased some pressure', 1.0),                      -- 24
  ROW('I feel less cluttered in my head', 1.0),               -- 25
  ROW('this helped me pause', 1.0),                           -- 26
  ROW('I feel more settled now', 1.0),                        -- 27
  ROW('things don’t feel as heavy', 1.0),                    -- 28
  ROW('this gave me some clarity', 1.0),                      -- 29
  ROW('I feel a bit more okay', 1.0),                          -- 30
  ROW('writing helped me release things', 1.0),               -- 31
  ROW('I feel more relaxed', 1.0),                            -- 32
  ROW('this helped me understand myself better', 1.0),        -- 33
  ROW('I feel less pressured', 1.0),                          -- 34
  ROW('that was actually helpful', 1.0),                      -- 35
  ROW('my thoughts feel less messy', 1.0),                    -- 36
  ROW('I feel calmer inside', 1.0),                            -- 37
  ROW('this helped me sort things out', 1.0),                  -- 38
  ROW('I feel a bit more stable', 1.0),                       -- 39
  ROW('writing gave me some relief', 1.0),                     -- 40
  ROW('I feel more at ease now', 1.0),                        -- 41
  ROW('that reduced some tension', 1.0),                      -- 42
  ROW('I feel less weighed down', 1.0),                       -- 43
  ROW('this helped me slow my thoughts', 1.0),                 -- 44
  ROW('I feel better emotionally', 1.0),                      -- 45
  ROW('writing helped more than I thought', 1.0),              -- 46
  ROW('I feel less stuck in my head', 1.0),                    -- 47
  ROW('this helped me reset a bit', 1.0),                      -- 48
  ROW('I feel calmer overall', 1.0),                           -- 49
  ROW('that helped ease my mind', 1.0),                        -- 50
  ROW('I feel more clear-headed now', 1.0),                    -- 51
  ROW('this helped me feel lighter', 1.0),                     -- 52
  ROW('I feel less overwhelmed now', 1.0),                    -- 53
  ROW('writing gave me some space', 1.0),                      -- 54
  ROW('I feel more okay than before', 1.0),                    -- 55
  ROW('this helped me reflect', 1.0),                          -- 56
  ROW('I feel calmer after doing this', 1.0),                  -- 57
  ROW('my thoughts feel more manageable', 1.0),                -- 58
  ROW('this helped reduce some stress', 1.0),                  -- 59
  ROW('I feel more settled inside', 1.0),                      -- 60
  ROW('writing helped me let go a bit', 1.0),                   -- 61
  ROW('I feel less tense now', 1.0),                            -- 62
  ROW('this helped me organise my thoughts', 1.0),             -- 63
  ROW('I feel more calm than before', 1.0),                    -- 64
  ROW('that helped ease things', 1.0),                          -- 65
  ROW('I feel more balanced now', 1.0),                        -- 66
  ROW('this helped me clear my mind', 1.0),                     -- 67
  ROW('I feel a bit more relaxed', 1.0),                       -- 68
  ROW('writing helped me process things better', 1.0),          -- 69
  ROW('I feel lighter overall', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết viết gì', 0.9),
  ROW('vẫn buồn', 0.8),
  ROW('viết xong nhưng không thấy khá hơn', 1.0),        -- 1
  ROW('cảm giác vẫn vậy', 1.0),                           -- 2
  ROW('viết ra mà chưa thấy đỡ', 1.0),                   -- 3
  ROW('chưa thấy có tác dụng gì', 1.0),                 -- 4
  ROW('thấy khó hiểu hơn', 1.0),                          -- 5
  ROW('viết xong mà vẫn rối', 1.0),                      -- 6
  ROW('không cảm nhận được gì', 1.0),                   -- 7
  ROW('có vẻ không hợp với mình', 1.0),                 -- 8
  ROW('thấy cứ bình thường', 1.0),                       -- 9
  ROW('viết ra mà không nhẹ hơn', 1.0),                  -- 10
  ROW('cảm giác chưa giải quyết được', 1.0),           -- 11
  ROW('thấy hơi mất thời gian', 1.0),                     -- 12
  ROW('viết xong vẫn nặng lòng', 1.0),                  -- 13
  ROW('không thấy thay đổi gì', 1.0),                    -- 14
  ROW('có vẻ chưa giúp được', 1.0),                     -- 15
  ROW('thấy khó viết quá', 1.0),                         -- 16
  ROW('viết mà không biết nói gì', 1.0),               -- 17
  ROW('cảm giác chưa đúng', 1.0),                        -- 18
  ROW('thấy vẫn bị kẹt', 1.0),                            -- 19
  ROW('viết ra nhưng không rõ hơn', 1.0),                -- 20
  ROW('không thấy dễ chịu hơn', 1.0),                    -- 21
  ROW('cảm giác vẫn căng', 1.0),                          -- 22
  ROW('viết xong mà vẫn bối rối', 1.0),                -- 23
  ROW('thấy chưa có ích', 1.0),                          -- 24
  ROW('không cảm thấy thay đổi', 1.0),                   -- 25
  ROW('viết ra mà vẫn không hiểu', 1.0),                -- 26
  ROW('có vẻ chưa phải cách phù hợp', 1.0),           -- 27
  ROW('thấy cứ bình bình', 1.0),                         -- 28
  ROW('viết xong mà không nhẹ đầu', 1.0),              -- 29
  ROW('chưa cảm thấy đỡ hơn', 1.0),                      -- 30
  ROW('cảm giác vẫn như cũ', 1.0),                       -- 31
  ROW('viết ra mà chưa thấy rõ ràng', 1.0),            -- 32
  ROW('thấy hơi khó chịu', 1.0),                         -- 33
  ROW('không cảm thấy nhẹ lòng', 1.0),                  -- 34
  ROW('viết xong vẫn thấy rối', 1.0),                   -- 35
  ROW('có vẻ chưa giúp gì nhiều', 1.0),               -- 36
  ROW('thấy mình không viết ra được', 1.0),             -- 37
  ROW('viết mà không ra ý', 1.0),                        -- 38
  ROW('cảm giác không khá hơn', 1.0),                   -- 39
  ROW('thấy vẫn bị áp lực', 1.0),                       -- 40
  ROW('viết ra mà chưa giải tỏa', 1.0),               -- 41
  ROW('không thấy hiệu quả lắm', 1.0),                 -- 42
  ROW('cảm giác vẫn bị kẹt suy nghĩ', 1.0),           -- 43
  ROW('viết xong mà chưa ổn', 1.0),                     -- 44
  ROW('thấy khó kết nối với bài viết', 1.0),         -- 45
  ROW('viết ra mà không thấy nhẹ', 1.0),               -- 46
  ROW('cảm giác chưa thay đổi nhiều', 1.0),           -- 47
  ROW('thấy vẫn bối rối trong đầu', 1.0),              -- 48
  ROW('viết xong mà chưa thấy dễ hơn', 1.0),           -- 49
  ROW('có vẻ chưa giải quyết được gì', 1.0),         -- 50
  ROW('thấy mình viết cho có', 1.0),                    -- 51
  ROW('viết ra nhưng không có cảm xúc', 1.0),         -- 52
  ROW('cảm giác vẫn cứng', 1.0),                        -- 53
  ROW('không thấy dễ nghĩ hơn', 1.0),                   -- 54
  ROW('viết xong mà vẫn nặng đầu', 1.0),              -- 55
  ROW('có vẻ chưa chạm tới điều cần viết', 1.0),     -- 56
  ROW('thấy viết ra cũng vậy', 1.0),                    -- 57
  ROW('cảm giác chưa sáng tỏ', 1.0),                  -- 58
  ROW('viết mà không thấy kết nối', 1.0),             -- 59
  ROW('thấy chưa giải tỏa được', 1.0),                 -- 60
  ROW('viết xong mà vẫn mơ hồ', 1.0),                  -- 61
  ROW('không cảm thấy yên tâm hơn', 1.0),               -- 62
  ROW('có vẻ chưa đúng lúc', 1.0),                    -- 63
  ROW('thấy viết ra mà không thay đổi', 1.0),          -- 64
  ROW('cảm giác vẫn không ổn', 1.0),                  -- 65
  ROW('viết xong mà chưa thấy dễ chịu', 1.0),        -- 66
  ROW('có vẻ chưa giúp được nhiều', 1.0),             -- 67
  ROW('thấy viết ra mà chưa rõ', 1.0),                 -- 68
  ROW('cảm giác vẫn nặng', 1.0),                       -- 69
  ROW('viết xong mà chưa thấy khá hơn', 1.0),

  ROW('I don’t feel much different after writing', 1.0),      -- 1
  ROW('this didn’t really help', 1.0),                         -- 2
  ROW('I still feel the same', 1.0),                           -- 3
  ROW('writing didn’t change much', 1.0),                      -- 4
  ROW('I don’t feel better yet', 1.0),                         -- 5
  ROW('this feels a bit unhelpful', 1.0),                      -- 6
  ROW('I’m still feeling stuck', 1.0),                         -- 7
  ROW('that didn’t ease anything', 1.0),                       -- 8
  ROW('I don’t really feel lighter', 1.0),                     -- 9
  ROW('this didn’t click for me', 1.0),                        -- 10
  ROW('I still feel confused', 1.0),                           -- 11
  ROW('writing felt hard', 1.0),                               -- 12
  ROW('I didn’t know what to write', 1.0),                     -- 13
  ROW('this didn’t help me process much', 1.0),                -- 14
  ROW('I feel about the same as before', 1.0),                 -- 15
  ROW('that didn’t really work', 1.0),                         -- 16
  ROW('I still feel tense', 1.0),                               -- 17
  ROW('writing didn’t clear my head', 1.0),                    -- 18
  ROW('I don’t feel calmer yet', 1.0),                         -- 19
  ROW('this feels ineffective', 1.0),                          -- 20
  ROW('I’m still overwhelmed', 1.0),                           -- 21
  ROW('writing didn’t help much', 1.0),                        -- 22
  ROW('I feel kind of blank', 1.0),                             -- 23
  ROW('this didn’t give me clarity', 1.0),                     -- 24
  ROW('I don’t feel any relief', 1.0),                          -- 25
  ROW('writing felt forced', 1.0),                              -- 26
  ROW('I still feel weighed down', 1.0),                       -- 27
  ROW('this didn’t ease my thoughts', 1.0),                    -- 28
  ROW('I don’t feel more settled', 1.0),                       -- 29
  ROW('that didn’t change how I feel', 1.0),                   -- 30
  ROW('I still feel pressure', 1.0),                           -- 31
  ROW('writing didn’t help me understand things', 1.0),        -- 32
  ROW('I feel stuck in my head', 1.0),                          -- 33
  ROW('this didn’t help me relax', 1.0),                       -- 34
  ROW('I don’t feel clearer', 1.0),                             -- 35
  ROW('writing didn’t really do anything', 1.0),               -- 36
  ROW('I still feel messy inside', 1.0),                       -- 37
  ROW('this didn’t ease my mind', 1.0),                         -- 38
  ROW('I don’t feel more okay', 1.0),                           -- 39
  ROW('writing felt unproductive', 1.0),                       -- 40
  ROW('I still feel unsettled', 1.0),                           -- 41
  ROW('this didn’t help me reset', 1.0),                       -- 42
  ROW('I feel emotionally the same', 1.0),                     -- 43
  ROW('writing didn’t reduce stress', 1.0),                    -- 44
  ROW('I still feel heavy', 1.0),                               -- 45
  ROW('this didn’t give me space', 1.0),                        -- 46
  ROW('I don’t feel grounded', 1.0),                            -- 47
  ROW('writing didn’t help me slow down', 1.0),                -- 48
  ROW('I still feel cluttered', 1.0),                           -- 49
  ROW('this didn’t really connect', 1.0),                      -- 50
  ROW('I don’t feel much relief', 1.0),                         -- 51
  ROW('writing didn’t help today', 1.0),                       -- 52
  ROW('I still feel tense inside', 1.0),                       -- 53
  ROW('this didn’t help me feel calmer', 1.0),                 -- 54
  ROW('I don’t feel any lighter', 1.0),                         -- 55
  ROW('writing didn’t help me sort things out', 1.0),          -- 56
  ROW('I still feel unsure', 1.0),                              -- 57
  ROW('this didn’t change my mindset', 1.0),                  -- 58
  ROW('I feel stuck emotionally', 1.0),                         -- 59
  ROW('writing didn’t help me release anything', 1.0),         -- 60
  ROW('I still feel off', 1.0),                                 -- 61
  ROW('this didn’t help much overall', 1.0),                  -- 62
  ROW('I don’t feel more balanced', 1.0),                      -- 63
  ROW('writing didn’t make things easier', 1.0),               -- 64
  ROW('I still feel confused inside', 1.0),                    -- 65
  ROW('this didn’t help me feel okay', 1.0),                   -- 66
  ROW('I don’t feel more at ease', 1.0),                        -- 67
  ROW('writing didn’t really help this time', 1.0),            -- 68
  ROW('I still feel unresolved', 1.0),                          -- 69
  ROW('this didn’t help me feel better yet', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử viết tiếp không', 1.0),
  ROW('cảm thấy khá hơn chút nào chưa', 0.8),
  ROW('có thể thử viết vài dòng cho bản thân nhé', 0.9),          -- 1
  ROW('không cần viết hay, chỉ cần thật lòng', 0.9),             -- 2
  ROW('viết như đang nói chuyện với chính mình', 0.9),           -- 3
  ROW('có thể bắt đầu bằng điều đang thấy khó nhất', 0.85),      -- 4
  ROW('viết chậm thôi, không cần vội', 0.85),                    -- 5
  ROW('có thể viết điều muốn được nghe lúc này', 0.9),          -- 6
  ROW('không ai chấm điểm bài viết này đâu', 0.9),               -- 7
  ROW('chỉ cần viết đúng cảm xúc hiện tại', 0.9),                -- 8
  ROW('có thể tưởng tượng đang an ủi một người bạn', 0.85),      -- 9
  ROW('viết cho bản thân phiên bản đang mệt', 0.9),              -- 10
  ROW('không cần giải quyết mọi thứ ngay', 0.85),                -- 11
  ROW('viết vài câu cũng được rồi', 0.9),                         -- 12
  ROW('có thể viết điều muốn tự nhắc mình', 0.9),                -- 13
  ROW('chỉ cần thành thật, không cần hoàn hảo', 0.9),            -- 14
  ROW('viết những điều bản thân cần nghe', 0.9),                 -- 15
  ROW('có thể bắt đầu bằng “mình đang cảm thấy…”', 0.85),        -- 16
  ROW('không cần dài, quan trọng là thật', 0.9),                 -- 17
  ROW('viết như đang ôm lấy chính mình', 0.9),                   -- 18
  ROW('có thể viết điều bản thân đã cố gắng', 0.85),             -- 19
  ROW('viết cho bản thân trong lúc này', 0.9),                   -- 20
  ROW('không cần nghĩ nhiều, cứ để chữ tuôn ra', 0.85),          -- 21
  ROW('viết ra điều bản thân đang cần nhất', 0.9),               -- 22
  ROW('có thể viết như một lời động viên', 0.9),                 -- 23
  ROW('không ai đọc ngoài bạn đâu', 0.9),                        -- 24
  ROW('viết cho bản thân với sự dịu dàng', 0.9),                 -- 25
  ROW('có thể viết điều khiến bạn thấy mệt', 0.85),              -- 26
  ROW('viết để bản thân được thở ra', 0.9),                      -- 27
  ROW('không cần đúng sai trong lá thư này', 0.9),               -- 28
  ROW('viết vài câu cũng là đủ rồi', 0.9),                        -- 29
  ROW('có thể viết điều bạn muốn được hiểu', 0.9),               -- 30
  ROW('viết cho bản thân như một người quan trọng', 0.9),        -- 31
  ROW('không cần ép bản thân viết nhiều', 0.85),                 -- 32
  ROW('viết ra để nhẹ lòng hơn', 0.9),                            -- 33
  ROW('có thể viết điều bản thân đang chịu đựng', 0.9),          -- 34
  ROW('viết như đang nói chuyện trong đầu', 0.85),               -- 35
  ROW('không cần tìm lời hay', 0.9),                              -- 36
  ROW('viết cho bản thân với sự kiên nhẫn', 0.9),                -- 37
  ROW('có thể viết điều bản thân muốn buông xuống', 0.9),        -- 38
  ROW('viết ra để không phải giữ trong lòng', 0.9),              -- 39
  ROW('không sao nếu chưa biết viết gì', 0.85),                  -- 40
  ROW('viết vài dòng rồi dừng cũng được', 0.9),                  -- 41
  ROW('có thể viết điều khiến bạn lo', 0.9),                     -- 42
  ROW('viết cho bản thân mà không phán xét', 0.9),               -- 43
  ROW('không cần ép cảm xúc phải tích cực', 0.9),                -- 44
  ROW('viết điều bạn muốn tự nhắn nhủ', 0.9),                    -- 45
  ROW('có thể viết điều bạn đang sợ', 0.9),                      -- 46
  ROW('viết ra rồi mình xem tiếp nhé', 0.85),                    -- 47
  ROW('không cần xong ngay', 0.85),                               -- 48
  ROW('viết cho bản thân lúc này là đủ', 0.9),                   -- 49
  ROW('có thể viết bất cứ điều gì hiện lên', 0.9),               -- 50
  ROW('viết để bản thân được lắng nghe', 0.9),                   -- 51
  ROW('không cần chỉnh sửa câu chữ', 0.9),                       -- 52
  ROW('viết cho bản thân một chút dịu dàng', 0.9),               -- 53
  ROW('có thể viết điều bạn mong ai đó nói', 0.9),               -- 54
  ROW('viết ra rồi mình cùng xem tiếp', 0.85),                   -- 55
  ROW('không cần cố gắng làm cho đúng', 0.9),                    -- 56
  ROW('viết cho bản thân như lúc cần nhất', 0.9),                -- 57
  ROW('có thể dừng bất cứ lúc nào', 0.85),                       -- 58
  ROW('viết để tự cho mình một chút an ủi', 0.9),                -- 59
  ROW('không cần phải viết đẹp', 0.9),                            -- 60
  ROW('viết vài dòng trước cũng được', 0.9),                     -- 61
  ROW('có thể quay lại viết tiếp sau', 0.85),                    -- 62
  ROW('viết cho bản thân bằng sự tử tế', 0.9),                   -- 63
  ROW('không cần phải hiểu hết ngay', 0.85),                     -- 64
  ROW('viết ra để bản thân được nghỉ một chút', 0.9),            -- 65
  ROW('có thể viết bất cứ điều gì đang có', 0.9),                -- 66
  ROW('viết cho bản thân mà không áp lực', 0.9),                 -- 67
  ROW('không sao nếu viết rất ngắn', 0.9),                       -- 68
  ROW('viết cho bản thân ngay lúc này', 0.9),                    -- 69
  ROW('viết xong rồi mình nói tiếp nhé', 0.85),

  ROW('you can try writing a few lines to yourself', 0.9),        -- 1
  ROW('it doesn’t have to be perfect', 0.9),                      -- 2
  ROW('write honestly, not nicely', 0.9),                         -- 3
  ROW('you can start with how you feel right now', 0.9),         -- 4
  ROW('take your time, no rush', 0.85),                           -- 5
  ROW('write as if you’re talking to yourself', 0.9),            -- 6
  ROW('this letter is just for you', 0.9),                        -- 7
  ROW('you don’t need to fix everything', 0.85),                  -- 8
  ROW('even a few sentences are enough', 0.9),                   -- 9
  ROW('write what you wish someone would say', 0.9),             -- 10
  ROW('there’s no right or wrong way to do this', 0.9),           -- 11
  ROW('write gently to yourself', 0.9),                           -- 12
  ROW('you can imagine comforting a friend', 0.85),              -- 13
  ROW('just write what feels true', 0.9),                         -- 14
  ROW('you don’t have to write a lot', 0.9),                      -- 15
  ROW('write for the version of you that’s tired', 0.9),         -- 16
  ROW('you can stop anytime', 0.85),                              -- 17
  ROW('write without judging yourself', 0.9),                    -- 18
  ROW('it’s okay if it feels awkward', 0.85),                    -- 19
  ROW('you can start with “right now I feel…”', 0.9),            -- 20
  ROW('this is a space just for you', 0.9),                       -- 21
  ROW('write what you need to hear', 0.9),                        -- 22
  ROW('you don’t need fancy words', 0.9),                         -- 23
  ROW('write at your own pace', 0.85),                            -- 24
  ROW('even short lines matter', 0.9),                            -- 25
  ROW('write like no one else will read it', 0.9),               -- 26
  ROW('you can pause and come back later', 0.85),                -- 27
  ROW('write what feels heavy', 0.9),                             -- 28
  ROW('you don’t need to explain everything', 0.9),              -- 29
  ROW('this is about being kind to yourself', 0.9),              -- 30
  ROW('write whatever comes up', 0.9),                            -- 31
  ROW('there’s no pressure to finish', 0.85),                    -- 32
  ROW('write like you’re listening to yourself', 0.9),           -- 33
  ROW('it’s okay if it’s messy', 0.9),                            -- 34
  ROW('write one sentence if that’s all you can do', 0.9),       -- 35
  ROW('you can take breaks while writing', 0.85),                -- 36
  ROW('write to give yourself some space', 0.9),                 -- 37
  ROW('this is just a gentle exercise', 0.9),                    -- 38
  ROW('write with patience', 0.9),                                -- 39
  ROW('you don’t need to feel positive', 0.9),                   -- 40
  ROW('write what you’re carrying right now', 0.9),              -- 41
  ROW('there’s no deadline here', 0.85),                          -- 42
  ROW('write to yourself like you matter', 0.9),                 -- 43
  ROW('you can keep it simple', 0.9),                             -- 44
  ROW('write a note of care to yourself', 0.9),                  -- 45
  ROW('it’s okay if it feels hard', 0.85),                       -- 46
  ROW('write without trying to solve things', 0.9),              -- 47
  ROW('you can stop whenever you want', 0.85),                   -- 48
  ROW('write what you wish you could say out loud', 0.9),        -- 49
  ROW('this is about letting yourself speak', 0.9),              -- 50
  ROW('write with honesty, not pressure', 0.9),                  -- 51
  ROW('you don’t need to make sense yet', 0.85),                 -- 52
  ROW('write to give yourself a moment', 0.9),                   -- 53
  ROW('even starting is enough', 0.9),                            -- 54
  ROW('write a few lines and see how it feels', 0.9),            -- 55
  ROW('you can continue later if needed', 0.85),                -- 56
  ROW('this is just for now', 0.9),                               -- 57
  ROW('write without expectations', 0.9),                        -- 58
  ROW('you don’t have to finish today', 0.85),                   -- 59
  ROW('write with care toward yourself', 0.9),                  -- 60
  ROW('it’s okay to keep it short', 0.9),                         -- 61
  ROW('write whatever feels closest', 0.9),                      -- 62
  ROW('you can come back to this later', 0.85),                  -- 63
  ROW('write in your own words', 0.9),                            -- 64
  ROW('this is a safe space to write', 0.9),                     -- 65
  ROW('write to give yourself kindness', 0.9),                  -- 66
  ROW('no one expects this to be perfect', 0.9),                -- 67
  ROW('write what feels right right now', 0.9),                  -- 68
  ROW('take a breath and start when ready', 0.85),               -- 69
  ROW('we can check in again after you write', 0.85) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_letter_self'
ON CONFLICT DO NOTHING;
---------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('căng cơ', 1.0),                         -- 1
  ROW('người căng cứng', 1.0),                 -- 2
  ROW('cơ thể căng thẳng', 1.0),               -- 3
  ROW('mệt trong người', 0.9),                 -- 4
  ROW('nặng người', 0.9),                      -- 5
  ROW('khó chịu trong người', 0.95),           -- 6
  ROW('cơ thể không thoải mái', 0.95),         -- 7
  ROW('đau vai gáy', 1.0),                     -- 8
  ROW('căng vai', 1.0),                        -- 9
  ROW('đau lưng', 1.0),                        -- 10
  ROW('người mỏi', 0.9),                       -- 11
  ROW('cảm giác nặng nề', 0.9),                -- 12
  ROW('khó thả lỏng', 1.0),                    -- 13
  ROW('không thư giãn được', 1.0),             -- 14
  ROW('người cứng đơ', 1.0),                   -- 15
  ROW('cơ bị siết lại', 1.0),                  -- 16
  ROW('đầu óc mệt mà người cũng mệt', 0.9),    -- 17
  ROW('toàn thân căng', 1.0),                  -- 18
  ROW('người không nhẹ', 0.9),                 -- 19
  ROW('cảm giác nặng ở ngực', 0.95),           -- 20
  ROW('đau nhức người', 1.0),                  -- 21
  ROW('mệt mỏi toàn thân', 0.9),               -- 22
  ROW('người uể oải', 0.9),                    -- 23
  ROW('khó cảm nhận cơ thể', 0.85),            -- 24
  ROW('không cảm thấy kết nối với cơ thể', 0.85), -- 25
  ROW('cảm giác trống rỗng trong người', 0.9), -- 26
  ROW('tay chân nặng', 0.9),                   -- 27
  ROW('tay chân mỏi', 0.9),                    -- 28
  ROW('khó buông lỏng cơ thể', 1.0),            -- 29
  ROW('cơ thể như bị khóa lại', 1.0),          -- 30
  ROW('người căng từ sáng đến giờ', 1.0),      -- 31
  ROW('cảm giác bị dồn trong người', 0.95),    -- 32
  ROW('mệt mà không biết vì sao', 0.9),        -- 33
  ROW('đầu thì mệt mà người cũng nặng', 0.9),  -- 34
  ROW('khó thả lỏng vai', 1.0),                -- 35
  ROW('khó thả lỏng cổ', 1.0),                 -- 36
  ROW('cảm giác căng ở ngực', 0.95),           -- 37
  ROW('người không thoải mái', 0.95),          -- 38
  ROW('cơ thể đang rất căng', 1.0),            -- 39
  ROW('cảm giác bí trong người', 0.95),        -- 40
  ROW('mệt về mặt thể chất', 0.9),             -- 41
  ROW('cảm giác nặng ở vai', 1.0),             -- 42
  ROW('đau mỏi cổ', 1.0),                      -- 43
  ROW('khó nhận biết cơ thể', 0.85),           -- 44
  ROW('cảm giác tê tê trong người', 0.9),      -- 45
  ROW('tay chân cứng', 1.0),                   -- 46
  ROW('cơ thể không nghe lời', 0.85),          -- 47
  ROW('cảm giác gồng người', 1.0),             -- 48
  ROW('cơ thể bị căng quá lâu', 1.0),          -- 49
  ROW('người mệt rã rời', 0.9),                -- 50
  ROW('cảm giác căng sâu bên trong', 1.0),     -- 51
  ROW('khó thư giãn cơ bắp', 1.0),              -- 52
  ROW('cơ thể đang bị stress', 0.95),          -- 53
  ROW('mệt trong cơ thể', 0.9),                -- 54
  ROW('cảm giác nặng từ trong người', 0.9),    -- 55
  ROW('khó thở do căng người', 0.9),            -- 56
  ROW('người bị gồng cứng', 1.0),               -- 57
  ROW('cảm giác cơ thể bị nén lại', 1.0),      -- 58
  ROW('khó buông cơ', 1.0),                     -- 59
  ROW('mệt mà không ngủ được', 0.9),            -- 60
  ROW('cảm giác căng mà không rõ lý do', 0.95), -- 61
  ROW('người không thả lỏng được', 1.0),       -- 62
  ROW('cơ thể không được nghỉ', 0.9),           -- 63
  ROW('cảm giác mỏi sâu', 0.9),                 -- 64
  ROW('người căng liên tục', 1.0),              -- 65
  ROW('khó cảm nhận từng phần cơ thể', 0.85),  -- 66
  ROW('cơ thể bị áp lực', 0.95),                -- 67
  ROW('người không nhẹ nhõm', 0.9),             -- 68
  ROW('cảm giác gồng suốt ngày', 1.0),          -- 69
  ROW('cơ thể đang rất mệt', 0.9), 

  ROW('muscle tension', 1.0),                   -- 71
  ROW('body feels tense', 1.0),                 -- 72
  ROW('my body is stiff', 1.0),                 -- 73
  ROW('can’t relax my body', 1.0),              -- 74
  ROW('physically tense', 1.0),                 -- 75
  ROW('shoulders feel tight', 1.0),             -- 76
  ROW('neck feels tight', 1.0),                 -- 77
  ROW('body feels heavy', 0.9),                 -- 78
  ROW('physically exhausted', 0.9),             -- 79
  ROW('muscles feel tight', 1.0),                -- 80
  ROW('body feels uncomfortable', 0.95),        -- 81
  ROW('hard to relax', 1.0),                     -- 82
  ROW('can’t loosen up', 1.0),                   -- 83
  ROW('body feels stressed', 0.95),              -- 84
  ROW('chest feels tight', 0.95),                -- 85
  ROW('body feels tense all day', 1.0),          -- 86
  ROW('physically drained', 0.9),                -- 87
  ROW('muscles feel locked', 1.0),               -- 88
  ROW('body feels rigid', 1.0),                  -- 89
  ROW('can’t release tension', 1.0),             -- 90
  ROW('my body won’t relax', 1.0),               -- 91
  ROW('feels tense inside my body', 1.0),        -- 92
  ROW('physically overwhelmed', 0.95),           -- 93
  ROW('body feels tight everywhere', 1.0),       -- 94
  ROW('hard to feel my body', 0.85),              -- 95
  ROW('feel disconnected from my body', 0.85),   -- 96
  ROW('body feels numb', 0.9),                    -- 97
  ROW('body feels compressed', 1.0),             -- 98
  ROW('muscles feel strained', 1.0),              -- 99
  ROW('body feels tense for no reason', 0.95),    -- 100
  ROW('shoulders are tense', 1.0),                -- 101
  ROW('body feels heavy and tight', 0.95),        -- 102
  ROW('hard to let my body rest', 0.9),            -- 103
  ROW('physical stress', 0.95),                   -- 104
  ROW('muscle tightness', 1.0),                   -- 105
  ROW('body feels on edge', 0.95),                -- 106
  ROW('can’t unclench my body', 1.0),             -- 107
  ROW('body feels wound up', 1.0),                -- 108
  ROW('physically uneasy', 0.95),                 -- 109
  ROW('body tension won’t go away', 1.0),         -- 110
  ROW('muscles feel sore and tight', 1.0),        -- 111
  ROW('body feels stuck', 0.9),                   -- 112
  ROW('physical discomfort', 0.95),               -- 113
  ROW('body feels pressured', 0.95),              -- 114
  ROW('hard to release muscle tension', 1.0),     -- 115
  ROW('body feels constrained', 1.0),             -- 116
  ROW('physically restless', 0.9),                -- 117
  ROW('body feels tense inside', 1.0),            -- 118
  ROW('can’t soften my body', 1.0),                -- 119
  ROW('body feels overstimulated', 0.9),           -- 120
  ROW('muscles feel clenched', 1.0),               -- 121
  ROW('body feels tight and tired', 0.9),          -- 122
  ROW('physical tension everywhere', 1.0),        -- 123
  ROW('hard to relax muscles', 1.0),               -- 124
  ROW('body feels stressed out', 0.95),            -- 125
  ROW('body feels heavy inside', 0.9),             -- 126
  ROW('physically overwhelmed inside', 0.95),     -- 127
  ROW('body won’t calm down', 0.95),               -- 128
  ROW('muscles feel tense for hours', 1.0),        -- 129
  ROW('body feels tight nonstop', 1.0),            -- 130
  ROW('physical tightness', 1.0),                  -- 131
  ROW('body feels stiff and tense', 1.0),          -- 132
  ROW('hard to feel relaxed physically', 1.0),     -- 133
  ROW('body feels constricted', 1.0),              -- 134
  ROW('muscles feel overloaded', 0.95),            -- 135
  ROW('body feels tense deep inside', 1.0),        -- 136
  ROW('physical stress buildup', 0.95),             -- 137
  ROW('body feels tense even when resting', 1.0),  -- 138
  ROW('muscles feel overworked', 0.9),              -- 139
  ROW('body feels locked up', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('thư giãn cơ thể', 1.0),
  ROW('cảm thấy nhẹ nhõm', 0.9),
  ROW('thấy cơ thể dễ chịu hơn', 1.0),        -- 1
  ROW('cơ thể bớt căng hơn', 0.95),             -- 2
  ROW('cảm giác nhẹ ra rồi', 0.95),           -- 3
  ROW('thấy thư giãn hơn một chút', 0.9),      -- 4
  ROW('bớt căng thẳng hơn rồi', 0.9),           -- 5
  ROW('người nhẹ hơn', 0.9),                    -- 6
  ROW('dễ chịu hơn trước', 0.9),               -- 7
  ROW('thấy thoải mái hơn', 0.9),               -- 8
  ROW('cơ thể có vẻ ổn hơn', 0.85),            -- 9
  ROW('bớt mệt hơn', 0.85),                     -- 10
  ROW('đỡ bị căng người', 0.85),               -- 11
  ROW('cảm nhận rõ cơ thể hơn', 0.85),         -- 12
  ROW('nhận ra chỗ nào đang căng', 0.85),       -- 13
  ROW('hiểu cơ thể mình hơn', 0.85),            -- 14
  ROW('thấy dễ thở hơn', 0.85),                 -- 15
  ROW('thư giãn hơn một ít', 0.8),              -- 16
  ROW('cảm giác chậm lại', 0.8),               -- 17
  ROW('đầu óc dịu hơn', 0.8),                   -- 18
  ROW('thấy bình tĩnh hơn', 0.8),               -- 19
  ROW('không còn căng như trước', 0.8),         -- 20
  ROW('bớt khó chịu trong người', 0.8),       -- 21
  ROW('cảm giác an toàn hơn', 0.8),             -- 22
  ROW('thấy cơ thể đang dịu xuống', 0.8),      -- 23
  ROW('bớt bị cứng người', 0.8),               -- 24
  ROW('thấy đỡ áp lực hơn', 0.8),               -- 25
  ROW('cơ thể có phản ứng tốt', 0.83),        -- 26
  ROW('cảm nhận rõ hơn từng phần', 0.83),     -- 27
  ROW('thấy có tác dụng', 0.83),               -- 28
  ROW('thư giãn được một phần', 0.83),         -- 29
  ROW('bớt căng ở vai và cổ', 0.83),           -- 30
  ROW('đầu không còn nặng nữa', 0.83),         -- 31
  ROW('cơ thể đỡ mệt hơn', 0.83),               -- 32
  ROW('nhận ra cơ thể đang gì', 0.83),          -- 33
  ROW('thấy dễ chịu từ bên trong', 0.83),     -- 34
  ROW('bớt hối hả trong người', 0.83),         -- 35
  ROW('cơ thể có vẻ thoải mái hơn', 0.8),    -- 36
  ROW('thấy nhẹ nhàng hơn', 0.8),               -- 37
  ROW('đỡ bị áp lực cơ thể', 0.8),             -- 38
  ROW('nhận biết được sự căng thẳng', 0.8),   -- 39
  ROW('cảm giác cơ thể rõ ràng hơn', 0.8),   -- 40
  ROW('bớt khó chịu ở ngực', 0.8),            -- 41
  ROW('thấy dịu lại', 0.8),                     -- 42
  ROW('đỡ căng toàn thân', 0.8),                -- 43
  ROW('thấy dễ chịu dần', 0.8),                -- 44
  ROW('cảm giác ổn hơn trước', 0.8),           -- 45
  ROW('thấy cơ thể đang thư giãn', 0.8),        -- 46
  ROW('bớt bị căng từ bên trong', 0.8),         -- 47
  ROW('nhận ra sự mệt mỏi', 0.8),               -- 48
  ROW('cơ thể dễ chịu dần lên', 0.8),          -- 49
  ROW('thấy dịu hơn so với lúc đầu', 0.8),    -- 50
  ROW('cảm giác nhẹ nhàng hơn', 0.8),         -- 51
  ROW('đỡ căng cơ', 0.8),                        -- 52
  ROW('thấy ổn hơn trong người', 0.8),          -- 53
  ROW('cơ thể có tín hiệu tốt', 0.8),        -- 54
  ROW('thấy đỡ cứng', 0.8),                     -- 55
  ROW('cảm giác cơ thể dịu xuống', 0.8),     -- 56
  ROW('bớt áp lực trên người', 0.8),           -- 57
  ROW('thấy dễ chịu hơn lúc trước', 0.8),    -- 58
  ROW('cơ thể không còn căng nhiều', 0.8),     -- 59
  ROW('thấy thư giãn hơn cảm giác', 0.8),     -- 60
  ROW('cảm nhận cơ thể tốt hơn', 0.8),        -- 61
  ROW('đỡ mệt trong người', 0.8),               -- 62
  ROW('thấy cơ thể bớt áp lực', 0.8),         -- 63
  ROW('cơ thể dịu đi', 0.8),                     -- 64
  ROW('thấy nhẹ hơn một chút', 0.8),           -- 65
  ROW('đỡ căng thẳng toàn thân', 0.8),         -- 66
  ROW('thấy ổn hơn về mặt cơ thể', 0.8),     -- 67
  ROW('cảm giác dễ chịu dần', 0.8),          -- 68
  ROW('cơ thể có vẻ dịu hơn', 0.8),            -- 69
  ROW('thấy thư giãn rõ hơn', 0.8),
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không thư giãn được', 0.9),
  ROW('vẫn căng thẳng', 0.8),
  ROW('không thấy khác gì', 1.0),                     -- 1
  ROW('không thấy hiệu quả', 1.0),                    -- 2
  ROW('vẫn căng như cũ', 0.95),                        -- 3
  ROW('chưa thấy dễ chịu hơn', 0.95),                -- 4
  ROW('không cảm nhận rõ gì', 0.95),                -- 5
  ROW('khó tập trung vào cơ thể', 0.95),            -- 6
  ROW('không cảm nhận được cơ thể', 0.95),           -- 7
  ROW('thấy khó làm', 0.95),                          -- 8
  ROW('thấy hơi kỳ', 0.95),                            -- 9
  ROW('không hiểu làm sao', 0.95),                    -- 10
  ROW('vẫn cảm thấy căng', 0.9),                       -- 11
  ROW('không thấy thư giãn hơn', 0.9),                 -- 12
  ROW('không vào được trạng thái', 0.9),            -- 13
  ROW('cảm giác không thay đổi', 0.9),               -- 14
  ROW('vẫn bị cứng người', 0.9),                     -- 15
  ROW('thấy khó tập trung', 0.9),                     -- 16
  ROW('đầu óc vẫn rối', 0.9),                          -- 17
  ROW('không cảm nhận được gì', 0.9),                -- 18
  ROW('thấy không hợp', 0.9),                           -- 19
  ROW('vẫn áp lực trong người', 0.9),                -- 20
  ROW('không thấy bớt căng', 0.85),                    -- 21
  ROW('cảm giác vẫn y nguyên', 0.85),                 -- 22
  ROW('thấy bị mất tập trung', 0.85),                -- 23
  ROW('không biết có làm đúng không', 0.85),        -- 24
  ROW('thấy hơi khó hiểu', 0.85),                     -- 25
  ROW('không cảm thấy kết nối', 0.85),               -- 26
  ROW('vẫn khó chịu trong người', 0.85),            -- 27
  ROW('không nhận ra cảm giác cơ thể', 0.85),       -- 28
  ROW('thấy không có tác dụng', 0.85),              -- 29
  ROW('không thấy thay đổi rõ', 0.85),               -- 30
  ROW('thấy cơ thể không phản ứng', 0.8),           -- 31
  ROW('vẫn mệt như trước', 0.8),                      -- 32
  ROW('không thấy nhẹ hơn', 0.8),                     -- 33
  ROW('thấy khó theo dõi', 0.8),                      -- 34
  ROW('không cảm nhận được sự thay đổi', 0.8),    -- 35
  ROW('vẫn căng toàn thân', 0.8),                     -- 36
  ROW('thấy không quen', 0.8),                          -- 37
  ROW('thấy hơi mất kiên nhẫn', 0.8),                 -- 38
  ROW('không cảm thấy dễ chịu hơn', 0.8),           -- 39
  ROW('thấy không vào nhịp', 0.8),                    -- 40
  ROW('không thấy khác so với trước', 0.8),        -- 41
  ROW('thấy bị phân tâm', 0.8),                        -- 42
  ROW('không biết tập trung vào đâu', 0.8),         -- 43
  ROW('cảm giác cơ thể vẫn căng', 0.8),            -- 44
  ROW('thấy hơi rối', 0.8),                            -- 45
  ROW('không thấy cơ thể dịu hơn', 0.8),            -- 46
  ROW('thấy làm không quen', 0.8),                    -- 47
  ROW('không cảm nhận được sự thư giãn', 0.8),    -- 48
  ROW('vẫn cảm thấy không ổn', 0.8),               -- 49
  ROW('không thấy giảm căng', 0.8),                   -- 50
  ROW('thấy khó nhận biết cảm giác', 0.75),      -- 51
  ROW('cảm giác không rõ ràng', 0.75),              -- 52
  ROW('không thấy cơ thể thay đổi', 0.75),         -- 53
  ROW('thấy bị rời rạc', 0.75),                     -- 54
  ROW('không cảm thấy thư giãn', 0.75),             -- 55
  ROW('vẫn còn căng cơ', 0.75),                       -- 56
  ROW('thấy không dễ', 0.75),                          -- 57
  ROW('không cảm nhận được sự dịu lại', 0.75),  -- 58
  ROW('vẫn bị áp lực', 0.75),                        -- 59
  ROW('thấy khó hình dung', 0.75),                  -- 60
  ROW('không thấy hiệu quả rõ', 0.75),             -- 61
  ROW('thấy cơ thể không thay đổi', 0.75),         -- 62
  ROW('vẫn không thoải mái', 0.75),                -- 63
  ROW('thấy hơi bất tiện', 0.75),                   -- 64
  ROW('không cảm thấy tốt hơn', 0.75),              -- 65
  ROW('vẫn cảm thấy căng thẳng', 0.75),            -- 66
  ROW('thấy khó tập trung vào cảm giác', 0.75), -- 67
  ROW('không thấy đỡ hơn', 0.75),                    -- 68
  ROW('thấy cơ thể vẫn mệt', 0.75),                -- 69
  ROW('không cảm thấy có ích', 0.75), 

  ROW('does not feel different', 1.0),                -- 71
  ROW('does not feel effective', 1.0),                -- 72
  ROW('still feels tense', 0.95),                     -- 73
  ROW('does not feel more comfortable', 0.95),        -- 74
  ROW('cannot feel much', 0.95),                      -- 75
  ROW('hard to focus on the body', 0.95),              -- 76
  ROW('cannot sense the body', 0.95),                 -- 77
  ROW('feels hard to do', 0.95),                      -- 78
  ROW('feels a bit strange', 0.95),                   -- 79
  ROW('not sure how to do it', 0.95),                 -- 80
  ROW('still feels tense inside', 0.9),               -- 81
  ROW('does not feel relaxed', 0.9),                  -- 82
  ROW('cannot get into the state', 0.9),              -- 83
  ROW('feels no change', 0.9),                        -- 84
  ROW('body still feels stiff', 0.9),                 -- 85
  ROW('hard to concentrate', 0.9),                    -- 86
  ROW('mind still feels messy', 0.9),                 -- 87
  ROW('cannot feel anything clearly', 0.9),           -- 88
  ROW('feels like it does not fit', 0.9),             -- 89
  ROW('still feels pressured', 0.9),                  -- 90
  ROW('does not feel less tense', 0.85),              -- 91
  ROW('feels exactly the same', 0.85),                -- 92
  ROW('keeps getting distracted', 0.85),              -- 93
  ROW('not sure if it is done right', 0.85),           -- 94
  ROW('feels confusing', 0.85),                       -- 95
  ROW('does not feel connected', 0.85),               -- 96
  ROW('body still feels uncomfortable', 0.85),        -- 97
  ROW('cannot notice body sensations', 0.85),         -- 98
  ROW('feels like it did nothing', 0.85),             -- 99
  ROW('no clear change', 0.85),                        -- 100
  ROW('body does not respond', 0.8),                  -- 101
  ROW('still feels tired', 0.8),                      -- 102
  ROW('does not feel lighter', 0.8),                  -- 103
  ROW('hard to follow along', 0.8),                   -- 104
  ROW('cannot sense any change', 0.8),                -- 105
  ROW('body still feels tense overall', 0.8),          -- 106
  ROW('feels unfamiliar', 0.8),                       -- 107
  ROW('feels impatient', 0.8),                        -- 108
  ROW('does not feel more comfortable yet', 0.8),     -- 109
  ROW('cannot get into rhythm', 0.8),                 -- 110
  ROW('feels the same as before', 0.8),               -- 111
  ROW('gets distracted easily', 0.8),                 -- 112
  ROW('not sure what to focus on', 0.8),               -- 113
  ROW('body sensations still feel tense', 0.8),        -- 114
  ROW('feels mentally messy', 0.8),                   -- 115
  ROW('body does not feel calmer', 0.8),               -- 116
  ROW('feels awkward to do', 0.8),                    -- 117
  ROW('does not feel relaxed at all', 0.8),            -- 118
  ROW('still does not feel okay', 0.8),               -- 119
  ROW('no reduction in tension', 0.8),                -- 120
  ROW('hard to notice sensations', 0.75),             -- 121
  ROW('sensations feel unclear', 0.75),               -- 122
  ROW('body feels unchanged', 0.75),                  -- 123
  ROW('feels scattered', 0.75),                       -- 124
  ROW('does not feel soothing', 0.75),                -- 125
  ROW('muscles still feel tight', 0.75),               -- 126
  ROW('feels difficult', 0.75),                       -- 127
  ROW('cannot feel calming effects', 0.75),            -- 128
  ROW('still feels pressured', 0.75),                 -- 129
  ROW('hard to imagine sensations', 0.75),            -- 130
  ROW('no clear benefit', 0.75),                      -- 131
  ROW('body still feels the same', 0.75),              -- 132
  ROW('does not feel comfortable', 0.75),             -- 133
  ROW('feels inconvenient', 0.75),                    -- 134
  ROW('does not feel better', 0.75),                  -- 135
  ROW('still feels stressed', 0.75),                  -- 136
  ROW('hard to focus on sensations', 0.75),            -- 137
  ROW('does not feel improved', 0.75),                -- 138
  ROW('body still feels tired', 0.75),                -- 139
  ROW('does not feel helpful', 0.75)  
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_body_scan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử lại một lần nữa không', 1.0),
  ROW('có cảm thấy nhẹ nhõm hơn không', 0.8),
  ROW('cứ để ý nhẹ nhàng thôi', 1.0),                    -- 1
  ROW('không cần cố cảm nhận gì cả', 1.0),              -- 2
  ROW('chỉ cần chú ý xem cơ thể đang ra sao', 1.0),     -- 3
  ROW('nếu chưa thấy gì cũng không sao', 0.95),         -- 4
  ROW('cảm giác nào đến thì để nó đến', 0.95),          -- 5
  ROW('không cần thay đổi cảm giác', 0.95),             -- 6
  ROW('chỉ quan sát thôi là đủ', 0.95),                 -- 7
  ROW('cứ để cơ thể tự nhiên', 0.95),                   -- 8
  ROW('không cần làm cho đúng', 0.95),                  -- 9
  ROW('không có cảm giác đúng hay sai', 0.95),          -- 10
  ROW('nếu đầu óc lang thang thì cũng ổn', 0.9),        -- 11
  ROW('chỉ cần quay lại với cơ thể khi sẵn sàng', 0.9), -- 12
  ROW('cứ để ý từng phần một cách chậm rãi', 0.9),      -- 13
  ROW('không cần vội vàng', 0.9),                       -- 14
  ROW('chỉ cần ở lại với khoảnh khắc này', 0.9),        -- 15
  ROW('cảm nhận theo nhịp riêng của cơ thể', 0.9),      -- 16
  ROW('nếu thấy khó chịu thì chỉ ghi nhận thôi', 0.9),  -- 17
  ROW('không cần đẩy cảm giác đi', 0.9),                -- 18
  ROW('chỉ cần nhận ra là đủ', 0.9),                    -- 19
  ROW('mọi cảm giác đều được chấp nhận', 0.9),          -- 20
  ROW('cứ để cơ thể lên tiếng theo cách của nó', 0.85), -- 21
  ROW('không cần phân tích', 0.85),                     -- 22
  ROW('chỉ cần để ý thôi', 0.85),                       -- 23
  ROW('nếu chưa quen thì cũng bình thường', 0.85),      -- 24
  ROW('có thể dừng lại nếu cần', 0.85),                 -- 25
  ROW('cứ cho cơ thể một chút thời gian', 0.85),        -- 26
  ROW('chỉ cần lắng nghe', 0.85),                       -- 27
  ROW('không cần ép bản thân cảm thấy gì', 0.85),       -- 28
  ROW('cứ ở yên và quan sát', 0.85),                    -- 29
  ROW('mọi thứ diễn ra chậm cũng ổn', 0.85),            -- 30
  ROW('cảm giác mơ hồ cũng không sao', 0.8),            -- 31
  ROW('không cần cố thư giãn', 0.8),                    -- 32
  ROW('chỉ cần nhận biết là được', 0.8),                -- 33
  ROW('nếu thấy phân tâm thì nhẹ nhàng quay lại', 0.8), -- 34
  ROW('có thể chú ý vào hơi thở nếu cần', 0.8),         -- 35
  ROW('không cần đạt được trạng thái nào', 0.8),        -- 36
  ROW('cứ để mọi thứ như nó đang là', 0.8),             -- 37
  ROW('không cần thay đổi cảm xúc', 0.8),               -- 38
  ROW('chỉ cần ở đây với cơ thể', 0.8),                 -- 39
  ROW('cơ thể biết cách tự điều chỉnh', 0.8),           -- 40
  ROW('nếu mệt thì có thể nghỉ', 0.75),                 -- 41
  ROW('không cần cố gắng quá', 0.75),                   -- 42
  ROW('cứ theo nhịp của bản thân', 0.75),               -- 43
  ROW('chỉ cần chú ý nhẹ nhàng', 0.75),                 -- 44
  ROW('mọi phản ứng đều ổn', 0.75),                     -- 45
  ROW('không cần kiểm soát', 0.75),                     -- 46
  ROW('cứ để cơ thể được là chính nó', 0.75),           -- 47
  ROW('nếu thấy căng thì chỉ cần ghi nhận', 0.75),      -- 48
  ROW('không cần ép thư giãn', 0.75),                   -- 49
  ROW('chỉ cần quan sát một cách hiền', 0.75),          -- 50
  ROW('mọi thứ diễn ra theo cách riêng', 0.75),         -- 51
  ROW('không cần thay đổi ngay', 0.75),                 -- 52
  ROW('cứ ở lại thêm chút nữa nếu muốn', 0.75),         -- 53
  ROW('cơ thể đang làm tốt nhất có thể', 0.75),         -- 54
  ROW('không cần đạt kết quả', 0.75),                   -- 55
  ROW('chỉ cần cho phép cảm giác tồn tại', 0.75),       -- 56
  ROW('mọi trải nghiệm đều hợp lệ', 0.75),              -- 57
  ROW('không cần đánh giá', 0.75),                      -- 58
  ROW('cứ nhẹ nhàng quay lại khi cần', 0.75),           -- 59
  ROW('không cần cố làm cho đúng', 0.75),               -- 60
  ROW('cơ thể đang được chú ý', 0.75),                  -- 61
  ROW('chỉ cần ở đây thêm chút', 0.75),                 -- 62
  ROW('mọi cảm giác đều ổn cả', 0.75),                  -- 63
  ROW('không cần phải hiểu hết', 0.75),                 -- 64
  ROW('cứ để mọi thứ trôi qua', 0.75),                  -- 65
  ROW('không cần phải cố gắng', 0.75),                  -- 66
  ROW('chỉ cần có mặt với cơ thể', 0.75),               -- 67
  ROW('cơ thể đang được lắng nghe', 0.75),              -- 68
  ROW('không cần làm gì thêm', 0.75),                   -- 69
  ROW('chỉ cần tiếp tục nhẹ nhàng', 0.75),              -- 70
  ROW('có thể dừng lại bất cứ lúc nào', 0.75),          -- 71
  ROW('mọi thứ đang ổn', 0.75),                          -- 72
  ROW('cứ để khoảnh khắc này trôi', 0.75),              -- 73
  ROW('chỉ cần ở yên thêm chút nữa', 0.75),             -- 74
  ROW('không cần vội kết thúc', 0.75),

  ROW('just notice gently', 1.0),                       -- 76
  ROW('no need to force any feeling', 1.0),             -- 77
  ROW('simply notice how the body feels', 1.0),         -- 78
  ROW('it is okay if nothing stands out', 0.95),        -- 79
  ROW('let sensations come and go', 0.95),              -- 80
  ROW('no need to change anything', 0.95),              -- 81
  ROW('just observing is enough', 0.95),                -- 82
  ROW('let the body be natural', 0.95),                 -- 83
  ROW('there is no right or wrong', 0.95),               -- 84
  ROW('no need to do this perfectly', 0.95),            -- 85
  ROW('if the mind wanders that is okay', 0.9),          -- 86
  ROW('gently return when ready', 0.9),                 -- 87
  ROW('take it one part at a time', 0.9),               -- 88
  ROW('there is no rush', 0.9),                          -- 89
  ROW('just stay with this moment', 0.9),               -- 90
  ROW('follow the body’s own pace', 0.9),                -- 91
  ROW('discomfort can be noticed without changing it', 0.9), -- 92
  ROW('no need to push sensations away', 0.9),          -- 93
  ROW('noticing is enough', 0.9),                        -- 94
  ROW('all sensations are allowed', 0.9),               -- 95
  ROW('let the body speak in its own way', 0.85),        -- 96
  ROW('no need to analyze', 0.85),                       -- 97
  ROW('just gently notice', 0.85),                       -- 98
  ROW('it is normal if this feels unfamiliar', 0.85),   -- 99
  ROW('you can pause if needed', 0.85),                 -- 100
  ROW('give the body some time', 0.85),                 -- 101
  ROW('simply listen', 0.85),                            -- 102
  ROW('no need to force a feeling', 0.85),               -- 103
  ROW('stay and observe quietly', 0.85),                -- 104
  ROW('slow is completely okay', 0.85),                 -- 105
  ROW('unclear sensations are fine', 0.8),              -- 106
  ROW('no need to try to relax', 0.8),                   -- 107
  ROW('awareness is enough', 0.8),                      -- 108
  ROW('gently come back if distracted', 0.8),           -- 109
  ROW('you may notice the breath if helpful', 0.8),     -- 110
  ROW('no specific state is needed', 0.8),               -- 111
  ROW('let things be as they are', 0.8),                 -- 112
  ROW('no need to change emotions', 0.8),                -- 113
  ROW('just be here with the body', 0.8),                -- 114
  ROW('the body knows how to adjust', 0.8),              -- 115
  ROW('you can rest if tired', 0.75),                    -- 116
  ROW('no need to try too hard', 0.75),                  -- 117
  ROW('follow your own rhythm', 0.75),                   -- 118
  ROW('notice gently', 0.75),                            -- 119
  ROW('every response is okay', 0.75),                   -- 120
  ROW('no need to control anything', 0.75),              -- 121
  ROW('let the body be itself', 0.75),                   -- 122
  ROW('tension can be noticed without fixing it', 0.75), -- 123
  ROW('no need to force relaxation', 0.75),              -- 124
  ROW('observe kindly', 0.75),                            -- 125
  ROW('everything unfolds in its own way', 0.75),        -- 126
  ROW('no need to change anything yet', 0.75),           -- 127
  ROW('stay a little longer if you want', 0.75),         -- 128
  ROW('the body is doing its best', 0.75),               -- 129
  ROW('no outcome is required', 0.75),                   -- 130
  ROW('allow sensations to exist', 0.75),                -- 131
  ROW('all experiences are valid', 0.75),                -- 132
  ROW('no need to judge', 0.75),                          -- 133
  ROW('return gently whenever needed', 0.75),            -- 134
  ROW('there is no need to do this right', 0.75),        -- 135
  ROW('the body is being noticed', 0.75),                -- 136
  ROW('stay here a bit longer', 0.75),                   -- 137
  ROW('everything is okay as it is', 0.75),              -- 138
  ROW('no need to understand everything', 0.75),         -- 139
  ROW('let this moment pass naturally', 0.75),           -- 140
  ROW('no effort is required', 0.75),                    -- 141
  ROW('just stay present with the body', 0.75),          -- 142
  ROW('the body is being listened to', 0.75),            -- 143
  ROW('nothing else is needed', 0.75),                   -- 144
  ROW('continue gently', 0.75),                           -- 145
  ROW('you may stop anytime', 0.75),                     -- 146
  ROW('everything is fine', 0.75),                       -- 147
  ROW('let this moment flow', 0.75),                     -- 148
  ROW('stay still a little longer', 0.75),               -- 149
  ROW('there is no need to rush the end', 0.75)
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
  ROW('lịch chăm sóc bản thân', 0.8),
  ROW('chăm sóc bản thân', 1.0),              -- 1
  ROW('self care', 1.0),                      -- 2
  ROW('muốn chăm sóc mình hơn', 0.95),        -- 3
  ROW('không biết chăm sóc bản thân', 0.95),  -- 4
  ROW('cần chăm sóc bản thân', 0.95),         -- 5
  ROW('không có thời gian cho bản thân', 0.95),-- 6
  ROW('bỏ bê bản thân', 0.95),                -- 7
  ROW('quên chăm sóc mình', 0.95),            -- 8
  ROW('không để ý tới bản thân', 0.9),        -- 9
  ROW('muốn sống lành mạnh hơn', 0.9),        -- 10
  ROW('cần thay đổi thói quen', 0.9),         -- 11
  ROW('thói quen sinh hoạt', 0.9),            -- 12
  ROW('routine hằng ngày', 0.9),              -- 13
  ROW('không có routine', 0.9),               -- 14
  ROW('sinh hoạt không điều độ', 0.9),        -- 15
  ROW('ngủ nghỉ không đều', 0.9),              -- 16
  ROW('ăn uống thất thường', 0.9),            -- 17
  ROW('không chăm lo cho sức khỏe', 0.9),     -- 18
  ROW('muốn sắp xếp lại cuộc sống', 0.9),     -- 19
  ROW('cuộc sống lộn xộn', 0.9),               -- 20
  ROW('mọi thứ rối tung', 0.9),                -- 21
  ROW('không biết bắt đầu từ đâu', 0.9),      -- 22
  ROW('cần kế hoạch cho bản thân', 0.9),      -- 23
  ROW('lập kế hoạch chăm sóc', 0.9),           -- 24
  ROW('kế hoạch sinh hoạt', 0.9),              -- 25
  ROW('muốn sống cân bằng hơn', 0.85),        -- 26
  ROW('không cân bằng', 0.85),                -- 27
  ROW('mất cân bằng cuộc sống', 0.85),        -- 28
  ROW('cảm thấy quá tải', 0.85),               -- 29
  ROW('quá nhiều thứ phải lo', 0.85),          -- 30
  ROW('kiệt sức', 0.85),                       -- 31
  ROW('mệt mỏi kéo dài', 0.85),                -- 32
  ROW('burnout', 0.85),                        -- 33
  ROW('stress kéo dài', 0.85),                 -- 34
  ROW('không biết tự chăm sóc sao cho đúng', 0.85), -- 35
  ROW('cần nghỉ ngơi nhiều hơn', 0.85),        -- 36
  ROW('muốn quan tâm bản thân hơn', 0.85),    -- 37
  ROW('cảm thấy mình bị bỏ quên', 0.85),       -- 38
  ROW('không lo cho mình', 0.85),              -- 39
  ROW('cần chăm sóc sức khỏe tinh thần', 0.85),-- 40
  ROW('muốn thay đổi lối sống', 0.85),         -- 41
  ROW('lối sống không ổn', 0.85),              -- 42
  ROW('sinh hoạt thất thường', 0.85),          -- 43
  ROW('muốn có kế hoạch rõ ràng', 0.85),       -- 44
  ROW('cần sắp xếp lại mọi thứ', 0.85),        -- 45
  ROW('không biết ưu tiên gì', 0.85),          -- 46
  ROW('không biết chăm mình ra sao', 0.85),   -- 47
  ROW('muốn chăm sóc bản thân tốt hơn', 0.85),-- 48
  ROW('cần quan tâm tới bản thân', 0.85),      -- 49
  ROW('bỏ quên nhu cầu bản thân', 0.85),       -- 50
  ROW('cảm thấy thiếu chăm sóc', 0.8),         -- 51
  ROW('muốn lập routine', 0.8),                -- 52
  ROW('tạo thói quen mới', 0.8),               -- 53
  ROW('chăm sóc tinh thần', 0.8),               -- 54
  ROW('chăm sóc cảm xúc', 0.8),                -- 55
  ROW('cần kế hoạch sinh hoạt lành mạnh', 0.8),-- 56
  ROW('muốn sống tốt hơn', 0.8),                -- 57
  ROW('muốn sống ổn định hơn', 0.8),           -- 58
  ROW('muốn quan tâm sức khỏe', 0.8),           -- 59
  ROW('thiếu routine', 0.8),                   -- 60
  ROW('thiếu thói quen tốt', 0.8),              -- 61
  ROW('muốn chăm sóc bản thân đúng cách', 0.8),-- 62
  ROW('cần định hướng cho bản thân', 0.8),     -- 63
  ROW('cần kế hoạch cá nhân', 0.8),             -- 64
  ROW('không biết nên chăm sóc cái gì trước', 0.8), -- 65
  ROW('quên nghỉ ngơi', 0.8),                   -- 66
  ROW('quên ăn uống đàng hoàng', 0.8),          -- 67
  ROW('không để ý sức khỏe', 0.8),              -- 68
  ROW('muốn thay đổi nhịp sống', 0.8),          -- 69
  ROW('cần thời gian cho bản thân', 0.8),       -- 70
  ROW('muốn chăm sóc toàn diện hơn', 0.8),     -- 71
  ROW('cảm thấy bản thân bị quá tải', 0.8),    -- 72
  ROW('muốn cân bằng lại', 0.8),               -- 73
  ROW('cần tự chăm sóc nhiều hơn', 0.8),       -- 74
  ROW('muốn lập kế hoạch tự chăm sóc', 0.8),

  ROW('self care', 1.0),                        -- 76
  ROW('taking care of myself', 1.0),            -- 77
  ROW('need self care', 0.95),                  -- 78
  ROW('want to take better care of myself', 0.95), -- 79
  ROW('not taking care of myself', 0.95),       -- 80
  ROW('neglecting myself', 0.95),               -- 81
  ROW('forgetting self care', 0.95),            -- 82
  ROW('no time for myself', 0.95),              -- 83
  ROW('need to care for myself', 0.95),         -- 84
  ROW('need better habits', 0.9),               -- 85
  ROW('daily routine', 0.9),                    -- 86
  ROW('no routine', 0.9),                       -- 87
  ROW('unhealthy routine', 0.9),                -- 88
  ROW('irregular schedule', 0.9),               -- 89
  ROW('need a routine', 0.9),                   -- 90
  ROW('lifestyle is messy', 0.9),               -- 91
  ROW('life feels chaotic', 0.9),               -- 92
  ROW('everything feels overwhelming', 0.9),    -- 93
  ROW('need a plan for myself', 0.9),            -- 94
  ROW('self care plan', 0.9),                    -- 95
  ROW('need structure', 0.9),                   -- 96
  ROW('need balance', 0.9),                     -- 97
  ROW('life feels unbalanced', 0.9),             -- 98
  ROW('need healthier habits', 0.9),             -- 99
  ROW('burnt out', 0.85),                        -- 100
  ROW('long term stress', 0.85),                 -- 101
  ROW('constantly tired', 0.85),                 -- 102
  ROW('emotionally drained', 0.85),              -- 103
  ROW('need rest', 0.85),                        -- 104
  ROW('need to slow down', 0.85),                -- 105
  ROW('need to prioritize myself', 0.85),        -- 106
  ROW('not caring about myself enough', 0.85),   -- 107
  ROW('need mental self care', 0.85),             -- 108
  ROW('need emotional self care', 0.85),          -- 109
  ROW('want a healthier lifestyle', 0.85),       -- 110
  ROW('lifestyle needs change', 0.85),            -- 111
  ROW('need to reorganize life', 0.85),           -- 112
  ROW('dont know what to prioritize', 0.85),     -- 113
  ROW('need a clear plan', 0.85),                 -- 114
  ROW('need personal plan', 0.85),                -- 115
  ROW('want better balance', 0.85),               -- 116
  ROW('forgetting to rest', 0.85),                -- 117
  ROW('forgetting to eat properly', 0.85),        -- 118
  ROW('not paying attention to health', 0.85),    -- 119
  ROW('need time for myself', 0.85),               -- 120
  ROW('need healthier schedule', 0.8),            -- 121
  ROW('need better self care', 0.8),               -- 122
  ROW('want a routine', 0.8),                     -- 123
  ROW('building new habits', 0.8),                -- 124
  ROW('need structure in life', 0.8),              -- 125
  ROW('want to live better', 0.8),                -- 126
  ROW('want to feel more stable', 0.8),           -- 127
  ROW('need to focus on health', 0.8),             -- 128
  ROW('lack of routine', 0.8),                    -- 129
  ROW('lack of good habits', 0.8),                 -- 130
  ROW('want proper self care', 0.8),               -- 131
  ROW('need direction for myself', 0.8),           -- 132
  ROW('need personal structure', 0.8),             -- 133
  ROW('not sure how to care for myself', 0.8),     -- 134
  ROW('need more self care time', 0.8),             -- 135
  ROW('want to reset my routine', 0.8),            -- 136
  ROW('need balanced lifestyle', 0.8),             -- 137
  ROW('life feels overloaded', 0.8),               -- 138
  ROW('need to take better care of myself', 0.8),  -- 139
  ROW('want a self care routine', 0.8),             -- 140
  ROW('need a self care plan', 0.8),                -- 141
  ROW('want to organize self care', 0.8),          -- 142
  ROW('need healthier balance', 0.8),              -- 143
  ROW('need consistent routine', 0.8),             -- 144
  ROW('want to feel taken care of', 0.8),          -- 145
  ROW('need to look after myself', 0.8),           -- 146
  ROW('want better self management', 0.8),         -- 147
  ROW('need sustainable routine', 0.8),            -- 148
  ROW('want long term self care', 0.8),             -- 149
  ROW('need to rebuild routine', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('thực hiện được kế hoạch', 1.0),
  ROW('cảm thấy tự chăm sóc hơn', 0.9),
  ROW('thấy dễ chăm sóc bản thân hơn', 1.0),      -- 1
  ROW('biết mình cần gì hơn', 1.0),              -- 2
  ROW('cảm thấy được quan tâm', 0.95),            -- 3
  ROW('có kế hoạch rõ ràng hơn', 0.95),          -- 4
  ROW('thấy an tâm hơn', 0.9),                      -- 5
  ROW('cảm giác ổn định hơn', 0.9),               -- 6
  ROW('có định hướng hơn', 0.9),                  -- 7
  ROW('biết mình nên làm gì tiếp theo', 0.9),   -- 8
  ROW('không còn rối như trước', 0.9),            -- 9
  ROW('thấy mọi thứ dễ hơn', 0.85),               -- 10
  ROW('cảm giác mình đang chăm sóc bản thân', 0.95), -- 11
  ROW('thấy bản thân quan trọng hơn', 0.95),     -- 12
  ROW('biết cách nghỉ ngơi hơn', 0.9),           -- 13
  ROW('biết cách giữ sức hơn', 0.9),             -- 14
  ROW('có cách tự chăm sóc', 0.9),              -- 15
  ROW('cảm thấy được nâng đỡ', 0.9),              -- 16
  ROW('cảm giác mình không bị bỏ mặc', 0.9),  -- 17
  ROW('thấy dễ thở hơn', 0.85),                   -- 18
  ROW('thấy nhẹ lòng hơn', 0.9),                  -- 19
  ROW('cảm giác được chăm chú', 0.9),            -- 20
  ROW('có thể tự lo cho mình', 0.95),            -- 21
  ROW('cảm thấy mình có giá trị', 0.9),        -- 22
  ROW('không còn bỏ bê bản thân', 0.9),           -- 23
  ROW('biết cân bằng hơn', 0.9),                  -- 24
  ROW('thấy đỡ mệt hơn', 0.85),                   -- 25
  ROW('biết nghỉ khi cần', 0.9),                  -- 26
  ROW('biết quan tâm đến sức khỏe', 0.9),        -- 27
  ROW('cảm giác an toàn hơn', 0.9),               -- 28
  ROW('có cảm giác được bảo vệ', 0.9),         -- 29
  ROW('có thể chậm lại một chút', 0.85),       -- 30
  ROW('không còn căng thẳng như trước', 0.9),     -- 31
  ROW('thấy bản thân dễ chịu hơn', 0.9),         -- 32
  ROW('cảm giác mọi thứ có kiểm soát', 0.9),  -- 33
  ROW('biết sắp xếp bản thân', 0.9),             -- 34
  ROW('thấy mình chủ động hơn', 0.9),            -- 35
  ROW('có cảm giác ổn định cảm xúc', 0.9),   -- 36
  ROW('thấy bản thân được chăm lo', 0.95),        -- 37
  ROW('không còn quá kiệt sức', 0.9),            -- 38
  ROW('biết giữ mình', 0.9),                      -- 39
  ROW('thấy đỡ áp lực hơn', 0.9),                -- 40
  ROW('có cảm giác an ủi', 0.9),                 -- 41
  ROW('thấy mình được quan tâm đúng cách', 0.95), -- 42
  ROW('biết tự lo cho cảm xúc', 0.9),            -- 43
  ROW('cảm giác bản thân được tôn trọng', 0.9),-- 44
  ROW('có thể tự chắc lọc', 0.85),              -- 45
  ROW('thấy bản thân quan trọng hơn trước', 0.9),-- 46
  ROW('cảm giác được yêu thương hơn', 0.9),      -- 47
  ROW('biết quan tâm đến mình hơn', 0.95),       -- 48
  ROW('có cảm giác được chăm chú đủ', 0.9),   -- 49
  ROW('thấy bản thân không bị bỏ quên', 0.9),   -- 50
  ROW('biết ưu tiên bản thân', 0.95),             -- 51
  ROW('có cách lo cho mình tốt hơn', 0.95),     -- 52
  ROW('thấy mình có trách nhiệm với bản thân', 0.9), -- 53
  ROW('cảm giác tự chủ hơn', 0.9),              -- 54
  ROW('biết dừng lại đúng lúc', 0.9),           -- 55
  ROW('thấy bản thân không bị quá tải', 0.9),  -- 56
  ROW('cảm giác được chăm sóc đủ đầy', 0.95), -- 57
  ROW('biết giữ năng lượng', 0.85),              -- 58
  ROW('có cảm giác ổn hơn trong ngày', 0.9),  -- 59
  ROW('thấy mình dễ chịu hơn cả ngày', 0.9),  -- 60
  ROW('cảm giác được chở che', 0.9),             -- 61
  ROW('thấy bản thân không bị lãng quên', 0.9), -- 62
  ROW('biết quan tâm đến sức khỏe tinh thần', 0.95), -- 63
  ROW('cảm giác mình được chăm lo đúng cách', 0.95), -- 64
  ROW('thấy mình không bị bỏ rơi', 0.9),        -- 65
  ROW('biết tự chắm sóc bản thân', 0.95),      -- 66
  ROW('có cảm giác an tâm về bản thân', 0.9), -- 67
  ROW('thấy mình được đối xử tốt hơn', 0.9),  -- 68
  ROW('biết yêu cầu bản thân nghỉ ngơi', 0.9), -- 69
  ROW('cảm giác bản thân được ưu tiên', 1.0)

  ROW('vẫn chưa chăm sóc bản thân', 0.8),
  ROW('feel more taken care of', 1.0),                 -- 1
  ROW('feel more cared for', 1.0),                     -- 2
  ROW('feel more supported', 0.95),                    -- 3
  ROW('feel safer now', 0.9),                          -- 4
  ROW('feel more stable', 0.9),                        -- 5
  ROW('feel more grounded overall', 0.9),              -- 6
  ROW('feel more balanced', 0.9),                      -- 7
  ROW('feel more okay now', 0.9),                      -- 8
  ROW('feel more settled', 0.9),                       -- 9
  ROW('feel less overwhelmed', 0.9),                   -- 10
  ROW('know how to take care of myself better', 0.95), -- 11
  ROW('have a clearer plan for myself', 0.95),        -- 12
  ROW('feel more in control of myself', 0.9),          -- 13
  ROW('feel more intentional', 0.9),                   -- 14
  ROW('feel more aware of my needs', 0.95),            -- 15
  ROW('understand what I need better', 0.95),          -- 16
  ROW('feel more organized inside', 0.9),              -- 17
  ROW('feel less chaotic', 0.9),                       -- 18
  ROW('feel more steady emotionally', 0.9),            -- 19
  ROW('feel calmer overall', 0.9),                     -- 20
  ROW('feel like I am taking care of myself', 1.0),    -- 21
  ROW('feel more responsible for myself', 0.9),       -- 22
  ROW('feel less neglected', 0.9),                     -- 23
  ROW('feel more valued', 0.9),                        -- 24
  ROW('feel more respected', 0.9),                     -- 25
  ROW('feel more important', 0.9),                     -- 26
  ROW('feel more protected', 0.9),                     -- 27
  ROW('feel more emotionally safe', 0.95),             -- 28
  ROW('feel less drained', 0.9),                       -- 29
  ROW('feel less exhausted', 0.9),                     -- 30
  ROW('know when to rest', 0.9),                        -- 31
  ROW('know when to slow down', 0.9),                  -- 32
  ROW('feel allowed to rest', 0.95),                   -- 33
  ROW('feel allowed to take breaks', 0.95),            -- 34
  ROW('feel less pressure', 0.9),                      -- 35
  ROW('feel less stressed', 0.9),                      -- 36
  ROW('feel less tense', 0.9),                         -- 37
  ROW('feel mentally lighter', 0.9),                   -- 38
  ROW('feel more at ease', 0.9),                       -- 39
  ROW('feel more comfortable', 0.9),                   -- 40
  ROW('feel like I matter more', 0.9),                 -- 41
  ROW('feel like I am not ignoring myself', 0.95),    -- 42
  ROW('feel more gentle with myself', 0.95),           -- 43
  ROW('feel kinder to myself', 0.95),                  -- 44
  ROW('feel less hard on myself', 0.9),                -- 45
  ROW('feel more patient with myself', 0.9),           -- 46
  ROW('feel emotionally supported', 0.95),             -- 47
  ROW('feel more emotionally steady', 0.9),            -- 48
  ROW('feel more emotionally okay', 0.9),              -- 49
  ROW('feel more emotionally safe', 0.95),             -- 50
  ROW('feel like I am doing enough', 0.9),             -- 51
  ROW('feel less guilty about resting', 0.9),          -- 52
  ROW('feel allowed to prioritize myself', 0.95),     -- 53
  ROW('feel like I can take care of myself', 1.0),    -- 54
  ROW('feel more capable of self-care', 1.0),          -- 55
  ROW('feel more confident about my needs', 0.9),     -- 56
  ROW('feel more mindful of myself', 0.9),             -- 57
  ROW('feel more aware of my limits', 0.9),            -- 58
  ROW('feel more emotionally prepared', 0.9),          -- 59
  ROW('feel more stable throughout the day', 0.9),    -- 60
  ROW('feel more cared for than before', 0.95),        -- 61
  ROW('feel more supported than before', 0.95),       -- 62
  ROW('feel better overall', 0.9),                     -- 63
  ROW('feel more okay than earlier', 0.9),             -- 64
  ROW('feel less fragile', 0.9),                       -- 65
  ROW('feel more secure', 0.9),                        -- 66
  ROW('feel emotionally held', 0.9),                   -- 67
  ROW('feel like I am not being ignored', 0.95),       -- 68
  ROW('feel like I am a priority', 1.0),               -- 69
  ROW('feel properly taken care of', 1.0) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không hoàn thành kế hoạch', 0.9),
  ROW('vẫn thấy mệt', 1.0),                     -- 1
  ROW('không thấy khá hơn', 1.0),               -- 2
  ROW('chưa thấy tác dụng', 0.95),              -- 3
  ROW('không giúp gì mấy', 0.95),               -- 4
  ROW('cảm giác vẫn nặng', 0.95),              -- 5
  ROW('vẫn rất áp lực', 0.95),                  -- 6
  ROW('chưa thấy dễ hơn', 0.9),                  -- 7
  ROW('không thấy nhẹ lòng', 0.9),              -- 8
  ROW('vẫn thấy quá tải', 0.95),                -- 9
  ROW('mọi thứ vẫn rối', 0.9),                  -- 10
  ROW('không biết bắt đầu từ đâu', 0.95),      -- 11
  ROW('cảm giác không lo nổi', 1.0),            -- 12
  ROW('vẫn thấy bất lực', 1.0),                  -- 13
  ROW('kế hoạch có vẻ không hợp', 0.9),       -- 14
  ROW('không theo được kế hoạch', 0.95),        -- 15
  ROW('cảm giác không khả thi', 0.9),           -- 16
  ROW('vẫn bị cuốn theo mọi thứ', 0.9),        -- 17
  ROW('không thấy an tâm hơn', 0.95),             -- 18
  ROW('cảm giác vẫn bị bỏ mặc', 1.0),         -- 19
  ROW('không cảm thấy được chăm sóc', 1.0),    -- 20
  ROW('vẫn thấy không ổn', 0.95),                -- 21
  ROW('chưa thấy được quan tâm', 1.0),            -- 22
  ROW('cảm giác mình bị làm ngơ', 1.0),       -- 23
  ROW('vẫn thấy căng thẳng', 0.95),              -- 24
  ROW('không thấy bớt mệt', 0.9),                -- 25
  ROW('cảm giác mọi thứ quá sức', 1.0),      -- 26
  ROW('vẫn thấy khó thở', 0.9),                 -- 27
  ROW('chưa thấy dễ chịu', 0.9),                -- 28
  ROW('cảm giác vẫn nặng nề', 0.95),           -- 29
  ROW('vẫn không nghỉ ngơi được', 0.95),        -- 30
  ROW('không thấy mình được ưu tiên', 1.0),     -- 31
  ROW('cảm giác bản thân không quan trọng', 1.0), -- 32
  ROW('vẫn thấy thiếu chăm sóc', 1.0),          -- 33
  ROW('không thấy có định hướng', 0.95),       -- 34
  ROW('vẫn bị rối trong đầu', 0.95),            -- 35
  ROW('không thấy kiểm soát được', 0.95),       -- 36
  ROW('cảm giác mọi thứ vẫn mất trật tự', 0.9), -- 37
  ROW('không biết lo cho mình thế nào', 1.0),  -- 38
  ROW('vẫn thấy bản thân bị bỏ quên', 1.0),   -- 39
  ROW('không thấy được chở che', 1.0),           -- 40
  ROW('cảm giác vẫn trống rỗng', 0.95),       -- 41
  ROW('vẫn thấy bất an', 0.95),                  -- 42
  ROW('không thấy dễ thở hơn', 0.9),            -- 43
  ROW('cảm giác không được an ủi', 1.0),       -- 44
  ROW('vẫn thấy mình không đủ tốt', 0.9),      -- 45
  ROW('không thấy mình được quan tâm đúng cách', 1.0), -- 46
  ROW('vẫn thấy áp lực cả ngày', 0.95),       -- 47
  ROW('chưa thấy cảm giác an toàn', 0.95),    -- 48
  ROW('cảm giác vẫn không ổn định', 0.95),    -- 49
  ROW('không thấy bớt căng', 0.9),               -- 50
  ROW('cảm giác mình không tự lo nổi', 1.0), -- 51
  ROW('vẫn thấy mọi thứ quá nhanh', 0.9),     -- 52
  ROW('không thấy có khoảng nghỉ', 0.95),     -- 53
  ROW('vẫn thấy bị ép', 0.9),                  -- 54
  ROW('cảm giác vẫn bị kéo căng', 0.9),       -- 55
  ROW('không thấy mình được chăm lo đủ', 1.0),-- 56
  ROW('vẫn thấy thiếu nâng đỡ', 1.0),          -- 57
  ROW('cảm giác vẫn không được nghỉ', 0.95), -- 58
  ROW('không thấy bớt nặng', 0.9),              -- 59
  ROW('vẫn thấy quá nhiều thứ phải lo', 0.95), -- 60
  ROW('cảm giác bản thân vẫn bị bỏ rơi', 1.0), -- 61
  ROW('không thấy mình được chăm sóc thật sự', 1.0), -- 62
  ROW('vẫn thấy mọi thứ chồng chất', 0.95),   -- 63
  ROW('chưa thấy cảm giác an ủi nào', 1.0),  -- 64
  ROW('không thấy mình được nghỉ ngơi', 0.95), -- 65
  ROW('vẫn thấy mình đang chịu đựng', 0.95),  -- 66
  ROW('không thấy đỡ hơn chút nào', 1.0),     -- 67
  ROW('vẫn thấy rất mệt mỏi', 1.0),             -- 68
  ROW('cảm giác mọi thứ vẫn quá nặng', 1.0),-- 69
  ROW('không thấy bản thân được chăm chú', 1.0),

  ROW('still feel tired', 1.0),                         -- 1
  ROW('do not feel better', 1.0),                       -- 2
  ROW('has not helped much', 0.95),                     -- 3
  ROW('did not really help', 0.95),                     -- 4
  ROW('still feel heavy', 0.95),                        -- 5
  ROW('still feel pressured', 0.95),                    -- 6
  ROW('do not feel lighter', 0.9),                      -- 7
  ROW('still feel overwhelmed', 1.0),                  -- 8
  ROW('things still feel messy', 0.9),                 -- 9
  ROW('nothing feels clearer', 0.9),                   -- 10
  ROW('still feel stuck', 1.0),                         -- 11
  ROW('do not know where to start', 0.95),              -- 12
  ROW('feel unable to take care of myself', 1.0),      -- 13
  ROW('plan does not feel right', 0.9),                -- 14
  ROW('cannot follow the plan', 0.95),                 -- 15
  ROW('feels unrealistic', 0.9),                       -- 16
  ROW('still feel pulled in many directions', 0.9),   -- 17
  ROW('do not feel safer', 0.95),                      -- 18
  ROW('still feel uncared for', 1.0),                  -- 19
  ROW('do not feel taken care of', 1.0),               -- 20
  ROW('still feel not okay', 0.95),                    -- 21
  ROW('do not feel supported', 1.0),                   -- 22
  ROW('feel ignored', 1.0),                            -- 23
  ROW('still feel tense', 0.95),                       -- 24
  ROW('do not feel less tired', 0.9),                  -- 25
  ROW('everything still feels like too much', 1.0),   -- 26
  ROW('still feel restless', 0.9),                    -- 27
  ROW('do not feel comfortable', 0.9),                -- 28
  ROW('still feel weighed down', 0.95),               -- 29
  ROW('still cannot rest', 0.95),                     -- 30
  ROW('do not feel like a priority', 1.0),             -- 31
  ROW('feel unimportant', 1.0),                        -- 32
  ROW('still feel neglected', 1.0),                   -- 33
  ROW('do not feel guided', 0.95),                     -- 34
  ROW('mind still feels messy', 0.95),                 -- 35
  ROW('do not feel in control', 0.95),                 -- 36
  ROW('everything still feels disorganized', 0.9),    -- 37
  ROW('do not know how to care for myself', 1.0),     -- 38
  ROW('still feel forgotten', 1.0),                   -- 39
  ROW('do not feel protected', 1.0),                  -- 40
  ROW('still feel empty', 0.95),                       -- 41
  ROW('still feel uneasy', 0.95),                     -- 42
  ROW('do not feel more relaxed', 0.9),               -- 43
  ROW('do not feel comforted', 1.0),                  -- 44
  ROW('still feel like I am not enough', 0.9),        -- 45
  ROW('do not feel properly cared for', 1.0),         -- 46
  ROW('still feel pressure all day', 0.95),           -- 47
  ROW('do not feel safe yet', 0.95),                  -- 48
  ROW('still feel unstable', 0.95),                  -- 49
  ROW('do not feel less tense', 0.9),                 -- 50
  ROW('feel unable to manage myself', 1.0),           -- 51
  ROW('everything still feels too fast', 0.9),        -- 52
  ROW('do not feel any break', 0.95),                 -- 53
  ROW('still feel forced', 0.9),                      -- 54
  ROW('still feel stretched thin', 0.9),              -- 55
  ROW('do not feel cared for enough', 1.0),           -- 56
  ROW('still feel unsupported', 1.0),                 -- 57
  ROW('still cannot relax', 0.95),                    -- 58
  ROW('do not feel lighter at all', 0.9),             -- 59
  ROW('still feel too many things to handle', 0.95), -- 60
  ROW('still feel abandoned', 1.0),                   -- 61
  ROW('do not feel truly cared for', 1.0),            -- 62
  ROW('still feel overwhelmed by everything', 0.95), -- 63
  ROW('do not feel any comfort yet', 1.0),            -- 64
  ROW('do not feel rested', 0.95),                    -- 65
  ROW('still feel like I am just coping', 0.95),      -- 66
  ROW('do not feel any better at all', 1.0),          -- 67
  ROW('still feel very exhausted', 1.0),              -- 68
  ROW('everything still feels heavy', 1.0),           -- 69
  ROW('do not feel emotionally cared for', 1.0) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='exercise_selfcare_plan'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử điều chỉnh kế hoạch không', 1.0),
  ROW('có dễ chịu hơn chưa', 0.8),
  ROW('có thể thử làm từng phần nhỏ thôi', 1.0),          -- 1
  ROW('không cần làm hết một lúc', 1.0),                 -- 2
  ROW('có thể chọn một việc dễ nhất trước', 0.95),      -- 3
  ROW('nếu thấy mệt thì có thể nghỉ', 0.95),             -- 4
  ROW('không cần phải hoàn hảo', 1.0),                   -- 5
  ROW('làm được bao nhiêu cũng ổn', 1.0),                -- 6
  ROW('có thể chậm lại một chút', 0.95),                 -- 7
  ROW('không sao nếu hôm nay chưa làm hết', 1.0),       -- 8
  ROW('có thể thử một việc nhỏ thôi', 0.95),             -- 9
  ROW('không cần ép bản thân', 1.0),                     -- 10

  ROW('nếu thấy khó thì có thể điều chỉnh lại', 0.95),   -- 11
  ROW('có thể đổi sang cách nhẹ hơn', 0.95),            -- 12
  ROW('không sao nếu kế hoạch chưa hợp', 1.0),          -- 13
  ROW('có thể xem lại cho phù hợp hơn', 0.95),          -- 14
  ROW('mọi thứ có thể linh hoạt', 0.9),                  -- 15
  ROW('không cần làm giống y như đã viết', 0.9),        -- 16
  ROW('có thể thay đổi nếu thấy chưa ổn', 0.95),        -- 17
  ROW('kế hoạch là để hỗ trợ, không phải áp lực', 1.0), -- 18
  ROW('có thể chọn lại nếu cần', 0.95),                 -- 19
  ROW('không sao nếu phải thử lại', 1.0),               -- 20

  ROW('có thể tự hỏi điều gì giúp dễ chịu hơn', 0.9),   -- 21
  ROW('có thể chú ý xem cơ thể cần gì', 0.9),           -- 22
  ROW('có thể ưu tiên nghỉ ngơi trước', 0.95),          -- 23
  ROW('có thể bắt đầu từ việc chăm sóc nhỏ nhất', 0.95), -- 24
  ROW('không cần làm nhiều để được coi là chăm sóc', 1.0), -- 25
  ROW('một việc nhỏ cũng là chăm sóc', 1.0),            -- 26
  ROW('có thể tập trung vào điều dễ làm hôm nay', 0.95), -- 27
  ROW('không cần so sánh với ai khác', 1.0),            -- 28
  ROW('mỗi người có nhịp riêng', 0.95),                 -- 29
  ROW('làm theo khả năng hiện tại là đủ', 1.0),         -- 30

  ROW('nếu chưa sẵn sàng thì có thể để sau', 0.95),     -- 31
  ROW('có thể quay lại khi thấy ổn hơn', 0.95),         -- 32
  ROW('không cần ép phải cảm thấy tốt ngay', 1.0),     -- 33
  ROW('chăm sóc là một quá trình', 0.95),               -- 34
  ROW('mọi bước đều có giá trị', 0.95),                 -- 35
  ROW('không sao nếu hôm nay chỉ làm được một chút', 1.0), -- 36
  ROW('có thể thử lại vào lúc khác', 0.95),             -- 37
  ROW('không cần tự trách nếu chưa làm được', 1.0),    -- 38
  ROW('có thể nhẹ nhàng với bản thân hơn', 1.0),       -- 39
  ROW('chăm sóc không phải là nghĩa vụ', 1.0),         -- 40

  ROW('có thể xem lại xem điều gì thực sự cần', 0.9),  -- 41
  ROW('có thể bỏ bớt những gì làm nặng thêm', 0.95),   -- 42
  ROW('không cần giữ những việc không còn phù hợp', 0.95), -- 43
  ROW('có thể chọn điều giúp dễ thở hơn', 0.95),       -- 44
  ROW('chỉ cần tập trung vào hiện tại', 0.9),          -- 45
  ROW('mỗi lần thử đều là một bước', 0.95),            -- 46
  ROW('không cần phải cố gắng quá mức', 1.0),          -- 47
  ROW('có thể cho phép bản thân nghỉ ngơi', 1.0),      -- 48
  ROW('chăm sóc cũng có thể rất đơn giản', 1.0),       -- 49
  ROW('không cần làm gì to tát', 1.0),                 -- 50

  ROW('có thể hỏi lại bản thân điều gì đang cần nhất', 0.9), -- 51
  ROW('có thể ưu tiên cảm giác an toàn trước', 0.95), -- 52
  ROW('chăm sóc là để hỗ trợ chính mình', 1.0),        -- 53
  ROW('không cần chứng minh điều gì', 1.0),            -- 54
  ROW('mọi cảm giác đều được phép', 0.95),             -- 55
  ROW('có thể dừng lại khi thấy quá tải', 1.0),        -- 56
  ROW('có thể làm theo nhịp riêng', 0.95),             -- 57
  ROW('chỉ cần đủ cho hôm nay', 1.0),                  -- 58
  ROW('mỗi ngày có thể khác nhau', 0.95),              -- 59
  ROW('không cần ép mình phải ổn', 1.0),               -- 60

  ROW('có thể quay lại khi thấy sẵn sàng hơn', 0.95),  -- 61
  ROW('chăm sóc cũng có lúc khó', 0.95),               -- 62
  ROW('không sao nếu cần thêm thời gian', 1.0),       -- 63
  ROW('mọi bước đều đáng ghi nhận', 0.95),             -- 64
  ROW('có thể đi từng ngày một', 1.0),                 -- 65
  ROW('không cần vội vàng', 1.0),                      -- 66
  ROW('có thể chọn lại bất cứ lúc nào', 0.95),        -- 67
  ROW('chăm sóc bản thân không có đúng sai', 1.0),    -- 68
  ROW('chỉ cần phù hợp với hiện tại', 0.95),           -- 69
  ROW('luôn có thể điều chỉnh lại', 1.0),

  ROW('you can take this one step at a time', 1.0),        -- 1
  ROW('you do not have to do everything at once', 1.0),   -- 2
  ROW('starting small is okay', 1.0),                     -- 3
  ROW('it is okay to rest if it feels hard', 1.0),        -- 4
  ROW('you do not need to be perfect', 1.0),              -- 5
  ROW('doing a little is still enough', 1.0),             -- 6
  ROW('you can slow down if needed', 0.95),               -- 7
  ROW('it is okay if not everything gets done today', 1.0), -- 8
  ROW('you can choose the easiest thing first', 0.95),   -- 9
  ROW('you do not need to push yourself', 1.0),           -- 10

  ROW('you can adjust the plan if it feels off', 0.95),   -- 11
  ROW('it is okay to change things', 1.0),                -- 12
  ROW('plans are meant to support you', 1.0),             -- 13
  ROW('this does not have to feel strict', 0.95),         -- 14
  ROW('you can make it more gentle', 0.95),               -- 15
  ROW('you do not have to follow it exactly', 0.9),       -- 16
  ROW('flexibility is allowed', 0.95),                    -- 17
  ROW('you can revisit it later', 0.95),                  -- 18
  ROW('it is okay if this takes time', 1.0),              -- 19
  ROW('you are allowed to try again', 1.0),               -- 20

  ROW('you can listen to what your body needs', 0.9),    -- 21
  ROW('rest can come first', 0.95),                       -- 22
  ROW('self-care can be very simple', 1.0),               -- 23
  ROW('even small care matters', 1.0),                    -- 24
  ROW('you do not need to do something big', 1.0),        -- 25
  ROW('focus on what feels manageable', 0.95),            -- 26
  ROW('you are not required to compare yourself', 1.0),  -- 27
  ROW('everyone has their own pace', 0.95),               -- 28
  ROW('what you can do right now is enough', 1.0),        -- 29
  ROW('there is no rush', 1.0),                            -- 30

  ROW('you can pause if it feels overwhelming', 1.0),    -- 31
  ROW('it is okay to come back to this later', 0.95),     -- 32
  ROW('you do not need to feel better immediately', 1.0), -- 33
  ROW('self-care is a process', 0.95),                    -- 34
  ROW('every step counts', 0.95),                          -- 35
  ROW('doing something small still matters', 1.0),       -- 36
  ROW('you can take breaks when needed', 1.0),           -- 37
  ROW('you do not need to blame yourself', 1.0),         -- 38
  ROW('you can be gentle with yourself', 1.0),           -- 39
  ROW('self-care is not a task to complete', 1.0),       -- 40

  ROW('you can check what feels supportive right now', 0.9), -- 41
  ROW('you can remove anything that feels heavy', 0.95), -- 42
  ROW('you do not need to keep what is not helping', 0.95), -- 43
  ROW('choose what helps you breathe easier', 0.95),     -- 44
  ROW('focus on the present moment', 0.9),               -- 45
  ROW('trying already matters', 0.95),                   -- 46
  ROW('you do not need to overdo it', 1.0),               -- 47
  ROW('rest is allowed', 1.0),                             -- 48
  ROW('self-care can be gentle', 1.0),                   -- 49
  ROW('you do not need to push through', 1.0),           -- 50

  ROW('you can ask yourself what feels safest', 0.9),    -- 51
  ROW('it is okay to prioritize safety', 0.95),          -- 52
  ROW('this is meant to support you', 1.0),              -- 53
  ROW('you do not need to prove anything', 1.0),         -- 54
  ROW('all feelings are allowed', 0.95),                 -- 55
  ROW('you can stop if it feels too much', 1.0),         -- 56
  ROW('you can move at your own pace', 0.95),            -- 57
  ROW('today can be enough', 1.0),                        -- 58
  ROW('each day can look different', 0.95),              -- 59
  ROW('you do not need to force yourself to be okay', 1.0), -- 60

  ROW('you can come back when you feel ready', 0.95),    -- 61
  ROW('self-care can be difficult sometimes', 0.95),    -- 62
  ROW('it is okay to need more time', 1.0),              -- 63
  ROW('every effort deserves credit', 0.95),             -- 64
  ROW('you can take this day by day', 1.0),              -- 65
  ROW('there is no right or wrong way', 1.0),            -- 66
  ROW('you can change things anytime', 0.95),            -- 67
  ROW('self-care should fit your current state', 0.95), -- 68
  ROW('you are allowed to adjust', 1.0),                 -- 69
  ROW('this can always be flexible', 1.0)  
  
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
  ROW('chia sẻ với bạn bè', 0.8),
  ROW('muốn nhắn tin cho bạn', 1.0),            -- 1
  ROW('muốn nói chuyện với bạn', 1.0),          -- 2
  ROW('muốn tâm sự với bạn', 1.0),               -- 3
  ROW('cần người để nói chuyện', 0.95),          -- 4
  ROW('muốn có ai đó lắng nghe', 0.95),          -- 5
  ROW('muốn nhờ bạn bè giúp', 0.95),              -- 6
  ROW('muốn chia sẻ với bạn thân', 0.95),        -- 7
  ROW('có nên nhắn cho bạn không', 0.95),         -- 8
  ROW('ngại nhắn tin cho bạn', 0.9),              -- 9
  ROW('không biết có nên nói với bạn', 0.9),     -- 10
  ROW('muốn kể cho bạn nghe', 0.9),               -- 11
  ROW('cần bạn ở bên', 0.9),                      -- 12
  ROW('muốn nói ra với ai đó', 0.9),              -- 13
  ROW('muốn tâm sự với người quen', 0.9),         -- 14
  ROW('cảm thấy cần bạn bè', 0.9),                -- 15
  ROW('muốn nhắn tin cho ai đó', 0.9),             -- 16
  ROW('muốn gọi cho bạn', 0.9),                   -- 17
  ROW('có bạn để nói chuyện thì tốt', 0.9),       -- 18
  ROW('muốn tìm người nói chuyện', 0.9),          -- 19
  ROW('không muốn ở một mình', 0.85),              -- 20
  ROW('cần người để tâm sự', 0.85),                -- 21
  ROW('muốn nói chuyện với người hiểu mình', 0.85),-- 22
  ROW('muốn chia sẻ cảm xúc với bạn', 0.85),      -- 23
  ROW('có ai đó để nhắn tin', 0.85),               -- 24
  ROW('muốn được bạn lắng nghe', 0.85),           -- 25
  ROW('muốn nói chuyện với bạn thân nhất', 0.85),-- 26
  ROW('muốn tâm sự chuyện này với bạn', 0.85),    -- 27
  ROW('đang phân vân có nên nhắn cho bạn', 0.85), -- 28
  ROW('muốn nói cho bạn biết', 0.85),              -- 29
  ROW('cảm thấy cần nói chuyện với ai đó', 0.85),-- 30
  ROW('muốn tìm bạn để nói chuyện', 0.85),        -- 31
  ROW('cần người quen để chia sẻ', 0.8),           -- 32
  ROW('muốn liên lạc với bạn bè', 0.8),            -- 33
  ROW('muốn mở lời với bạn', 0.8),                 -- 34
  ROW('không biết nhắn cho bạn thế nào', 0.8),    -- 35
  ROW('muốn nói ra cho nhẹ lòng với bạn', 0.8),   -- 36
  ROW('muốn có người quen để nói chuyện', 0.8),   -- 37
  ROW('cần một người bạn để tâm sự', 0.8),         -- 38
  ROW('muốn kể chuyện cho bạn nghe', 0.8),         -- 39
  ROW('có nên tâm sự với bạn không', 0.8),         -- 40
  ROW('muốn nhắn cho bạn thân', 0.8),              -- 41
  ROW('muốn nói chuyện với bạn cho đỡ buồn', 0.8),-- 42
  ROW('muốn được bạn bè an ủi', 0.8),              -- 43
  ROW('muốn bạn bè hiểu mình', 0.8),               -- 44
  ROW('cảm thấy cần sự hiện diện của bạn', 0.8),  -- 45
  ROW('muốn nhờ bạn lắng nghe', 0.8),              -- 46
  ROW('muốn chia sẻ chuyện này với ai đó', 0.8),  -- 47
  ROW('muốn nói chuyện với người thân quen', 0.8),-- 48
  ROW('cần bạn để nói ra cảm xúc', 0.8),           -- 49
  ROW('muốn tâm sự với bạn cho nhẹ lòng', 0.8),   -- 50
  ROW('muốn có bạn bên cạnh lúc này', 0.8),       -- 51
  ROW('muốn nhắn tin hỏi thăm bạn', 0.75),         -- 52
  ROW('muốn nói chuyện cho bớt nặng đầu', 0.75),  -- 53
  ROW('muốn có ai đó quen để chia sẻ', 0.75),     -- 54
  ROW('muốn tìm bạn để tâm sự', 0.75),             -- 55
  ROW('muốn nhắn vài dòng cho bạn', 0.75),         -- 56
  ROW('muốn nói chuyện với bạn cho đỡ căng', 0.75),-- 57
  ROW('cần một người quen để nói chuyện', 0.75),  -- 58
  ROW('muốn nói cho bạn nghe cho nhẹ lòng', 0.75),-- 59
  ROW('muốn có bạn để chia sẻ cảm xúc', 0.75),    -- 60
  ROW('muốn nhắn cho bạn lúc này', 0.75),          -- 61
  ROW('muốn nói chuyện với bạn cho dễ chịu hơn', 0.75), -- 62
  ROW('muốn chia sẻ với bạn cho đỡ mệt', 0.75),   -- 63
  ROW('muốn có người quen để nói ra', 0.75),      -- 64
  ROW('muốn nhắn tin cho bạn để tâm sự', 0.75),   -- 65
  ROW('muốn nói chuyện với bạn để nhẹ đầu', 0.75),-- 66
  ROW('muốn bạn bè nghe mình nói', 0.75),         -- 67
  ROW('muốn nói chuyện với ai đó mình tin', 0.75),-- 68
  ROW('muốn liên lạc với bạn thân', 0.75),        -- 69
  ROW('muốn nhắn cho một người bạn', 0.75),

  ROW('want to text a friend', 1.0),               -- 1
  ROW('want to message a friend', 1.0),            -- 2
  ROW('want to talk to a friend', 1.0),             -- 3
  ROW('need someone to talk to', 0.95),             -- 4
  ROW('want someone to listen', 0.95),              -- 5
  ROW('thinking of texting a friend', 0.95),        -- 6
  ROW('want to reach out to a friend', 0.95),       -- 7
  ROW('want to share with a friend', 0.95),         -- 8
  ROW('not sure if I should text a friend', 0.9),   -- 9
  ROW('hesitant to message a friend', 0.9),         -- 10
  ROW('want to talk to someone I trust', 0.9),      -- 11
  ROW('need a friend right now', 0.9),              -- 12
  ROW('want to open up to a friend', 0.9),          -- 13
  ROW('want to tell a friend about this', 0.9),    -- 14
  ROW('want to vent to a friend', 0.9),              -- 15
  ROW('thinking about calling a friend', 0.9),     -- 16
  ROW('want to chat with a friend', 0.9),           -- 17
  ROW('need a familiar person to talk to', 0.9),   -- 18
  ROW('want to talk to someone close', 0.9),        -- 19
  ROW('don’t want to be alone right now', 0.85),   -- 20
  ROW('need someone I know', 0.85),                  -- 21
  ROW('want a friend to listen', 0.85),             -- 22
  ROW('want to share my feelings with a friend', 0.85), -- 23
  ROW('want someone I trust to hear me', 0.85),    -- 24
  ROW('want to message my best friend', 0.85),     -- 25
  ROW('want to talk to a close friend', 0.85),      -- 26
  ROW('thinking of reaching out to someone', 0.85),-- 27
  ROW('want to talk things out with a friend', 0.85), -- 28
  ROW('want to tell someone I know', 0.85),         -- 29
  ROW('need to talk to someone familiar', 0.85),   -- 30
  ROW('want a friend to be there', 0.85),           -- 31
  ROW('need peer support', 0.8),                     -- 32
  ROW('want to connect with a friend', 0.8),        -- 33
  ROW('want to message someone close', 0.8),        -- 34
  ROW('want to talk to someone who understands', 0.8), -- 35
  ROW('need a friendly ear', 0.8),                   -- 36
  ROW('want to share what’s going on with a friend', 0.8), -- 37
  ROW('want to text someone I trust', 0.8),         -- 38
  ROW('want a friend’s comfort', 0.8),               -- 39
  ROW('want to reach out to someone I know', 0.8),  -- 40
  ROW('want to talk to a peer', 0.8),                 -- 41
  ROW('need someone familiar to talk to', 0.8),     -- 42
  ROW('want to message a close person', 0.8),       -- 43
  ROW('want to talk to someone for support', 0.8),  -- 44
  ROW('need a trusted friend', 0.8),                 -- 45
  ROW('want to talk things through with a friend', 0.8), -- 46
  ROW('want to tell a friend how I feel', 0.8),     -- 47
  ROW('want to chat with someone I know', 0.8),     -- 48
  ROW('want to message a friend for support', 0.8),-- 49
  ROW('need a friend to listen', 0.8),               -- 50
  ROW('want to talk to someone I feel safe with', 0.8), -- 51
  ROW('want to text a friend right now', 0.75),     -- 52
  ROW('want to talk to someone close to me', 0.75), -- 53
  ROW('need someone familiar right now', 0.75),    -- 54
  ROW('want to share this with a friend', 0.75),    -- 55
  ROW('want to reach out to my friend', 0.75),      -- 56
  ROW('want to talk to a friend to feel better', 0.75), -- 57
  ROW('need a friend’s presence', 0.75),            -- 58
  ROW('want to message someone I care about', 0.75),-- 59
  ROW('want to talk to someone for comfort', 0.75), -- 60
  ROW('want to share my thoughts with a friend', 0.75), -- 61
  ROW('need to talk to a friend for support', 0.75),-- 62
  ROW('want to reach out for peer support', 0.75),  -- 63
  ROW('want to message a friend to talk', 0.75),    -- 64
  ROW('want to talk to someone I know well', 0.75), -- 65
  ROW('want a friend to hear me out', 0.75),        -- 66
  ROW('want to connect with someone familiar', 0.75), -- 67
  ROW('need to talk to someone close', 0.75),       -- 68
  ROW('want to message a trusted friend', 0.75),   -- 69
  ROW('want to talk to a friend for reassurance', 0.75)
  
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy được an ủi', 1.0),
  ROW('nhẹ nhõm hơn', 0.9),
  ROW('cảm thấy nhẹ lòng hơn', 1.0),              -- 1
  ROW('đỡ cô đơn hơn rồi', 1.0),                  -- 2
  ROW('có người lắng nghe thấy dễ chịu hơn', 1.0),-- 3
  ROW('nói ra thấy nhẹ hơn', 0.95),               -- 4
  ROW('tâm trạng đỡ hơn sau khi nói chuyện', 0.95),-- 5
  ROW('được an ủi nên thấy ổn hơn', 0.95),        -- 6
  ROW('có người hiểu nên thấy đỡ mệt', 0.95),    -- 7
  ROW('nói chuyện xong thấy dễ thở hơn', 0.95),  -- 8
  ROW('cảm thấy được quan tâm', 0.95),            -- 9
  ROW('có người ở bên nên thấy ổn hơn', 0.95),   -- 10
  ROW('chia sẻ xong thấy nhẹ đầu', 0.9),          -- 11
  ROW('không còn cảm giác một mình nữa', 0.9),   -- 12
  ROW('được lắng nghe nên thấy đỡ căng', 0.9),   -- 13
  ROW('nói chuyện xong thấy bớt nặng nề', 0.9),  -- 14
  ROW('cảm thấy có chỗ dựa tinh thần', 0.9),     -- 15
  ROW('đỡ buồn hơn sau khi nói chuyện', 0.9),    -- 16
  ROW('cảm xúc dịu lại một chút', 0.9),           -- 17
  ROW('có người nghe nên thấy an tâm hơn', 0.9), -- 18
  ROW('không còn bị dồn nén như trước', 0.9),    -- 19
  ROW('nói ra được nên thấy nhẹ lòng', 0.9),     -- 20
  ROW('cảm thấy được chia sẻ', 0.85),             -- 21
  ROW('tâm trạng bớt tệ hơn', 0.85),              -- 22
  ROW('đỡ áp lực hơn sau khi nhắn tin', 0.85),   -- 23
  ROW('cảm thấy có người đồng hành', 0.85),      -- 24
  ROW('không còn thấy quá cô độc', 0.85),        -- 25
  ROW('được động viên nên thấy ổn hơn', 0.85),   -- 26
  ROW('có người hiểu nên thấy dễ chịu', 0.85),   -- 27
  ROW('nói chuyện giúp cảm xúc dịu lại', 0.85),  -- 28
  ROW('tâm trạng ổn hơn một chút', 0.85),         -- 29
  ROW('có người quan tâm nên thấy đỡ mệt', 0.85),-- 30
  ROW('không còn quá nặng lòng nữa', 0.8),       -- 31
  ROW('đỡ căng thẳng hơn sau khi nói chuyện', 0.8),-- 32
  ROW('cảm thấy được thấu hiểu', 0.8),            -- 33
  ROW('có người nghe nên thấy nhẹ hơn', 0.8),    -- 34
  ROW('tâm trạng bớt rối hơn', 0.8),              -- 35
  ROW('cảm xúc không còn quá dồn dập', 0.8),     -- 36
  ROW('nói ra giúp dễ chịu hơn', 0.8),            -- 37
  ROW('đỡ lo hơn khi có người nói chuyện', 0.8), -- 38
  ROW('cảm thấy bớt trống trải', 0.8),            -- 39
  ROW('có người bên cạnh nên thấy ổn', 0.8),     -- 40
  ROW('cảm xúc được giải tỏa phần nào', 0.75),   -- 41
  ROW('tâm trạng bớt nặng nề', 0.75),             -- 42
  ROW('đỡ suy nghĩ tiêu cực hơn', 0.75),          -- 43
  ROW('có người nghe nên không còn quá mệt', 0.75),-- 44
  ROW('nói chuyện giúp bớt buồn', 0.75),          -- 45
  ROW('cảm thấy nhẹ hơn trong lòng', 0.75),       -- 46
  ROW('có người chia sẻ nên đỡ áp lực', 0.75),   -- 47
  ROW('tâm trạng đỡ hơn so với trước', 0.75),    -- 48
  ROW('không còn cảm giác bị bỏ rơi', 0.75),     -- 49
  ROW('có người quan tâm nên thấy yên tâm', 0.75),-- 50
  ROW('cảm xúc dịu xuống', 0.75),                 -- 51
  ROW('nói ra giúp đầu óc nhẹ hơn', 0.75),        -- 52
  ROW('đỡ cảm thấy lạc lõng', 0.75),              -- 53
  ROW('tâm trạng ổn định hơn một chút', 0.75),   -- 54
  ROW('có người lắng nghe nên dễ chịu hơn', 0.75),-- 55
  ROW('đỡ bị đè nặng cảm xúc', 0.75),             -- 56
  ROW('nói chuyện xong thấy bình tĩnh hơn', 0.75),-- 57
  ROW('cảm thấy được kết nối', 0.75),             -- 58
  ROW('có người hiểu nên thấy đỡ tủi', 0.75),    -- 59
  ROW('tâm trạng bớt uể oải', 0.75),              -- 60
  ROW('cảm xúc bớt tiêu cực', 0.75),              -- 61
  ROW('nói chuyện giúp dễ cân bằng hơn', 0.75),  -- 62
  ROW('đỡ cảm thấy nặng nề trong lòng', 0.75),   -- 63
  ROW('có người bên cạnh nên thấy an toàn hơn', 0.75),-- 64
  ROW('tâm trạng không còn quá tệ', 0.75),       -- 65
  ROW('đỡ thấy cô lập', 0.75),                    -- 66
  ROW('nói ra giúp giải tỏa cảm xúc', 0.75),     -- 67
  ROW('cảm thấy được nâng đỡ tinh thần', 0.75),  -- 68
  ROW('đỡ cảm thấy một mình', 0.75),              -- 69
  ROW('tâm trạng nhẹ nhàng hơn', 0.75),

  ROW('feel less alone', 1.0),                    -- 1
  ROW('feel lighter after talking', 1.0),        -- 2
  ROW('feel better after sharing', 1.0),         -- 3
  ROW('feel heard and understood', 0.95),        -- 4
  ROW('feel more supported', 0.95),              -- 5
  ROW('feel calmer after talking', 0.95),        -- 6
  ROW('feel relieved after messaging', 0.95),   -- 7
  ROW('feel comforted', 0.95),                    -- 8
  ROW('feel less lonely now', 0.95),              -- 9
  ROW('feel someone is there', 0.95),             -- 10
  ROW('feel lighter emotionally', 0.9),           -- 11
  ROW('feel less overwhelmed', 0.9),              -- 12
  ROW('feel understood by someone', 0.9),        -- 13
  ROW('feel supported by a friend', 0.9),        -- 14
  ROW('feel calmer than before', 0.9),            -- 15
  ROW('feel less heavy inside', 0.9),             -- 16
  ROW('feel reassured', 0.9),                     -- 17
  ROW('feel emotionally safer', 0.9),             -- 18
  ROW('feel less isolated', 0.9),                 -- 19
  ROW('feel better than earlier', 0.9),           -- 20
  ROW('feel emotionally relieved', 0.85),        -- 21
  ROW('feel less stressed after talking', 0.85), -- 22
  ROW('feel cared about', 0.85),                  -- 23
  ROW('feel emotionally supported', 0.85),       -- 24
  ROW('feel less tense', 0.85),                   -- 25
  ROW('feel comfort after sharing', 0.85),       -- 26
  ROW('feel more at ease', 0.85),                 -- 27
  ROW('feel less burdened', 0.85),                -- 28
  ROW('feel someone understands', 0.85),         -- 29
  ROW('feel emotionally steadier', 0.85),        -- 30
  ROW('feel less pressured', 0.8),                -- 31
  ROW('feel calmer inside', 0.8),                 -- 32
  ROW('feel emotionally lighter', 0.8),          -- 33
  ROW('feel more connected', 0.8),                -- 34
  ROW('feel less distressed', 0.8),               -- 35
  ROW('feel supported emotionally', 0.8),        -- 36
  ROW('feel less overwhelmed now', 0.8),         -- 37
  ROW('feel heard by someone', 0.8),              -- 38
  ROW('feel more comforted', 0.8),                -- 39
  ROW('feel less weighed down', 0.8),             -- 40
  ROW('feel emotions easing', 0.75),              -- 41
  ROW('feel a bit more okay', 0.75),               -- 42
  ROW('feel less emotionally tense', 0.75),      -- 43
  ROW('feel somewhat relieved', 0.75),            -- 44
  ROW('feel supported enough', 0.75),             -- 45
  ROW('feel less mentally heavy', 0.75),          -- 46
  ROW('feel emotionally soothed', 0.75),          -- 47
  ROW('feel calmer after sharing', 0.75),         -- 48
  ROW('feel less alone inside', 0.75),            -- 49
  ROW('feel emotionally lighter than before', 0.75), -- 50
  ROW('feel less negative', 0.75),                -- 51
  ROW('feel emotionally balanced', 0.75),        -- 52
  ROW('feel less inner pressure', 0.75),          -- 53
  ROW('feel some emotional release', 0.75),       -- 54
  ROW('feel emotionally steadier now', 0.75),    -- 55
  ROW('feel supported enough to cope', 0.75),    -- 56
  ROW('feel calmer overall', 0.75),               -- 57
  ROW('feel less mentally tense', 0.75),          -- 58
  ROW('feel emotionally reassured', 0.75),       -- 59
  ROW('feel more okay than before', 0.75),       -- 60
  ROW('feel less emotional strain', 0.75),       -- 61
  ROW('feel comforted by the conversation', 0.75),-- 62
  ROW('feel emotionally supported now', 0.75),   -- 63
  ROW('feel less inner tension', 0.75),           -- 64
  ROW('feel more emotionally settled', 0.75),    -- 65
  ROW('feel less emotional weight', 0.75),       -- 66
  ROW('feel calmer mentally', 0.75),              -- 67
  ROW('feel emotionally okay', 0.75),             -- 68
  ROW('feel less emotionally burdened', 0.75),   -- 69
  ROW('feel more emotionally at ease', 0.75)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không muốn chia sẻ', 0.9),
  ROW('vẫn thấy cô đơn', 1.0),                       -- 1
  ROW('nhắn xong mà vẫn buồn', 1.0),                 -- 2
  ROW('nói chuyện nhưng không khá hơn', 1.0),       -- 3
  ROW('vẫn thấy trống rỗng', 0.95),                  -- 4
  ROW('không thấy nhẹ hơn', 0.95),                   -- 5
  ROW('cảm xúc không thay đổi', 0.95),               -- 6
  ROW('nói ra mà vẫn nặng lòng', 0.95),              -- 7
  ROW('vẫn thấy mệt', 0.95),                         -- 8
  ROW('không cảm thấy được an ủi', 1.0),             -- 9
  ROW('vẫn thấy một mình', 1.0),                     -- 10
  ROW('nhắn tin mà không thấy ổn hơn', 0.95),        -- 11
  ROW('nói chuyện nhưng vẫn rối', 0.95),             -- 12
  ROW('vẫn thấy bị bỏ mặc', 1.0),                    -- 13
  ROW('không cảm thấy được hiểu', 1.0),              -- 14
  ROW('cảm giác vẫn nặng nề', 0.95),                 -- 15
  ROW('nói chuyện mà không đỡ', 0.95),               -- 16
  ROW('vẫn thấy lạc lõng', 1.0),                     -- 17
  ROW('không thấy ai thật sự nghe', 1.0),            -- 18
  ROW('vẫn thấy áp lực', 0.95),                      -- 19
  ROW('nhắn xong mà vẫn căng thẳng', 0.95),          -- 20
  ROW('không cảm thấy được kết nối', 1.0),           -- 21
  ROW('vẫn thấy xa cách', 0.95),                     -- 22
  ROW('nói chuyện nhưng vẫn khó chịu', 0.95),        -- 23
  ROW('không cảm thấy an tâm', 1.0),                 -- 24
  ROW('vẫn thấy nặng đầu', 0.95),                    -- 25
  ROW('chia sẻ nhưng không nhẹ hơn', 0.95),          -- 26
  ROW('vẫn thấy buồn nhiều', 1.0),                   -- 27
  ROW('không cảm thấy được quan tâm', 1.0),          -- 28
  ROW('nhắn tin mà không thấy khác gì', 0.95),       -- 29
  ROW('vẫn thấy mệt mỏi', 0.95),                     -- 30
  ROW('nói ra nhưng không giải tỏa', 1.0),           -- 31
  ROW('vẫn thấy bị cô lập', 1.0),                    -- 32
  ROW('không thấy dễ chịu hơn', 0.95),               -- 33
  ROW('vẫn thấy nặng cảm xúc', 0.95),                -- 34
  ROW('nói chuyện mà vẫn bế tắc', 1.0),              -- 35
  ROW('không cảm thấy được nâng đỡ', 1.0),           -- 36
  ROW('vẫn thấy tủi thân', 1.0),                     -- 37
  ROW('nhắn tin nhưng vẫn rỗng', 0.95),              -- 38
  ROW('không cảm thấy được lắng nghe', 1.0),         -- 39
  ROW('vẫn thấy nặng lòng hơn mong đợi', 0.95),      -- 40
  ROW('nói chuyện mà vẫn áp lực', 0.95),             -- 41
  ROW('không thấy được chia sẻ thật sự', 1.0),       -- 42
  ROW('vẫn thấy tâm trạng tệ', 1.0),                 -- 43
  ROW('nhắn xong mà vẫn lo', 0.95),                  -- 44
  ROW('không cảm thấy đỡ cô đơn', 1.0),              -- 45
  ROW('vẫn thấy cảm xúc bị dồn lại', 0.95),          -- 46
  ROW('nói ra nhưng vẫn nặng', 0.95),                -- 47
  ROW('không thấy được đồng cảm', 1.0),              -- 48
  ROW('vẫn thấy khó chịu trong lòng', 0.95),         -- 49
  ROW('nhắn tin mà không thấy an ủi', 1.0),          -- 50
  ROW('vẫn thấy mọi thứ y như cũ', 0.95),            -- 51
  ROW('không cảm thấy khá hơn chút nào', 1.0),       -- 52
  ROW('vẫn thấy thiếu sự kết nối', 1.0),             -- 53
  ROW('nói chuyện mà vẫn thấy trống', 0.95),         -- 54
  ROW('không thấy nhẹ nhõm', 1.0),                   -- 55
  ROW('vẫn thấy tâm trạng nặng nề', 0.95),           -- 56
  ROW('nhắn tin nhưng không giúp gì', 1.0),          -- 57
  ROW('không cảm thấy bớt buồn', 1.0),               -- 58
  ROW('vẫn thấy bị bỏ rơi', 1.0),                    -- 59
  ROW('nói chuyện mà không đỡ mệt', 0.95),           -- 60
  ROW('không cảm thấy được quan tâm đủ', 1.0),       -- 61
  ROW('vẫn thấy cô độc', 1.0),                       -- 62
  ROW('nhắn tin mà vẫn thấy xa lạ', 0.95),           -- 63
  ROW('không thấy được an ủi nhiều', 0.95),          -- 64
  ROW('vẫn thấy nặng trong lòng', 0.95),             -- 65
  ROW('nói chuyện nhưng không giúp ổn hơn', 1.0),   -- 66
  ROW('không cảm thấy có người ở bên', 1.0),         -- 67
  ROW('vẫn thấy mệt về cảm xúc', 0.95),              -- 68
  ROW('nhắn xong mà vẫn không ổn', 1.0),             -- 69
  ROW('vẫn thấy một mình dù đã nhắn', 1.0), 

  ROW('still feel alone', 1.0),                      -- 1
  ROW('still feel lonely', 1.0),                     -- 2
  ROW('do not feel better', 1.0),                    -- 3
  ROW('feel the same as before', 0.95),              -- 4
  ROW('feel no relief', 1.0),                        -- 5
  ROW('still feel heavy inside', 0.95),              -- 6
  ROW('still feel emotionally stuck', 1.0),          -- 7
  ROW('do not feel comforted', 1.0),                 -- 8
  ROW('feel unheard', 1.0),                          -- 9
  ROW('still feel isolated', 1.0),                   -- 10
  ROW('talking did not help', 1.0),                  -- 11
  ROW('messaging did not help', 1.0),                -- 12
  ROW('still feel overwhelmed', 1.0),                -- 13
  ROW('do not feel supported', 1.0),                 -- 14
  ROW('feel disconnected', 0.95),                    -- 15
  ROW('still feel empty', 0.95),                     -- 16
  ROW('feel emotionally distant', 0.95),             -- 17
  ROW('still feel tense', 0.95),                     -- 18
  ROW('do not feel understood', 1.0),                -- 19
  ROW('still feel pressured', 0.95),                 -- 20
  ROW('feel no emotional relief', 1.0),              -- 21
  ROW('still feel weighed down', 0.95),              -- 22
  ROW('talking changed nothing', 1.0),               -- 23
  ROW('still feel uneasy', 0.95),                    -- 24
  ROW('do not feel reassured', 1.0),                 -- 25
  ROW('feel emotionally unsupported', 1.0),         -- 26
  ROW('still feel mentally heavy', 0.95),            -- 27
  ROW('feel no connection', 1.0),                    -- 28
  ROW('still feel distressed', 1.0),                 -- 29
  ROW('do not feel calmer', 1.0),                    -- 30
  ROW('feel no comfort from it', 1.0),               -- 31
  ROW('still feel sad', 1.0),                        -- 32
  ROW('feel emotionally ignored', 1.0),              -- 33
  ROW('talking did not ease anything', 1.0),         -- 34
  ROW('still feel burdened', 0.95),                  -- 35
  ROW('do not feel any lighter', 1.0),               -- 36
  ROW('feel emotionally disconnected', 1.0),        -- 37
  ROW('still feel lonely inside', 1.0),              -- 38
  ROW('do not feel cared about', 1.0),               -- 39
  ROW('still feel inner tension', 0.95),             -- 40
  ROW('feel no emotional support', 1.0),             -- 41
  ROW('still feel uncomfortable', 0.95),             -- 42
  ROW('do not feel understood at all', 1.0),         -- 43
  ROW('still feel emotionally heavy', 0.95),         -- 44
  ROW('feel unchanged after talking', 0.95),         -- 45
  ROW('still feel mentally tired', 0.95),            -- 46
  ROW('feel emotionally blocked', 1.0),              -- 47
  ROW('do not feel any relief yet', 1.0),             -- 48
  ROW('still feel unsupported by it', 1.0),          -- 49
  ROW('feel emotionally distant from others', 1.0), -- 50
  ROW('still feel overwhelmed inside', 1.0),         -- 51
  ROW('do not feel soothed', 1.0),                    -- 52
  ROW('feel no emotional ease', 1.0),                 -- 53
  ROW('still feel emotionally strained', 0.95),     -- 54
  ROW('feel no change in mood', 0.95),                -- 55
  ROW('still feel pressure inside', 0.95),           -- 56
  ROW('do not feel less lonely', 1.0),                -- 57
  ROW('still feel emotionally unsettled', 0.95),    -- 58
  ROW('feel no sense of connection', 1.0),           -- 59
  ROW('still feel down', 1.0),                        -- 60
  ROW('do not feel emotionally okay', 1.0),           -- 61
  ROW('still feel alone after messaging', 1.0),      -- 62
  ROW('feel emotionally unsupported still', 1.0),   -- 63
  ROW('still feel weighed emotionally', 0.95),      -- 64
  ROW('do not feel any comfort yet', 1.0),            -- 65
  ROW('still feel emotionally tired', 0.95),        -- 66
  ROW('feel no emotional release', 1.0),             -- 67
  ROW('still feel isolated inside', 1.0),            -- 68
  ROW('do not feel helped by talking', 1.0),          -- 69
  ROW('still feel alone despite reaching out', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='tip_message_friend'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử nhắn thêm không', 1.0),
  ROW('cảm thấy khá hơn chưa', 0.8),
  ROW('có thể thử nhắn cho một người tin cậy không', 1.0),        -- 1
  ROW('muốn nhắn cho ai đó để bớt nặng lòng không', 1.0),        -- 2
  ROW('có người nào khiến thấy an tâm để nói chuyện không', 1.0),-- 3
  ROW('thử chia sẻ với một người quen xem sao nhé', 0.95),      -- 4
  ROW('có thể bắt đầu bằng một tin nhắn ngắn', 0.95),           -- 5
  ROW('không cần nói hết, chỉ cần nói một chút cũng được', 0.95),-- 6
  ROW('có thể nhắn rằng đang không ổn lắm', 0.95),               -- 7
  ROW('chỉ cần nói rằng cần người nghe', 0.95),                 -- 8
  ROW('không cần giải thích quá nhiều đâu', 0.9),               -- 9
  ROW('có thể thử nhắn một câu đơn giản', 0.9),                 -- 10
  ROW('muốn thử nói chuyện với bạn bè không', 0.9),             -- 11
  ROW('có thể chọn người dễ nói chuyện nhất', 0.9),            -- 12
  ROW('không nhất thiết phải là bạn thân', 0.9),                -- 13
  ROW('chỉ cần một người chịu nghe là đủ', 0.9),                -- 14
  ROW('có thể nhắn cho người từng khiến thấy thoải mái', 0.9),  -- 15
  ROW('không cần phải nhắn ngay nếu chưa sẵn sàng', 0.9),       -- 16
  ROW('có thể để dành khi cảm thấy phù hợp hơn', 0.9),          -- 17
  ROW('nói chuyện với ai đó có thể giúp nhẹ hơn', 0.9),         -- 18
  ROW('được nghe và được hiểu cũng quan trọng lắm', 0.9),       -- 19
  ROW('không phải lúc nào cũng cần tự chịu một mình', 0.9),    -- 20
  ROW('có thể bắt đầu bằng việc hỏi thăm', 0.85),               -- 21
  ROW('một tin nhắn nhỏ cũng có thể tạo khác biệt', 0.85),      -- 22
  ROW('có thể chỉ nói là đang cần nói chuyện', 0.85),           -- 23
  ROW('không cần phải có câu trả lời đúng', 0.85),              -- 24
  ROW('chỉ cần được lắng nghe là đủ rồi', 0.85),                -- 25
  ROW('có thể thử chia sẻ từng chút một', 0.85),                -- 26
  ROW('nói ra có thể giúp cảm xúc dịu hơn', 0.85),              -- 27
  ROW('không cần ép bản thân phải nói hết', 0.85),              -- 28
  ROW('có thể dừng lại bất cứ lúc nào', 0.85),                  -- 29
  ROW('chọn cách khiến thấy thoải mái nhất', 0.85),             -- 30
  ROW('nếu không phải bây giờ thì cũng không sao', 0.85),       -- 31
  ROW('mọi người đều cần được lắng nghe đôi lúc', 0.85),        -- 32
  ROW('việc tìm người nói chuyện là điều bình thường', 0.85),  -- 33
  ROW('không cần phải mạnh mẽ một mình', 0.85),                 -- 34
  ROW('có thể thử nhắn cho người hay quan tâm', 0.85),          -- 35
  ROW('chỉ cần một cuộc trò chuyện nhẹ nhàng', 0.8),            -- 36
  ROW('có thể nói rằng đang hơi mệt', 0.8),                     -- 37
  ROW('không cần giải thích chi tiết', 0.8),                    -- 38
  ROW('nói chuyện không phải là làm phiền', 0.8),               -- 39
  ROW('việc nhờ người khác lắng nghe là ổn', 0.8),              -- 40
  ROW('có thể thử nhắn khi cảm thấy sẵn sàng', 0.8),            -- 41
  ROW('chỉ cần nói thật cảm xúc hiện tại', 0.8),                -- 42
  ROW('không cần phải tỏ ra ổn', 0.8),                           -- 43
  ROW('có thể bắt đầu bằng câu rất đơn giản', 0.8),             -- 44
  ROW('nói chuyện cũng là một cách chăm sóc bản thân', 0.8),   -- 45
  ROW('chia sẻ có thể giúp giảm áp lực', 0.8),                  -- 46
  ROW('không cần phải đối mặt một mình', 0.8),                  -- 47
  ROW('có thể chọn người khiến thấy an toàn', 0.8),             -- 48
  ROW('việc tìm sự hỗ trợ là điều tích cực', 0.8),              -- 49
  ROW('có thể nhắn một câu ngắn trước', 0.8),                   -- 50
  ROW('mọi cảm xúc đều đáng được lắng nghe', 0.8),              -- 51
  ROW('không sao nếu chưa biết nói gì', 0.8),                   -- 52
  ROW('chỉ cần bắt đầu là được', 0.8),                           -- 53
  ROW('có thể thử nhắn cho người thân', 0.8),                   -- 54
  ROW('nói chuyện không có đúng sai', 0.8),                     -- 55
  ROW('chia sẻ không làm bản thân yếu đi', 0.8),                -- 56
  ROW('có thể dừng nếu thấy không ổn', 0.8),                    -- 57
  ROW('nói chuyện là một lựa chọn, không bắt buộc', 0.8),      -- 58
  ROW('chỉ cần làm theo nhịp của mình', 0.8),                   -- 59
  ROW('mọi người đều cần kết nối', 0.8),                         -- 60
  ROW('có thể thử một cách nhẹ nhàng', 0.8),                    -- 61
  ROW('nói chuyện có thể giúp không còn thấy một mình', 0.8),  -- 62
  ROW('không sao nếu cần thời gian', 0.8),                      -- 63
  ROW('việc tìm người nghe là điều hợp lý', 0.8),               -- 64
  ROW('có thể chọn cách nói phù hợp nhất', 0.8),                -- 65
  ROW('không cần ép bản thân phải nhanh', 0.8),                 -- 66
  ROW('chia sẻ là một bước nhỏ nhưng quan trọng', 0.8),         -- 67
  ROW('có thể thử khi cảm thấy đủ an tâm', 0.8),                -- 68
  ROW('không cần làm điều này một mình', 0.8),                  -- 69
  ROW('việc tìm người nói chuyện là hoàn toàn ổn', 0.8),

  ROW('maybe try messaging someone you trust', 1.0),            -- 1
  ROW('would it help to talk to a friend', 1.0),                -- 2
  ROW('is there someone safe to reach out to', 1.0),            -- 3
  ROW('you could try sending a short message', 0.95),           -- 4
  ROW('it does not have to be a long message', 0.95),           -- 5
  ROW('you can start with something simple', 0.95),             -- 6
  ROW('you could say you are not feeling great', 0.95),         -- 7
  ROW('it is okay to just ask someone to listen', 0.95),        -- 8
  ROW('you do not need to explain everything', 0.9),            -- 9
  ROW('just one message is enough', 0.9),                        -- 10
  ROW('maybe talking to a friend could help', 0.9),              -- 11
  ROW('you can choose someone you feel comfortable with', 0.9),-- 12
  ROW('it does not have to be your closest friend', 0.9),       -- 13
  ROW('one supportive person can make a difference', 0.9),     -- 14
  ROW('you are not bothering anyone by reaching out', 0.9),    -- 15
  ROW('you do not have to do this alone', 0.9),                  -- 16
  ROW('you can take your time before sending', 0.9),            -- 17
  ROW('reaching out can help you feel less alone', 0.9),        -- 18
  ROW('being heard can be really helpful', 0.9),                -- 19
  ROW('it is okay to ask for support', 0.9),                     -- 20
  ROW('you can start with a small message', 0.85),               -- 21
  ROW('even a short chat can help', 0.85),                       -- 22
  ROW('you can say you just need to talk', 0.85),                -- 23
  ROW('there is no right or wrong way to say it', 0.85),         -- 24
  ROW('you do not need to have answers', 0.85),                  -- 25
  ROW('sharing a little is already enough', 0.85),               -- 26
  ROW('talking can help emotions settle', 0.85),                 -- 27
  ROW('you can stop if it feels too much', 0.85),                -- 28
  ROW('go at your own pace', 0.85),                               -- 29
  ROW('it is okay if now is not the right time', 0.85),          -- 30
  ROW('everyone needs someone to talk to sometimes', 0.85),     -- 31
  ROW('reaching out is a normal thing to do', 0.85),             -- 32
  ROW('you do not have to be strong alone', 0.85),               -- 33
  ROW('you could message someone who usually cares', 0.85),     -- 34
  ROW('a gentle conversation can help', 0.85),                  -- 35
  ROW('you could say you feel tired', 0.8),                      -- 36
  ROW('you do not need to go into details', 0.8),                -- 37
  ROW('talking is not bothering anyone', 0.8),                   -- 38
  ROW('asking someone to listen is okay', 0.8),                  -- 39
  ROW('reach out when you feel ready', 0.8),                     -- 40
  ROW('you can share how you feel honestly', 0.8),               -- 41
  ROW('you do not have to pretend to be okay', 0.8),             -- 42
  ROW('you can start with a very simple sentence', 0.8),        -- 43
  ROW('talking is part of taking care of yourself', 0.8),       -- 44
  ROW('sharing can help reduce pressure', 0.8),                 -- 45
  ROW('you do not need to handle everything alone', 0.8),       -- 46
  ROW('choose someone who feels safe', 0.8),                    -- 47
  ROW('seeking support is a positive step', 0.8),               -- 48
  ROW('you can send a short message first', 0.8),               -- 49
  ROW('your feelings deserve to be heard', 0.8),                -- 50
  ROW('it is okay if you do not know what to say', 0.8),        -- 51
  ROW('starting is what matters', 0.8),                          -- 52
  ROW('you could reach out to a family member', 0.8),           -- 53
  ROW('there is no perfect way to talk', 0.8),                  -- 54
  ROW('sharing does not make you weak', 0.8),                   -- 55
  ROW('you can pause the conversation if needed', 0.8),        -- 56
  ROW('talking is an option not a requirement', 0.8),           -- 57
  ROW('move at a pace that feels right', 0.8),                  -- 58
  ROW('everyone needs connection', 0.8),                        -- 59
  ROW('you can try a gentle approach', 0.8),                    -- 60
  ROW('talking can help you feel less alone', 0.8),             -- 61
  ROW('it is okay to take time', 0.8),                           -- 62
  ROW('seeking someone to listen makes sense', 0.8),            -- 63
  ROW('you can choose how much to share', 0.8),                 -- 64
  ROW('there is no rush', 0.8),                                  -- 65
  ROW('sharing is a small but meaningful step', 0.8),           -- 66
  ROW('reach out when you feel safe enough', 0.8),              -- 67
  ROW('you do not have to do this by yourself', 0.8),           -- 68
  ROW('looking for someone to talk to is okay', 0.8),           -- 69
  ROW('you deserve support too', 0.8)               
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
  ROW('nhờ giúp đỡ', 0.8),
  ROW('cần người nói chuyện', 1.0),          -- -1
  ROW('muốn có người nói chuyện', 1.0),      -- -2
  ROW('không có ai để nói', 1.0),             -- -3
  ROW('không có ai để tâm sự', 1.0),          -- -4
  ROW('muốn được lắng nghe', 1.0),            -- -5
  ROW('cần được lắng nghe', 1.0),             -- -6
  ROW('chẳng ai hiểu', 0.95),                 -- -7
  ROW('không ai hiểu mình', 0.95),            -- -8
  ROW('cảm thấy cô đơn', 0.95),               -- -9
  ROW('cảm giác cô đơn', 0.95),               -- -10

  ROW('ở một mình hoài', 0.9),                -- -11
  ROW('luôn chỉ có một mình', 0.9),           -- -12
  ROW('không có ai bên cạnh', 0.9),           -- -13
  ROW('muốn có người ở bên', 0.9),             -- -14
  ROW('cảm thấy lạc lõng', 0.9),               -- -15
  ROW('không biết nói với ai', 0.95),         -- -16
  ROW('chẳng biết chia sẻ với ai', 0.95),     -- -17
  ROW('muốn tâm sự', 1.0),                    -- -18
  ROW('cần tâm sự', 1.0),                     -- -19
  ROW('muốn được quan tâm', 0.9),              -- -20

  ROW('không có người để dựa', 0.9),           -- -21
  ROW('cần người hiểu mình', 1.0),             -- -22
  ROW('không ai lắng nghe', 0.95),             -- -23
  ROW('muốn có người nghe mình nói', 1.0),    -- -24
  ROW('cảm giác bị bỏ rơi', 0.9),              -- -25
  ROW('cảm thấy bị bỏ quên', 0.9),             -- -26
  ROW('muốn nói chuyện với ai đó', 0.95),     -- -27
  ROW('cần người bên cạnh', 0.95),             -- -28
  ROW('muốn được an ủi', 0.95),                -- -29
  ROW('muốn được chia sẻ cảm xúc', 1.0),      -- -30

  ROW('không có ai ở đây', 0.85),              -- -31
  ROW('cảm thấy không thuộc về đâu', 0.85),   -- -32
  ROW('muốn nhắn cho ai đó', 0.9),             -- -33
  ROW('không biết tìm ai', 0.9),               -- -34
  ROW('cần người nói cùng', 0.9),              -- -35
  ROW('muốn có bạn để nói chuyện', 0.95),     -- -36
  ROW('không có ai hiểu cảm giác này', 0.95), -- -37
  ROW('cần có người nghe mình', 1.0),          -- -38
  ROW('muốn được hiểu', 1.0),                  -- -39
  ROW('cảm thấy một mình quá', 0.95),          -- -40

  ROW('không ai ở bên lúc này', 0.95),         -- -41
  ROW('muốn có ai đó ở cạnh', 0.9),            -- -42
  ROW('thiếu người để nói chuyện', 0.95),     -- -43
  ROW('muốn được ai đó nghe', 1.0),            -- -44
  ROW('cảm thấy trống trải', 0.9),             -- -45
  ROW('không có ai để dựa dẫm', 0.9),          -- -46
  ROW('muốn có người hiểu cảm xúc', 1.0),     -- -47
  ROW('cảm thấy bị tách ra', 0.9),             -- -48
  ROW('muốn được ai đó quan tâm', 0.95),      -- -49
  ROW('cần có người bên mình', 0.95),          -- -50

  ROW('cảm thấy không được nghe', 0.95),      -- -51
  ROW('muốn nói cho ai đó biết', 0.95),       -- -52
  ROW('cần chia sẻ với người khác', 1.0),     -- -53
  ROW('muốn có ai đó lắng nghe', 1.0),        -- -54
  ROW('không có ai để chia sẻ', 1.0),          -- -55
  ROW('cảm giác rất cô đơn', 0.95),            -- -56
  ROW('cần người nói cùng lúc này', 1.0),     -- -57
  ROW('muốn có ai đó bên cạnh', 0.95),        -- -58
  ROW('thiếu sự kết nối', 0.9),                -- -59
  ROW('cảm thấy thiếu người bên cạnh', 0.9), -- -60

  ROW('muốn được nghe và hiểu', 1.0),          -- -61
  ROW('cảm thấy bị cô lập', 0.9),              -- -62
  ROW('không có ai để dựa vào', 0.9),          -- -63
  ROW('muốn có người chia sẻ', 1.0),           -- -64
  ROW('cảm thấy bị tách biệt', 0.9),           -- -65
  ROW('muốn được ai đó ở bên', 0.95),          -- -66
  ROW('cần sự kết nối với người khác', 0.95), -- -67
  ROW('muốn có người nói cùng lúc này', 1.0), -- -68
  ROW('cảm thấy rất một mình', 0.95),          -- -69
  ROW('không có ai để tâm sự lúc này', 1.0),  -- -70

  ROW('cần có người bên cạnh ngay bây giờ', 1.0), -- -71
  ROW('muốn được nói ra với ai đó', 1.0),      -- -72
  ROW('cảm thấy thiếu sự quan tâm', 0.9),     -- -73
  ROW('muốn có ai đó để nói', 1.0),            -- -74
  ROW('không có ai để chia sẻ cảm giác', 1.0),-- -75
  ROW('cần người hiểu mình lúc này', 1.0),    -- -76
  ROW('muốn được ở cạnh ai đó', 0.95),        -- -77
  ROW('cảm thấy không ai nghe', 0.95),         -- -78
  ROW('muốn được ai đó lắng nghe thật sự',1.0),-- -79
  ROW('cảm thấy rất cô độc', 0.95),            -- -80

  ROW('cần người bên cạnh lúc này', 1.0),     -- -81
  ROW('muốn có người hiểu cảm xúc này',1.0),  -- -82
  ROW('cảm thấy thiếu người để nói', 1.0),    -- -83
  ROW('muốn có ai đó để lắng nghe', 1.0),     -- -84
  ROW('không có ai để nói ra', 1.0),

  ROW('need someone to talk to', 1.0),         -- -1
  ROW('want someone to talk to', 1.0),         -- -2
  ROW('no one to talk to', 1.0),                -- -3
  ROW('need someone to listen', 1.0),          -- -4
  ROW('want someone to listen', 1.0),          -- -5
  ROW('feel lonely', 0.95),                    -- -6
  ROW('feels lonely', 0.95),                   -- -7
  ROW('feel so alone', 0.95),                  -- -8
  ROW('feel alone', 0.95),                     -- -9
  ROW('no one understands me', 1.0),           -- -10

  ROW('nobody understands me', 1.0),           -- -11
  ROW('want to share my feelings', 1.0),       -- -12
  ROW('need to share feelings', 1.0),          -- -13
  ROW('feel disconnected', 0.9),               -- -14
  ROW('feel left out', 0.9),                   -- -15
  ROW('want to talk to someone', 1.0),         -- -16
  ROW('need someone by my side', 0.95),        -- -17
  ROW('wish someone was here', 0.9),            -- -18
  ROW('feel unsupported', 0.95),               -- -19
  ROW('feel unheard', 0.95),                   -- -20

  ROW('want to be heard', 1.0),                -- -21
  ROW('feel isolated', 0.9),                   -- -22
  ROW('need emotional support', 0.95),         -- -23
  ROW('need support from others', 0.95),       -- -24
  ROW('wish I had someone to talk to', 1.0),   -- -25
  ROW('feel emotionally alone', 0.95),         -- -26
  ROW('need someone right now', 1.0),          -- -27
  ROW('want company', 0.9),                    -- -28
  ROW('craving connection', 0.9),              -- -29
  ROW('need connection', 0.9),                 -- -30

  ROW('want human connection', 0.9),           -- -31
  ROW('feel invisible', 0.9),                  -- -32
  ROW('need reassurance from others', 0.9),    -- -33
  ROW('feel socially disconnected', 0.9),      -- -34
  ROW('wish someone would listen', 1.0),       -- -35
  ROW('feel emotionally alone right now',0.95),-- -36
  ROW('need someone to be there', 1.0),        -- -37
  ROW('want to open up to someone', 1.0),      -- -38
  ROW('feel like no one listens', 1.0),        -- -39
  ROW('need comfort from someone', 0.95),      -- -40

  ROW('feel alone with my thoughts', 0.95),    -- -41
  ROW('want to feel understood', 1.0),         -- -42
  ROW('need people around me', 0.9),           -- -43
  ROW('wish I wasn’t alone', 0.95),             -- -44
  ROW('feel disconnected from others',0.9),   -- -45
  ROW('need someone to hear me', 1.0),         -- -46
  ROW('want to talk things out', 1.0),         -- -47
  ROW('no one is there for me', 0.95),          -- -48
  ROW('feel emotionally isolated', 0.95),      -- -49
  ROW('need emotional connection', 0.95),      -- -50

  ROW('want someone to care', 0.9),             -- -51
  ROW('need someone who understands', 1.0),   -- -52
  ROW('feel cut off from people', 0.9),        -- -53
  ROW('need someone to share with', 1.0),      -- -54
  ROW('want to feel less alone', 0.95),        -- -55
  ROW('feel like I have no one', 1.0),         -- -56
  ROW('need to talk to someone badly',1.0),   -- -57
  ROW('want someone to be there', 1.0),        -- -58
  ROW('feel socially alone', 0.95),             -- -59
  ROW('wish I had support', 0.95),              -- -60

  ROW('need someone close', 0.9),               -- -61
  ROW('feel distant from everyone', 0.9),      -- -62
  ROW('want to feel connected', 0.95),         -- -63
  ROW('need someone who listens', 1.0),        -- -64
  ROW('feel like no one gets me', 1.0),        -- -65
  ROW('wish someone understood me', 1.0),      -- -66
  ROW('feel alone emotionally', 0.95),         -- -67
  ROW('need someone to talk things through',1.0),-- -68
  ROW('want someone to hear me out',1.0),      -- -69
  ROW('feel disconnected right now',0.9),      -- -70

  ROW('need someone to care right now',1.0),   -- -71
  ROW('want to feel supported', 0.95),         -- -72
  ROW('feel like I’m on my own',0.95),          -- -73
  ROW('need someone beside me',0.95),          -- -74
  ROW('wish I had someone here',0.95),          -- -75
  ROW('feel like I’m facing this alone',0.95), -- -76
  ROW('need someone to talk things out with',1.0),-- -77
  ROW('want someone to listen to me',1.0),     -- -78
  ROW('feel emotionally disconnected',0.95),  -- -79
  ROW('need someone to understand me',1.0),    -- -80

  ROW('want someone to share this with',1.0),  -- -81
  ROW('feel alone in this',0.95),               -- -82
  ROW('need someone to hear my feelings',1.0), -- -83
  ROW('want support from others',0.95),        -- -84
  ROW('wish I had someone to lean on',0.95)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy được lắng nghe', 1.0),
  ROW('hỗ trợ hữu ích', 0.9),
  ROW('cảm thấy đỡ cô đơn hơn', 1.0),            -- -1
  ROW('không còn thấy một mình nữa', 1.0),      -- -2
  ROW('có người nghe rồi', 1.0),                 -- -3
  ROW('có người lắng nghe', 1.0),                -- -4
  ROW('cảm thấy được nghe', 1.0),                -- -5
  ROW('cảm thấy được hiểu', 1.0),                -- -6
  ROW('có người hiểu mình', 1.0),                -- -7
  ROW('đỡ trống trải hơn', 0.95),                -- -8
  ROW('đỡ lạc lõng hơn', 0.95),                  -- -9
  ROW('đỡ cô độc hơn', 0.95),                    -- -10

  ROW('có người bên cạnh rồi', 0.95),            -- -11
  ROW('cảm thấy được quan tâm', 0.95),           -- -12
  ROW('được ai đó an ủi', 0.95),                 -- -13
  ROW('nói ra thấy nhẹ hơn', 1.0),               -- -14
  ROW('chia sẻ xong thấy dễ chịu', 1.0),         -- -15
  ROW('tâm trạng khá hơn sau khi nói chuyện',1.0),-- -16
  ROW('nói chuyện xong thấy ổn hơn',1.0),        -- -17
  ROW('đỡ nặng lòng hơn', 0.95),                 -- -18
  ROW('cảm giác nhẹ người hơn', 0.95),           -- -19
  ROW('không còn bị dồn nén nữa', 0.95),         -- -20

  ROW('có người chia sẻ cùng', 1.0),             -- -21
  ROW('có người để tâm sự', 1.0),                -- -22
  ROW('không còn giữ trong lòng nữa', 0.95),    -- -23
  ROW('được nói ra nên đỡ hơn', 1.0),             -- -24
  ROW('cảm thấy được kết nối', 0.95),            -- -25
  ROW('có cảm giác không còn đơn độc', 0.95),   -- -26
  ROW('có người ở bên lúc này', 0.95),           -- -27
  ROW('được nghe và phản hồi', 1.0),             -- -28
  ROW('cảm thấy được chia sẻ', 1.0),             -- -29
  ROW('có người hiểu cảm xúc này', 1.0),         -- -30

  ROW('tâm trạng dịu xuống', 0.9),               -- -31
  ROW('cảm xúc ổn hơn', 0.9),                    -- -32
  ROW('bớt căng thẳng hơn', 0.9),                -- -33
  ROW('đỡ áp lực hơn', 0.9),                     -- -34
  ROW('nói chuyện xong thấy nhẹ đầu',0.95),     -- -35
  ROW('cảm thấy được ủng hộ', 0.95),             -- -36
  ROW('được ai đó đứng về phía mình',0.95),     -- -37
  ROW('không còn cảm giác bị bỏ rơi',0.95),     -- -38
  ROW('đỡ cảm giác bị cô lập',0.95),             -- -39
  ROW('có người quan tâm thật',1.0),             -- -40

  ROW('chia sẻ giúp dễ thở hơn',0.95),           -- -41
  ROW('được lắng nghe nên đỡ hơn',1.0),          -- -42
  ROW('cảm giác không còn bị phớt lờ',0.95),    -- -43
  ROW('có người phản hồi lại',0.95),             -- -44
  ROW('cảm thấy có chỗ dựa',0.95),               -- -45
  ROW('được ai đó hiểu cho',1.0),                -- -46
  ROW('không còn cảm giác vô hình',0.9),         -- -47
  ROW('cảm thấy được công nhận',0.95),           -- -48
  ROW('được chia sẻ cùng người khác',1.0),      -- -49
  ROW('cảm thấy bớt tách biệt',0.95),            -- -50

  ROW('nói chuyện giúp đầu óc dễ chịu hơn',0.95),-- -51
  ROW('cảm giác có người đồng cảm',1.0),        -- -52
  ROW('không còn phải chịu một mình',1.0),      -- -53
  ROW('được nói ra nên nhẹ lòng',1.0),           -- -54
  ROW('cảm thấy được ở bên',0.95),               -- -55
  ROW('có người hiểu chuyện này',1.0),          -- -56
  ROW('cảm giác được chia sẻ thật',1.0),        -- -57
  ROW('đỡ cảm giác bị bỏ quên',0.95),            -- -58
  ROW('cảm thấy được chú ý',0.9),                -- -59
  ROW('được ai đó lắng nghe thật sự',1.0),      -- -60

  ROW('cảm xúc không còn dồn nén',0.95),        -- -61
  ROW('có người bên mình rồi',0.95),             -- -62
  ROW('được nói ra nên thấy ổn',1.0),            -- -63
  ROW('chia sẻ giúp bớt nặng',0.95),             -- -64
  ROW('cảm thấy được đồng hành',0.95),           -- -65
  ROW('có người để dựa tinh thần',0.95),        -- -66
  ROW('không còn cảm giác cô lập',0.95),        -- -67
  ROW('cảm thấy có kết nối hơn',0.95),           -- -68
  ROW('có người chia sẻ cảm xúc cùng',1.0),    -- -69
  ROW('cảm thấy được ở cùng ai đó',0.95),       -- -70

  ROW('tâm trạng ổn định hơn',0.9),              -- -71
  ROW('đỡ rối hơn sau khi nói chuyện',0.95),   -- -72
  ROW('cảm thấy được hỗ trợ',0.95),              -- -73
  ROW('có người quan tâm đến cảm xúc',1.0),    -- -74
  ROW('không còn phải giấu trong lòng',0.95),  -- -75
  ROW('được chia sẻ nên thấy dễ chịu',1.0),    -- -76
  ROW('cảm thấy được thấu hiểu hơn',1.0),      -- -77
  ROW('có người lắng nghe cảm xúc',1.0),       -- -78
  ROW('đỡ cảm giác cô đơn rõ rệt',1.0),         -- -79
  ROW('cảm thấy có người đồng hành',0.95),     -- -80

  ROW('cảm xúc dịu hơn sau khi chia sẻ',0.95),-- -81
  ROW('được nói ra nên nhẹ đầu',0.95),          -- -82
  ROW('có người nghe nên đỡ áp lực',1.0),      -- -83
  ROW('cảm thấy không còn một mình',1.0),      -- -84
  ROW('chia sẻ giúp thấy ổn hơn nhiều',1.0),

  ROW('feel less lonely', 1.0),                 -- -1
  ROW('don’t feel alone anymore', 1.0),         -- -2
  ROW('someone listened to me', 1.0),           -- -3
  ROW('someone heard me', 1.0),                 -- -4
  ROW('feel heard', 1.0),                       -- -5
  ROW('feel understood', 1.0),                  -- -6
  ROW('someone understands me', 1.0),           -- -7
  ROW('feel less isolated', 0.95),              -- -8
  ROW('feel less disconnected', 0.95),          -- -9
  ROW('feel less alone emotionally',0.95),     -- -10

  ROW('someone is there for me',0.95),          -- -11
  ROW('feel supported',0.95),                   -- -12
  ROW('feel cared about',0.95),                 -- -13
  ROW('talking helped',1.0),                    -- -14
  ROW('felt better after talking',1.0),        -- -15
  ROW('feel better after sharing',1.0),        -- -16
  ROW('talking made me feel better',1.0),      -- -17
  ROW('feel lighter emotionally',0.95),        -- -18
  ROW('feel relieved',0.95),                    -- -19
  ROW('feel less pressured',0.95),              -- -20

  ROW('had someone to share with',1.0),         -- -21
  ROW('had someone to talk to',1.0),            -- -22
  ROW('didn’t have to keep it inside',0.95),  -- -23
  ROW('getting it out helped',1.0),             -- -24
  ROW('feel more connected',0.95),              -- -25
  ROW('don’t feel as alone anymore',1.0),      -- -26
  ROW('someone was there',0.95),                -- -27
  ROW('felt listened to',1.0),                  -- -28
  ROW('felt acknowledged',0.95),                -- -29
  ROW('someone got how I feel',1.0),            -- -30

  ROW('feel calmer now',0.9),                   -- -31
  ROW('feel more okay',0.9),                    -- -32
  ROW('feel less tense',0.9),                   -- -33
  ROW('feel less stressed',0.9),                -- -34
  ROW('talking cleared my head',0.95),          -- -35
  ROW('felt supported emotionally',0.95),      -- -36
  ROW('felt backed up by someone',0.95),       -- -37
  ROW('don’t feel abandoned',0.95),             -- -38
  ROW('feel less isolated socially',0.95),     -- -39
  ROW('someone genuinely cared',1.0),           -- -40

  ROW('sharing helped me breathe easier',0.95),-- -41
  ROW('felt heard and understood',1.0),        -- -42
  ROW('don’t feel ignored anymore',0.95),      -- -43
  ROW('got a response',0.95),                   -- -44
  ROW('feel like I have support',0.95),        -- -45
  ROW('someone understood my feelings',1.0),   -- -46
  ROW('don’t feel invisible anymore',0.9),     -- -47
  ROW('feel validated',0.95),                   -- -48
  ROW('shared this with someone',1.0),         -- -49
  ROW('feel less cut off',0.95),                -- -50

  ROW('talking made things easier',0.95),      -- -51
  ROW('felt emotional connection',1.0),        -- -52
  ROW('didn’t have to handle it alone',1.0),   -- -53
  ROW('felt relieved after sharing',1.0),      -- -54
  ROW('felt someone was with me',0.95),        -- -55
  ROW('someone understood this',1.0),          -- -56
  ROW('felt truly listened to',1.0),           -- -57
  ROW('feel less forgotten',0.95),              -- -58
  ROW('felt noticed',0.9),                      -- -59
  ROW('felt genuinely heard',1.0),             -- -60

  ROW('feel less emotionally bottled up',0.95),-- -61
  ROW('someone stayed with me',0.95),          -- -62
  ROW('felt okay after talking',1.0),          -- -63
  ROW('sharing made it lighter',0.95),         -- -64
  ROW('felt accompanied',0.95),                -- -65
  ROW('had emotional support',0.95),           -- -66
  ROW('don’t feel isolated anymore',0.95),     -- -67
  ROW('feel more connected now',0.95),         -- -68
  ROW('shared feelings with someone',1.0),     -- -69
  ROW('felt someone beside me',0.95),          -- -70

  ROW('feel emotionally steadier',0.9),        -- -71
  ROW('felt clearer after talking',0.95),     -- -72
  ROW('felt supported by someone',0.95),      -- -73
  ROW('someone cared about my feelings',1.0), -- -74
  ROW('didn’t have to hide it anymore',0.95), -- -75
  ROW('sharing felt comforting',1.0),          -- -76
  ROW('felt more understood',1.0),             -- -77
  ROW('someone listened to my feelings',1.0), -- -78
  ROW('felt noticeably less lonely',1.0),     -- -79
  ROW('felt like I wasn’t alone',1.0),         -- -80

  ROW('emotions felt calmer after sharing',0.95),-- -81
  ROW('felt lighter after talking',0.95),     -- -82
  ROW('having someone listen reduced stress',1.0),-- -83
  ROW('felt supported and heard',1.0),        -- -84
  ROW('sharing made a real difference',1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không có ai cả', 1.0),
  ROW('chẳng có ai', 1.0),
  ROW('không có người nào', 1.0),
  ROW('không có ai bên cạnh', 0.95),
  ROW('không có ai quan tâm', 0.95),
  ROW('không có ai hiểu', 0.95),
  ROW('không có ai để chia sẻ', 0.95),
  ROW('không có ai để nói chuyện', 0.95),
  ROW('không có ai lắng nghe', 0.95),
  ROW('rất cô đơn', 0.95),

  -- 11–20 (support absence)
  ROW('thiếu sự hỗ trợ', 0.9),
  ROW('không có sự giúp đỡ', 0.9),
  ROW('không có người đáng tin', 0.9),
  ROW('không có chỗ dựa', 0.9),
  ROW('không có ai để nhắn', 0.9),
  ROW('không có ai để gọi', 0.9),
  ROW('không có người phù hợp', 0.9),
  ROW('không có mạng lưới hỗ trợ', 0.9),
  ROW('không có ai sẵn sàng', 0.9),
  ROW('không có ai ở thời điểm này', 0.9),

  -- 21–30 (uncertainty)
  ROW('không biết nhờ ai', 0.85),
  ROW('không biết nói với ai', 0.85),
  ROW('không biết tìm ai', 0.85),
  ROW('không biết ai sẽ nghe', 0.85),
  ROW('không rõ ai phù hợp', 0.85),
  ROW('không biết ai quan tâm', 0.85),
  ROW('không biết ai giúp được', 0.85),
  ROW('không biết chia sẻ với ai', 0.85),
  ROW('không biết tìm sự giúp đỡ ở đâu', 0.85),
  ROW('không biết bắt đầu từ đâu', 0.85),

  -- 31–40 (avoidance)
  ROW('không muốn làm phiền người khác', 0.85),
  ROW('không muốn kể cho người khác', 0.85),
  ROW('không muốn chia sẻ chuyện này', 0.85),
  ROW('không muốn mở lòng', 0.85),
  ROW('không muốn nói ra', 0.85),
  ROW('không muốn nhờ vả', 0.85),
  ROW('không muốn liên lạc', 0.85),
  ROW('không muốn tâm sự', 0.85),
  ROW('không muốn dựa vào ai', 0.85),
  ROW('không muốn kéo người khác vào', 0.85),

  -- 41–50 (self-reliance)
  ROW('quen tự chịu', 0.8),
  ROW('quen tự lo', 0.8),
  ROW('tự xử lý được', 0.8),
  ROW('tự giải quyết thôi', 0.8),
  ROW('không cần giúp đỡ', 0.8),
  ROW('không cần ai hỗ trợ', 0.8),
  ROW('tự vượt qua', 0.8),
  ROW('tự chịu đựng', 0.8),
  ROW('quen rồi', 0.8),
  ROW('tự mình đối mặt', 0.8),

  -- 51–60 (trust & safety)
  ROW('khó tin người khác', 0.8),
  ROW('không tin ai', 0.8),
  ROW('không thấy an toàn khi chia sẻ', 0.8),
  ROW('không thoải mái khi nói chuyện', 0.8),
  ROW('không ai đủ tin cậy', 0.8),
  ROW('không ai đủ hiểu', 0.8),
  ROW('không ai đủ kiên nhẫn', 0.8),
  ROW('không ai đủ lắng nghe', 0.8),
  ROW('không ai đủ an toàn', 0.8),
  ROW('không ai phù hợp để tâm sự', 0.8),

  -- 61–70 (situational)
  ROW('ai cũng bận', 0.8),
  ROW('mọi người đều có việc riêng', 0.8),
  ROW('không ai rảnh', 0.8),
  ROW('không ai sẵn lòng nghe', 0.8),
  ROW('không ai ở gần', 0.8),
  ROW('không có ai lúc này', 0.8),
  ROW('không có ai xung quanh', 0.8),
  ROW('không có ai để tìm đến', 0.8),
  ROW('không có ai để kết nối', 0.8),
  ROW('không có ai để dựa tinh thần', 0.8),

  -- 71–85 (emotional framing)
  ROW('cảm giác bị bỏ lại', 0.8),
  ROW('cảm giác không được quan tâm', 0.8),
  ROW('cảm giác không được lắng nghe', 0.8),
  ROW('cảm giác bị tách biệt', 0.8),
  ROW('cảm giác không ai hiểu', 0.8),
  ROW('cảm giác phải tự xoay xở', 0.8),
  ROW('cảm giác chỉ có một mình', 0.8),
  ROW('cảm giác không có chỗ dựa', 0.8),
  ROW('cảm giác không được hỗ trợ', 0.8),
  ROW('cảm giác không biết dựa vào đâu', 0.8),

  ROW('no one at all', 1.0),
  ROW('nobody around', 1.0),
  ROW('completely alone', 1.0),
  ROW('no support available', 0.95),
  ROW('no emotional support', 0.95),
  ROW('no trusted person', 0.95),
  ROW('no one nearby', 0.95),
  ROW('no one listening', 0.95),
  ROW('no one understanding', 0.95),
  ROW('feels very lonely', 0.95),

  -- 11–20 (support gap)
  ROW('lack of support', 0.9),
  ROW('no support system', 0.9),
  ROW('no safe person', 0.9),
  ROW('no one dependable', 0.9),
  ROW('no one reliable', 0.9),
  ROW('no one available right now', 0.9),
  ROW('no one to talk with', 0.9),
  ROW('no one to share with', 0.9),
  ROW('no one to reach out to', 0.9),
  ROW('no one to lean on', 0.9),

  -- 21–30 (uncertainty)
  ROW('not sure who to talk to', 0.85),
  ROW('not sure who could help', 0.85),
  ROW('not sure who would care', 0.85),
  ROW('don’t know where to get help', 0.85),
  ROW('don’t know how to ask', 0.85),
  ROW('don’t know who to trust', 0.85),
  ROW('don’t know who would listen', 0.85),
  ROW('not clear who is available', 0.85),
  ROW('no clear person to turn to', 0.85),
  ROW('no clear support option', 0.85),

  -- 31–40 (avoidance)
  ROW('don’t want to bother others', 0.85),
  ROW('don’t want to open up', 0.85),
  ROW('don’t want to share this', 0.85),
  ROW('don’t want to reach out', 0.85),
  ROW('don’t want to involve anyone', 0.85),
  ROW('don’t want to talk about it', 0.85),
  ROW('don’t want to depend on others', 0.85),
  ROW('don’t want to ask for help', 0.85),
  ROW('don’t want to explain things', 0.85),
  ROW('don’t want to bring others in', 0.85),

  -- 41–50 (self-reliance)
  ROW('used to handling things alone', 0.8),
  ROW('handling things alone', 0.8),
  ROW('dealing with it alone', 0.8),
  ROW('prefer handling it alone', 0.8),
  ROW('no need for help', 0.8),
  ROW('manage on my own', 0.8),
  ROW('get through it alone', 0.8),
  ROW('handle it solo', 0.8),
  ROW('used to being alone', 0.8),
  ROW('figure it out alone', 0.8),

  -- 51–60 (trust & safety)
  ROW('hard to trust people', 0.8),
  ROW('don’t trust people easily', 0.8),
  ROW('don’t feel safe opening up', 0.8),
  ROW('don’t feel comfortable sharing', 0.8),
  ROW('no one feels safe', 0.8),
  ROW('no one feels trustworthy', 0.8),
  ROW('no one feels understanding', 0.8),
  ROW('no one feels patient enough', 0.8),
  ROW('no one feels supportive', 0.8),
  ROW('no one feels right to talk to', 0.8),

  -- 61–70 (situational)
  ROW('everyone seems busy', 0.8),
  ROW('people have their own problems', 0.8),
  ROW('no one has time', 0.8),
  ROW('no one available to listen', 0.8),
  ROW('no one around right now', 0.8),
  ROW('no one nearby to help', 0.8),
  ROW('no one close enough', 0.8),
  ROW('no one reachable', 0.8),
  ROW('no one accessible', 0.8),
  ROW('no one to connect with', 0.8),

  -- 71–85 (emotional framing)
  ROW('feels left out', 0.8),
  ROW('feels unsupported', 0.8),
  ROW('feels unheard', 0.8),
  ROW('feels disconnected', 0.8),
  ROW('feels isolated', 0.8),
  ROW('feels on their own', 0.8),
  ROW('feels cut off', 0.8),
  ROW('feels like facing it alone', 0.8),
  ROW('feels no one is there', 0.8),
  ROW('feels nowhere to turn', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử tìm ai khác không', 1.0),
  ROW('có ai để chia sẻ chưa', 0.8),
  ROW('hiện tại có ai đang ở bên hỗ trợ không', 1.0),
  ROW('thường tìm đến ai khi cần giúp đỡ', 1.0),
  ROW('có người đáng tin để chia sẻ chuyện này không', 1.0),
  ROW('xung quanh có ai có thể lắng nghe không', 0.95),
  ROW('có ai thường giúp trong những lúc khó khăn không', 0.95),

  ROW('mạng lưới hỗ trợ hiện tại gồm những ai', 0.95),
  ROW('có cảm thấy được lắng nghe bởi người khác không', 0.95),
  ROW('có ai từng giúp vượt qua tình huống tương tự không', 0.95),
  ROW('ai là người thường mang lại cảm giác an tâm', 0.95),
  ROW('có ai khiến cảm giác được thấu hiểu không', 0.95),

  ROW('việc chia sẻ với người khác có dễ dàng không', 0.9),
  ROW('có ai thường chủ động quan tâm không', 0.9),
  ROW('xung quanh có người sẵn sàng giúp khi cần không', 0.9),
  ROW('có cảm giác được ủng hộ từ người khác không', 0.9),
  ROW('ai là người thường được nghĩ đến đầu tiên', 0.9),

  ROW('việc tìm kiếm hỗ trợ hiện tại có gặp khó khăn không', 0.9),
  ROW('có ai khiến cảm giác không còn một mình không', 0.9),
  ROW('có người từng lắng nghe mà không phán xét không', 0.9),
  ROW('có cảm giác được đồng hành không', 0.9),
  ROW('ai là người có thể liên lạc khi cần nói chuyện', 0.9),

  ROW('mối quan hệ hiện tại có mang lại sự an toàn không', 0.85),
  ROW('có ai từng giúp giảm bớt áp lực không', 0.85),
  ROW('việc nhờ giúp đỡ có thoải mái không', 0.85),
  ROW('có người sẵn sàng dành thời gian lắng nghe không', 0.85),
  ROW('có ai từng ở bên trong giai đoạn khó khăn không', 0.85),

  ROW('có cảm thấy được quan tâm từ xung quanh không', 0.85),
  ROW('ai là người thường tạo cảm giác dễ chịu', 0.85),
  ROW('có người nào khiến cảm xúc được nhẹ hơn không', 0.85),
  ROW('việc kết nối với người khác hiện tại ra sao', 0.85),
  ROW('có cảm giác được chia sẻ gánh nặng không', 0.85),

  ROW('có ai có thể cùng suy nghĩ hướng giải quyết không', 0.8),
  ROW('có người nào có thể liên hệ ngay lúc này không', 0.8),
  ROW('có cảm thấy thoải mái khi nói chuyện với ai đó không', 0.8),
  ROW('có ai mang lại cảm giác được bảo vệ không', 0.8),
  ROW('việc tìm kiếm hỗ trợ có khả thi không', 0.8),

  ROW('có ai trong gia đình có thể lắng nghe không', 0.8),
  ROW('có bạn bè nào thường chia sẻ không', 0.8),
  ROW('có người trưởng thành đáng tin không', 0.8),
  ROW('có ai từng hỗ trợ về mặt tinh thần không', 0.8),
  ROW('có người nào có thể nói chuyện an toàn không', 0.8),

  ROW('có cảm giác được kết nối với người khác không', 0.8),
  ROW('có ai có thể giúp cảm xúc ổn định hơn không', 0.8),
  ROW('việc mở lòng với người khác có khó không', 0.8),
  ROW('có ai từng khiến cảm giác nhẹ nhõm hơn không', 0.8),
  ROW('có người nào có thể ở bên trong lúc này không', 0.8),

  ROW('có ai phù hợp để cùng chia sẻ điều này không', 0.8),
  ROW('có người nào tạo cảm giác được tôn trọng không', 0.8),
  ROW('có ai giúp cảm giác bớt căng thẳng không', 0.8),
  ROW('có ai có thể hỗ trợ tinh thần lúc này không', 0.8),
  ROW('có người nào khiến cảm giác không bị bỏ mặc không', 0.8),

  ROW('is there anyone providing support right now', 1.0),
  ROW('who is usually reached out to for help', 1.0),
  ROW('is there someone trusted to share this with', 1.0),
  ROW('is anyone available to listen', 0.95),
  ROW('is there support during difficult moments', 0.95),

  ROW('what does the current support circle look like', 0.95),
  ROW('is there a sense of being heard by others', 0.95),
  ROW('has anyone helped in similar situations before', 0.95),
  ROW('who tends to provide comfort', 0.95),
  ROW('is there anyone who feels understanding', 0.95),

  ROW('does reaching out feel possible', 0.9),
  ROW('is anyone checking in regularly', 0.9),
  ROW('is help available when needed', 0.9),
  ROW('is there a feeling of being supported', 0.9),
  ROW('who usually comes to mind first', 0.9),

  ROW('are there barriers to getting support right now', 0.9),
  ROW('is there anyone who reduces the sense of isolation', 0.9),
  ROW('has anyone listened without judging', 0.9),
  ROW('is there a feeling of not facing this alone', 0.9),
  ROW('who could be contacted for a conversation', 0.9),

  ROW('do current relationships feel safe', 0.85),
  ROW('has anyone helped ease the pressure before', 0.85),
  ROW('does asking for help feel comfortable', 0.85),
  ROW('is anyone willing to spend time listening', 0.85),
  ROW('has anyone been present during hard times', 0.85),

  ROW('is there a sense of being cared for', 0.85),
  ROW('who tends to create a calm feeling', 0.85),
  ROW('has anyone helped emotions feel lighter', 0.85),
  ROW('how does connecting with others feel right now', 0.85),
  ROW('is there a sense of sharing the load', 0.85),

  ROW('is there someone to think through solutions with', 0.8),
  ROW('is there anyone reachable right now', 0.8),
  ROW('does talking to someone feel safe', 0.8),
  ROW('is there anyone who brings a sense of protection', 0.8),
  ROW('does support feel accessible', 0.8),

  ROW('is there family support available', 0.8),
  ROW('are there friends who usually listen', 0.8),
  ROW('is there a trusted adult available', 0.8),
  ROW('has emotional support been offered before', 0.8),
  ROW('is there a safe person to talk to', 0.8),

  ROW('is there a feeling of connection with others', 0.8),
  ROW('is there someone who helps emotions settle', 0.8),
  ROW('does opening up feel difficult', 0.8),
  ROW('has anyone helped things feel more manageable', 0.8),
  ROW('is there someone who could be present right now', 0.8),

  ROW('is there someone suitable to share this with', 0.8),
  ROW('is there anyone who shows respect and care', 0.8),
  ROW('has anyone helped reduce stress before', 0.8),
  ROW('is emotional support available at this moment', 0.8),
  ROW('is there anyone who prevents feeling forgotten', 0.8)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_social_support'
ON CONFLICT DO NOTHING;

----------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('cần được động viên', 1.0),                --1
  ROW('muốn nghe lời khích lệ', 1.0),             --2
  ROW('thiếu động lực', 1.0),                     --3
  ROW('cảm thấy nản', 1.0),                       --4
  ROW('cảm thấy không đủ tốt', 1.0),              --5
  ROW('cần lời an ủi', 1.0),                      --6
  ROW('cảm giác tự ti', 1.0),                     --7
  ROW('nghi ngờ khả năng', 1.0),                  --8
  ROW('cảm thấy thất vọng về bản thân', 1.0),     --9
  ROW('cần sự khích lệ tinh thần', 1.0),          --10
  ROW('mệt mỏi về tinh thần', 0.95),              --11
  ROW('cảm thấy yếu đuối', 0.95),                 --12
  ROW('không còn tự tin', 0.95),                  --13
  ROW('cảm giác bị áp lực', 0.95),                --14
  ROW('cần lời nói tích cực', 0.95),              --15
  ROW('cảm thấy kém cỏi', 0.95),                  --16
  ROW('tinh thần đi xuống', 0.95),                --17
  ROW('cảm giác bị chê trách', 0.95),             --18
  ROW('cảm thấy không được công nhận', 0.95),     --19
  ROW('thiếu niềm tin vào bản thân', 0.95),       --20
  ROW('cần được tiếp thêm tinh thần', 0.95),      --21
  ROW('cảm thấy dễ nản', 0.95),                   --22
  ROW('khó tự động viên', 0.95),                  --23
  ROW('cảm giác không tiến bộ', 0.95),            --24
  ROW('cần được nhắc rằng đã cố gắng', 0.95),     --25
  ROW('mọi thứ thật khó', 0.9),                   --26
  ROW('cảm thấy quá tải', 0.9),                   --27
  ROW('cảm giác mất động lực', 0.9),              --28
  ROW('cần thêm hy vọng', 0.9),                   --29
  ROW('tinh thần sa sút', 0.9),                   --30
  ROW('cảm thấy không ai đánh giá cao', 0.9),     --31
  ROW('cảm giác bị so sánh', 0.9),                --32
  ROW('không thấy giá trị bản thân', 0.9),        --33
  ROW('cảm giác chán nản kéo dài', 0.9),          --34
  ROW('cần nghe điều tích cực', 0.9),             --35
  ROW('cảm thấy không đủ giỏi', 0.9),             --36
  ROW('mất niềm tin', 0.9),                       --37
  ROW('cảm giác tự trách', 0.9),                  --38
  ROW('tinh thần xuống thấp', 0.9),               --39
  ROW('cảm thấy không được ủng hộ', 0.9),         --40
  ROW('cần lời nhắc nhẹ nhàng', 0.9),             --41
  ROW('cảm thấy bất lực', 0.9),                   --42
  ROW('thiếu sự khích lệ', 0.9),                  --43
  ROW('cảm giác thất bại', 0.9),                  --44
  ROW('cần được động viên lúc này', 0.9),         --45
  ROW('mất phương hướng', 0.85),                  --46
  ROW('cảm thấy nhỏ bé', 0.85),                   --47
  ROW('cảm giác không xứng đáng', 0.85),          --48
  ROW('tinh thần mệt mỏi kéo dài', 0.85),         --49
  ROW('cảm thấy bị tụt lại', 0.85),               --50
  ROW('khó nhìn thấy điểm tích cực', 0.85),       --51
  ROW('cần được nhắc rằng điều này là đủ', 0.85), --52
  ROW('cảm thấy thiếu giá trị', 0.85),            --53
  ROW('tinh thần không ổn định', 0.85),           --54
  ROW('cảm giác không ai tin tưởng', 0.85),       --55
  ROW('cảm thấy bị bỏ rơi', 0.85),                --56
  ROW('tinh thần xuống dốc', 0.85),               --57
  ROW('cảm giác không ai ghi nhận', 0.85),        --58
  ROW('khó giữ tinh thần tích cực', 0.85),        --59
  ROW('cảm thấy mệt mỏi tâm lý', 0.85),           --60
  ROW('cảm giác bị xem nhẹ', 0.85),               --61
  ROW('thiếu sự động viên tinh thần', 0.85),      --62
  ROW('cảm thấy bị áp lực kéo dài', 0.85),        --63
  ROW('cảm giác chùn bước', 0.85),                --64
  ROW('khó duy trì động lực', 0.85),              --65
  ROW('cần lời nói ấm áp', 0.8),                  --66
  ROW('cảm thấy tự ti kéo dài', 0.8),             --67
  ROW('cần sự động viên nhẹ nhàng', 0.8),         --68
  ROW('cảm giác không được đủ', 0.8),             --69
  ROW('tinh thần suy giảm', 0.8),                 --70
  ROW('cần lời nhắc tích cực lúc này', 0.8),      --71
  ROW('cảm thấy mất động lực nghiêm trọng', 0.8), --72
  ROW('cảm giác không ai quan tâm', 0.8),         --73
  ROW('khó giữ vững tinh thần', 0.8),             --74
  ROW('cần được an ủi tinh thần', 0.8),           --75
  ROW('cảm thấy chán chính mình', 0.8),           --76
  ROW('thiếu sự công nhận', 0.8),                 --77
  ROW('cần nghe lời động viên', 0.8),             --78
  ROW('cảm giác bị bỏ qua', 0.8),                 --79
  ROW('tinh thần rất thấp', 0.8),                 --80
  ROW('khó cảm thấy tự tin', 0.8),                --81
  ROW('cảm thấy không đủ mạnh mẽ', 0.8),          --82
  ROW('cần lời nhắc rằng đã cố gắng', 0.8),       --83
  ROW('cảm giác nặng nề tinh thần', 0.8),         --84
  ROW('thiếu nguồn động viên', 0.8),

  ROW('need encouragement', 1.0),                     --1
  ROW('want positive support', 1.0),                  --2
  ROW('lacking motivation', 1.0),                     --3
  ROW('feeling discouraged', 1.0),                    --4
  ROW('feeling not good enough', 1.0),                --5
  ROW('need emotional reassurance', 1.0),             --6
  ROW('feeling insecure', 1.0),                       --7
  ROW('doubting abilities', 1.0),                     --8
  ROW('feeling disappointed internally', 1.0),       --9
  ROW('need mental encouragement', 1.0),              --10
  ROW('mental exhaustion present', 0.95),             --11
  ROW('feeling emotionally weak', 0.95),              --12
  ROW('confidence is low', 0.95),                     --13
  ROW('experiencing pressure', 0.95),                 --14
  ROW('need positive words', 0.95),                   --15
  ROW('feeling inadequate', 0.95),                    --16
  ROW('mood declining', 0.95),                        --17
  ROW('feeling criticized', 0.95),                    --18
  ROW('feeling unrecognized', 0.95),                  --19
  ROW('lack of self belief', 0.95),                   --20
  ROW('need emotional strength', 0.95),               --21
  ROW('easily discouraged', 0.95),                    --22
  ROW('difficulty self motivating', 0.95),            --23
  ROW('feeling no progress', 0.95),                   --24
  ROW('need reminder of effort', 0.95),               --25
  ROW('everything feels difficult', 0.9),             --26
  ROW('feeling overwhelmed', 0.9),                    --27
  ROW('motivation decreasing', 0.9),                  --28
  ROW('need hope', 0.9),                              --29
  ROW('mental state worsening', 0.9),                 --30
  ROW('feeling undervalued', 0.9),                    --31
  ROW('feeling compared', 0.9),                       --32
  ROW('self worth unclear', 0.9),                     --33
  ROW('long term discouragement', 0.9),               --34
  ROW('need something positive', 0.9),                --35
  ROW('feeling not capable', 0.9),                    --36
  ROW('confidence fading', 0.9),                      --37
  ROW('strong self criticism', 0.9),                  --38
  ROW('mental energy low', 0.9),                      --39
  ROW('feeling unsupported', 0.9),                    --40
  ROW('need gentle reassurance', 0.9),                --41
  ROW('sense of helplessness', 0.9),                  --42
  ROW('lack of encouragement', 0.9),                  --43
  ROW('feeling like failure', 0.9),                   --44
  ROW('need encouragement now', 0.9),                 --45
  ROW('feeling lost', 0.85),                          --46
  ROW('feeling small', 0.85),                         --47
  ROW('feeling undeserving', 0.85),                   --48
  ROW('ongoing mental fatigue', 0.85),                --49
  ROW('feeling left behind', 0.85),                   --50
  ROW('difficulty seeing positives', 0.85),           --51
  ROW('need reminder effort is enough', 0.85),        --52
  ROW('feeling low value', 0.85),                     --53
  ROW('emotional instability', 0.85),                 --54
  ROW('feeling untrusted', 0.85),                     --55
  ROW('feeling abandoned', 0.85),                     --56
  ROW('mental state declining', 0.85),                --57
  ROW('lack of recognition', 0.85),                   --58
  ROW('difficulty staying positive', 0.85),           --59
  ROW('psychological tiredness', 0.85),               --60
  ROW('feeling overlooked', 0.85),                    --61
  ROW('lack of emotional support', 0.85),             --62
  ROW('prolonged pressure', 0.85),                    --63
  ROW('loss of momentum', 0.85),                      --64
  ROW('difficulty sustaining motivation', 0.85),     --65
  ROW('need comforting words', 0.8),                  --66
  ROW('persistent insecurity', 0.8),                 --67
  ROW('need gentle encouragement', 0.8),             --68
  ROW('feeling insufficient', 0.8),                  --69
  ROW('mental strength reduced', 0.8),               --70
  ROW('need positive reminder now', 0.8),            --71
  ROW('severe lack of motivation', 0.8),             --72
  ROW('feeling uncared for', 0.8),                   --73
  ROW('difficulty staying strong', 0.8),             --74
  ROW('need emotional comfort', 0.8),                --75
  ROW('internal self disappointment', 0.8),          --76
  ROW('absence of validation', 0.8),                 --77
  ROW('need motivational words', 0.8),               --78
  ROW('feeling dismissed', 0.8),                     --79
  ROW('very low morale', 0.8),                       --80
  ROW('confidence very low', 0.8),                   --81
  ROW('feeling not strong enough', 0.8),             --82
  ROW('need effort acknowledged', 0.8),              --83
  ROW('heavy mental burden', 0.8),                   --84
  ROW('lack of supportive feedback', 0.8)   
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('nghe vậy thấy dễ chịu hơn', 1.0),               -- 1
  ROW('cảm giác nhẹ lòng hơn rồi', 1.0),               -- 2
  ROW('nghe cũng đỡ áp lực hơn', 0.95),                -- 3
  ROW('thấy bớt nặng nề hơn', 0.95),                   -- 4
  ROW('nghe vậy thấy ổn hơn', 1.0),                    -- 5
  ROW('cảm giác được an ủi', 1.0),                     -- 6
  ROW('nghe vậy thấy đỡ căng thẳng', 0.95),            -- 7
  ROW('cảm giác được hiểu hơn', 1.0),                  -- 8
  ROW('nghe cũng hợp lý', 0.9),                        -- 9
  ROW('thấy không còn tự trách nhiều nữa', 1.0),      -- 10

  ROW('nghe vậy thấy bớt tệ', 0.95),                   -- 11
  ROW('cảm giác dễ thở hơn', 1.0),                     -- 12
  ROW('nghe vậy thấy không còn quá nặng', 0.95),      -- 13
  ROW('thấy nhẹ đầu hơn', 0.9),                        -- 14
  ROW('nghe vậy thấy đỡ mệt hơn', 0.9),                -- 15
  ROW('cảm giác được công nhận', 1.0),                -- 16
  ROW('nghe vậy thấy an tâm hơn', 1.0),                -- 17
  ROW('thấy không còn quá căng', 0.95),                -- 18
  ROW('nghe vậy thấy bớt lo', 1.0),                    -- 19
  ROW('cảm giác được trấn an', 1.0),                   -- 20

  ROW('nghe vậy thấy ổn hơn nhiều', 1.0),              -- 21
  ROW('thấy không còn quá áp lực', 0.95),              -- 22
  ROW('nghe vậy thấy dễ chịu thật', 1.0),              -- 23
  ROW('cảm giác được vỗ về', 0.95),                    -- 24
  ROW('nghe vậy thấy bớt tự trách', 1.0),              -- 25
  ROW('thấy lòng dịu lại', 1.0),                       -- 26
  ROW('nghe vậy thấy không còn quá khắt khe', 0.95),  -- 27
  ROW('cảm giác được thấu hiểu', 1.0),                 -- 28
  ROW('nghe vậy thấy nhẹ nhõm hơn', 1.0),              -- 29
  ROW('thấy đỡ rối hơn', 0.9),                          -- 30

  ROW('nghe vậy thấy dễ chấp nhận hơn', 0.95),        -- 31
  ROW('cảm giác ổn hơn trước', 0.95),                 -- 32
  ROW('nghe vậy thấy không còn quá khó chịu', 0.9),  -- 33
  ROW('thấy tinh thần dịu lại', 1.0),                  -- 34
  ROW('nghe vậy thấy bớt áp lực thật', 1.0),           -- 35
  ROW('cảm giác được xoa dịu', 1.0),                  -- 36
  ROW('nghe vậy thấy đỡ nặng đầu', 0.9),               -- 37
  ROW('thấy không còn tự trách nhiều', 1.0),           -- 38
  ROW('nghe vậy thấy bớt căng thẳng nhiều', 1.0),     -- 39
  ROW('cảm giác được an ủi thật', 1.0),                -- 40

  ROW('nghe vậy thấy ổn hơn hẳn', 1.0),                -- 41
  ROW('thấy tâm trạng dịu xuống', 1.0),                -- 42
  ROW('nghe vậy thấy dễ chịu hơn nhiều', 1.0),         -- 43
  ROW('cảm giác không còn quá tệ', 0.95),              -- 44
  ROW('nghe vậy thấy bớt khắt khe với bản thân', 1.0),-- 45
  ROW('thấy được an tâm hơn', 1.0),                    -- 46
  ROW('nghe vậy thấy nhẹ lòng thật', 1.0),             -- 47
  ROW('cảm giác không còn quá căng', 0.95),            -- 48
  ROW('nghe vậy thấy dễ thở hơn nhiều', 1.0),          -- 49
  ROW('thấy tinh thần ổn hơn', 0.95),                  -- 50

  ROW('nghe vậy thấy không còn quá áp lực nữa', 1.0), -- 51
  ROW('cảm giác được động viên', 1.0),                -- 52
  ROW('nghe vậy thấy yên tâm hơn', 1.0),               -- 53
  ROW('thấy nhẹ hơn trong lòng', 1.0),                -- 54
  ROW('nghe vậy thấy không còn quá tiêu cực', 0.95), -- 55
  ROW('cảm giác được nâng đỡ', 1.0),                  -- 56
  ROW('nghe vậy thấy ổn hơn nhiều rồi', 1.0),         -- 57
  ROW('thấy đỡ lo lắng hơn', 1.0),                     -- 58
  ROW('nghe vậy thấy bớt tự trách bản thân', 1.0),   -- 59
  ROW('cảm giác được an ủi phần nào', 0.95),          -- 60

  ROW('nghe vậy thấy lòng dịu hơn', 1.0),             -- 61
  ROW('thấy tinh thần nhẹ hơn', 1.0),                 -- 62
  ROW('nghe vậy thấy không còn quá căng thẳng', 1.0),-- 63
  ROW('cảm giác được công nhận cảm xúc', 1.0),       -- 64
  ROW('nghe vậy thấy dễ chịu hơn thật', 1.0),        -- 65
  ROW('thấy đỡ áp lực nhiều', 1.0),                    -- 66
  ROW('nghe vậy thấy tâm trạng ổn hơn', 0.95),       -- 67
  ROW('cảm giác được trấn an hơn', 1.0),              -- 68
  ROW('nghe vậy thấy không còn quá nặng nề', 1.0),   -- 69
  ROW('thấy ổn hơn trong lòng', 1.0),                 -- 70

  ROW('nghe vậy thấy nhẹ nhõm thật sự', 1.0),         -- 71
  ROW('cảm giác dễ chịu hơn nhiều rồi', 1.0),        -- 72
  ROW('nghe vậy thấy đỡ căng hẳn', 1.0),              -- 73
  ROW('thấy tâm trạng tốt hơn chút', 0.9),           -- 74
  ROW('nghe vậy thấy ổn hơn trước nhiều', 1.0),      -- 75
  ROW('cảm giác được chia sẻ', 1.0),                 -- 76
  ROW('nghe vậy thấy không còn quá áp lực nữa rồi', 1.0),-- 77
  ROW('thấy nhẹ hơn nhiều', 1.0),                    -- 78
  ROW('nghe vậy thấy dễ chịu hơn rồi', 1.0),         -- 79
  ROW('cảm giác ổn hơn thật', 1.0),                  -- 80

  ROW('nghe vậy thấy lòng nhẹ đi', 1.0),              -- 81
  ROW('thấy không còn quá nặng lòng', 1.0),           -- 82
  ROW('nghe vậy thấy bớt lo thật', 1.0),              -- 83
  ROW('cảm giác được an tâm hơn nhiều', 1.0),        -- 84
  ROW('nghe vậy thấy ổn hơn rồi', 1.0),

  ROW('that makes things feel lighter', 1.0),        -- 1
  ROW('that feels comforting', 1.0),                 -- 2
  ROW('feels a bit calmer now', 1.0),                -- 3
  ROW('that helps ease the pressure', 0.95),         -- 4
  ROW('that makes sense and helps', 1.0),            -- 5
  ROW('feels less overwhelming now', 1.0),           -- 6
  ROW('that feels reassuring', 1.0),                 -- 7
  ROW('feels more understood now', 1.0),             -- 8
  ROW('that actually helps', 0.95),                  -- 9
  ROW('feels less harsh now', 1.0),                  -- 10

  ROW('that makes things feel easier', 1.0),         -- 11
  ROW('feels a bit more manageable', 1.0),           -- 12
  ROW('that brings some relief', 1.0),               -- 13
  ROW('feels less heavy now', 1.0),                  -- 14
  ROW('that calms things down', 1.0),                -- 15
  ROW('feels validating', 1.0),                      -- 16
  ROW('that helps a lot', 1.0),                      -- 17
  ROW('feels more okay now', 1.0),                   -- 18
  ROW('that eases the tension', 0.95),               -- 19
  ROW('feels reassuring to hear', 1.0),              -- 20

  ROW('that actually feels comforting', 1.0),        -- 21
  ROW('feels calmer than before', 1.0),              -- 22
  ROW('that helps ease anxiety', 1.0),               -- 23
  ROW('feels more settled now', 1.0),                -- 24
  ROW('that takes some weight off', 1.0),            -- 25
  ROW('feels less stressful now', 1.0),              -- 26
  ROW('that feels supportive', 1.0),                 -- 27
  ROW('feels less intense now', 1.0),                -- 28
  ROW('that helps calm things down', 1.0),           -- 29
  ROW('feels more grounded', 1.0),                   -- 30

  ROW('that makes it easier to accept', 0.95),       -- 31
  ROW('feels more stable now', 0.95),                -- 32
  ROW('that softens things a bit', 0.95),            -- 33
  ROW('feels more at ease', 1.0),                    -- 34
  ROW('that really helps', 1.0),                     -- 35
  ROW('feels gently reassuring', 1.0),               -- 36
  ROW('that lowers the pressure', 1.0),              -- 37
  ROW('feels less self-critical now', 1.0),          -- 38
  ROW('that eases the stress', 1.0),                 -- 39
  ROW('feels emotionally supported', 1.0),           -- 40

  ROW('that makes things feel calmer', 1.0),         -- 41
  ROW('feels more emotionally steady', 1.0),         -- 42
  ROW('that brings some peace', 1.0),                -- 43
  ROW('feels less overwhelming than before', 1.0),  -- 44
  ROW('that helps reduce pressure', 1.0),            -- 45
  ROW('feels more reassuring now', 1.0),             -- 46
  ROW('that makes things feel lighter again', 1.0), -- 47
  ROW('feels less tense', 1.0),                      -- 48
  ROW('that helps a great deal', 1.0),               -- 49
  ROW('feels more okay emotionally', 1.0),           -- 50

  ROW('that helps ease discomfort', 0.95),           -- 51
  ROW('feels encouraged', 1.0),                      -- 52
  ROW('that brings reassurance', 1.0),               -- 53
  ROW('feels lighter emotionally', 1.0),             -- 54
  ROW('that reduces negativity', 0.95),              -- 55
  ROW('feels supported in this moment', 1.0),       -- 56
  ROW('that helps settle things', 1.0),              -- 57
  ROW('feels less worried now', 1.0),                -- 58
  ROW('that eases self-blame', 1.0),                  -- 59
  ROW('feels somewhat comforting', 0.9),             -- 60

  ROW('that soothes things a bit', 1.0),             -- 61
  ROW('feels mentally lighter', 1.0),                -- 62
  ROW('that reduces tension a lot', 1.0),            -- 63
  ROW('feels emotionally validated', 1.0),           -- 64
  ROW('that genuinely helps', 1.0),                  -- 65
  ROW('feels far less pressured', 1.0),              -- 66
  ROW('that improves the mood a bit', 0.9),          -- 67
  ROW('feels more reassured', 1.0),                  -- 68
  ROW('that removes some heaviness', 1.0),           -- 69
  ROW('feels more settled inside', 1.0),             -- 70

  ROW('that brings real relief', 1.0),               -- 71
  ROW('feels much calmer now', 1.0),                 -- 72
  ROW('that eases stress a lot', 1.0),                -- 73
  ROW('feels slightly better now', 0.9),             -- 74
  ROW('that helps significantly', 1.0),              -- 75
  ROW('feels emotionally shared', 1.0),              -- 76
  ROW('that removes a lot of pressure', 1.0),        -- 77
  ROW('feels much lighter', 1.0),                    -- 78
  ROW('that makes things easier now', 1.0),          -- 79
  ROW('feels genuinely okay', 1.0),                  -- 80

  ROW('that eases emotional weight', 1.0),           -- 81
  ROW('feels far less heavy', 1.0),                  -- 82
  ROW('that helps reduce worry', 1.0),               -- 83
  ROW('feels much more reassured', 1.0),             -- 84
  ROW('that feels calming overall', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không cảm thấy tốt hơn', 0.9),
  ROW('vẫn buồn', 0.8),
  ROW('nghe vậy mà vẫn không khá hơn', 1.0),          -- 1
  ROW('không thấy đỡ hơn', 1.0),                     -- 2
  ROW('vẫn cảm thấy như cũ', 1.0),                   -- 3
  ROW('nghe vậy nhưng không giúp gì', 1.0),          -- 4
  ROW('vẫn thấy nặng nề', 0.95),                     -- 5
  ROW('nghe không thấy tác dụng', 1.0),              -- 6
  ROW('vẫn thấy tệ', 1.0),                           -- 7
  ROW('không cảm thấy khác đi', 1.0),                -- 8
  ROW('nghe cũng không đỡ mấy', 0.95),               -- 9
  ROW('vẫn thấy áp lực', 1.0),                       -- 10

  ROW('nghe vậy mà không thấy nhẹ hơn', 1.0),        -- 11
  ROW('vẫn cảm thấy mệt', 0.95),                     -- 12
  ROW('không thấy thay đổi gì', 1.0),                -- 13
  ROW('nghe mà vẫn thấy khó chịu', 1.0),             -- 14
  ROW('vẫn thấy căng thẳng', 1.0),                   -- 15
  ROW('nghe vậy mà không thấy an tâm', 0.95),        -- 16
  ROW('vẫn thấy rối', 0.95),                         -- 17
  ROW('không cảm thấy được an ủi', 1.0),             -- 18
  ROW('nghe mà vẫn thấy nặng đầu', 0.9),             -- 19
  ROW('vẫn chưa ổn hơn', 1.0),                       -- 20

  ROW('nghe vậy nhưng cảm giác không thay đổi', 1.0),-- 21
  ROW('vẫn thấy khó chịu trong lòng', 1.0),          -- 22
  ROW('không thấy bớt lo', 1.0),                     -- 23
  ROW('nghe mà vẫn thấy áp lực', 1.0),               -- 24
  ROW('vẫn cảm thấy tiêu cực', 1.0),                 -- 25
  ROW('nghe vậy mà không thấy dễ chịu', 1.0),        -- 26
  ROW('vẫn thấy căng', 0.95),                        -- 27
  ROW('không thấy được trấn an', 1.0),               -- 28
  ROW('nghe mà không thấy nhẹ lòng', 1.0),           -- 29
  ROW('vẫn cảm thấy không ổn', 1.0),                 -- 30

  ROW('nghe vậy nhưng không giúp giảm lo', 1.0),     -- 31
  ROW('vẫn thấy áp lực nhiều', 1.0),                 -- 32
  ROW('không cảm thấy được hiểu hơn', 1.0),          -- 33
  ROW('nghe vậy mà vẫn thấy tệ hơn mong đợi', 0.9), -- 34
  ROW('vẫn thấy mệt mỏi', 1.0),                      -- 35
  ROW('nghe mà không thấy đỡ căng', 1.0),            -- 36
  ROW('vẫn cảm thấy bế tắc', 0.95),                  -- 37
  ROW('không thấy dễ thở hơn', 1.0),                 -- 38
  ROW('nghe vậy mà cảm giác vẫn nặng', 1.0),         -- 39
  ROW('vẫn thấy không ổn chút nào', 1.0),            -- 40

  ROW('nghe nhưng không thấy tác động nhiều', 0.95), -- 41
  ROW('vẫn thấy tâm trạng thấp', 1.0),               -- 42
  ROW('không cảm thấy khá hơn', 1.0),                -- 43
  ROW('nghe mà vẫn thấy lo lắng', 1.0),              -- 44
  ROW('vẫn cảm thấy căng thẳng nhiều', 1.0),         -- 45
  ROW('không thấy được động viên', 1.0),             -- 46
  ROW('nghe vậy nhưng vẫn thấy nặng nề', 1.0),       -- 47
  ROW('vẫn cảm thấy áp lực trong đầu', 0.95),        -- 48
  ROW('không thấy nhẹ hơn', 1.0),                    -- 49
  ROW('nghe mà vẫn thấy khó chịu nhiều', 0.95),      -- 50

  ROW('vẫn chưa thấy khá lên', 1.0),                 -- 51
  ROW('nghe vậy mà vẫn thấy rối hơn', 0.9),          -- 52
  ROW('không thấy được xoa dịu', 1.0),               -- 53
  ROW('vẫn cảm thấy tiêu cực nhiều', 1.0),           -- 54
  ROW('nghe mà không thấy an tâm hơn', 1.0),         -- 55
  ROW('vẫn thấy mệt trong lòng', 0.95),              -- 56
  ROW('không cảm thấy ổn hơn chút nào', 1.0),        -- 57
  ROW('nghe vậy mà không thấy dễ chịu hơn', 1.0),   -- 58
  ROW('vẫn thấy áp lực không giảm', 1.0),            -- 59
  ROW('không thấy bớt nặng nề', 1.0),                -- 60

  ROW('nghe mà cảm giác vẫn vậy', 1.0),              -- 61
  ROW('vẫn thấy tâm trạng tệ', 1.0),                 -- 62
  ROW('không cảm thấy được giúp gì', 1.0),           -- 63
  ROW('nghe vậy mà không thấy thay đổi nhiều', 0.95),-- 64
  ROW('vẫn cảm thấy khó chịu nhiều', 1.0),           -- 65
  ROW('không thấy nhẹ lòng hơn', 1.0),               -- 66
  ROW('nghe mà vẫn thấy áp lực trong người', 0.95), -- 67
  ROW('vẫn thấy chưa ổn', 1.0),                      -- 68
  ROW('không cảm thấy được an ủi hơn', 1.0),         -- 69
  ROW('nghe vậy mà cảm giác không khá hơn', 1.0),    -- 70

  ROW('vẫn thấy tâm trạng nặng', 1.0),               -- 71
  ROW('không thấy được trấn an hơn', 1.0),           -- 72
  ROW('nghe mà không thấy dễ chịu mấy', 0.95),       -- 73
  ROW('vẫn cảm thấy nhiều áp lực', 1.0),             -- 74
  ROW('không thấy bớt căng thẳng', 1.0),             -- 75
  ROW('nghe vậy mà vẫn thấy khó ở', 0.9),            -- 76
  ROW('vẫn thấy không ổn hơn', 1.0),                 -- 77
  ROW('không cảm thấy được an tâm hơn chút nào', 1.0),-- 78
  ROW('nghe mà cảm giác vẫn nặng lòng', 1.0),        -- 79
  ROW('vẫn chưa thấy nhẹ hơn', 1.0),                 -- 80

  ROW('không thấy khá hơn chút nào', 1.0),           -- 81
  ROW('nghe vậy mà vẫn thấy mệt nhiều', 1.0),        -- 82
  ROW('vẫn cảm thấy áp lực y như cũ', 1.0),          -- 83
  ROW('không thấy được giúp đỡ nhiều', 0.95),        -- 84
  ROW('nghe mà vẫn thấy không ổn', 1.0),

  ROW('that does not really help', 1.0),              -- 1
  ROW('feels the same as before', 1.0),               -- 2
  ROW('still feels heavy', 1.0),                      -- 3
  ROW('that does not change much', 1.0),              -- 4
  ROW('still feels bad', 1.0),                        -- 5
  ROW('that does not make a difference', 1.0),       -- 6
  ROW('still feels overwhelming', 1.0),              -- 7
  ROW('does not feel better', 1.0),                   -- 8
  ROW('that does not ease anything', 1.0),           -- 9
  ROW('still feels stressful', 1.0),                 -- 10

  ROW('that does not really help much', 1.0),        -- 11
  ROW('still feels tense', 1.0),                     -- 12
  ROW('no real change in feeling', 1.0),             -- 13
  ROW('that does not feel comforting', 1.0),         -- 14
  ROW('still feels pressured', 1.0),                 -- 15
  ROW('that does not bring relief', 1.0),            -- 16
  ROW('still feels confusing', 0.95),                -- 17
  ROW('does not feel reassuring', 1.0),              -- 18
  ROW('that does not lighten anything', 1.0),        -- 19
  ROW('still does not feel okay', 1.0),               -- 20

  ROW('that does not really change things', 1.0),    -- 21
  ROW('still feels uncomfortable', 1.0),             -- 22
  ROW('does not reduce worry', 1.0),                  -- 23
  ROW('that does not calm anything', 1.0),           -- 24
  ROW('still feels negative', 1.0),                  -- 25
  ROW('that does not feel helpful', 1.0),            -- 26
  ROW('still feels tight inside', 0.95),             -- 27
  ROW('does not feel validating', 1.0),              -- 28
  ROW('that does not ease the weight', 1.0),         -- 29
  ROW('still feels off', 1.0),                        -- 30

  ROW('that does not lower anxiety', 1.0),           -- 31
  ROW('still feels like a lot', 1.0),                 -- 32
  ROW('does not feel understood', 1.0),              -- 33
  ROW('that does not help as hoped', 0.95),          -- 34
  ROW('still feels exhausting', 1.0),                -- 35
  ROW('that does not reduce tension', 1.0),          -- 36
  ROW('still feels stuck', 1.0),                     -- 37
  ROW('does not feel easier to breathe', 0.95),      -- 38
  ROW('that does not remove heaviness', 1.0),        -- 39
  ROW('still feels really bad', 1.0),                -- 40

  ROW('that has little effect', 0.95),               -- 41
  ROW('still feels low', 1.0),                        -- 42
  ROW('does not feel improved', 1.0),                -- 43
  ROW('that does not reduce stress', 1.0),           -- 44
  ROW('still feels very tense', 1.0),                -- 45
  ROW('does not feel encouraging', 1.0),             -- 46
  ROW('that does not ease discomfort', 1.0),         -- 47
  ROW('still feels pressured mentally', 0.95),      -- 48
  ROW('does not feel lighter', 1.0),                 -- 49
  ROW('that does not really comfort', 1.0),          -- 50

  ROW('still does not feel better', 1.0),            -- 51
  ROW('that makes things feel worse', 0.9),          -- 52
  ROW('does not feel soothing', 1.0),                -- 53
  ROW('still feels very negative', 1.0),             -- 54
  ROW('that does not bring calm', 1.0),              -- 55
  ROW('still feels emotionally tired', 0.95),       -- 56
  ROW('does not feel okay at all', 1.0),              -- 57
  ROW('that does not help emotionally', 1.0),        -- 58
  ROW('still feels pressured', 1.0),                 -- 59
  ROW('does not reduce heaviness', 1.0),              -- 60

  ROW('that changes nothing', 1.0),                  -- 61
  ROW('still feels really low', 1.0),                -- 62
  ROW('does not feel supported', 1.0),               -- 63
  ROW('that barely helps', 0.95),                    -- 64
  ROW('still feels uncomfortable emotionally', 1.0),-- 65
  ROW('does not feel relieving', 1.0),               -- 66
  ROW('that does not ease inner pressure', 1.0),     -- 67
  ROW('still does not feel settled', 1.0),           -- 68
  ROW('does not feel more reassuring', 1.0),         -- 69
  ROW('that does not help much at all', 1.0),        -- 70

  ROW('still feels emotionally heavy', 1.0),         -- 71
  ROW('does not feel calming', 1.0),                 -- 72
  ROW('that does not help much', 1.0),               -- 73
  ROW('still feels under pressure', 1.0),            -- 74
  ROW('does not reduce tension at all', 1.0),        -- 75
  ROW('that feels uncomfortable', 0.95),             -- 76
  ROW('still does not feel okay', 1.0),               -- 77
  ROW('does not bring reassurance', 1.0),            -- 78
  ROW('that does not ease emotional weight', 1.0),   -- 79
  ROW('still does not feel lighter', 1.0),           -- 80

  ROW('does not feel better at all', 1.0),            -- 81
  ROW('that does not help enough', 1.0),             -- 82
  ROW('still feels just as stressful', 1.0),         -- 83
  ROW('does not feel very helpful', 0.95),           -- 84
  ROW('that does not feel okay', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn nghe thêm câu khẳng định khác không', 1.0),
  ROW('cảm thấy khá hơn chưa', 0.8),
  ROW('nghe vậy có giúp nhẹ hơn một chút không', 1.0),        -- 1
  ROW('cảm xúc hiện tại có thay đổi gì không', 1.0),          -- 2
  ROW('điều đó có chạm đúng cảm giác đang có không', 0.95),  -- 3
  ROW('những lời vừa rồi có phần nào đúng không', 0.95),     -- 4
  ROW('có thấy dễ thở hơn một chút không', 0.9),              -- 5
  ROW('cảm giác trong người bây giờ thế nào', 0.95),         -- 6
  ROW('có điều gì còn đang nặng trong lòng không', 0.9),     -- 7
  ROW('vẫn còn điều gì khiến khó chịu không', 0.9),          -- 8
  ROW('nghe vậy có làm bớt căng thẳng không', 0.9),           -- 9
  ROW('cảm xúc hiện tại có ổn hơn không', 1.0),               -- 10
  ROW('có cần nói thêm một chút nữa không', 0.9),             -- 11
  ROW('vẫn còn suy nghĩ nào đang quay lại không', 0.85),     -- 12
  ROW('có điều gì muốn làm rõ thêm không', 0.85),             -- 13
  ROW('những cảm xúc này có còn mạnh không', 0.9),           -- 14
  ROW('cảm giác hiện tại có dễ chịu hơn không', 1.0),        -- 15
  ROW('có muốn dừng lại một chút để thở không', 0.85),       -- 16
  ROW('có cần một khoảnh khắc nghỉ ngơi không', 0.85),       -- 17
  ROW('vẫn còn áp lực nào đang tồn tại không', 0.9),         -- 18
  ROW('cảm giác này có đang dịu xuống không', 0.95),         -- 19
  ROW('nghe vậy có thấy được hiểu hơn không', 1.0),          -- 20
  ROW('có muốn chia sẻ thêm điều gì không', 0.9),            -- 21
  ROW('vẫn còn điều gì chưa nói ra không', 0.9),             -- 22
  ROW('cảm xúc này có đang ổn định hơn không', 0.95),        -- 23
  ROW('có cần một gợi ý nhẹ để tiếp tục không', 0.85),       -- 24
  ROW('hiện tại có cần làm gì thêm không', 0.85),            -- 25
  ROW('có muốn dành một chút thời gian cho bản thân không', 0.9), -- 26
  ROW('cảm giác lúc này có an toàn hơn không', 1.0),         -- 27
  ROW('có thấy bớt nặng nề hơn không', 0.95),                -- 28
  ROW('vẫn còn điều gì khiến lo lắng không', 0.9),           -- 29
  ROW('cảm xúc hiện tại có dễ kiểm soát hơn không', 0.85),  -- 30
  ROW('có muốn tiếp tục nói chuyện chậm rãi không', 0.9),    -- 31
  ROW('có cần một khoảng lặng ngắn không', 0.85),            -- 32
  ROW('cảm giác này có đang dần ổn hơn không', 0.95),        -- 33
  ROW('nghe vậy có làm nhẹ lòng hơn không', 1.0),            -- 34
  ROW('có muốn thử một điều nhỏ để thư giãn không', 0.85),  -- 35
  ROW('vẫn còn căng thẳng trong người không', 0.9),          -- 36
  ROW('cảm xúc này có đang bớt gay gắt không', 0.9),        -- 37
  ROW('có cần thêm một lời trấn an không', 0.85),            -- 38
  ROW('hiện tại có cảm thấy ổn hơn lúc đầu không', 1.0),    -- 39
  ROW('có muốn tiếp tục theo nhịp chậm không', 0.85),       -- 40
  ROW('cảm giác này có đang dịu đi không', 0.95),            -- 41
  ROW('vẫn còn điều gì làm tâm trí rối không', 0.9),         -- 42
  ROW('có cần thêm không gian để cảm nhận không', 0.85),    -- 43
  ROW('cảm xúc này có đang được lắng xuống không', 0.95),   -- 44
  ROW('có muốn dừng lại ở đây một chút không', 0.85),       -- 45
  ROW('nghe vậy có tạo cảm giác an toàn hơn không', 1.0),   -- 46
  ROW('vẫn còn cảm giác khó chịu nào không', 0.9),          -- 47
  ROW('có muốn thử tập trung vào hơi thở không', 0.85),     -- 48
  ROW('cảm xúc này có đang nhẹ hơn không', 1.0),            -- 49
  ROW('có muốn tiếp tục theo cách nhẹ nhàng không', 0.9),  -- 50
  ROW('cảm giác lúc này có dễ chịu hơn không', 1.0),        -- 51
  ROW('có cần thêm sự trấn an không', 0.85),                -- 52
  ROW('vẫn còn suy nghĩ nào làm khó chịu không', 0.9),     -- 53
  ROW('có muốn giữ nhịp chậm như vậy không', 0.85),         -- 54
  ROW('cảm xúc này có đang được xoa dịu không', 0.95),     -- 55
  ROW('có cần một gợi ý rất nhỏ không', 0.85),              -- 56
  ROW('cảm giác này có đang ổn dần không', 1.0),            -- 57
  ROW('có muốn tiếp tục nói thêm không', 0.9),              -- 58
  ROW('vẫn còn điều gì khiến khó yên không', 0.9),          -- 59
  ROW('có thấy bớt áp lực hơn không', 1.0),                 -- 60
  ROW('cảm xúc này có đang cân bằng hơn không', 0.95),     -- 61
  ROW('có cần nghỉ một nhịp không', 0.85),                  -- 62
  ROW('nghe vậy có giúp ổn định hơn không', 1.0),          -- 63
  ROW('vẫn còn căng thẳng nào không', 0.9),                 -- 64
  ROW('có muốn tiếp tục theo cảm giác hiện tại không', 0.85), -- 65
  ROW('cảm giác này có đang bớt nặng không', 0.95),        -- 66
  ROW('có cần thêm thời gian không', 0.85),                -- 67
  ROW('cảm xúc này có đang dễ chịu hơn không', 1.0),       -- 68
  ROW('có muốn thử một bước rất nhỏ không', 0.85),         -- 69
  ROW('vẫn còn điều gì chưa ổn không', 0.9),               -- 70
  ROW('cảm giác này có đang yên hơn không', 0.95),         -- 71
  ROW('có cần tiếp tục theo nhịp này không', 0.85),        -- 72
  ROW('nghe vậy có giúp bình tĩnh hơn không', 1.0),        -- 73
  ROW('vẫn còn điều gì làm tâm trí nặng không', 0.9),      -- 74
  ROW('cảm xúc này có đang ổn lại không', 1.0),            -- 75
  ROW('có muốn ở lại cảm giác này một chút không', 0.85), -- 76
  ROW('có cần thêm sự nhẹ nhàng không', 0.85),             -- 77
  ROW('cảm giác này có đang được nâng đỡ không', 0.95),   -- 78
  ROW('vẫn còn điều gì khiến bất an không', 0.9),          -- 79
  ROW('có thấy dễ chịu hơn so với trước không', 1.0),     -- 80
  ROW('cảm xúc này có đang ổn định hơn không', 1.0),      -- 81
  ROW('có cần tiếp tục nhẹ nhàng không', 0.85),           -- 82
  ROW('nghe vậy có giúp an tâm hơn không', 1.0),           -- 83
  ROW('vẫn còn cảm giác nặng nề không', 0.9),             -- 84
  ROW('có muốn tiếp tục khi đã sẵn sàng không', 0.85),

  ROW('does that feel a little lighter now', 1.0),        -- 1
  ROW('does that make sense emotionally', 1.0),           -- 2
  ROW('does this feel closer to what is happening', 0.95),-- 3
  ROW('does that land in a helpful way', 0.95),           -- 4
  ROW('does the feeling seem less intense now', 0.9),    -- 5
  ROW('how does the body feel right now', 0.95),          -- 6
  ROW('is anything still weighing heavily', 0.9),        -- 7
  ROW('is there any lingering tension', 0.9),            -- 8
  ROW('does that reduce some pressure', 0.9),            -- 9
  ROW('does the emotion feel steadier', 1.0),             -- 10
  ROW('would it help to share a bit more', 0.9),          -- 11
  ROW('is anything still looping in the mind', 0.85),    -- 12
  ROW('does anything need clarification', 0.85),         -- 13
  ROW('does the feeling still feel strong', 0.9),        -- 14
  ROW('does this feel more manageable now', 1.0),        -- 15
  ROW('would a brief pause help', 0.85),                  -- 16
  ROW('would a moment of rest help', 0.85),               -- 17
  ROW('is there still some pressure present', 0.9),      -- 18
  ROW('does the feeling seem to be easing', 0.95),       -- 19
  ROW('does this feel more understood', 1.0),             -- 20
  ROW('would it help to continue slowly', 0.9),          -- 21
  ROW('is there anything left unsaid', 0.9),             -- 22
  ROW('does the emotion feel more settled', 0.95),       -- 23
  ROW('would a gentle suggestion be okay', 0.85),        -- 24
  ROW('is there anything needed right now', 0.85),       -- 25
  ROW('would some personal space help', 0.9),             -- 26
  ROW('does the situation feel safer now', 1.0),          -- 27
  ROW('does this feel less heavy', 0.95),                -- 28
  ROW('is there any remaining worry', 0.9),              -- 29
  ROW('does the emotion feel easier to handle', 0.85),   -- 30
  ROW('would continuing gently feel okay', 0.9),         -- 31
  ROW('would a short pause help', 0.85),                  -- 32
  ROW('does this feel more stable', 0.95),               -- 33
  ROW('does this feel reassuring', 1.0),                 -- 34
  ROW('would a small calming step help', 0.85),          -- 35
  ROW('is there tension still present', 0.9),            -- 36
  ROW('does the emotion feel less sharp', 0.9),          -- 37
  ROW('would extra reassurance help', 0.85),             -- 38
  ROW('does this feel better than before', 1.0),         -- 39
  ROW('would keeping this pace help', 0.85),             -- 40
  ROW('does the feeling continue to soften', 0.95),      -- 41
  ROW('is anything still mentally heavy', 0.9),          -- 42
  ROW('would more space help', 0.85),                     -- 43
  ROW('does the emotion feel quieter', 0.95),            -- 44
  ROW('would it help to pause here briefly', 0.85),      -- 45
  ROW('does this feel more grounding', 1.0),             -- 46
  ROW('is there lingering discomfort', 0.9),             -- 47
  ROW('would focusing on breathing help', 0.85),         -- 48
  ROW('does this feel lighter overall', 1.0),            -- 49
  ROW('would continuing gently feel supportive', 0.9),  -- 50
  ROW('does the body feel more at ease', 1.0),            -- 51
  ROW('would more reassurance help', 0.85),              -- 52
  ROW('is there a thought still bothering', 0.9),        -- 53
  ROW('would keeping things slow help', 0.85),           -- 54
  ROW('does the emotion feel soothed', 0.95),            -- 55
  ROW('would a very small suggestion help', 0.85),       -- 56
  ROW('does this feel more okay now', 1.0),               -- 57
  ROW('would sharing more feel helpful', 0.9),           -- 58
  ROW('is there any lingering unease', 0.9),             -- 59
  ROW('does this feel less pressured', 1.0),             -- 60
  ROW('does the emotion feel more balanced', 0.95),      -- 61
  ROW('would a brief rest help', 0.85),                   -- 62
  ROW('does this help things settle', 1.0),              -- 63
  ROW('is there any remaining tension', 0.9),            -- 64
  ROW('would continuing at this pace help', 0.85),       -- 65
  ROW('does the feeling feel lighter', 0.95),            -- 66
  ROW('would more time help', 0.85),                      -- 67
  ROW('does this feel more comfortable', 1.0),           -- 68
  ROW('would trying a tiny step help', 0.85),            -- 69
  ROW('is anything still unsettled', 0.9),               -- 70
  ROW('does the feeling feel calmer', 0.95),             -- 71
  ROW('would continuing gently help', 0.85),             -- 72
  ROW('does this feel calming', 1.0),                    -- 73
  ROW('is there anything still heavy mentally', 0.9),   -- 74
  ROW('does this feel more stable now', 1.0),            -- 75
  ROW('would staying here briefly help', 0.85),         -- 76
  ROW('would more gentleness help', 0.85),               -- 77
  ROW('does this feel supportive', 0.95),                -- 78
  ROW('is there lingering uneasiness', 0.9),             -- 79
  ROW('does this feel better than earlier', 1.0),       -- 80
  ROW('does the emotion feel steadier now', 1.0),        -- 81
  ROW('would continuing gently feel okay', 0.85),        -- 82
  ROW('does this feel reassuring overall', 1.0),        -- 83
  ROW('is there any remaining heaviness', 0.9),         -- 84
  ROW('would continuing when ready feel right', 0.85)  -- 85
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='info_affirmation'
ON CONFLICT DO NOTHING;

-------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('không biết bản thân có giá trị không', 1.0),            -- 1
  ROW('cảm thấy bản thân không có giá trị', 1.0),             -- 2
  ROW('không thấy mình quan trọng', 0.95),                    -- 3
  ROW('không rõ bản thân có ý nghĩa gì', 0.95),               -- 4
  ROW('cảm giác không có ích', 1.0),                           -- 5
  ROW('không biết mình có đáng không', 1.0),                  -- 6
  ROW('cảm thấy vô dụng', 1.0),                                -- 7
  ROW('không thấy bản thân có ích gì', 0.95),                 -- 8
  ROW('cảm giác không có giá trị gì', 1.0),                   -- 9
  ROW('không thấy mình có ý nghĩa', 1.0),                     -- 10

  ROW('tự hỏi bản thân có quan trọng không', 0.95),           -- 11
  ROW('cảm thấy không đáng được quan tâm', 1.0),              -- 12
  ROW('không biết mình có đáng tồn tại không', 0.9),          -- 13
  ROW('cảm giác không xứng đáng', 1.0),                       -- 14
  ROW('không thấy bản thân có đóng góp gì', 0.95),            -- 15
  ROW('cảm thấy mình không đủ tốt', 1.0),                     -- 16
  ROW('tự hỏi mình có ý nghĩa gì với người khác không', 0.9), -- 17
  ROW('cảm giác không được cần đến', 1.0),                    -- 18
  ROW('không thấy mình có vai trò gì', 0.95),                 -- 19
  ROW('cảm thấy bản thân thừa thãi', 1.0),                    -- 20

  ROW('không biết mình có đáng được yêu quý không', 0.95),    -- 21
  ROW('cảm giác không quan trọng với ai', 1.0),               -- 22
  ROW('tự hỏi mình có giá trị gì không', 1.0),                -- 23
  ROW('không thấy lý do để tự hào về bản thân', 0.95),        -- 24
  ROW('cảm thấy không có gì đặc biệt', 0.9),                  -- 25
  ROW('không biết bản thân có đáng không', 1.0),              -- 26
  ROW('cảm giác không có vị trí', 0.95),                      -- 27
  ROW('không thấy mình có ý nghĩa lâu dài', 0.9),             -- 28
  ROW('cảm thấy bản thân không quan trọng', 1.0),             -- 29
  ROW('không rõ mình có giá trị ở đâu', 0.95),                -- 30

  ROW('cảm giác không mang lại lợi ích gì', 0.95),            -- 31
  ROW('không thấy bản thân đáng được ghi nhận', 1.0),        -- 32
  ROW('tự hỏi mình có đáng được tôn trọng không', 0.95),     -- 33
  ROW('cảm thấy bản thân không có tiếng nói', 0.9),           -- 34
  ROW('không thấy giá trị của bản thân', 1.0),                -- 35
  ROW('cảm giác không có gì để đóng góp', 1.0),               -- 36
  ROW('không thấy mình mang lại điều tích cực', 0.95),       -- 37
  ROW('cảm thấy bản thân không đủ quan trọng', 1.0),         -- 38
  ROW('không biết mình có đáng để cố gắng không', 0.9),      -- 39
  ROW('cảm giác bản thân không có ý nghĩa nhiều', 0.95),     -- 40

  ROW('không thấy bản thân được coi trọng', 1.0),             -- 41
  ROW('cảm giác không có giá trị lâu dài', 0.9),             -- 42
  ROW('tự hỏi bản thân có đáng được lắng nghe không', 0.95), -- 43
  ROW('không thấy mình có tầm quan trọng', 1.0),             -- 44
  ROW('cảm thấy bản thân không có ích lợi', 1.0),            -- 45
  ROW('không biết mình có ý nghĩa gì trong cuộc sống này', 0.9), -- 46
  ROW('cảm giác không được đánh giá cao', 0.95),             -- 47
  ROW('không thấy bản thân có giá trị rõ ràng', 1.0),        -- 48
  ROW('cảm thấy mình không xứng đáng với điều tốt', 1.0),   -- 49
  ROW('không rõ mình có giá trị thật sự không', 1.0),        -- 50

  ROW('cảm giác không có điều gì đáng kể', 0.9),             -- 51
  ROW('không thấy bản thân có vai trò quan trọng', 1.0),    -- 52
  ROW('tự hỏi mình có đáng được công nhận không', 0.95),    -- 53
  ROW('cảm thấy bản thân không có giá trị riêng', 0.95),    -- 54
  ROW('không biết mình có ý nghĩa với ai không', 0.9),      -- 55
  ROW('cảm giác không có gì để tự tin', 0.95),              -- 56
  ROW('không thấy bản thân mang lại giá trị', 1.0),         -- 57
  ROW('cảm thấy mình không quan trọng trong bức tranh chung', 0.9), -- 58
  ROW('không rõ giá trị bản thân nằm ở đâu', 1.0),          -- 59
  ROW('cảm giác không được cần thiết', 1.0),                -- 60

  ROW('không thấy bản thân có ý nghĩa thực sự', 1.0),       -- 61
  ROW('tự hỏi mình có đáng tồn tại không', 0.9),            -- 62
  ROW('cảm thấy bản thân không có giá trị nội tại', 1.0),  -- 63
  ROW('không thấy mình mang lại điều gì quan trọng', 0.95),-- 64
  ROW('cảm giác không xứng đáng với sự quan tâm', 1.0),    -- 65
  ROW('không biết mình có giá trị với người khác không', 0.95), -- 66
  ROW('cảm thấy bản thân không có giá trị riêng biệt', 0.95), -- 67
  ROW('không thấy lý do để tin vào giá trị bản thân', 1.0),-- 68
  ROW('cảm giác không đủ ý nghĩa', 1.0),                    -- 69
  ROW('không rõ bản thân có đáng hay không', 1.0),          -- 70

  ROW('cảm thấy bản thân không có gì nổi bật', 0.9),        -- 71
  ROW('không thấy mình có giá trị rõ rệt', 1.0),            -- 72
  ROW('tự hỏi bản thân có đáng được coi trọng không', 0.95),-- 73
  ROW('cảm giác không có chỗ đứng', 0.95),                 -- 74
  ROW('không thấy bản thân mang lại ý nghĩa', 1.0),        -- 75
  ROW('cảm thấy mình không quan trọng lắm', 0.95),         -- 76
  ROW('không biết giá trị của bản thân là gì', 1.0),       -- 77
  ROW('cảm giác bản thân không được cần đến', 1.0),        -- 78
  ROW('không thấy mình có giá trị đáng kể', 1.0),          -- 79
  ROW('cảm thấy bản thân không có ý nghĩa nhiều lắm', 0.95),-- 80

  ROW('không rõ mình có giá trị gì trong cuộc sống', 1.0), -- 81
  ROW('cảm giác không đủ quan trọng để được chú ý', 1.0), -- 82
  ROW('không thấy bản thân có giá trị bền vững', 0.9),    -- 83
  ROW('cảm thấy bản thân không đáng kể', 1.0),            -- 84
  ROW('không biết bản thân có giá trị thật không', 1.0),  -- 85

  ROW('not sure if there is any value here', 1.0),         -- 1
  ROW('feels like no real worth', 1.0),                    -- 2
  ROW('does not feel important', 0.95),                   -- 3
  ROW('questioning personal value', 1.0),                 -- 4
  ROW('feels useless', 1.0),                               -- 5
  ROW('not sure if worth anything', 1.0),                  -- 6
  ROW('feels like no contribution', 0.95),                -- 7
  ROW('no sense of usefulness', 1.0),                      -- 8
  ROW('feels unimportant', 1.0),                           -- 9
  ROW('uncertain about personal worth', 1.0),             -- 10

  ROW('questioning if value exists', 1.0),                -- 11
  ROW('feels like not needed', 1.0),                       -- 12
  ROW('not feeling worthwhile', 1.0),                      -- 13
  ROW('feels insignificant', 1.0),                         -- 14
  ROW('no sense of meaning', 1.0),                          -- 15
  ROW('feels like no role', 0.95),                          -- 16
  ROW('questioning importance', 0.95),                     -- 17
  ROW('feels replaceable', 1.0),                            -- 18
  ROW('no clear purpose felt', 0.95),                      -- 19
  ROW('feels like not enough', 1.0),                       -- 20

  ROW('questioning self worth', 1.0),                      -- 21
  ROW('feels like no value to others', 0.95),              -- 22
  ROW('not feeling meaningful', 1.0),                      -- 23
  ROW('feels undeserving', 1.0),                           -- 24
  ROW('no sense of importance', 1.0),                      -- 25
  ROW('feels like nothing special', 0.9),                  -- 26
  ROW('uncertain about being valuable', 1.0),              -- 27
  ROW('feels overlooked', 0.95),                            -- 28
  ROW('no clear worth felt', 1.0),                          -- 29
  ROW('feels unnecessary', 1.0),                           -- 30

  ROW('questioning personal significance', 0.95),          -- 31
  ROW('feels like no impact', 1.0),                         -- 32
  ROW('not sure if valued', 1.0),                           -- 33
  ROW('feels undervalued', 1.0),                            -- 34
  ROW('no sense of contribution', 1.0),                    -- 35
  ROW('feels unworthy', 1.0),                               -- 36
  ROW('questioning own importance', 1.0),                  -- 37
  ROW('feels like no place', 0.95),                         -- 38
  ROW('uncertain about meaning', 1.0),                     -- 39
  ROW('feels like no real purpose', 1.0),                  -- 40

  ROW('feels like not valued enough', 1.0),                -- 41
  ROW('no feeling of worthiness', 1.0),                    -- 42
  ROW('questioning if value exists at all', 0.9),          -- 43
  ROW('feels insignificant overall', 1.0),                -- 44
  ROW('no sense of being needed', 1.0),                    -- 45
  ROW('uncertain about personal meaning', 1.0),            -- 46
  ROW('feels unimportant overall', 1.0),                   -- 47
  ROW('no clear sense of value', 1.0),                     -- 48
  ROW('feels undeserving of good things', 1.0),            -- 49
  ROW('questioning if worthwhile', 1.0),                   -- 50

  ROW('feels like nothing matters personally', 0.9),      -- 51
  ROW('no sense of significance felt', 1.0),               -- 52
  ROW('questioning if deserving recognition', 0.95),      -- 53
  ROW('feels like no inherent value', 1.0),                -- 54
  ROW('uncertain if meaningful to anyone', 0.95),         -- 55
  ROW('feels like no confidence in worth', 0.95),          -- 56
  ROW('no feeling of being valuable', 1.0),                -- 57
  ROW('feels small in the bigger picture', 0.9),           -- 58
  ROW('questioning where value comes from', 1.0),          -- 59
  ROW('feels unnecessary overall', 1.0),                  -- 60

  ROW('no sense of real meaning', 1.0),                    -- 61
  ROW('questioning right to exist', 0.9),                  -- 62
  ROW('feels no inner worth', 1.0),                        -- 63
  ROW('no feeling of being important', 1.0),               -- 64
  ROW('feels undeserving of attention', 1.0),              -- 65
  ROW('questioning value to others', 0.95),                -- 66
  ROW('feels no unique value', 1.0),                       -- 67
  ROW('no reason felt to believe in worth', 1.0),          -- 68
  ROW('feels lacking meaning', 1.0),                       -- 69
  ROW('uncertain if truly valuable', 1.0),                 -- 70

  ROW('feels unremarkable', 0.9),                          -- 71
  ROW('no strong sense of value', 1.0),                    -- 72
  ROW('questioning if deserving respect', 0.95),          -- 73
  ROW('feels like no place exists', 0.95),                 -- 74
  ROW('no sense of personal meaning', 1.0),                -- 75
  ROW('feels not very important', 0.95),                   -- 76
  ROW('uncertain about own value', 1.0),                   -- 77
  ROW('feels not needed by others', 1.0),                  -- 78
  ROW('no significant value felt', 1.0),                   -- 79
  ROW('feels only slightly meaningful', 0.95),             -- 80

  ROW('questioning value in life overall', 1.0),           -- 81
  ROW('feels not important enough', 1.0),                  -- 82
  ROW('no sense of lasting value', 0.9),                   -- 83
  ROW('feels insignificant personally', 1.0),             -- 84
  ROW('uncertain if value is real', 1.0) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('nhận ra giá trị', 1.0),
  ROW('cảm thấy tự tin hơn', 0.9),
  ROW('bắt đầu thấy bản thân có giá trị hơn', 1.0),          -- 1
  ROW('cảm thấy bản thân có ý nghĩa', 1.0),                 -- 2
  ROW('nhận ra bản thân cũng quan trọng', 1.0),             -- 3
  ROW('thấy rõ hơn điều quan trọng với bản thân', 1.0),     -- 4
  ROW('cảm thấy có giá trị riêng', 1.0),                    -- 5
  ROW('bắt đầu trân trọng bản thân hơn', 1.0),              -- 6
  ROW('thấy bản thân không vô dụng như nghĩ', 1.0),         -- 7
  ROW('cảm giác có vai trò nhất định', 0.95),               -- 8
  ROW('nhận ra bản thân cũng đáng được quan tâm', 1.0),     -- 9
  ROW('thấy rõ điểm mạnh của bản thân', 1.0),               -- 10

  ROW('cảm thấy bản thân có ích', 1.0),                     -- 11
  ROW('nhận ra bản thân có điều đáng giá', 1.0),            -- 12
  ROW('thấy mình có đóng góp', 1.0),                        -- 13
  ROW('cảm thấy có ý nghĩa hơn', 1.0),                      -- 14
  ROW('bắt đầu thấy tự tin hơn', 1.0),                      -- 15
  ROW('nhận ra bản thân không vô hình', 0.95),              -- 16
  ROW('thấy rõ giá trị cá nhân hơn', 1.0),                  -- 17
  ROW('cảm giác bản thân quan trọng với ai đó', 1.0),      -- 18
  ROW('nhận ra bản thân có điểm tốt', 1.0),                 -- 19
  ROW('thấy mình đáng được tôn trọng', 1.0),               -- 20

  ROW('cảm thấy bản thân xứng đáng hơn', 1.0),              -- 21
  ROW('nhận ra bản thân không hề vô nghĩa', 1.0),           -- 22
  ROW('thấy có điều để tự hào', 1.0),                       -- 23
  ROW('cảm giác có mục tiêu rõ hơn', 0.95),                 -- 24
  ROW('thấy giá trị bản thân rõ ràng hơn', 1.0),            -- 25
  ROW('bắt đầu tin vào bản thân hơn', 1.0),                 -- 26
  ROW('cảm thấy bản thân có ý nghĩa với cuộc sống', 1.0),  -- 27
  ROW('nhận ra bản thân có chỗ đứng', 1.0),                 -- 28
  ROW('thấy rõ điều quan trọng trong cuộc sống', 0.95),    -- 29
  ROW('cảm giác bản thân đáng được lắng nghe', 1.0),       -- 30

  ROW('thấy bản thân không hề thừa thãi', 1.0),              -- 31
  ROW('nhận ra bản thân có giá trị nội tại', 1.0),          -- 32
  ROW('cảm thấy có định hướng hơn', 0.95),                  -- 33
  ROW('thấy bản thân có ý nghĩa với người khác', 1.0),     -- 34
  ROW('nhận ra giá trị không chỉ đến từ kết quả', 0.9),    -- 35
  ROW('cảm giác bản thân đủ tốt', 1.0),                     -- 36
  ROW('thấy rõ điều bản thân coi trọng', 1.0),              -- 37
  ROW('bắt đầu chấp nhận bản thân hơn', 1.0),               -- 38
  ROW('cảm thấy bản thân có giá trị lâu dài', 0.95),       -- 39
  ROW('nhận ra bản thân cũng xứng đáng với điều tốt', 1.0),-- 40

  ROW('thấy mình không hề vô dụng', 1.0),                   -- 41
  ROW('cảm giác có lý do để cố gắng', 1.0),                 -- 42
  ROW('nhận ra bản thân có điểm riêng', 1.0),               -- 43
  ROW('thấy giá trị không bị mất đi', 0.95),               -- 44
  ROW('cảm thấy bản thân đáng kể hơn', 1.0),               -- 45
  ROW('bắt đầu nhìn nhận bản thân tích cực hơn', 1.0),     -- 46
  ROW('nhận ra bản thân cũng quan trọng theo cách riêng', 1.0), -- 47
  ROW('thấy bản thân có giá trị dù chưa hoàn hảo', 1.0),   -- 48
  ROW('cảm giác có ý nghĩa ngay lúc này', 0.95),           -- 49
  ROW('nhận ra giá trị không cần so sánh', 0.9),           -- 50

  ROW('thấy bản thân có điều để giữ gìn', 0.95),           -- 51
  ROW('cảm giác bản thân có ích theo cách riêng', 1.0),   -- 52
  ROW('nhận ra bản thân không cần phải chứng minh', 0.9), -- 53
  ROW('thấy rõ điều bản thân trân trọng', 1.0),            -- 54
  ROW('cảm thấy bản thân đáng được quan tâm hơn', 1.0),   -- 55
  ROW('bắt đầu thấy ý nghĩa trong những việc nhỏ', 0.95),-- 56
  ROW('nhận ra bản thân có giá trị dù còn đang học hỏi', 1.0), -- 57
  ROW('thấy bản thân không bị bỏ quên', 0.95),             -- 58
  ROW('cảm giác có điều quan trọng để hướng tới', 1.0),   -- 59
  ROW('nhận ra bản thân có nền tảng giá trị riêng', 1.0), -- 60

  ROW('thấy bản thân không còn vô nghĩa như trước', 1.0), -- 61
  ROW('cảm thấy bản thân có trọng lượng hơn', 0.95),     -- 62
  ROW('nhận ra bản thân đáng được tôn trọng hơn', 1.0),  -- 63
  ROW('thấy rõ điều làm bản thân có ý nghĩa', 1.0),       -- 64
  ROW('cảm giác bản thân có lý do để tồn tại', 0.95),     -- 65
  ROW('nhận ra bản thân có giá trị dù còn thiếu sót', 1.0),-- 66
  ROW('thấy bản thân không chỉ là gánh nặng', 1.0),       -- 67
  ROW('cảm thấy có giá trị từ bên trong', 1.0),           -- 68
  ROW('nhận ra bản thân có điều quan trọng cần giữ', 0.95),-- 69
  ROW('thấy bản thân xứng đáng được công nhận', 1.0),    -- 70

  ROW('cảm giác bản thân có ý nghĩa thật sự', 1.0),       -- 71
  ROW('nhận ra giá trị không biến mất', 1.0),              -- 72
  ROW('thấy bản thân đáng được trân trọng', 1.0),         -- 73
  ROW('cảm thấy có nền tảng giá trị vững hơn', 0.95),     -- 74
  ROW('nhận ra bản thân có giá trị bền vững', 1.0),       -- 75
  ROW('thấy bản thân có điều quan trọng để đóng góp', 1.0),-- 76
  ROW('cảm giác bản thân không còn trống rỗng', 0.95),    -- 77
  ROW('nhận ra bản thân có ý nghĩa theo cách riêng', 1.0),-- 78
  ROW('thấy giá trị bản thân rõ ràng hơn trước', 1.0),    -- 79
  ROW('cảm thấy bản thân đáng giá hơn', 1.0),             -- 80

  ROW('nhận ra bản thân không hề vô giá trị', 1.0),       -- 81
  ROW('thấy rõ điều bản thân coi trọng nhất', 1.0),       -- 82
  ROW('cảm giác có hướng đi rõ hơn', 0.95),               -- 83
  ROW('nhận ra bản thân có điều đáng giữ gìn', 0.95),     -- 84
  ROW('thấy bản thân có giá trị thật sự', 1.0),

  ROW('starting to feel more valuable', 1.0),             -- 1
  ROW('feels a sense of self worth', 1.0),                 -- 2
  ROW('realizing personal value', 1.0),                    -- 3
  ROW('feels more meaningful', 1.0),                       -- 4
  ROW('starting to feel important', 1.0),                  -- 5
  ROW('recognizing inner value', 1.0),                     -- 6
  ROW('feels worth something', 1.0),                       -- 7
  ROW('gaining a sense of purpose', 1.0),                  -- 8
  ROW('feels more confident', 1.0),                        -- 9
  ROW('realizing strengths', 1.0),                          -- 10
  ROW('feels useful', 1.0),                                -- 11
  ROW('recognizing personal importance', 1.0),             -- 12
  ROW('feels meaningful to others', 1.0),                  -- 13
  ROW('starting to value self', 1.0),                      -- 14
  ROW('feels worthy', 1.0),                                 -- 15
  ROW('realizing value exists', 1.0),                      -- 16
  ROW('feels like having a role', 0.95),                   -- 17
  ROW('starting to believe in value', 1.0),                -- 18
  ROW('feels respected', 1.0),                              -- 19
  ROW('recognizing personal worth', 1.0),                  -- 20
  ROW('feels deserving', 1.0),                              -- 21
  ROW('realizing not meaningless', 1.0),                   -- 22
  ROW('feels proud of something', 1.0),                    -- 23
  ROW('gaining clarity on values', 1.0),                   -- 24
  ROW('feels more grounded', 0.95),                        -- 25
  ROW('starting to trust self', 1.0),                      -- 26
  ROW('feels life has meaning', 1.0),                      -- 27
  ROW('realizing having a place', 1.0),                    -- 28
  ROW('feels values are clearer', 1.0),                    -- 29
  ROW('feels heard', 1.0),                                  -- 30
  ROW('realizing not useless', 1.0),                        -- 31
  ROW('feels direction emerging', 0.95),                   -- 32
  ROW('recognizing inner worth', 1.0),                     -- 33
  ROW('feels valued', 1.0),                                 -- 34
  ROW('understanding value beyond results', 0.9),         -- 35
  ROW('feels good enough', 1.0),                            -- 36
  ROW('clarifying what matters', 1.0),                     -- 37
  ROW('starting to accept self', 1.0),                     -- 38
  ROW('feels long term value', 0.95),                      -- 39
  ROW('realizing deserving good things', 1.0),             -- 40
  ROW('feels not a burden', 1.0),                           -- 41
  ROW('finding reason to keep going', 1.0),                -- 42
  ROW('recognizing uniqueness', 1.0),                      -- 43
  ROW('feels value remains', 0.95),                        -- 44
  ROW('feels more significant', 1.0),                      -- 45
  ROW('thinking more positively', 1.0),                    -- 46
  ROW('realizing importance in own way', 1.0),             -- 47
  ROW('feels valuable even imperfect', 1.0),               -- 48
  ROW('feels meaning right now', 0.95),                    -- 49
  ROW('understanding value without comparison', 0.9),     -- 50
  ROW('feels something worth protecting', 0.95),           -- 51
  ROW('recognizing personal contribution', 1.0),           -- 52
  ROW('feels no need to prove worth', 0.9),                -- 53
  ROW('clarifying core values', 1.0),                      -- 54
  ROW('feels deserving of care', 1.0),                     -- 55
  ROW('finding meaning in small things', 0.95),            -- 56
  ROW('feels valuable while learning', 1.0),               -- 57
  ROW('feels not forgotten', 0.95),                        -- 58
  ROW('feels something important ahead', 1.0),             -- 59
  ROW('recognizing value foundation', 1.0),                -- 60
  ROW('feels less meaningless', 1.0),                      -- 61
  ROW('feels more solid inside', 0.95),                    -- 62
  ROW('feels more respected', 1.0),                        -- 63
  ROW('understanding what gives meaning', 1.0),            -- 64
  ROW('feels reason to exist', 0.95),                      -- 65
  ROW('feels worthy despite flaws', 1.0),                  -- 66
  ROW('feels not just a burden', 1.0),                     -- 67
  ROW('feels inner value', 1.0),                            -- 68
  ROW('recognizing something important within', 0.95),    -- 69
  ROW('feels deserving recognition', 1.0),                 -- 70
  ROW('feels truly meaningful', 1.0),                      -- 71
  ROW('realizing value does not disappear', 1.0),          -- 72
  ROW('feels appreciated', 1.0),                            -- 73
  ROW('feels values more stable', 0.95),                   -- 74
  ROW('feels lasting value', 1.0),                          -- 75
  ROW('recognizing something to contribute', 1.0),         -- 76
  ROW('feels less empty', 0.95),                            -- 77
  ROW('recognizing meaning in own way', 1.0),              -- 78
  ROW('feels value more clearly', 1.0),                     -- 79
  ROW('feels more worthwhile', 1.0),                        -- 80
  ROW('realizing not worthless', 1.0),                     -- 81
  ROW('clarifying what matters most', 1.0),                -- 82
  ROW('feels clearer direction', 0.95),                    -- 83
  ROW('recognizing something worth holding onto', 0.95),  -- 84
  ROW('feels genuine self worth', 1.0) 
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('vẫn nghi ngờ bản thân', 0.9),
  ROW('không cảm thấy giá trị', 0.8),
  ROW('cảm thấy không có giá trị', 1.0),
  ROW('không thấy bản thân quan trọng', 1.0),
  ROW('cảm giác bản thân vô nghĩa', 0.95),
  ROW('không thấy giá trị cá nhân', 1.0),
  ROW('cảm giác bản thân không đáng kể', 1.0),
  ROW('không thấy điểm mạnh nào', 0.95),
  ROW('cảm giác kém cỏi', 1.0),
  ROW('không thấy tự hào về bản thân', 0.95),
  ROW('cảm giác thua kém', 0.9),
  ROW('không cảm nhận được sự tự tin', 0.95),
  ROW('cảm giác bị bỏ qua', 0.9),
  ROW('không thấy bản thân được coi trọng', 1.0),
  ROW('cảm giác bị xem nhẹ', 0.9),
  ROW('không cảm nhận được sự công nhận', 1.0),
  ROW('cảm giác không được trân trọng', 1.0),
  ROW('cảm giác bản thân không đủ tốt', 1.0),
  ROW('không thấy bản thân xứng đáng', 1.0),
  ROW('cảm giác không đạt kỳ vọng', 0.9),
  ROW('không thấy bản thân có ích', 1.0),
  ROW('cảm giác bản thân chỉ là gánh nặng', 1.0),
  ROW('không thấy ý nghĩa của bản thân', 1.0),
  ROW('cảm giác tồn tại không quan trọng', 1.0),
  ROW('không thấy lý do để tự tin', 0.95),
  ROW('cảm giác bản thân mờ nhạt', 0.9),
  ROW('không cảm nhận được giá trị nội tại', 1.0),
  ROW('cảm giác thất vọng về bản thân', 0.95),
  ROW('không thấy bản thân đủ giỏi', 1.0),
  ROW('cảm giác tự ti', 1.0),
  ROW('không thấy điểm gì đáng quý', 0.95),
  ROW('cảm giác bản thân yếu kém', 1.0),
  ROW('cảm giác bị tụt lại', 0.9),
  ROW('không thấy bản thân có chỗ đứng', 1.0),
  ROW('cảm giác giá trị bản thân thấp', 1.0),
  ROW('không cảm nhận được sự tự trọng', 1.0),
  ROW('cảm giác bản thân không đủ quan trọng', 1.0),
  ROW('không thấy bản thân có tiếng nói', 0.9),
  ROW('cảm giác không được lắng nghe', 0.95),
  ROW('không cảm nhận được ảnh hưởng tích cực', 0.9),
  ROW('cảm giác bản thân không tạo ra giá trị', 1.0),
  ROW('không thấy bản thân có đóng góp', 0.95),
  ROW('cảm giác bản thân không cần thiết', 1.0),
  ROW('không thấy ý nghĩa lâu dài', 0.9),
  ROW('cảm giác bản thân dễ bị thay thế', 0.9),
  ROW('không cảm nhận được sự tự tôn', 1.0),
  ROW('cảm giác bản thân không đáng được quan tâm', 1.0),
  ROW('cảm giác bản thân không đủ năng lực', 1.0),
  ROW('không thấy giá trị riêng', 1.0),
  ROW('cảm giác bản thân lép vế', 0.9),
  ROW('không cảm nhận được sự tự hào cá nhân', 0.95),
  ROW('cảm giác bản thân kém hơn người khác', 0.95),
  ROW('cảm giác bản thân không có vai trò', 0.9),
  ROW('không thấy sự hiện diện có ý nghĩa', 1.0),
  ROW('cảm giác bản thân không đủ xứng đáng', 1.0),
  ROW('không cảm nhận được sự công bằng cho bản thân', 0.9),
  ROW('cảm giác bản thân không có giá trị lâu dài', 0.9),
  ROW('cảm giác bản thân không được ghi nhận', 1.0),
  ROW('không thấy bản thân có điểm tựa', 0.9),
  ROW('cảm giác giá trị cá nhân mong manh', 0.9),
  ROW('không cảm nhận được sự ổn định về giá trị', 0.9),
  ROW('cảm giác bản thân dễ bị phủ nhận', 0.9),
  ROW('không thấy bản thân đủ quan trọng để được chú ý', 1.0),
  ROW('cảm giác bản thân không đáng được ưu tiên', 1.0),
  ROW('không cảm nhận được sự tự tin nội tâm', 0.95),
  ROW('cảm giác bản thân không có gì nổi bật', 0.9),
  ROW('không thấy bản thân có sức ảnh hưởng', 0.9),
  ROW('cảm giác bản thân không tạo ra khác biệt', 0.9),
  ROW('không thấy giá trị tồn tại rõ ràng', 1.0),
  ROW('cảm giác bản thân không được cần đến', 1.0),
  ROW('không cảm nhận được sự tự chủ về giá trị', 0.9),
  ROW('cảm giác bản thân không có vị trí', 1.0),
  ROW('không thấy bản thân đủ tốt để được công nhận', 1.0),
  ROW('cảm giác bản thân luôn thiếu sót', 0.95),
  ROW('không cảm nhận được sự an tâm về giá trị', 0.9),
  ROW('cảm giác bản thân không đạt chuẩn', 0.9),
  ROW('không thấy bản thân có nền tảng vững', 0.9),
  ROW('không cảm nhận được sự tự tin lâu dài', 0.9),
  ROW('cảm giác bản thân không đủ mạnh', 0.9),
  ROW('không thấy giá trị cá nhân rõ rệt', 1.0),
  ROW('cảm giác bản thân không có điểm tựa nội tâm', 0.9),
  ROW('cảm giác bản thân không đáng được đánh giá cao', 1.0),
  ROW('không cảm nhận được sự công nhận bản thân', 1.0),
  ROW('cảm giác bản thân không có trọng lượng', 0.9),
  ROW('không thấy bản thân có ý nghĩa đặc biệt', 1.0),
  ROW('cảm giác bản thân không đủ quan trọng để được nhớ đến', 1.0),

  ROW('low self worth', 1.0),
  ROW('sense of worthlessness', 1.0),
  ROW('lack of personal value', 1.0),
  ROW('sense of being unimportant', 1.0),
  ROW('insignificant presence', 0.95),
  ROW('not good enough', 1.0),
  ROW('sense of inadequacy', 1.0),
  ROW('lack of confidence', 0.95),
  ROW('persistent self doubt', 0.95),
  ROW('comparison with others', 0.9),
  ROW('lack of recognition', 1.0),
  ROW('being overlooked', 0.95),
  ROW('not being valued', 1.0),
  ROW('lack of appreciation', 1.0),
  ROW('dismissed contributions', 0.9),
  ROW('sense of uselessness', 1.0),
  ROW('being a burden', 1.0),
  ROW('lack of usefulness', 0.95),
  ROW('no meaningful contribution', 1.0),
  ROW('existence feels unnecessary', 1.0),
  ROW('lack of meaning', 1.0),
  ROW('no clear purpose', 1.0),
  ROW('unclear personal direction', 0.95),
  ROW('questioning personal meaning', 0.9),
  ROW('absence of motivation', 0.9),
  ROW('self disappointment', 0.95),
  ROW('regret about self', 0.9),
  ROW('negative self view', 1.0),
  ROW('harsh self judgment', 0.95),
  ROW('constant self criticism', 1.0),
  ROW('lack of belonging', 1.0),
  ROW('no sense of place', 1.0),
  ROW('social disconnection', 0.95),
  ROW('feeling left behind', 0.9),
  ROW('difficulty fitting in', 0.9),
  ROW('being unnoticed', 0.95),
  ROW('lack of visibility', 0.9),
  ROW('not being heard', 0.95),
  ROW('absence of impact', 0.9),
  ROW('minimal influence', 0.9),
  ROW('easily replaceable', 0.9),
  ROW('no unique value', 1.0),
  ROW('nothing special', 0.95),
  ROW('interchangeable role', 0.9),
  ROW('lack of individuality', 0.95),
  ROW('low competence', 1.0),
  ROW('lack of ability', 1.0),
  ROW('limited capability', 0.95),
  ROW('questioning own skills', 0.9),
  ROW('not meeting expectations', 0.95),
  ROW('no clear role', 0.9),
  ROW('uncertain place in life', 1.0),
  ROW('lack of purpose in actions', 0.95),
  ROW('unclear personal role', 0.9),
  ROW('no meaningful position', 1.0),
  ROW('unstable self image', 0.9),
  ROW('fragile self esteem', 1.0),
  ROW('insecure sense of worth', 1.0),
  ROW('identity confusion', 0.9),
  ROW('uncertain self concept', 0.9),
  ROW('not a priority', 1.0),
  ROW('lack of importance', 1.0),
  ROW('rarely acknowledged', 0.95),
  ROW('easily ignored', 0.9),
  ROW('low perceived value', 1.0),
  ROW('not making a difference', 0.9),
  ROW('limited impact', 0.9),
  ROW('actions feel meaningless', 1.0),
  ROW('no lasting contribution', 1.0),
  ROW('absence of significance', 1.0),
  ROW('lack of self respect', 1.0),
  ROW('difficulty valuing oneself', 1.0),
  ROW('self worth tied to failure', 0.95),
  ROW('constant self comparison', 0.9),
  ROW('negative self identity', 1.0),
  ROW('nothing to be proud of', 0.95),
  ROW('low personal pride', 0.95),
  ROW('confidence easily shaken', 0.9),
  ROW('difficulty trusting self', 0.9),
  ROW('weak internal validation', 1.0),
  ROW('not worthy of recognition', 1.0),
  ROW('rarely remembered', 1.0),
  ROW('lack of acknowledgment', 1.0),
  ROW('minimal personal significance', 1.0),
  ROW('existence feels unnoticed', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='question_value_check'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử kiểm tra lại không', 1.0),
  ROW('có thấy khá hơn không', 0.8),
  ROW('cảm giác đó có còn rõ ràng không', 1.0),
  ROW('trạng thái hiện tại có thay đổi chút nào không', 0.95),
  ROW('cảm xúc này đang mạnh hay nhẹ hơn', 0.95),
  ROW('điều này có còn ảnh hưởng nhiều không', 0.9),
  ROW('cảm nhận hiện tại ra sao', 0.95),
  ROW('nhiều người cũng từng cảm thấy như vậy', 0.9),
  ROW('những cảm giác này không kỳ lạ', 0.85),
  ROW('điều này không phải là hiếm gặp', 0.9),
  ROW('trạng thái này thường xuất hiện khi áp lực kéo dài', 0.85),
  ROW('cảm giác này có thể đến rồi đi', 0.9),
  ROW('điều gì khiến cảm giác này xuất hiện', 1.0),
  ROW('hoàn cảnh nào có thể liên quan đến cảm giác này', 0.95),
  ROW('yếu tố nào gần đây ảnh hưởng nhiều nhất', 0.95),
  ROW('sự việc nào làm cảm giác này rõ hơn', 0.9),
  ROW('có điều gì cụ thể kích hoạt trạng thái này không', 0.95),
  ROW('điều gì thường được xem là quan trọng', 1.0),
  ROW('giá trị nào thường được ưu tiên', 0.95),
  ROW('điều nào mang lại cảm giác ý nghĩa hơn', 0.95),
  ROW('có điều gì khiến cảm thấy tự hào không', 0.9),
  ROW('điều nào cảm giác đúng với bản thân', 0.95),
  ROW('đã từng vượt qua điều khó khăn nào trước đây', 0.95),
  ROW('có điều gì từng làm tốt, dù là nhỏ thôi', 0.95),
  ROW('điểm nào thường được người khác đánh giá cao', 0.9),
  ROW('có kỹ năng nào thường bị bỏ qua không', 0.9),
  ROW('điều gì thường làm tốt một cách tự nhiên', 0.9),
  ROW('hiện tại có thể tập trung vào điều gì', 0.95),
  ROW('một việc đơn giản lúc này là gì', 0.95),
  ROW('điều gì có thể kiểm soát ngay bây giờ', 1.0),
  ROW('một bước nhỏ có thể thử là gì', 1.0),
  ROW('điều gì giúp cảm thấy ổn hơn một chút', 0.95),
  ROW('không cần phải có câu trả lời ngay', 1.0),
  ROW('việc chưa rõ ràng là cũng không sao cả', 1.0),
  ROW('không cần phải hoàn hảo', 0.95),
  ROW('mọi thứ có thể được nhìn dần dần', 0.9),
  ROW('không cần phải tự ép buộc', 0.95),
  ROW('có thể cho phép bản thân chậm lại', 0.95),
  ROW('có thể nghỉ một chút nếu cần', 0.9),
  ROW('có thể chỉ quan sát cảm giác này', 0.95),
  ROW('có thể không cần phán xét cảm xúc', 1.0),
  ROW('nếu nhìn khác đi thì sao', 0.9),
  ROW('nếu hỏi một người đáng tin thì sao', 0.85),
  ROW('nếu xem đây là tín hiệu thì sao', 0.9),
  ROW('nếu thử tiếp cận nhẹ nhàng hơn', 0.95),
  ROW('nếu dành thời gian suy nghĩ thêm', 0.9),
  ROW('có ai từng giúp nhìn rõ hơn điều này', 0.95),
  ROW('có nguồn hỗ trợ nào từng hiệu quả', 0.9),
  ROW('có người nào phù hợp để chia sẻ', 0.95),
  ROW('có không gian nào cảm thấy an toàn', 0.9),
  ROW('có cách nào từng giúp cảm thấy vững hơn', 0.95),
  ROW('điều gì từng mang lại cảm giác ý nghĩa', 1.0),
  ROW('điều gì phản ánh con người thật', 1.0),
  ROW('giá trị nào từng giúp đưa ra quyết định', 0.95),
  ROW('điều gì từng khiến cảm thấy đúng hướng', 0.95),
  ROW('điều nào từng được trân trọng', 0.9),
  ROW('có thể chọn tập trung vào một điều', 0.95),
  ROW('có thể bỏ qua những điều chưa cần thiết', 0.9),
  ROW('có thể ưu tiên một việc nhỏ', 1.0),
  ROW('có thể cho phép bản thân thử lại', 0.95),
  ROW('có thể thay đổi nhịp độ', 0.9),
  ROW('không có gì cần quyết định vội', 1.0),
  ROW('mọi thứ vẫn có thể điều chỉnh', 0.95),
  ROW('việc cảm thấy mơ hồ là chấp nhận được', 1.0),
  ROW('không cần phải tự giải quyết tất cả', 0.95),
  ROW('có thể tìm thêm thời gian', 0.9),
  ROW('đã làm tốt khi dừng lại suy nghĩ', 0.95),
  ROW('việc nhận ra cảm giác này là một bước', 1.0),
  ROW('sự chú ý đến bản thân là quan trọng', 0.95),
  ROW('việc tự hỏi như vậy cho thấy sự quan tâm', 0.9),
  ROW('đây là một quá trình', 1.0),
  ROW('một hành động nhỏ hôm nay có thể là gì', 1.0),
  ROW('một lựa chọn nhẹ nhàng có thể thử', 0.95),
  ROW('một việc không quá áp lực', 0.95),
  ROW('một điều đơn giản để bắt đầu', 1.0),
  ROW('một bước không cần hoàn hảo', 0.95),
  ROW('cảm giác hiện tại có dễ chịu hơn không', 0.95),
  ROW('điều này có giúp nhìn rõ hơn chút nào không', 0.95),
  ROW('trạng thái hiện tại có ổn hơn không', 1.0),
  ROW('có muốn tiếp tục suy nghĩ thêm không', 0.9),
  ROW('có cần chuyển sang điều khác nhẹ hơn không', 0.9),
  ROW('có thể tiếp tục khi sẵn sàng', 1.0),
  ROW('có thể quay lại chủ đề này sau', 1.0),
  ROW('mọi thứ có thể tiến từng bước', 1.0),
  ROW('không cần phải vội vàng', 1.0),
  ROW('ở đây để tiếp tục cùng lúc cần', 1.0),

  ROW('does this feeling still feel strong', 1.0),
  ROW('has anything shifted slightly', 0.95),
  ROW('is this state still present', 0.95),
  ROW('does it feel lighter or heavier now', 0.9),
  ROW('how does it feel at the moment', 0.95),
  ROW('this experience is quite common', 0.9),
  ROW('many people experience this at times', 0.85),
  ROW('this reaction makes sense under pressure', 0.9),
  ROW('these thoughts often appear during stress', 0.85),
  ROW('this can come and go over time', 0.9),
  ROW('what might be connected to this', 1.0),
  ROW('what situations seem related', 0.95),
  ROW('what has had the biggest impact recently', 0.95),
  ROW('what tends to bring this up', 0.9),
  ROW('any specific trigger noticed', 0.95),
  ROW('what usually matters most', 1.0),
  ROW('which values feel important', 0.95),
  ROW('what brings a sense of meaning', 0.95),
  ROW('what has felt right before', 0.9),
  ROW('what has felt worth caring about', 0.95),
  ROW('what has been handled before', 0.95),
  ROW('what has gone well in the past', 0.95),
  ROW('what others have appreciated', 0.9),
  ROW('what skills may be overlooked', 0.9),
  ROW('what comes naturally', 0.9),
  ROW('what feels manageable right now', 0.95),
  ROW('what is within control at the moment', 1.0),
  ROW('what is one small step', 1.0),
  ROW('what could help even a little', 0.95),
  ROW('what feels least overwhelming', 0.95),
  ROW('no need to have answers right away', 1.0),
  ROW('uncertainty is okay', 1.0),
  ROW('there is no rush', 0.95),
  ROW('things can unfold gradually', 0.9),
  ROW('perfection is not required', 0.95),
  ROW('it is okay to slow down', 0.95),
  ROW('it is okay to pause', 0.9),
  ROW('it is okay to simply notice this', 0.95),
  ROW('it is okay not to judge this feeling', 1.0),
  ROW('it is okay to sit with this briefly', 0.9),
  ROW('what if this is explored gently', 0.9),
  ROW('what if a different angle is tried', 0.85),
  ROW('what if this is a signal', 0.9),
  ROW('what if less pressure is applied', 0.95),
  ROW('what if more time is given', 0.9),
  ROW('has support helped before', 0.95),
  ROW('who has offered helpful perspective', 0.9),
  ROW('what kind of support feels safe', 0.95),
  ROW('where has support been found', 0.9),
  ROW('what has helped create stability', 0.95),
  ROW('what has felt meaningful before', 1.0),
  ROW('what reflects core values', 1.0),
  ROW('what has guided decisions before', 0.95),
  ROW('what has felt aligned', 0.95),
  ROW('what has been personally important', 0.9),
  ROW('one thing can be chosen to focus on', 0.95),
  ROW('unnecessary pressure can be set aside', 0.9),
  ROW('one small priority is enough', 1.0),
  ROW('trying again is allowed', 0.95),
  ROW('pace can be adjusted', 0.9),
  ROW('no urgent decisions are needed', 1.0),
  ROW('things can be revisited later', 0.95),
  ROW('feeling unsure is acceptable', 1.0),
  ROW('everything does not need to be solved now', 0.95),
  ROW('more time is available', 0.9),
  ROW('pausing to reflect is meaningful', 0.95),
  ROW('noticing this is a step forward', 1.0),
  ROW('paying attention to this matters', 0.95),
  ROW('asking these questions shows care', 0.9),
  ROW('this is part of a process', 1.0),
  ROW('one small action could be enough', 1.0),
  ROW('a gentle step may help', 0.95),
  ROW('something simple can be tried', 0.95),
  ROW('a low pressure start is okay', 1.0),
  ROW('progress does not need to be perfect', 0.95),
  ROW('does this feel a bit clearer', 0.95),
  ROW('does this help even slightly', 0.95),
  ROW('does this feel more manageable', 1.0),
  ROW('would continuing feel okay', 0.9),
  ROW('would a lighter topic help', 0.9),
  ROW('this can be continued when ready', 1.0),
  ROW('this topic can wait if needed', 1.0),
  ROW('taking things step by step is fine', 1.0),
  ROW('there is no need to rush', 1.0),
  ROW('support is here when needed', 1.0)
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
  ROW('cần hỗ trợ chuyên nghiệp', 1.0),
  ROW('cần hỗ trợ từ con người', 1.0),
  ROW('cần giúp đỡ nghiêm túc', 1.0),
  ROW('cần hỗ trợ khẩn cấp', 1.0),
  ROW('cần hỗ trợ tâm lý', 1.0),
  ROW('cần tư vấn chuyên môn', 0.95),
  ROW('cần liên hệ đường dây nóng', 1.0),
  ROW('cần hỗ trợ ngay lập tức', 1.0),
  ROW('cần người có chuyên môn', 0.95),
  ROW('cần sự can thiệp bên ngoài', 1.0),
  ROW('cần hỗ trợ thực tế', 0.95),
  ROW('cần người thật hỗ trợ', 1.0),
  ROW('cần hỗ trợ từ chuyên gia', 1.0),
  ROW('cần sự giúp đỡ chính thức', 0.95),
  ROW('cần hỗ trợ ngoài hệ thống', 1.0),
  ROW('cần hỗ trợ bên ngoài ngay', 1.0),
  ROW('cần dịch vụ hỗ trợ', 0.95),
  ROW('cần người có đào tạo', 0.95),
  ROW('cần hỗ trợ mức cao hơn', 1.0),
  ROW('cần hỗ trợ nghiêm túc ngay', 1.0),
  ROW('cần người đáng tin cậy', 0.9),
  ROW('cần hỗ trợ chính thống', 0.95),
  ROW('cần sự chăm sóc phù hợp', 1.0),
  ROW('cần hỗ trợ từ người có kinh nghiệm', 0.95),
  ROW('cần hỗ trợ chuyên sâu', 1.0),
  ROW('không thể tự xử lý một mình', 1.0),
  ROW('tình huống này vượt quá khả năng', 0.95),
  ROW('vấn đề này cần người có chuyên môn', 0.95),
  ROW('cần hỗ trợ nhiều hơn tự giúp', 0.95),
  ROW('tình huống này cần can thiệp', 1.0),
  ROW('việc này không an toàn để tự xử lý', 1.0),
  ROW('cần sự hỗ trợ phù hợp hơn', 0.9),
  ROW('tình huống này đang nghiêm trọng', 1.0),
  ROW('vấn đề này không thể tự giải quyết', 0.95),
  ROW('cần sự quan tâm đúng mức', 0.9),
  ROW('tình trạng này cần người thật', 0.95),
  ROW('việc này cần xử lý chuyên nghiệp', 1.0),
  ROW('tình huống này cần hỗ trợ gấp', 1.0),
  ROW('việc này vượt quá giới hạn hiện tại', 0.9),
  ROW('tình trạng này không thể tiếp tục', 0.95),
  ROW('cần chuyển sang hỗ trợ con người', 1.0),
  ROW('tình huống này cần đánh giá chuyên môn', 0.95),
  ROW('vấn đề này cần sự can thiệp phù hợp', 0.95),
  ROW('cần hỗ trợ an toàn hơn', 0.95),
  ROW('tình trạng này cần được chú ý', 0.9),
  ROW('việc này không thể xử lý nội bộ', 0.95),
  ROW('cần hỗ trợ bên ngoài kịp thời', 1.0),
  ROW('tình huống này cần chăm sóc đúng cách', 1.0),
  ROW('vấn đề này cần hỗ trợ nghiêm túc', 1.0),
  ROW('cần người có chuyên môn đánh giá', 0.95),
  ROW('việc này không nên tự xử lý', 0.95),
  ROW('tình trạng này đang vượt kiểm soát', 0.95),
  ROW('vấn đề này cần hỗ trợ cao hơn', 1.0),
  ROW('cần sự hỗ trợ phù hợp ngay', 1.0),
  ROW('việc này cần được xử lý kịp thời', 1.0),
  ROW('khó suy nghĩ rõ ràng lúc này', 0.85),
  ROW('mọi thứ đang trở nên quá tải', 0.85),
  ROW('không thấy hướng giải quyết', 0.85),
  ROW('tình trạng này đang nặng dần', 0.9),
  ROW('khả năng chịu đựng đang giảm', 0.9),
  ROW('cảm giác không còn kiểm soát', 0.9),
  ROW('không còn cách tự xoay xở', 0.9),
  ROW('tình trạng này không an toàn', 1.0),
  ROW('mọi giải pháp hiện tại không đủ', 0.9),
  ROW('tình huống này cần người khác tham gia', 0.85),
  ROW('việc này đang vượt giới hạn', 0.9),
  ROW('tình trạng này không thể bỏ qua', 0.9),
  ROW('cần sự hỗ trợ bên ngoài ngay lúc này', 1.0),
  ROW('việc này đang trở nên rủi ro', 1.0),
  ROW('tình huống này cần được xử lý ngay', 1.0),
  ROW('tình trạng này đang leo thang', 0.95),
  ROW('khả năng tự xử lý đang cạn', 0.9),
  ROW('tình huống này đang vượt tầm kiểm soát', 1.0),
  ROW('việc này không thể trì hoãn', 1.0),
  ROW('tình trạng này cần chăm sóc ngay', 1.0),
  ROW('việc này cần người có chuyên môn can thiệp', 1.0),
  ROW('tình huống này đang đến giới hạn', 1.0),
  ROW('cần sự hỗ trợ kịp thời từ bên ngoài', 1.0),
  ROW('tình trạng này cần được hỗ trợ gấp', 1.0),
  ROW('việc này cần sự can thiệp ngay', 1.0),
  ROW('tình huống này không thể tự gánh', 0.95),
  ROW('vấn đề này cần được chia sẻ với người khác', 0.85),
  ROW('tình trạng này cần sự giúp đỡ thật', 1.0),
  ROW('việc này đang trở nên nghiêm trọng', 1.0),
  ROW('tình huống này cần hỗ trợ bằng người thật', 1.0)

  ROW('need professional help', 1.0),
  ROW('need human support', 1.0),
  ROW('need real help', 1.0),
  ROW('need hotline support', 1.0),
  ROW('need crisis support', 1.0),
  ROW('need emergency help', 1.0),
  ROW('need to talk to someone real', 0.95),
  ROW('need outside support', 0.95),
  ROW('need mental health support', 1.0),
  ROW('need therapist support', 1.0),
  ROW('need counselor support', 1.0),
  ROW('need expert guidance', 0.95),
  ROW('need trained support', 0.95),
  ROW('need immediate assistance', 1.0),
  ROW('need urgent support', 1.0),
  ROW('need help right now', 1.0),
  ROW('need to contact support', 0.95),
  ROW('need to reach someone', 0.9),
  ROW('need live support', 0.95),
  ROW('need professional care', 1.0),
  ROW('need external intervention', 1.0),
  ROW('need serious help', 1.0),
  ROW('need trusted adult support', 0.95),
  ROW('need clinical support', 1.0),
  ROW('need off platform help', 0.95),
  ROW('cannot handle this alone', 1.0),
  ROW('this is too much to manage', 0.95),
  ROW('this needs more than self help', 0.95),
  ROW('this requires expert attention', 0.95),
  ROW('support beyond this is needed', 0.95),
  ROW('this is beyond current capacity', 0.9),
  ROW('help from a real person is needed', 0.95),
  ROW('this situation needs escalation', 1.0),
  ROW('this feels out of control', 0.9),
  ROW('this cannot be handled safely', 1.0),
  ROW('this needs immediate attention', 1.0),
  ROW('this requires proper care', 0.95),
  ROW('this needs trained support', 0.95),
  ROW('this cannot continue like this', 0.9),
  ROW('this feels overwhelming', 0.9),
  ROW('this is getting unmanageable', 0.9),
  ROW('this needs a higher level of support', 1.0),
  ROW('this requires human judgment', 0.95),
  ROW('this needs professional input', 0.95),
  ROW('this cannot be solved alone', 0.95),
  ROW('this needs real world help', 0.95),
  ROW('this is beyond safe self handling', 1.0),
  ROW('this requires outside support', 0.95),
  ROW('this situation is serious', 1.0),
  ROW('this needs immediate support', 1.0),
  ROW('this is too intense to handle', 0.9),
  ROW('this is escalating', 0.95),
  ROW('this needs human intervention', 1.0),
  ROW('this needs proper attention', 0.9),
  ROW('this requires external care', 0.95),
  ROW('unable to think clearly anymore', 0.85),
  ROW('everything feels overwhelming now', 0.85),
  ROW('cannot see a way forward', 0.85),
  ROW('stuck in a spiral', 0.85),
  ROW('losing control of the situation', 0.9),
  ROW('nothing seems to help anymore', 0.9),
  ROW('this keeps getting worse', 0.9),
  ROW('this is becoming too heavy', 0.85),
  ROW('mental capacity feels exhausted', 0.85),
  ROW('this feels unsafe to handle', 1.0),
  ROW('ability to cope feels gone', 0.9),
  ROW('this feels beyond limits', 0.9),
  ROW('thinking is getting narrower', 0.85),
  ROW('no tools seem enough', 0.9),
  ROW('this cannot be contained', 0.9),
  ROW('support is urgently needed', 1.0),
  ROW('help from outside is necessary', 0.95),
  ROW('this cannot stay internal', 0.9),
  ROW('this needs to be shared with someone', 0.85),
  ROW('this requires more support', 0.9),
  ROW('this feels too risky alone', 1.0),
  ROW('this needs real attention now', 1.0),
  ROW('this situation feels unsafe', 1.0),
  ROW('this cannot be ignored', 0.9),
  ROW('this needs immediate care', 1.0),
  ROW('this is reaching a breaking point', 1.0),
  ROW('this feels critical', 1.0),
  ROW('this cannot wait', 1.0),
  ROW('this needs external help now', 1.0),
  ROW('this needs urgent human support', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('cảm thấy an toàn', 1.0),
  ROW('được hỗ trợ', 0.9),
  ROW('đã liên hệ với ai đó', 1.0),
  ROW('đã nhắn cho người đáng tin', 1.0),
  ROW('đã gọi cho người hỗ trợ', 1.0),
  ROW('đã kết nối với người khác', 0.95),
  ROW('đã tìm được sự hỗ trợ', 1.0),
  ROW('đã chia sẻ với người khác', 0.95),
  ROW('đã nói chuyện với người lớn', 0.95),
  ROW('đã liên hệ hỗ trợ', 1.0),
  ROW('đã tiếp cận người thật', 1.0),
  ROW('đã báo cho người đáng tin', 0.95),
  ROW('đã kết nối với dịch vụ hỗ trợ', 1.0),
  ROW('đã tìm được người lắng nghe', 1.0),
  ROW('đã có người biết tình hình', 0.9),
  ROW('đã nhờ được sự giúp đỡ', 1.0),
  ROW('đã tiếp cận hỗ trợ bên ngoài', 1.0),
  ROW('có người đang lắng nghe', 1.0),
  ROW('có người đang giúp đỡ', 1.0),
  ROW('không còn một mình', 1.0),
  ROW('đang có sự hỗ trợ', 1.0),
  ROW('có người ở bên', 0.95),
  ROW('được hỗ trợ từ người khác', 1.0),
  ROW('có sự giúp đỡ sẵn sàng', 0.95),
  ROW('cảm giác được hỗ trợ', 1.0),
  ROW('có người quan tâm', 0.95),
  ROW('có người hiểu tình hình', 0.95),
  ROW('được xem trọng', 1.0),
  ROW('có người theo dõi', 0.95),
  ROW('sự hỗ trợ đang diễn ra', 1.0),
  ROW('không phải tự đối mặt', 1.0),
  ROW('đã có sự giúp đỡ', 1.0),
  ROW('cảm thấy an toàn hơn', 1.0),
  ROW('tình huống an toàn hơn', 1.0),
  ROW('nguy cơ đã giảm', 1.0),
  ROW('cảm giác yên tâm hơn', 0.95),
  ROW('mức độ an toàn cải thiện', 1.0),
  ROW('ít rủi ro hơn', 1.0),
  ROW('được bảo vệ', 1.0),
  ROW('đã ổn định hơn', 1.0),
  ROW('tình hình đã dịu lại', 0.95),
  ROW('môi trường an toàn hơn', 0.95),
  ROW('không còn nguy hiểm', 1.0),
  ROW('lo lắng về an toàn giảm', 0.95),
  ROW('vấn đề an toàn được xử lý', 1.0),
  ROW('đủ an toàn lúc này', 0.9),
  ROW('đã qua giai đoạn nguy cấp', 1.0),
  ROW('bớt quá tải hơn', 0.95),
  ROW('bình tĩnh hơn sau khi nói chuyện', 1.0),
  ROW('áp lực cảm xúc giảm', 1.0),
  ROW('nhẹ lòng hơn sau khi chia sẻ', 1.0),
  ROW('căng thẳng giảm bớt', 0.95),
  ROW('đầu óc nhẹ hơn', 0.95),
  ROW('tâm trí ổn định hơn', 0.95),
  ROW('bớt hoảng loạn', 1.0),
  ROW('dễ thở hơn', 0.9),
  ROW('cảm xúc ổn hơn', 0.95),
  ROW('bớt căng thẳng', 0.9),
  ROW('suy nghĩ rõ ràng hơn', 0.95),
  ROW('mức độ khó chịu giảm', 1.0),
  ROW('trạng thái cảm xúc cải thiện', 1.0),
  ROW('lấy lại được sự bình tĩnh', 0.95),
  ROW('đã có kế hoạch với người hỗ trợ', 1.0),
  ROW('đã bàn về bước tiếp theo', 0.95),
  ROW('sẽ có người theo dõi tiếp', 1.0),
  ROW('có người tiếp tục hỗ trợ', 1.0),
  ROW('sự giúp đỡ đang tiếp diễn', 1.0),
  ROW('quy trình hỗ trợ đã bắt đầu', 1.0),
  ROW('rõ ràng hơn về hướng xử lý', 0.95),
  ROW('tin tưởng vào sự hỗ trợ', 1.0),
  ROW('được hướng dẫn bởi người có kinh nghiệm', 1.0),
  ROW('không còn phải tự xoay xở', 1.0),
  ROW('sự giúp đỡ sẽ tiếp tục', 1.0),
  ROW('đã có kế hoạch hỗ trợ', 1.0),
  ROW('cảm giác được dẫn dắt', 0.95),
  ROW('tình huống đang được theo dõi', 1.0),
  ROW('vấn đề đang được xử lý', 1.0),
  ROW('được an ủi khi kết nối', 1.0),
  ROW('yên tâm hơn sau khi liên hệ', 1.0),
  ROW('tin tưởng vào người hỗ trợ', 1.0),
  ROW('cảm giác được quan tâm', 1.0),
  ROW('an toàn cảm xúc cải thiện', 1.0),
  ROW('không còn bị bỏ mặc', 1.0),
  ROW('được công nhận và lắng nghe', 1.0),
  ROW('phản hồi hỗ trợ tích cực', 1.0),
  ROW('nhận được phản hồi kịp thời', 1.0),
  ROW('không còn cảm thấy cô đơn', 1.0)

  ROW('contacted someone', 1.0),
  ROW('reached out to someone', 1.0),
  ROW('talked to a trusted person', 1.0),
  ROW('connected with someone', 0.95),
  ROW('got in touch with support', 1.0),
  ROW('messaged a trusted person', 0.95),
  ROW('called someone for help', 1.0),
  ROW('shared this with someone', 0.95),
  ROW('support was contacted', 1.0),
  ROW('reached a real person', 1.0),
  ROW('talked to an adult', 0.95),
  ROW('contacted support services', 1.0),
  ROW('connected with help', 1.0),
  ROW('someone was informed', 0.9),
  ROW('external support reached', 1.0),
  ROW('someone is listening', 1.0),
  ROW('someone is helping', 1.0),
  ROW('not alone anymore', 1.0),
  ROW('support is present', 1.0),
  ROW('someone is there', 0.95),
  ROW('supported by others', 1.0),
  ROW('help is available', 0.95),
  ROW('feels supported now', 1.0),
  ROW('has support nearby', 0.95),
  ROW('someone understands', 0.95),
  ROW('being taken seriously', 1.0),
  ROW('someone is checking in', 0.95),
  ROW('support is active', 1.0),
  ROW('not facing this alone', 1.0),
  ROW('help has arrived', 1.0),
  ROW('feels safer now', 1.0),
  ROW('situation feels safer', 1.0),
  ROW('immediate danger reduced', 1.0),
  ROW('more secure than before', 0.95),
  ROW('sense of safety improved', 1.0),
  ROW('less at risk now', 1.0),
  ROW('protected by support', 1.0),
  ROW('safety restored', 1.0),
  ROW('situation stabilized', 0.95),
  ROW('environment feels safer', 0.95),
  ROW('no longer unsafe', 1.0),
  ROW('risk feels lower', 0.95),
  ROW('safety concerns addressed', 1.0),
  ROW('secure enough for now', 0.9),
  ROW('out of immediate danger', 1.0),
  ROW('less overwhelmed now', 0.95),
  ROW('calmer after talking', 1.0),
  ROW('emotional pressure reduced', 1.0),
  ROW('relief after sharing', 1.0),
  ROW('stress level decreased', 0.95),
  ROW('mental load feels lighter', 0.95),
  ROW('more grounded now', 0.95),
  ROW('less panic than before', 1.0),
  ROW('breathing feels easier', 0.9),
  ROW('emotions feel steadier', 0.95),
  ROW('tension reduced', 0.9),
  ROW('mind feels clearer', 0.95),
  ROW('less distress present', 1.0),
  ROW('emotional state improved', 1.0),
  ROW('regained some calm', 0.95),
  ROW('has a plan with support', 1.0),
  ROW('next steps discussed', 0.95),
  ROW('support will follow up', 1.0),
  ROW('someone will stay involved', 1.0),
  ROW('help is ongoing', 1.0),
  ROW('support process started', 1.0),
  ROW('clearer about next steps', 0.95),
  ROW('trust in support system', 1.0),
  ROW('guided by someone experienced', 1.0),
  ROW('not handling this alone anymore', 1.0),
  ROW('help will continue', 1.0),
  ROW('support plan in place', 1.0),
  ROW('feels guided now', 0.95),
  ROW('someone is monitoring the situation', 1.0),
  ROW('situation being handled', 1.0),
  ROW('comforted by connection', 1.0),
  ROW('reassured after reaching out', 1.0),
  ROW('confidence in support', 1.0),
  ROW('feels cared for', 1.0),
  ROW('emotional safety improved', 1.0),
  ROW('not ignored anymore', 1.0),
  ROW('validated by others', 1.0),
  ROW('help response was positive', 1.0),
  ROW('support response was quick', 1.0),
  ROW('no longer isolated', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không nhận được hỗ trợ', 0.9),
  ROW('vẫn lo lắng', 0.8),
  ROW('không liên hệ được ai', 1.0),
  ROW('không nhận được phản hồi', 1.0),
  ROW('hỗ trợ không trả lời', 1.0),
  ROW('không kết nối được với ai', 1.0),
  ROW('tin nhắn không được phản hồi', 0.95),
  ROW('cuộc gọi không được bắt máy', 1.0),
  ROW('không ai nghe máy', 0.95),
  ROW('liên hệ không thành công', 1.0),
  ROW('hỗ trợ không khả dụng', 1.0),
  ROW('không thể kết nối', 1.0),
  ROW('không có hồi âm', 0.95),
  ROW('không tiếp cận được hỗ trợ', 1.0),
  ROW('không ai phản hồi', 1.0),
  ROW('hỗ trợ không thể liên lạc', 1.0),
  ROW('việc liên hệ thất bại', 1.0),
  ROW('hỗ trợ không giúp ích', 1.0),
  ROW('sự giúp đỡ không hiệu quả', 0.95),
  ROW('hỗ trợ chưa đủ', 0.95),
  ROW('không nhận được hỗ trợ thực sự', 1.0),
  ROW('hỗ trợ không cải thiện tình hình', 1.0),
  ROW('giúp đỡ còn hạn chế', 0.9),
  ROW('phản hồi hỗ trợ yếu', 0.9),
  ROW('vấn đề chưa được giải quyết', 1.0),
  ROW('hỗ trợ không hiểu rõ', 0.95),
  ROW('giúp đỡ không đúng trọng tâm', 1.0),
  ROW('hỗ trợ không rõ ràng', 0.9),
  ROW('không có hỗ trợ thiết thực', 1.0),
  ROW('hỗ trợ không tiếp tục', 1.0),
  ROW('giúp đỡ bị gián đoạn', 0.95),
  ROW('kết quả hỗ trợ gây thất vọng', 0.9),
  ROW('vẫn chưa an toàn', 1.0),
  ROW('tình huống vẫn rủi ro', 1.0),
  ROW('an toàn chưa được cải thiện', 1.0),
  ROW('vẫn chưa được hỗ trợ', 1.0),
  ROW('hỗ trợ không làm tăng an toàn', 1.0),
  ROW('tình hình vẫn chưa ổn định', 0.95),
  ROW('vẫn cảm thấy dễ tổn thương', 0.95),
  ROW('không có cảm giác được bảo vệ', 1.0),
  ROW('nguy cơ vẫn còn', 1.0),
  ROW('lo ngại an toàn vẫn tồn tại', 1.0),
  ROW('vẫn chưa yên tâm', 1.0),
  ROW('môi trường vẫn không an toàn', 1.0),
  ROW('hỗ trợ không giảm rủi ro', 1.0),
  ROW('tình huống vẫn nghiêm trọng', 1.0),
  ROW('chưa có sự trấn an về an toàn', 0.95),
  ROW('vẫn quá tải', 0.95),
  ROW('căng thẳng chưa giảm', 0.95),
  ROW('áp lực cảm xúc vẫn còn', 1.0),
  ROW('vẫn rất khó chịu', 1.0),
  ROW('không có sự nhẹ nhõm', 1.0),
  ROW('chưa bình tĩnh lại', 0.95),
  ROW('căng thẳng vẫn cao', 0.9),
  ROW('tâm trí không nhẹ hơn', 0.95),
  ROW('vẫn cảm thấy bất ổn', 1.0),
  ROW('hỗ trợ không làm dịu tình hình', 1.0),
  ROW('trạng thái cảm xúc không đổi', 1.0),
  ROW('vẫn bị dao động', 0.9),
  ROW('áp lực vẫn tồn tại', 0.95),
  ROW('hỗ trợ không giảm căng thẳng', 1.0),
  ROW('an toàn cảm xúc chưa cải thiện', 1.0),
  ROW('không có hỗ trợ tiếp theo', 1.0),
  ROW('hỗ trợ ngừng phản hồi', 1.0),
  ROW('không có hỗ trợ lâu dài', 1.0),
  ROW('quy trình hỗ trợ kết thúc sớm', 1.0),
  ROW('không có bước tiếp theo', 1.0),
  ROW('thiếu kế hoạch hỗ trợ', 1.0),
  ROW('không có hướng dẫn cụ thể', 0.95),
  ROW('hỗ trợ chưa trọn vẹn', 0.95),
  ROW('thiếu sự liên tục trong hỗ trợ', 1.0),
  ROW('hỗ trợ bị gián đoạn', 1.0),
  ROW('không có ai theo dõi lại', 1.0),
  ROW('không có phản hồi sau đó', 1.0),
  ROW('hỗ trợ bị ngắt kết nối', 1.0),
  ROW('giúp đỡ không duy trì', 0.95),
  ROW('hỗ trợ thiếu cấu trúc', 0.9),
  ROW('vẫn phải tự đối mặt', 1.0),
  ROW('không có ai sẵn sàng giúp', 1.0),
  ROW('mạng lưới hỗ trợ không liên lạc được', 1.0),
  ROW('vẫn bị cô lập', 1.0),
  ROW('không có hỗ trợ đáng tin', 1.0),
  ROW('chưa thiết lập được kết nối', 0.95),
  ROW('chưa đảm bảo được hỗ trợ', 1.0),
  ROW('vẫn chưa có ai giúp', 1.0),
  ROW('không tìm được hỗ trợ hiệu quả', 1.0),
  ROW('nỗ lực tìm hỗ trợ không thành', 1.0)

  ROW('could not reach anyone', 1.0),
  ROW('no response from support', 1.0),
  ROW('support did not reply', 1.0),
  ROW('unable to contact anyone', 1.0),
  ROW('messages not answered', 0.95),
  ROW('calls went unanswered', 1.0),
  ROW('no one picked up', 0.95),
  ROW('contact attempt failed', 1.0),
  ROW('support unavailable', 1.0),
  ROW('could not get through', 1.0),
  ROW('no reply received', 0.95),
  ROW('unable to connect with support', 1.0),
  ROW('no one responded', 1.0),
  ROW('support unreachable', 1.0),
  ROW('contact not successful', 1.0),
  ROW('support did not help', 1.0),
  ROW('help was not useful', 0.95),
  ROW('support felt insufficient', 0.95),
  ROW('no meaningful help received', 1.0),
  ROW('support did not improve situation', 1.0),
  ROW('help was limited', 0.9),
  ROW('support response felt weak', 0.9),
  ROW('problem not resolved', 1.0),
  ROW('support did not understand', 0.95),
  ROW('help did not address issue', 1.0),
  ROW('support was unclear', 0.9),
  ROW('no practical help given', 1.0),
  ROW('support did not continue', 1.0),
  ROW('help stopped early', 0.95),
  ROW('support outcome disappointing', 0.9),
  ROW('still feels unsafe', 1.0),
  ROW('situation still feels risky', 1.0),
  ROW('no improvement in safety', 1.0),
  ROW('still not supported', 1.0),
  ROW('support did not increase safety', 1.0),
  ROW('situation remains unstable', 0.95),
  ROW('still feels exposed', 0.95),
  ROW('no sense of protection', 1.0),
  ROW('risk still present', 1.0),
  ROW('safety concerns remain', 1.0),
  ROW('still not secure', 1.0),
  ROW('environment still unsafe', 1.0),
  ROW('support did not reduce risk', 1.0),
  ROW('situation still critical', 1.0),
  ROW('no safety reassurance', 0.95),
  ROW('still overwhelmed', 0.95),
  ROW('stress not reduced', 0.95),
  ROW('emotional pressure remains', 1.0),
  ROW('still distressed', 1.0),
  ROW('no emotional relief', 1.0),
  ROW('calm not restored', 0.95),
  ROW('tension still high', 0.9),
  ROW('mental load unchanged', 0.95),
  ROW('still feeling unstable', 1.0),
  ROW('support did not calm situation', 1.0),
  ROW('emotional state unchanged', 1.0),
  ROW('still shaken', 0.9),
  ROW('pressure still present', 0.95),
  ROW('support did not ease distress', 1.0),
  ROW('emotional safety not improved', 1.0),
  ROW('no follow up received', 1.0),
  ROW('support stopped responding', 1.0),
  ROW('no ongoing support', 1.0),
  ROW('support process ended early', 1.0),
  ROW('no next steps provided', 1.0),
  ROW('support plan missing', 1.0),
  ROW('no guidance given', 0.95),
  ROW('support felt incomplete', 0.95),
  ROW('no continuity in help', 1.0),
  ROW('support dropped off', 1.0),
  ROW('no one checked back', 1.0),
  ROW('follow up never happened', 1.0),
  ROW('support disconnected', 1.0),
  ROW('help not sustained', 0.95),
  ROW('support lacked structure', 0.9),
  ROW('still alone with the problem', 1.0),
  ROW('no one available to help', 1.0),
  ROW('support network not reachable', 1.0),
  ROW('still isolated', 1.0),
  ROW('no reliable support', 1.0),
  ROW('connection not established', 0.95),
  ROW('support not secured', 1.0),
  ROW('still without help', 1.0),
  ROW('no effective support found', 1.0),
  ROW('help attempt unsuccessful', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('muốn thử gọi lại không', 1.0),
  ROW('có cảm thấy ổn hơn chưa', 0.8),
  ROW('kiểm tra xem tình hình hiện tại thế nào', 1.0),
  ROW('chỉ muốn xem mọi thứ có ổn hơn không', 1.0),
  ROW('xem hiện tại có cảm thấy dễ chịu hơn không', 0.95),
  ROW('kiểm tra xem hỗ trợ có giúp ích phần nào không', 0.95),
  ROW('xem mọi thứ có đang ổn không', 0.9),
  ROW('chỉ là một lần hỏi thăm nhẹ nhàng', 0.9),
  ROW('kiểm tra xem vẫn còn hỗ trợ xung quanh không', 0.9),
  ROW('xem hiện tại có cảm thấy an toàn hơn không', 0.9),
  ROW('hy vọng mọi thứ bớt nặng nề hơn lúc này', 0.9),
  ROW('xem tình hình có dịu lại chút nào không', 0.9),
  ROW('kiểm tra xem có cần thêm hỗ trợ không', 0.9),
  ROW('xem thêm giúp đỡ có hữu ích không', 0.9),
  ROW('chỉ muốn xem mọi thứ đang diễn ra ra sao', 0.9),
  ROW('xem hiện tại có cảm thấy dễ xoay xở hơn không', 0.9),
  ROW('kiểm tra xem có cảm giác được hỗ trợ hơn không', 0.9),
  ROW('xem vẫn còn chỗ dựa phù hợp không', 0.85),
  ROW('kiểm tra xem hỗ trợ có dễ tiếp cận không', 0.85),
  ROW('xem việc hỗ trợ có gây áp lực không', 0.85),
  ROW('kiểm tra xem tâm trạng có bình ổn hơn không', 0.85),
  ROW('xem mọi thứ có đang xấu đi không', 0.85),
  ROW('kiểm tra xem thêm giúp đỡ có cần thiết không', 0.85),
  ROW('xem hỗ trợ hiện tại có hiệu quả không', 0.85),
  ROW('kiểm tra xem hỗ trợ có phù hợp không', 0.85),
  ROW('chỉ muốn đảm bảo không có sự vội vàng', 0.85),
  ROW('xem mọi thứ có nhẹ hơn một chút không', 0.85),
  ROW('kiểm tra xem nhịp độ có ổn không', 0.85),
  ROW('xem hỗ trợ có đủ ổn định không', 0.85),
  ROW('kiểm tra xem tình hình có ổn định hơn không', 0.85),
  ROW('xem hiện tại có thiếu điều gì không', 0.85),
  ROW('chỉ muốn xác nhận là mọi thứ vẫn ổn', 0.85),
  ROW('kiểm tra xem hỗ trợ có mang lại cảm giác yên tâm không', 0.85),
  ROW('xem hiện tại có cảm giác vững hơn không', 0.85),
  ROW('kiểm tra xem sự giúp đỡ có dễ tiếp cận không', 0.85),
  ROW('đảm bảo không có áp lực nào ở đây', 0.85),
  ROW('xem mọi thứ có bớt quá tải không', 0.85),
  ROW('kiểm tra xem có cảm giác kiểm soát hơn không', 0.85),
  ROW('xem thêm hướng dẫn có hữu ích không', 0.85),
  ROW('chỉ muốn chắc rằng có thể tạm dừng nếu cần', 0.85),
  ROW('kiểm tra xem mức hỗ trợ hiện tại có đủ không', 0.85),
  ROW('đảm bảo không có gì quá sức lúc này', 0.85),
  ROW('xem hỗ trợ hiện tại có còn phù hợp không', 0.85),
  ROW('kiểm tra xem mọi thứ có rõ ràng hơn không', 0.85),
  ROW('xem sự giúp đỡ có đúng lúc không', 0.85),
  ROW('đảm bảo hỗ trợ vẫn là một lựa chọn', 0.85),
  ROW('xem tình hình có bớt căng thẳng không', 0.85),
  ROW('kiểm tra xem mọi thứ có ổn định hơn không', 0.85),
  ROW('xem hiện tại có dễ xoay xở hơn không', 0.85),
  ROW('đảm bảo hỗ trợ không bị ép buộc', 0.85),
  ROW('kiểm tra xem còn điều gì chưa được giải quyết không', 0.85),
  ROW('xem có thể tạm dừng một chút không', 0.85),
  ROW('kiểm tra xem hỗ trợ hiện tại có đủ hữu ích không', 0.85),
  ROW('đảm bảo vẫn có cảm giác an toàn', 0.85),
  ROW('xem việc tiếp cận hỗ trợ có dễ dàng không', 0.85),
  ROW('kiểm tra xem mọi thứ có cân bằng hơn không', 0.85),
  ROW('xem thêm sự trấn an có cần thiết không', 0.85),
  ROW('đảm bảo hỗ trợ mang tính tôn trọng', 0.85),
  ROW('xem tổng thể có bình ổn hơn không', 0.85),
  ROW('kiểm tra xem mức độ căng thẳng có giảm không', 0.85),
  ROW('xem sự giúp đỡ có kịp thời không', 0.85),
  ROW('đảm bảo hỗ trợ phù hợp với tình huống', 0.85),
  ROW('xem hiện tại có đủ ổn định không', 0.85),
  ROW('kiểm tra xem mức hỗ trợ có đủ không', 0.85),
  ROW('xem còn điều gì chưa rõ không', 0.85),
  ROW('chỉ muốn xác nhận là không có gì gấp gáp', 0.85),
  ROW('kiểm tra xem áp lực có giảm bớt không', 0.85),
  ROW('xem từng khoảnh khắc có ổn hơn không', 0.85),
  ROW('kiểm tra xem hỗ trợ có phù hợp lúc này không', 0.85),
  ROW('đảm bảo hỗ trợ có thể linh hoạt', 0.85),
  ROW('xem có không gian để nghỉ ngơi không', 0.85),
  ROW('kiểm tra xem mọi thứ có dễ chịu hơn không', 0.85),
  ROW('xem hỗ trợ hiện tại có đủ trấn an không', 0.85),
  ROW('đảm bảo không bỏ sót điều gì quan trọng', 0.85),
  ROW('kiểm tra xem mức độ an toàn có ổn không', 0.85),
  ROW('xem có thể tiếp tục chậm rãi không', 0.85),
  ROW('kiểm tra xem hỗ trợ có đủ nhẹ nhàng không', 0.85),
  ROW('đảm bảo mọi thứ đang ở trạng thái ổn', 0.85),
  ROW('xem có điều gì cần điều chỉnh không', 0.85),
  ROW('kiểm tra xem áp lực có giảm không', 0.85),
  ROW('xem hỗ trợ hiện tại có còn phù hợp không', 0.85),
  ROW('chỉ muốn xác nhận là hiện tại vẫn ổn', 0.85)

  ROW('checking in to see how things are going now', 1.0),
  ROW('just making sure things feel a bit steadier', 1.0),
  ROW('wanting to check how the situation feels now', 0.95),
  ROW('seeing whether support has helped even a little', 0.95),
  ROW('checking that things are still okay', 0.9),
  ROW('just a gentle check-in here', 0.9),
  ROW('making sure support is still available', 0.9),
  ROW('checking whether things feel safer now', 0.9),
  ROW('hoping things feel less heavy at the moment', 0.9),
  ROW('checking whether things have eased slightly', 0.9),
  ROW('wanting to make sure no extra support is needed', 0.9),
  ROW('checking if more help would be useful', 0.9),
  ROW('just here to see how things are holding up', 0.9),
  ROW('checking whether things feel manageable', 0.9),
  ROW('seeing if things feel more supported now', 0.9),
  ROW('making sure there is still someone to lean on', 0.85),
  ROW('checking whether support is still within reach', 0.85),
  ROW('just confirming support is not overwhelming', 0.85),
  ROW('checking whether things feel calmer now', 0.85),
  ROW('making sure things are not getting worse', 0.85),
  ROW('checking whether extra help might be useful', 0.85),
  ROW('seeing if support feels helpful so far', 0.85),
  ROW('checking that support feels comfortable', 0.85),
  ROW('just making sure nothing feels rushed', 0.85),
  ROW('checking whether things feel a bit lighter', 0.85),
  ROW('making sure the pace feels okay', 0.85),
  ROW('checking if support feels steady enough', 0.85),
  ROW('seeing whether things feel more stable', 0.85),
  ROW('checking if there is anything missing right now', 0.85),
  ROW('just confirming things feel okay for now', 0.85),
  ROW('checking whether support feels reassuring', 0.85),
  ROW('seeing if things feel more grounded', 0.85),
  ROW('checking whether help feels accessible', 0.85),
  ROW('making sure there is no pressure', 0.85),
  ROW('checking if things feel less overwhelming', 0.85),
  ROW('seeing whether things feel under control', 0.85),
  ROW('checking if more guidance would help', 0.85),
  ROW('just making sure there is space to pause', 0.85),
  ROW('checking whether things feel supported enough', 0.85),
  ROW('making sure nothing feels too much right now', 0.85),
  ROW('checking if support still feels right', 0.85),
  ROW('seeing whether things feel a bit clearer', 0.85),
  ROW('checking whether help feels appropriate', 0.85),
  ROW('just ensuring support remains an option', 0.85),
  ROW('checking whether things feel less tense', 0.85),
  ROW('seeing if things feel more settled', 0.85),
  ROW('checking whether things feel manageable now', 0.85),
  ROW('making sure help does not feel forced', 0.85),
  ROW('checking if anything feels unresolved', 0.85),
  ROW('seeing whether things feel okay to pause', 0.85),
  ROW('checking whether support feels helpful enough', 0.85),
  ROW('making sure there is still a sense of safety', 0.85),
  ROW('checking whether help feels easy to access', 0.85),
  ROW('seeing if things feel more balanced', 0.85),
  ROW('checking if extra reassurance would help', 0.85),
  ROW('just making sure support feels respectful', 0.85),
  ROW('checking whether things feel calmer overall', 0.85),
  ROW('seeing if things feel less intense', 0.85),
  ROW('checking whether help feels timely', 0.85),
  ROW('making sure support fits the situation', 0.85),
  ROW('checking if things feel stable enough for now', 0.85),
  ROW('seeing whether support feels sufficient', 0.85),
  ROW('checking if anything feels unclear', 0.85),
  ROW('just confirming there is no urgency', 0.85),
  ROW('checking whether things feel less stressful', 0.85),
  ROW('seeing if things feel okay moment by moment', 0.85),
  ROW('checking whether help feels appropriate right now', 0.85),
  ROW('making sure support remains flexible', 0.85),
  ROW('checking if there is space to rest', 0.85),
  ROW('seeing whether things feel a bit easier', 0.85),
  ROW('checking whether support feels reassuring enough', 0.85),
  ROW('just making sure nothing feels overlooked', 0.85),
  ROW('checking whether things feel safe enough', 0.85),
  ROW('seeing if things feel okay to continue slowly', 0.85),
  ROW('checking whether help feels gentle enough', 0.85),
  ROW('making sure things feel steady right now', 0.85),
  ROW('checking if there is anything to adjust', 0.85),
  ROW('seeing whether things feel less pressured', 0.85),
  ROW('checking whether support still feels right now', 0.85),
  ROW('just confirming things feel okay at this moment', 0.85)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_contact_support'
ON CONFLICT DO NOTHING;

--------
INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'keyword', 'trigger', wt
FROM actions a,
unnest(ARRAY[
  ROW('không còn ai khác để liên hệ', 0.85),
  ROW('không còn ai khác sẵn sàng', 0.85),
  ROW('không còn ai khác để tìm đến', 0.85),
  ROW('không còn ai khác để dựa vào', 0.85),
  ROW('không còn ai khác xung quanh', 0.85),
  ROW('không còn ai khác để nói chuyện', 0.85),
  ROW('không còn ai khác để liên lạc', 0.85),
  ROW('không còn ai khác phản hồi', 0.85),
  ROW('không còn ai khác có mặt lúc này', 0.85),
  ROW('không còn ai khác có thể giúp', 0.85),
  ROW('không có phương án hỗ trợ nào lúc này', 0.85),
  ROW('không có lựa chọn hỗ trợ an toàn', 0.85),
  ROW('không có kênh hỗ trợ khả dụng', 0.85),
  ROW('không có hỗ trợ bên ngoài để liên hệ', 0.85),
  ROW('không có ai tiếp cận được để giúp', 0.85),
  ROW('không có hỗ trợ ở gần', 0.85),
  ROW('không có lựa chọn giúp đỡ nào', 0.85),
  ROW('không có hỗ trợ cá nhân khả dụng', 0.85),
  ROW('không có hỗ trợ trực tiếp bên ngoài', 0.85),
  ROW('không có ai để liên hệ bên ngoài', 0.85)
  ROW('hotline', 1.0),
  ROW('số điện thoại hỗ trợ', 0.9),
  ROW('liên hệ chuyên gia', 0.8),
  ROW('hỗ trợ hiện tại không còn hiệu quả', 1.0),
  ROW('mọi phương án hỗ trợ đã cạn', 1.0),
  ROW('không còn cách hỗ trợ phù hợp', 1.0),
  ROW('cần sự trợ giúp từ bên ngoài', 1.0),
  ROW('không thể tự xử lý an toàn', 1.0),
  ROW('tình huống vượt quá khả năng tự xoay xở', 1.0),
  ROW('không thể đảm bảo an toàn một mình', 1.0),
  ROW('hỗ trợ hiện có không đủ', 0.95),
  ROW('cần hỗ trợ khẩn cấp', 1.0),
  ROW('cần sự giúp đỡ ngay lập tức', 1.0),
  ROW('cảm giác an toàn không còn', 1.0),
  ROW('mức độ rủi ro tăng cao', 1.0),
  ROW('hệ thống hỗ trợ không tiếp cận được', 0.95),
  ROW('không thấy lối thoát an toàn', 1.0),
  ROW('cần can thiệp ngay', 1.0),
  ROW('quá tải khi thiếu hỗ trợ', 0.95),
  ROW('tình trạng cô lập không an toàn', 1.0),
  ROW('không thể dựa vào hỗ trợ cá nhân', 0.95),
  ROW('cần hỗ trợ chuyên môn', 1.0),
  ROW('cần trợ giúp ngoài vòng quen biết', 1.0),
  ROW('kênh hỗ trợ không khả dụng', 0.95),
  ROW('giúp đỡ cá nhân không đủ', 0.95),
  ROW('không an toàn khi thiếu hỗ trợ', 1.0),
  ROW('không có phương án hỗ trợ phù hợp', 1.0),
  ROW('cần can thiệp từ bên ngoài', 1.0),
  ROW('tình huống đang leo thang', 1.0),
  ROW('căng thẳng tăng cao khi thiếu hỗ trợ', 1.0),
  ROW('không thể tự ổn định', 1.0),
  ROW('xuất hiện khoảng trống hỗ trợ', 0.9),
  ROW('cần kết nối ngay', 1.0),
  ROW('thiếu hỗ trợ an toàn', 1.0),
  ROW('không có nguồn giúp đỡ đáng tin', 1.0),
  ROW('nguồn hỗ trợ đã cạn', 0.95),
  ROW('cần giúp đỡ ngay lúc này', 1.0),
  ROW('cần hỗ trợ ở mức nghiêm trọng', 1.0),
  ROW('trạng thái tinh thần không an toàn', 1.0),
  ROW('rủi ro khi không có trợ giúp', 1.0),
  ROW('không thể tiếp tục nếu thiếu hỗ trợ', 1.0),
  ROW('không có yếu tố ổn định', 1.0),
  ROW('cần trợ giúp ngay', 1.0),
  ROW('cần hỗ trợ bên ngoài gấp', 1.0),
  ROW('việc chờ hỗ trợ trở nên nguy hiểm', 1.0),
  ROW('cách đối phó hiện tại không đủ', 0.95),
  ROW('hệ thống hỗ trợ bị gián đoạn', 0.95),
  ROW('tình huống ở mức nghiêm trọng', 1.0),
  ROW('xuất hiện lo ngại về an toàn', 1.0),
  ROW('cần trợ giúp ngoài cuộc trò chuyện', 1.0),
  ROW('không thể chỉ dựa vào tự điều chỉnh', 1.0),
  ROW('cần hỗ trợ trực tiếp từ con người', 1.0),
  ROW('hỗ trợ bị gián đoạn', 0.9),
  ROW('cô lập và thiếu hỗ trợ', 1.0),
  ROW('không có lớp bảo vệ an toàn', 1.0),
  ROW('rủi ro khi không có giám sát', 1.0),
  ROW('cần hỗ trợ ở mức khẩn cấp', 1.0),
  ROW('hỗ trợ không có sẵn khi cần', 0.95),
  ROW('căng thẳng vượt quá khả năng đối phó', 1.0),
  ROW('không thể tự duy trì an toàn', 1.0),
  ROW('thiếu yếu tố giảm áp lực', 1.0),
  ROW('cần trợ giúp khẩn', 1.0),
  ROW('không tiếp cận được hỗ trợ', 0.95),
  ROW('cần trợ giúp gấp', 1.0),
  ROW('không có phương án dự phòng an toàn', 1.0),
  ROW('không thể chờ thêm hỗ trợ', 1.0),
  ROW('việc trì hoãn hỗ trợ không an toàn', 1.0),
  ROW('mức độ rủi ro tăng', 1.0),
  ROW('hệ thống hỗ trợ không hoạt động', 0.95),
  ROW('không có yếu tố ổn định tức thì', 1.0),
  ROW('không an toàn nếu thiếu can thiệp', 1.0),
  ROW('cần trợ giúp ngay lập tức', 1.0),
  ROW('trạng thái khủng hoảng', 1.0),
  ROW('không có lựa chọn hỗ trợ an toàn khác', 1.0),
  ROW('cần trợ giúp từ bên ngoài ngay', 1.0),
  ROW('tình huống hiện tại không an toàn', 1.0),
  ROW('cần hỗ trợ đảm bảo an toàn', 1.0),
  ROW('không thể tự xoay xở', 1.0),
  ROW('đường hỗ trợ bị chặn', 0.95),
  ROW('không có kết nối ổn định', 1.0),
  ROW('cần can thiệp ngay lập tức', 1.0),
  ROW('thiếu mạng lưới an toàn', 1.0),
  ROW('cần hỗ trợ vượt ngoài bạn bè', 1.0),
  ROW('mức độ cô lập không an toàn', 1.0),
  ROW('thiếu hỗ trợ ở mức nghiêm trọng', 1.0),
  ROW('cần hỗ trợ khẩn cấp', 1.0),
  ROW('không có phương án hỗ trợ khả thi', 1.0),
  ROW('tình huống cần đến đường dây nóng', 1.0)

  ROW('no one else can be contacted', 0.85),
  ROW('no one else is available', 0.85),
  ROW('no one else to contact', 0.85),
  ROW('no one else to rely on', 0.85),
  ROW('no one else around', 0.85),
  ROW('no one else to talk with', 0.85),
  ROW('no one else to reach', 0.85),
  ROW('no one else responding', 0.85),
  ROW('no one else available right now', 0.85),
  ROW('no one else able to help', 0.85),
  ROW('no support option available right now', 0.85),
  ROW('no safe option for support', 0.85),
  ROW('no available support channel', 0.85),
  ROW('no reachable support outside this chat', 0.85),
  ROW('no one accessible for help', 0.85),
  ROW('no support option nearby', 0.85),
  ROW('no help option available', 0.85),
  ROW('no personal help available', 0.85),
  ROW('no support available offline', 0.85),
  ROW('no one to contact outside', 0.85)
  ROW('support options exhausted', 1.0),
  ROW('nothing is helping anymore', 1.0),
  ROW('current support not working', 1.0),
  ROW('no effective support available', 1.0),
  ROW('outside help needed', 1.0),
  ROW('situation feels unmanageable alone', 1.0),
  ROW('cannot handle this safely alone', 1.0),
  ROW('support feels insufficient', 0.95),
  ROW('needs immediate external support', 1.0),
  ROW('requires urgent help', 1.0),
  ROW('safety feels uncertain', 1.0),
  ROW('risk feels too high', 1.0),
  ROW('support system not accessible', 0.95),
  ROW('no safe resolution in sight', 1.0),
  ROW('immediate assistance required', 1.0),
  ROW('overwhelming without support', 0.95),
  ROW('isolation feels unsafe', 1.0),
  ROW('cannot rely on personal support', 0.95),
  ROW('needs professional help', 1.0),
  ROW('help beyond personal circle required', 1.0),
  ROW('support channels unavailable', 0.95),
  ROW('personal help insufficient', 0.95),
  ROW('unsafe to remain unsupported', 1.0),
  ROW('no workable support option', 1.0),
  ROW('outside intervention necessary', 1.0),
  ROW('situation escalating', 1.0),
  ROW('distress increasing without support', 1.0),
  ROW('cannot stabilize alone', 1.0),
  ROW('support gap present', 0.9),
  ROW('needs immediate connection', 1.0),
  ROW('lack of safe support', 1.0),
  ROW('no reliable help source', 1.0),
  ROW('support resources depleted', 0.95),
  ROW('help needed right now', 1.0),
  ROW('critical support required', 1.0),
  ROW('unsafe emotional state', 0.8),
  ROW('risk without assistance', 1.0),
  ROW('cannot continue unsupported', 0.9),
  ROW('no stabilizing support', 1.0),
  ROW('requires immediate help', 1.0),
  ROW('outside support urgently needed', 1.0),
  ROW('support delay feels dangerous', 1.0),
  ROW('current coping not enough', 0.95),
  ROW('support failure detected', 0.95),
  ROW('critical situation', 1.0),
  ROW('safety concerns present', 1.0),
  ROW('help beyond chat required', 1.0),
  ROW('cannot rely on coping alone', 1.0),
  ROW('needs immediate human support', 1.0),
  ROW('support interruption occurred', 0.9),
  ROW('isolated and unsupported', 1.0),
  ROW('no protective support layer', 1.0),
  ROW('risk without supervision', 1.0),
  ROW('requires emergency-level help', 1.0),
  ROW('support unavailable when needed', 0.95),
  ROW('distress exceeds coping capacity', 1.0),
  ROW('unable to maintain safety alone', 1.0),
  ROW('no buffer against distress', 1.0),
  ROW('needs urgent assistance', 1.0),
  ROW('support access blocked', 0.95),
  ROW('help urgently required', 1.0),
  ROW('no safe fallback option', 1.0),
  ROW('cannot wait for support', 1.0),
  ROW('support delay unacceptable', 1.0),
  ROW('risk level elevated', 1.0),
  ROW('support system unavailable', 0.95),
  ROW('no immediate stabilizer', 1.0),
  ROW('unsafe without intervention', 1.0),
  ROW('help required now', 1.0),
  ROW('crisis-level distress', 1.0),
  ROW('no safe alternative support', 1.0),
  ROW('external help required immediately', 1.0),
  ROW('current situation unsafe', 1.0),
  ROW('needs urgent safety support', 1.0),
  ROW('cannot manage situation alone', 1.0),
  ROW('support pathway blocked', 0.95),
  ROW('no stabilizing connection', 1.0),
  ROW('immediate intervention required', 1.0),
  ROW('safety net missing', 1.0),
  ROW('help beyond peers required', 1.0),
  ROW('unsafe level of isolation', 1.0),
  ROW('support absence critical', 1.0),
  ROW('requires emergency support', 1.0),
  ROW('no viable support option', 1.0),
  ROW('situation requires hotline help', 1.0)

]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'success', wt
FROM actions a,
unnest(ARRAY[
  ROW('được giúp đỡ', 1.0),
  ROW('cảm thấy an toàn', 0.9),
  ROW('đã liên hệ thành công đường dây nóng', 1.0),
  ROW('đã kết nối với hỗ trợ khẩn cấp', 1.0),
  ROW('đã tiếp cận được hỗ trợ', 1.0),
  ROW('đã gọi đến đường dây hỗ trợ', 1.0),
  ROW('đã liên lạc với hỗ trợ khủng hoảng', 1.0),
  ROW('đang trao đổi với nhân viên hỗ trợ', 1.0),
  ROW('đang nhận trợ giúp từ đường dây nóng', 1.0),
  ROW('cuộc trò chuyện hỗ trợ đang diễn ra', 0.95),
  ROW('đã kết nối với trợ giúp khẩn', 1.0),
  ROW('đang được hỗ trợ trực tiếp', 1.0),
  ROW('cảm giác an toàn tăng lên', 1.0),
  ROW('tình trạng an toàn được cải thiện', 1.0),
  ROW('tình huống ổn định hơn', 0.95),
  ROW('mức độ rủi ro giảm', 1.0),
  ROW('không gian trở nên an toàn hơn', 0.95),
  ROW('trạng thái bình tĩnh hơn', 1.0),
  ROW('căng thẳng giảm xuống', 1.0),
  ROW('hoảng loạn đã dịu lại', 1.0),
  ROW('cảm xúc bớt dồn dập', 0.95),
  ROW('cân bằng cảm xúc được khôi phục', 1.0),
  ROW('được trấn an', 1.0),
  ROW('cảm thấy được lắng nghe', 1.0),
  ROW('cảm thấy được thấu hiểu', 1.0),
  ROW('cảm thấy được coi trọng', 1.0),
  ROW('cảm thấy được hỗ trợ chuyên môn', 1.0),
  ROW('nhận được hướng dẫn rõ ràng', 1.0),
  ROW('được hướng dẫn các bước tiếp theo', 1.0),
  ROW('được cung cấp cách đối phó', 0.95),
  ROW('được hướng dẫn xử lý tình huống', 1.0),
  ROW('nhận được chỉ dẫn an toàn', 1.0),
  ROW('cảm giác nhẹ nhõm xuất hiện', 1.0),
  ROW('áp lực giảm bớt', 0.95),
  ROW('gánh nặng tinh thần nhẹ hơn', 0.95),
  ROW('quá tải giảm xuống', 1.0),
  ROW('cảm xúc bớt nặng nề', 1.0),
  ROW('hỗ trợ phản hồi kịp thời', 1.0),
  ROW('hỗ trợ thể hiện sự quan tâm', 1.0),
  ROW('hỗ trợ thể hiện sự tôn trọng', 1.0),
  ROW('trải nghiệm hỗ trợ tích cực', 0.95),
  ROW('tương tác hỗ trợ hiệu quả', 1.0),
  ROW('tinh thần ổn định hơn', 1.0),
  ROW('suy nghĩ rõ ràng hơn', 1.0),
  ROW('tâm trí bớt rối loạn', 1.0),
  ROW('khả năng tập trung cải thiện', 0.95),
  ROW('cảm giác kiểm soát tăng', 1.0),
  ROW('đã bàn về kế hoạch an toàn', 1.0),
  ROW('đã xác định bước bảo vệ', 1.0),
  ROW('được hướng dẫn đảm bảo an toàn', 1.0),
  ROW('an toàn trước mắt được xử lý', 1.0),
  ROW('hỗ trợ giúp đảm bảo an toàn', 1.0),
  ROW('đã sắp xếp hỗ trợ tiếp theo', 1.0),
  ROW('được gợi ý hỗ trợ lâu dài', 0.95),
  ROW('được chia sẻ thêm nguồn lực', 1.0),
  ROW('được cung cấp lựa chọn trợ giúp', 1.0),
  ROW('đã thảo luận chăm sóc tiếp diễn', 1.0),
  ROW('cảm xúc được xác nhận', 1.0),
  ROW('mối quan tâm được ghi nhận', 1.0),
  ROW('trải nghiệm được bình thường hóa', 0.95),
  ROW('cảm giác được chấp nhận', 1.0),
  ROW('cảm giác được tôn trọng', 1.0),
  ROW('niềm tin được cải thiện', 0.95),
  ROW('hy vọng tăng lên', 1.0),
  ROW('sức mạnh tinh thần quay lại', 0.95),
  ROW('niềm tin vào khả năng đối phó tăng', 1.0),
  ROW('động lực giữ an toàn tăng', 1.0),
  ROW('khủng hoảng được hạ nhiệt', 1.0),
  ROW('tình huống được ổn định', 1.0),
  ROW('nguy cơ trước mắt giảm', 1.0),
  ROW('giai đoạn khẩn cấp đã qua', 0.95),
  ROW('tình huống trở nên kiểm soát được', 1.0),
  ROW('niềm tin vào hỗ trợ được hình thành', 1.0),
  ROW('cảm giác an toàn khi tìm kiếm trợ giúp', 1.0),
  ROW('hỗ trợ thể hiện độ tin cậy', 1.0),
  ROW('hỗ trợ phù hợp với nhu cầu', 0.95),
  ROW('hỗ trợ mang lại hiệu quả', 1.0),
  ROW('nhịp thở ổn định hơn', 0.95),
  ROW('căng cơ giảm', 0.95),
  ROW('cơ thể bớt căng thẳng', 0.95),
  ROW('cảm giác thư giãn tăng', 1.0),
  ROW('phản ứng stress giảm', 1.0),
  ROW('hỗ trợ từ đường dây nóng thành công', 1.0),
  ROW('trợ giúp khẩn cấp mang lại hiệu quả', 1.0),
  ROW('hỗ trợ đạt kết quả mong muốn', 1.0),
  ROW('an toàn được khôi phục sau liên hệ', 1.0),
  ROW('tương tác hỗ trợ giúp vượt qua khủng hoảng', 1.0),

  ROW('hotline contacted successfully', 1.0),
  ROW('emergency support reached', 1.0),
  ROW('connected with hotline support', 1.0),
  ROW('support line reached', 1.0),
  ROW('crisis support contacted', 1.0),
  ROW('currently speaking with support', 1.0),
  ROW('chatting with hotline staff', 1.0),
  ROW('receiving help from hotline', 1.0),
  ROW('support conversation ongoing', 0.95),
  ROW('connected to emergency assistance', 1.0),
  ROW('feels safer now', 1.0),
  ROW('safety has improved', 1.0),
  ROW('situation feels more stable', 0.95),
  ROW('risk level reduced', 1.0),
  ROW('environment feels safer', 0.95),
  ROW('calmer state achieved', 1.0),
  ROW('distress has decreased', 1.0),
  ROW('panic has eased', 1.0),
  ROW('emotional intensity lowered', 0.95),
  ROW('regained emotional balance', 1.0),
  ROW('received reassurance', 1.0),
  ROW('felt understood by support', 1.0),
  ROW('felt listened to', 1.0),
  ROW('felt taken seriously', 1.0),
  ROW('felt supported by professional', 1.0),
  ROW('received clear guidance', 1.0),
  ROW('given next steps to follow', 1.0),
  ROW('provided with coping steps', 0.95),
  ROW('guided through the situation', 1.0),
  ROW('received safety instructions', 1.0),
  ROW('sense of relief present', 1.0),
  ROW('pressure has lessened', 0.95),
  ROW('burden feels lighter', 0.95),
  ROW('overwhelm reduced', 1.0),
  ROW('emotional load decreased', 1.0),
  ROW('support felt responsive', 1.0),
  ROW('support felt caring', 1.0),
  ROW('support felt respectful', 1.0),
  ROW('support interaction positive', 0.95),
  ROW('support interaction helpful', 1.0),
  ROW('more grounded now', 1.0),
  ROW('thinking feels clearer', 1.0),
  ROW('mind feels more settled', 1.0),
  ROW('able to focus better', 0.95),
  ROW('sense of control improved', 1.0),
  ROW('safety plan discussed', 1.0),
  ROW('protective steps identified', 1.0),
  ROW('clear safety direction given', 1.0),
  ROW('immediate safety addressed', 1.0),
  ROW('support ensured safety', 1.0),
  ROW('follow up support arranged', 1.0),
  ROW('ongoing support suggested', 0.95),
  ROW('next resources shared', 1.0),
  ROW('additional help options provided', 1.0),
  ROW('continued care discussed', 1.0),
  ROW('emotions validated', 1.0),
  ROW('concerns acknowledged', 1.0),
  ROW('experience normalized', 0.95),
  ROW('felt accepted', 1.0),
  ROW('felt respected', 1.0),
  ROW('confidence slightly restored', 0.95),
  ROW('hope increased', 1.0),
  ROW('sense of strength returned', 0.95),
  ROW('belief in coping improved', 1.0),
  ROW('motivation to stay safe increased', 1.0),
  ROW('crisis de-escalated', 1.0),
  ROW('situation stabilized', 1.0),
  ROW('immediate danger reduced', 1.0),
  ROW('emergency phase passed', 0.95),
  ROW('situation feels manageable now', 1.0),
  ROW('trust in support established', 1.0),
  ROW('felt safe reaching out', 1.0),
  ROW('support felt reliable', 1.0),
  ROW('support felt appropriate', 0.95),
  ROW('support felt effective', 1.0),
  ROW('breathing steadied', 0.95),
  ROW('body tension reduced', 0.95),
  ROW('heart rate calmed', 0.95),
  ROW('physical calm increased', 1.0),
  ROW('stress response lowered', 1.0),
  ROW('hotline support successful', 1.0),
  ROW('emergency help effective', 1.0),
  ROW('support achieved desired outcome', 1.0),
  ROW('safety restored after contact', 1.0),
  ROW('support interaction resolved crisis', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'failure', wt
FROM actions a,
unnest(ARRAY[
  ROW('không kết nối được', 0.9),
  ROW('vẫn lo lắng', 0.8),
  ROW('không kết nối được đường dây', 1.0),
  ROW('không liên lạc được tổng đài', 1.0),
  ROW('cuộc gọi không thành công', 0.95),
  ROW('không có phản hồi từ tổng đài', 1.0),
  ROW('đường dây không hoạt động', 1.0),
  ROW('lỗi kết nối', 0.9),
  ROW('cuộc gọi bị ngắt', 0.9),
  ROW('hệ thống gặp sự cố', 0.85),
  ROW('tin nhắn không gửi được', 0.9),
  ROW('dịch vụ bị gián đoạn', 0.9),
  ROW('ngoài giờ hỗ trợ', 1.0),
  ROW('tổng đài đã đóng', 1.0),
  ROW('hiện không có hỗ trợ', 0.95),
  ROW('hết giờ làm việc', 0.95),
  ROW('thời gian chờ quá lâu', 0.9),
  ROW('không nhận được hỗ trợ', 1.0),
  ROW('khó tiếp cận hỗ trợ', 1.0),
  ROW('không kết nối được tư vấn viên', 1.0),
  ROW('không được giúp đỡ', 1.0),
  ROW('liên hệ không hiệu quả', 0.95),
  ROW('hỗ trợ không hữu ích', 1.0),
  ROW('cuộc trao đổi không hiệu quả', 0.95),
  ROW('không cảm thấy được hỗ trợ', 1.0),
  ROW('phản hồi thiếu gần gũi', 0.9),
  ROW('mức hỗ trợ chưa đủ', 1.0),
  ROW('vẫn chưa an toàn', 1.0),
  ROW('không thấy nhẹ hơn', 1.0),
  ROW('tình hình không thay đổi', 0.95),
  ROW('căng thẳng vẫn còn', 1.0),
  ROW('không cải thiện sau khi gọi', 1.0),
  ROW('chưa được hiểu đúng', 1.0),
  ROW('cảm thấy bị hiểu sai', 1.0),
  ROW('nhu cầu chưa được đáp ứng', 1.0),
  ROW('lo lắng không được ghi nhận', 0.95),
  ROW('phản hồi quá chung chung', 0.9),
  ROW('khó diễn đạt tình huống', 0.9),
  ROW('khó nói rõ suy nghĩ', 0.9),
  ROW('giao tiếp bị gián đoạn', 0.9),
  ROW('rào cản ngôn ngữ', 0.9),
  ROW('không thể tiếp tục trò chuyện', 0.95),
  ROW('do dự khi tiếp tục', 0.9),
  ROW('ngừng tìm kiếm hỗ trợ', 1.0),
  ROW('rút khỏi cuộc trò chuyện', 1.0),
  ROW('kết thúc cuộc gọi sớm', 0.95),
  ROW('không thể tiếp tục chia sẻ', 1.0),
  ROW('thiếu tin tưởng dịch vụ', 1.0),
  ROW('không cảm thấy thoải mái', 1.0),
  ROW('khó chia sẻ an toàn', 1.0),
  ROW('ngại mở lòng', 0.95),
  ROW('lo ngại về quyền riêng tư', 0.9),
  ROW('cảm giác tệ hơn sau đó', 1.0),
  ROW('tâm trạng xấu đi', 1.0),
  ROW('hỗ trợ làm tăng căng thẳng', 1.0),
  ROW('trải nghiệm quá nặng nề', 0.95),
  ROW('cảm thấy bất ổn', 0.95),
  ROW('không rõ bước tiếp theo', 1.0),
  ROW('không được hướng dẫn', 1.0),
  ROW('không biết nên làm gì tiếp', 1.0),
  ROW('chỉ dẫn khó hiểu', 0.9),
  ROW('kết thúc mà không có định hướng', 1.0),
  ROW('thiếu kết nối cảm xúc', 1.0),
  ROW('tương tác lạnh lùng', 0.95),
  ROW('thiếu sự đồng cảm', 1.0),
  ROW('hỗ trợ mang tính máy móc', 0.9),
  ROW('không tạo được sự an tâm', 0.95),
  ROW('khủng hoảng chưa được giải quyết', 1.0),
  ROW('vấn đề vẫn tồn tại', 1.0),
  ROW('hỗ trợ không giải quyết được', 1.0),
  ROW('căng thẳng vẫn kéo dài', 1.0),
  ROW('tình hình vẫn khó khăn', 0.95),
  ROW('không thể tiếp tục tìm hỗ trợ', 1.0),
  ROW('bỏ cuộc trong việc liên hệ', 1.0),
  ROW('ngừng thử liên lạc tổng đài', 1.0),
  ROW('mất động lực tìm kiếm trợ giúp', 0.95),
  ROW('nỗ lực trở nên vô ích', 1.0),
  ROW('kiệt quệ cảm xúc', 0.95),
  ROW('quá quá tải để tiếp tục', 1.0),
  ROW('quá mệt mỏi để trò chuyện', 0.95),
  ROW('cạn kiệt năng lượng', 0.9),
  ROW('không thể tham gia thêm', 1.0),
  ROW('vẫn cần hỗ trợ khẩn cấp', 1.0),
  ROW('khoảng trống hỗ trợ vẫn còn', 1.0),
  ROW('an toàn chưa được đảm bảo', 1.0),
  ROW('chưa tìm được hỗ trợ phù hợp', 1.0),
  ROW('rủi ro vẫn tồn tại', 1.0),

  ROW('hotline unavailable', 1.0),
  ROW('unable to reach hotline', 1.0),
  ROW('line not connecting', 0.95),
  ROW('call did not go through', 0.95),
  ROW('no response from hotline', 1.0),
  ROW('connection failed', 0.9),
  ROW('call dropped', 0.9),
  ROW('system error', 0.85),
  ROW('message not delivered', 0.9),
  ROW('service interruption', 0.9),
  ROW('outside service hours', 1.0),
  ROW('hotline closed', 1.0),
  ROW('not available at this time', 0.95),
  ROW('support hours ended', 0.95),
  ROW('long waiting time', 0.9),
  ROW('could not get support', 1.0),
  ROW('support not accessible', 1.0),
  ROW('unable to connect with counselor', 1.0),
  ROW('no assistance received', 1.0),
  ROW('attempt unsuccessful', 0.95),
  ROW('support did not help', 1.0),
  ROW('conversation felt ineffective', 0.95),
  ROW('did not feel supported', 1.0),
  ROW('response felt distant', 0.9),
  ROW('support felt insufficient', 1.0),
  ROW('still unsafe', 1.0),
  ROW('no sense of relief', 1.0),
  ROW('situation unchanged', 0.95),
  ROW('distress remains', 1.0),
  ROW('no improvement after call', 1.0),
  ROW('not fully understood', 1.0),
  ROW('felt misunderstood', 1.0),
  ROW('needs not addressed', 1.0),
  ROW('concerns not acknowledged', 0.95),
  ROW('response felt generic', 0.9),
  ROW('difficulty explaining situation', 0.9),
  ROW('hard to express thoughts', 0.9),
  ROW('communication felt blocked', 0.9),
  ROW('language barrier', 0.9),
  ROW('unable to continue conversation', 0.95),
  ROW('hesitation to continue', 0.9),
  ROW('stopped reaching out', 1.0),
  ROW('withdrew from conversation', 1.0),
  ROW('ended the call early', 0.95),
  ROW('unable to keep talking', 1.0),
  ROW('lack of trust in service', 1.0),
  ROW('did not feel comfortable', 1.0),
  ROW('felt unsafe sharing', 1.0),
  ROW('reluctant to open up', 0.95),
  ROW('privacy concerns', 0.9),
  ROW('felt worse afterward', 1.0),
  ROW('emotional state declined', 1.0),
  ROW('support increased distress', 1.0),
  ROW('experience felt overwhelming', 0.95),
  ROW('left feeling unsettled', 0.95),
  ROW('unclear next steps', 1.0),
  ROW('no guidance provided', 1.0),
  ROW('did not know what to do next', 1.0),
  ROW('instructions were confusing', 0.9),
  ROW('left without direction', 1.0),
  ROW('felt emotionally disconnected', 1.0),
  ROW('interaction felt cold', 0.95),
  ROW('lack of empathy', 1.0),
  ROW('support felt mechanical', 0.9),
  ROW('do no feel reassured', 0.9),
  ROW('no emotional resonance', 0.95),
  ROW('crisis unresolved', 1.0),
  ROW('problem still present', 1.0),
  ROW('support did not resolve issue', 1.0),
  ROW('distress ongoing', 1.0),
  ROW('situation remains difficult', 0.95),
  ROW('unable to continue seeking help', 1.0),
  ROW('gave up contacting support', 1.0),
  ROW('stopped trying hotline', 1.0),
  ROW('lost motivation to reach out', 0.95),
  ROW('effort felt pointless', 1.0),
  ROW('emotionally drained', 0.95),
  ROW('too overwhelmed to continue', 1.0),
  ROW('support process exhausting', 0.95),
  ROW('energy depleted', 0.9),
  ROW('unable to engage further', 1.0),
  ROW('still need immediate support', 1.0),
  ROW('support gap remains', 1.0),
  ROW('safety not ensured', 1.0),
  ROW('no secure support found', 1.0),
  ROW('still at risk', 1.0)
]::text_weight[]) AS t(kw text, wt numeric)
WHERE a.slug='handoff_hotline'
ON CONFLICT DO NOTHING;

INSERT INTO action_patterns (action_id, pattern, type, direction, weight)
SELECT a.id, kw, 'semantic_intent', 'followup', wt
FROM actions a,
unnest(ARRAY[
  ROW('bạn có muốn thử gọi lại không', 1.0),
  ROW('cảm thấy ổn hơn chưa', 0.8),
  ROW('kiểm tra lại sau hỗ trợ trước đó', 1.0),
  ROW('xem tình hình hiện tại ra sao', 1.0),
  ROW('theo dõi xem mọi thứ thế nào rồi', 0.95),
  ROW('muốn kiểm tra lại một chút', 0.95),
  ROW('xem cảm giác hiện tại có khác không', 0.9),
  ROW('đảm bảo tình hình đang an toàn', 1.0),
  ROW('kiểm tra mức độ ổn định hiện tại', 1.0),
  ROW('xem mọi thứ có bớt căng hơn không', 0.95),
  ROW('kiểm tra xem còn cần hỗ trợ không', 0.95),
  ROW('đảm bảo không có gì xấu hơn', 0.9),
  ROW('không cần phản hồi ngay', 1.0),
  ROW('có thể trả lời khi sẵn sàng', 1.0),
  ROW('chậm lại cũng hoàn toàn ổn', 0.95),
  ROW('không có gì gấp', 0.95),
  ROW('không gian này vẫn mở', 0.9),
  ROW('việc tìm hỗ trợ đã là một nỗ lực', 1.0),
  ROW('tìm kiếm giúp đỡ không hề dễ', 1.0),
  ROW('bước đó đòi hỏi sự can đảm', 0.95),
  ROW('ghi nhận nỗ lực đã thực hiện', 0.95),
  ROW('bước đi đó vẫn có ý nghĩa', 0.9),
  ROW('có thể chia sẻ cảm nhận nếu muốn', 1.0),
  ROW('thoải mái nói về trải nghiệm đó', 0.95),
  ROW('có thể nói điều gì hữu ích hay không', 0.9),
  ROW('không gian để chia sẻ suy nghĩ', 0.9),
  ROW('chỉ khi cảm thấy phù hợp', 0.9),
  ROW('có thể cân nhắc các hỗ trợ khác', 1.0),
  ROW('hỗ trợ có nhiều hình thức', 1.0),
  ROW('không chỉ có một con đường hỗ trợ', 0.95),
  ROW('có thể tìm phương án khác nếu cần', 0.95),
  ROW('mỗi người phù hợp hỗ trợ khác nhau', 0.9),
  ROW('vẫn ở đây', 1.0),
  ROW('không gian này vẫn sẵn sàng', 1.0),
  ROW('có thể tiếp tục hỗ trợ tại đây', 0.95),
  ROW('không biến mất', 0.9),
  ROW('tiếp tục đồng hành', 0.9),
  ROW('phản ứng khác nhau là điều bình thường', 1.0),
  ROW('trải nghiệm mỗi người khác nhau', 0.95),
  ROW('không có phản ứng đúng hay sai', 0.95),
  ROW('cảm giác mơ hồ cũng ổn', 0.9),
  ROW('mọi phản ứng đều hợp lệ', 0.9),
  ROW('quyết định tiếp theo hoàn toàn linh hoạt', 1.0),
  ROW('quyền kiểm soát vẫn được giữ', 1.0),
  ROW('không cần quyết định ngay', 0.95),
  ROW('các lựa chọn vẫn mở', 0.95),
  ROW('có thể thay đổi theo thời gian', 0.9),
  ROW('luôn sẵn sàng lắng nghe', 1.0),
  ROW('có mặt để hỗ trợ lúc này', 1.0),
  ROW('có thể tiếp tục khi cần', 0.95),
  ROW('hỗ trợ vẫn khả dụng', 0.95),
  ROW('ở đây không kỳ vọng gì', 0.9),
  ROW('những bước nhỏ có thể giúp ổn định', 0.95),
  ROW('tạm dừng ngắn có thể hữu ích', 0.9),
  ROW('hít thở chậm có thể giúp', 0.9),
  ROW('tập trung hiện tại có thể giảm căng thẳng', 0.9),
  ROW('giữ nhịp chậm rãi', 0.9),
  ROW('hỗ trợ không chỉ đến từ một nơi', 1.0),
  ROW('có thể có nguồn hỗ trợ khác', 1.0),
  ROW('nhiều con đường hỗ trợ đều hợp lệ', 0.95),
  ROW('mỗi người có hệ hỗ trợ khác nhau', 0.9),
  ROW('hỗ trợ có thể đến từ nhiều phía', 0.9),
  ROW('giữ mọi thứ trong mức chịu được', 1.0),
  ROW('tiến từng bước một', 1.0),
  ROW('không cần giải quyết tất cả ngay', 0.95),
  ROW('tập trung bước tiếp theo nhỏ nhất', 0.95),
  ROW('giảm áp lực là quan trọng', 0.9),
  ROW('sẵn sàng lắng nghe điều hữu ích', 1.0),
  ROW('quan tâm điều gì giúp ổn hơn', 0.95),
  ROW('lắng nghe nhu cầu cá nhân', 0.95),
  ROW('đi theo điều cảm thấy phù hợp', 0.9),
  ROW('ưu tiên điều mang lại an tâm', 0.9),
  ROW('xứng đáng được hỗ trợ', 1.0),
  ROW('nhu cầu là quan trọng', 1.0),
  ROW('tìm giúp đỡ là hợp lý', 1.0),
  ROW('việc này là chính đáng', 0.95),
  ROW('việc cần hỗ trợ là bình thường', 0.95),
  ROW('tiếp tục một cách nhẹ nhàng', 0.95),
  ROW('tiến lên cẩn trọng', 0.9),
  ROW('giữ nhịp ổn định', 0.9),
  ROW('không cần vội vàng', 0.9),
  ROW('giữ sự vững vàng', 0.9),
  ROW('có thể kiểm tra lại sau', 0.95),
  ROW('hỗ trợ luôn sẵn sàng', 1.0),
  ROW('cuộc trò chuyện có thể tiếp tục', 1.0),
  ROW('quay lại bất cứ lúc nào', 1.0),
  ROW('luôn ở đây khi cần', 1.0),

  ROW('checking in after earlier support', 1.0),
  ROW('just checking how things are now', 1.0),
  ROW('following up to see how things are going', 0.95),
  ROW('wanted to check in again', 0.95),
  ROW('checking if things feel any different', 0.9),
  ROW('making sure things feel safe right now', 1.0),
  ROW('checking on current safety', 1.0),
  ROW('seeing if things feel more stable', 0.95),
  ROW('checking if support is still needed', 0.95),
  ROW('making sure things have not escalated', 0.9),
  ROW('no pressure to respond immediately', 1.0),
  ROW('response can happen at any pace', 1.0),
  ROW('taking time is completely okay', 0.95),
  ROW('there is no rush here', 0.95),
  ROW('this space stays open', 0.9),
  ROW('reaching out earlier took effort', 1.0),
  ROW('seeking support is not easy', 1.0),
  ROW('it took courage to try that step', 0.95),
  ROW('acknowledging the effort made', 0.95),
  ROW('that step still mattered', 0.9),
  ROW('open to sharing how that went', 1.0),
  ROW('comfortable to reflect on that experience', 0.95),
  ROW('any thoughts about what helped or did not', 0.9),
  ROW('space to share impressions', 0.9),
  ROW('optional to talk about how it felt', 0.9),
  ROW('other support options can be explored', 1.0),
  ROW('different forms of support exist', 1.0),
  ROW('there are multiple ways to get support', 0.95),
  ROW('alternatives are available if needed', 0.95),
  ROW('support can look different for everyone', 0.9),
  ROW('staying here for now', 1.0),
  ROW('this space remains available', 1.0),
  ROW('support can continue here', 0.95),
  ROW('not going anywhere', 0.9),
  ROW('remaining present', 0.9),
  ROW('mixed reactions are common', 1.0),
  ROW('responses can vary widely', 0.95),
  ROW('there is no right reaction', 0.95),
  ROW('experiences differ for everyone', 0.9),
  ROW('it is okay if things feel unclear', 0.9),
  ROW('next steps can be chosen freely', 1.0),
  ROW('control stays with the individual', 1.0),
  ROW('nothing has to be decided now', 0.95),
  ROW('options remain open', 0.95),
  ROW('choices can change over time', 0.9),
  ROW('available to listen', 1.0),
  ROW('here to support in this moment', 1.0),
  ROW('ready to continue when needed', 0.95),
  ROW('support remains accessible', 0.95),
  ROW('present without expectations', 0.9),
  ROW('small grounding steps can help', 0.95),
  ROW('short pauses can be useful', 0.9),
  ROW('breathing slowly may help', 0.9),
  ROW('simple grounding can reduce intensity', 0.9),
  ROW('focusing on the present can help', 0.9),
  ROW('other trusted support may exist', 1.0),
  ROW('support does not have to be one source', 1.0),
  ROW('multiple support paths are valid', 0.95),
  ROW('support systems vary', 0.9),
  ROW('help can come from different places', 0.9),
  ROW('keeping things manageable', 1.0),
  ROW('taking things one step at a time', 1.0),
  ROW('no need to solve everything now', 0.95),
  ROW('focusing on the next small step', 0.95),
  ROW('reducing pressure matters', 0.9),
  ROW('open to hearing what feels helpful', 1.0),
  ROW('curious about what feels supportive', 0.95),
  ROW('listening to preferences', 0.95),
  ROW('open to guidance on what helps', 0.9),
  ROW('following what feels right', 0.9),
  ROW('support is deserved', 1.0),
  ROW('needs matter', 1.0),
  ROW('seeking help is valid', 1.0),
  ROW('support is appropriate here', 0.95),
  ROW('needs are important', 0.95),
  ROW('continuing gently', 0.95),
  ROW('moving forward carefully', 0.9),
  ROW('keeping things steady', 0.9),
  ROW('maintaining a calm pace', 0.9),
  ROW('staying grounded together', 0.9),
  ROW('checking again later if helpful', 0.95),
  ROW('support remains available anytime', 1.0),
  ROW('this conversation can continue', 1.0),
  ROW('returning here is always okay', 1.0),
  ROW('remaining available for support', 1.0)
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