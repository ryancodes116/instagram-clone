-- who are the 5 oldest users?
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

-- what day of the week do most users register on?
SELECT DATE_FORMAT(created_at, '%W') AS day,
COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

-- which users have never posted a photo?
SELECT username
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- which photo has the most likes?
SELECT 
  username,
  photos.id, 
  photos.image_url,
  COUNT(*) AS total
FROM photos
INNER JOIN likes
  ON likes.photo_id = photos.id
INNER JOIN users
  ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- how many times does the average user post?
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS 'average posts';

-- what are the top 5 hashtags?
SELECT tag_name, COUNT(*) AS total
FROM photo_tags
INNER JOIN tags
  ON photo_tags.tag_id = tags.id 
GROUP BY tag_id
ORDER BY total DESC
LIMIT 5;

-- which users have liked every photo on the site?
SELECT username, COUNT(*) AS num_likes
FROM users
INNER JOIN likes
  ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);