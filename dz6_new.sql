
-- триггер 
-- Написать триггер, который проверяет новое появляющееся сообщество.
-- Длина названия сообщества (поле name) должна быть не менее 5 символов. 
-- Если требование не выполнено, то выбрасывать исключение с пояснением.

DROP TRIGGER IF EXISTS check_comm_insert;

DELIMITER //

CREATE TRIGGER check_comm_insert 
BEFORE INSERT ON communities
FOR EACH row
BEGIN
    IF length(NEW.name)<5 THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Название должно быть не менее 5 символов';
    END IF;

END//

DELIMITER ;



-- обработка ошибки в транзакции
DROP PROCEDURE IF EXISTS `sp_del_user3`;

DELIMITER $$

CREATE PROCEDURE `sp_del_user3`(id_user_delete int, OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
   	DECLARE code varchar(100);
   	DECLARE error_string varchar(100);
   	-- DECLARE last_user_id int;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
    	SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	SET tran_result = CONCAT('Error occured. Code: ', code, '. Text: ', error_string);
    END;
    START TRANSACTION;
   
    DELETE FROM users_communities
    WHERE user_id=id_user_delete;
   
    DELETE l FROM likes AS l
    JOIN media AS m ON l.media_id=m.id
    WHERE m.user_id= id_user_delete;
   
    DELETE l FROM likes AS l
    WHERE l.user_id= id_user_delete;
   
   	DELETE  FROM friend_requests as fr
    WHERE (fr.initiator_user_id=id_user_delete);
   
   	DELETE  FROM friend_requests as fr2
    WHERE (fr2.target_user_id=id_user_delete);
   
    DELETE FROM messages AS mes
    WHERE (mes.from_user_id=id_user_delete) or (mes.to_user_id=id_user_delete) ;
   
    DELETE p FROM profiles AS p
    JOIN media AS m ON m.id=p.photo_id
    WHERE m.user_id=id_user_delete;
   
    DELETE m FROM media AS m
    WHERE m.user_id=id_user_delete;  
   
    DELETE  FROM profiles AS p
    WHERE p.user_id=id_user_delete;
  
    DELETE  FROM users as u
    WHERE u.id=id_user_delete;
   
    IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		SET tran_result := 'ok';
	       COMMIT;
	    END IF;
	 
END $$

DELIMITER ;
-- вызываем процедуру
CALL sp_del_user3(3,@tran_result);

-- смотрим результат
SELECT @tran_result;

-- Функции
/*
Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk.
 Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи,
 профиль и запись из таблицы users. Функция должна возвращать номер пользователя.
*/

USE vk;

DROP FUNCTION IF EXISTS func_delete_all;

DELIMITER // -- выставим разделитель
CREATE FUNCTION func_delete_all(id_user_delete BIGINT UNSIGNED)
RETURNS INT READS SQL DATA
  BEGIN
	  
	DELETE FROM users_communities
    WHERE user_id=id_user_delete;
   
    DELETE l FROM likes AS l
    JOIN media AS m ON l.media_id=m.id
    WHERE m.user_id= id_user_delete;
   
    DELETE l FROM likes AS l
    WHERE l.user_id= id_user_delete;
   
   	DELETE  FROM friend_requests as fr
    WHERE (fr.initiator_user_id=id_user_delete);
   
   	DELETE  FROM friend_requests as fr2
    WHERE (fr2.target_user_id=id_user_delete);
   
    DELETE FROM messages AS mes
    WHERE (mes.from_user_id=id_user_delete) OR (mes.to_user_id=id_user_delete) ;
   
    DELETE p FROM profiles AS p
    JOIN media AS m ON m.id=p.photo_id
    WHERE m.user_id=id_user_delete;
   
    DELETE m FROM media AS m
    WHERE m.user_id=id_user_delete;  
   
    DELETE  FROM profiles AS p
    WHERE p.user_id=id_user_delete;
  
    DELETE  FROM users as u
    WHERE u.id=id_user_delete;
   
    RETURN id_user_delete;
  END //
  
DELIMITER ; -- вернем прежний разделитель


-- Вызов функции / результаты
SELECT func_delete_all(4);
 

 