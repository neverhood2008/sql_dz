-- Написать скрипт, возвращающий список имен (только firstname)
--  пользователей без повторений в алфавитном порядке. [ORDER BY]
SELECT DISTINCT firstname
FROM users
ORDER BY firstname;

-- Выведите количество мужчин старше 35 лет [COUNT].
SELECT count(*) as count_m
FROM profiles
WHERE  TIMESTAMPDIFF(YEAR, birthday, NOW()) >35 AND gender='m';

-- Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
SELECT status, count(*) as count
FROM friend_requests
GROUP BY status;

-- * Выведите номер пользователя, который отправил больше 
-- всех заявок в друзья (таблица friend_requests) [LIMIT].

select initiator_user_id, count(*) 
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY initiator_user_id ASC
LIMIT 1;

-- * Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].users_communities
SELECT id , `name`
FROM communities
WHERE `name` LIKE '_____';