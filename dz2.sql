USE vk;
DROP TABLE IF EXISTS music_list;
CREATE TABLE music_list(
	idsong BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    title_song VARCHAR(100),
    artist VARCHAR(100),
    genre VARCHAR(100),
    album VARCHAR(100),
    duration TIME,
    year_song YEAR
);
ALTER TABLE music_list
ADD INDEX title_song_index (title_song);

DROP TABLE IF EXISTS user_music;
CREATE TABLE user_music(
	id SERIAL,
	id_user BIGINT UNSIGNED NOT NULL,
    id_song_user BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_song_user) REFERENCES music_list(idsong)
);

INSERT  INTO users (firstname,lastname,email,password_hash, phone)
VALUES ('Иван','Петров','qwerty@mail.ru','12345','89001002356'),
('Петр','Иванов','petrov@mail.ru','12345','89001002776');







INSERT  INTO music_list (idsong,title_song,artist,album,genre,duration,year_song )
VALUES (1,'song1','aaa','QW','pop','03:00','1999'),
(2,'song14','aaнеa','QнкW','pop','03:00','2000'),
(3,'song31','aaкнa','QвапW','pop','01:00','1999'),
(4,'song351','aаaa','QваW','pop','03:00','1999'),
(5,'song351','aарaa','QWва','pop','03:00','2022'),
(6,'song2351','aарвaa','QвапW','pop','03:00','1999'),
(7,'song351','aaврa','QвапW','pop','05:00','1999'),
(8,'song351','aaврa','QвапW','pop','03:00','2025'),
(9,'song351','aврaa','QваW','pop','06:00','1999');


INSERT  INTO user_music (id_user,id_song_user)
VALUES ('1','5'),('1','7'),('1','9'),('1','6'),('2','1'),('2','2'),('2','5'),('2','9'),('2','3');

INSERT  INTO profiles (user_id,gender,birthday)
VALUES (1,'m','2010-01-12'),(2,'m','2010-01-12');



-- 4.* Написать скрипт, отмечающий несовершеннолетних 
--   пользователей как неактивных (поле is_active = true).
-- При необходимости предварительно добавить такое поле 
-- в таблицу profiles со значением по умолчанию = false 
-- (или 0) (ALTER TABLE + UPDATE)
ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT false;

UPDATE profiles
SET `is_active` = '1'
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP,5) < RIGHT(birthday,5)) < 18
;
UPDATE profiles
SET `is_active` = '1'
WHERE TIMESTAMPDIFF(YEAR,CURRENT_TIMESTAMP,birthday) < 18
 ;

ALTER TABLE profiles ADD COLUMN age INT ;

UPDATE profiles
SET `age` = TIMESTAMPDIFF(YEAR,birthday,CURRENT_TIMESTAMP);



-- 5.* Написать скрипт, удаляющий сообщения
-- «из будущего» (дата позже сегодняшней) (DELETE)

INSERT  INTO messages (from_user_id,to_user_id,body)
VALUES ('1','2','wrqwrq'),('2','1','111111111');

UPDATE messages
SET `created_at` = '2025-12-11'
WHERE id=2;
;


DELETE FROM messages
WHERE created_at>now();



