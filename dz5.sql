-- Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]
CREATE or replace VIEW users_before_18 AS 
  SELECT count(*)
  FROM profiles f
    JOIN users u ON u.id = f.user_id
  WHERE TIMESTAMPDIFF(year,birthday,now())<18;
-- Выведите данные, используя написанное представление [SELECT]
-- получим количество пользователей младше 18 из представления 
select *
from users_before_18;
-- Удалите представление [DROP VIEW]
DROP VIEW users_before_18;


-- * Сколько новостей (записей в таблице media) у каждого пользователя? Вывести поля: 
-- news_count (количество новостей), user_id (номер пользователя),
-- user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.

WITH cte1 AS (
	select 
		count(*) as news_count,
		m.user_id, 
		u.email
	from media m
	join users u on u.id=m.user_id
	group by m.user_id)
SELECT *
FROM cte1 ;
