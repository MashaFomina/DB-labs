#удалим из таблицы realtor запись, с которой связано 0 заявок
DROP PROCEDURE IF EXISTS realty_agency.del_realtor_not_connected;

DELIMITER //
CREATE PROCEDURE realty_agency.del_realtor_not_connected()
BEGIN
	DELETE FROM realty_agency.realtor
	WHERE id NOT IN (SELECT DISTINCT id_realtor	FROM request);
END //

call del_realtor_not_connected();