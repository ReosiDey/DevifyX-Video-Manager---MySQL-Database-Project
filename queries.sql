
-- 1. View all users
SELECT * FROM users;

-- 2. Get all videos with their status and uploader name
SELECT v.video_id, v.title, v.description, v.duration, v.upload_date, v.uploader_id, v.privacy, v.is_deleted
FROM videos v
JOIN video_upload_status vus ON v.video_id = vus.video_id
JOIN users u ON v.uploader_id = u.user_id;

-- 3. Search videos by tag (example: 'education')
SELECT v.video_id, v.title, t.name AS tag
FROM videos v
JOIN video_tags vt ON v.video_id = vt.video_id
JOIN tags t ON vt.tag_id = t.tag_id
WHERE t.name = 'education';

-- 4. List all playlists created by users
SELECT p.playlist_id, p.name AS playlist_name, u.username
FROM playlists p
JOIN users u ON p.created_by = u.user_id;

-- 5. Show videos in a playlist with their order
SELECT p.name AS playlist_name, v.title, pv.position
FROM playlists p
JOIN playlist_videos pv ON p.playlist_id = pv.playlist_id
JOIN videos v ON pv.video_id = v.video_id
ORDER BY p.name, pv.position;

-- 6. Fetch top 5 most viewed videos
SELECT v.title, COUNT(sl.log_id) AS views
FROM videos v
JOIN streaming_logs sl ON v.video_id = sl.video_id
GROUP BY v.video_id
ORDER BY views DESC
LIMIT 5;

-- 7. Fetch total watch time for videos
SELECT v.title, SUM(sl.watch_duration) AS total_watch_time
FROM videos v
JOIN streaming_logs sl ON v.video_id = sl.video_id
GROUP BY v.video_id;

-- 8. Average video ratings
SELECT v.title, AVG(r.rating) AS avg_rating
FROM videos v
JOIN video_ratings r ON v.video_id = r.video_id
GROUP BY v.video_id;

-- 9. Show soft-deleted videos
SELECT * FROM videos WHERE is_deleted = TRUE;

-- 10. Comments on a specific video (e.g., video_id = 1)
SELECT u.username, vc.comment_text, vc.commented_at
FROM video_comments vc
JOIN users u ON vc.user_id = u.user_id
WHERE vc.video_id = 1;

-- 11. Collaborative playlists (bonus feature)
SELECT pc.playlist_id, p.name AS playlist_name, u.username AS collaborator
FROM playlist_collaborators pc
JOIN playlists p ON pc.playlist_id = p.playlist_id
JOIN users u ON pc.user_id = u.user_id;
