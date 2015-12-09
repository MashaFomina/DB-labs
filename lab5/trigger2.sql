# Триггер который перед тем как удалить запись из таблицы address проверяет встречается ли она в таблице housing_characteristics
DROP TRIGGER IF EXISTS check_del_addr;
DELIMITER //
CREATE TRIGGER check_del_addr BEFORE DELETE ON address FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM housing_characteristics WHERE address  = old.id) > 0 then
	SIGNAL SQLSTATE '45000' # unhandled user-defined exception
   SET MESSAGE_TEXT = 'This address is using in table housing_characteristics', MYSQL_ERRNO = 1001;
END IF;
END; //
DELETE FROM address WHERE id=2;