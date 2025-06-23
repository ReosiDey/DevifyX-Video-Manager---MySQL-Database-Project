
-- 👤 Users
INSERT INTO users (username, email, role, password_hash) VALUES
('rahul_mehra', 'rahul@example.com', 'admin', 'test123'),
('ananya_verma', 'ananya@example.com', 'uploader', 'test123'),
('arjun_singh', 'arjun@example.com', 'viewer', 'test123'),
('isha_patel', 'isha@example.com', 'uploader', 'test123');

-- 🎞️ Videos
INSERT INTO videos (title, description, duration, upload_date, uploader_id, privacy, is_deleted) VALUES
('Intro to SQL', 'A beginner-friendly SQL tutorial in Hindi', 600, NOW(), 2, 'public', FALSE),
('Advanced MySQL', 'Covers indexing and optimization techniques', 1200, NOW(), 2, 'unlisted', FALSE);

-- 📦 Video Upload Status
INSERT INTO video_upload_status (video_id, status, updated_at) VALUES
(1, 'approved', NOW()),
(2, 'pending', NOW());

-- 📊 Streaming Logs
INSERT INTO streaming_logs (video_id, user_id, watch_time, watch_duration, watched_at) VALUES
(1, 3, 200, 180, NOW()),
(1, 4, 400, 360, NOW()),
(2, 3, 300, 300, NOW());

-- 📂 Playlists
INSERT INTO playlists (name, created_by) VALUES
('Data Science Tutorials', 3),
('SQL Learning Path', 4);

-- 🎬 Playlist Videos
INSERT INTO playlist_videos (playlist_id, video_id, position) VALUES
(1, 1, 1),
(2, 2, 1),
(2, 1, 2);

-- 🏷️ Tags
INSERT INTO tags (name) VALUES
('sql'), ('database'), ('tutorial');

-- 🔗 Video Tags
INSERT INTO video_tags (video_id, tag_id) VALUES
(1, 1), (1, 3), (2, 2);

-- 🗂️ Categories
INSERT INTO categories (name) VALUES
('Education'), ('Technology');

-- 📎 Video Categories
INSERT INTO video_categories (video_id, category_id) VALUES
(1, 1), (2, 2);

-- ⭐ Ratings
INSERT INTO video_ratings (video_id, user_id, rating) VALUES
(1, 3, 5), (2, 3, 4);

-- 💬 Comments
INSERT INTO video_comments (video_id, user_id, comment_text, commented_at) VALUES
(1, 3, 'Great explanation in simple Hindi!', NOW()),
(2, 3, 'Please add subtitles.', NOW());

-- 👥 Playlist Collaborators (Bonus)
INSERT INTO playlist_collaborators (playlist_id, user_id) VALUES
(1, 4);
