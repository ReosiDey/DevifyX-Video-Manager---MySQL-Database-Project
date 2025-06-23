# DevifyX-Video-Manager---MySQL-Database-Project
Welcome to the DevifyX Video Manager — a database-only project built using MySQL that powers a full-featured video content platform. 
This backend system handles:

User roles (admin, uploader, viewer)
Video uploads and metadata
Playlists, tags, ratings, and comments
Video privacy settings
Search and streaming logs
No frontend or backend code — just solid, scalable SQL database design.

What’s Inside

Here’s what each file in the project does:

schema.sql – Creates all tables with proper relationships and constraints
sample_data.sql – Populates the tables with example users, videos, playlists, and logs
queries.sql – Sample SQL queries to test, analyze, and showcase the database
README.md – This documentation file to help you understand and set everything up
Prerequisites

Make sure you have:

MySQL Server (8.x or Homebrew version like 9.3.0 on macOS)
A working terminal and MySQL CLI
A macOS or Linux system (this guide assumes you're on a Mac)
How to Set It Up

Step 1: Start MySQL Server
On a Mac (via Homebrew):

mysql.server start
Step 2: Create the Database
Inside the MySQL shell:

CREATE DATABASE devifyx_video_manager;
Step 3: Load the Schema
In your terminal:

mysql -u root devifyx_video_manager < ~/Desktop/schema.sql
Step 4: Insert Sample Data

mysql -u root devifyx_video_manager < ~/Downloads/sample_data.sql
Step 5: Run the Queries

mysql -u root devifyx_video_manager < ~/Desktop/queries.sql
Key Features

User Roles: Admins, uploaders, and viewers with access control
Video Uploads: Title, duration, status, uploader info
Playlists: Create, edit, and order videos inside playlists
Categories/Tags: Organize videos for easy search
Ratings and Comments: For viewer feedback
Logs: Streaming data like who watched what, and for how long
Privacy Settings: Public, private, or unlisted videos
Soft Deletes: Archive videos without permanent removal
Example Queries

-- List all users
SELECT * FROM users;

-- Get videos uploaded by 'reosi_dey'
SELECT * FROM videos WHERE uploader_id = (
  SELECT user_id FROM users WHERE username = 'reosi_dey'
);

-- Top 2 videos based on average rating
SELECT v.title, AVG(r.rating) as avg_rating
FROM videos v
JOIN video_ratings r ON v.video_id = r.video_id
GROUP BY v.video_id
ORDER BY avg_rating DESC
LIMIT 2;
Notes

If you ever get an error like:
"table already exists"

Run this to reset:

DROP DATABASE devifyx_video_manager;


