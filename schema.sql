-- 1. USER MANAGEMENT
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'uploader', 'viewer') DEFAULT 'viewer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. VIDEO STORAGE
CREATE TABLE videos (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    duration INT CHECK (duration > 0),
    upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    uploader_id INT,
    privacy ENUM('public', 'private', 'unlisted') DEFAULT 'public',
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (uploader_id) REFERENCES users(user_id)
);

-- 3. VIDEO UPLOAD TRACKING
CREATE TABLE video_upload_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    video_id INT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- 4. STREAMING LOGS
CREATE TABLE streaming_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    video_id INT,
    user_id INT,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    watch_duration INT CHECK (watch_duration >= 0),
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 5. PLAYLIST MANAGEMENT
CREATE TABLE playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_by INT,
    is_collaborative BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- 6. PLAYLIST-VIDEO ASSOCIATION
CREATE TABLE playlist_videos (
    playlist_id INT,
    video_id INT,
    position INT,
    PRIMARY KEY (playlist_id, video_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- 7. CATEGORIES AND TAGS
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE video_categories (
    video_id INT,
    category_id INT,
    PRIMARY KEY (video_id, category_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE video_tags (
    video_id INT,
    tag_id INT,
    PRIMARY KEY (video_id, tag_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);

-- 8. VIDEO COMMENTS AND RATINGS (BONUS)
CREATE TABLE video_comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    video_id INT,
    user_id INT,
    comment_text TEXT,
    commented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE video_ratings (
    video_id INT,
    user_id INT,
    rating TINYINT CHECK (rating BETWEEN 1 AND 5),
    rated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (video_id, user_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 9. INDEXES FOR PERFORMANCE
CREATE INDEX idx_video_title ON videos(title);
CREATE INDEX idx_video_uploader ON videos(uploader_id);
CREATE INDEX idx_tag_name ON tags(name); 
CREATE INDEX idx_category_name ON categories(name);

-- 10. COLLABORATIVE PLAYLISTS (BONUS)
CREATE TABLE playlist_collaborators (
    playlist_id INT,
    user_id INT,
    PRIMARY KEY (playlist_id, user_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
