-- Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.

SELECT users.id, firstname, lastname, count(community_id) AS `count`
FROM users
JOIN users_communities AS uc ON id=uc.user_id
GROUP BY users.id 
ORDER BY `count` DESC;
-- Подсчитать количество пользователей в каждом сообществе.
SELECT  community_id,name,count(community_id) AS `count`
FROM users_communities AS uc
JOIN communities  AS comm ON community_id=comm.id
GROUP BY community_id 
ORDER BY `count` DESC;

-- Пусть задан некоторый пользователь. Из всех пользователей соц. 
-- сети найдите человека, который больше всех общался с 
-- выбранным пользователем (написал ему сообщений).
SELECT from_user_id,firstname,lastname, count(*) AS `count`
FROM messages
JOIN users AS u ON from_user_id=u.id
WHERE to_user_id=1
GROUP BY from_user_id
ORDER BY count DESC;

-- * Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
SELECT COUNT(l.id) AS `count_year<18`
FROM likes AS l
JOIN media AS m ON l.media_id=m.id
JOIN profiles AS p ON m.user_id=p.user_id
WHERE TIMESTAMPDIFF(YEAR,p.birthday,NOW())<18;

-- * Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 
	CASE (p.gender)
		WHEN 'f' THEN 'женский'
		WHEN 'm' THEN 'мужской'
	end as 'gender' ,
	COUNT(l.id) AS `count_gender`
FROM likes AS l
JOIN profiles AS p ON l.user_id=p.user_id
GROUP BY gender
ORDER BY`count_gender`DESC ;


