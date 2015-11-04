#удалим из таблицы address записи, с которыми не связано ни одно жильё
DROP PROCEDURE IF EXISTS realty_agency.del_address_not_connected;

DELIMITER //
CREATE PROCEDURE realty_agency.del_address_not_connected()
BEGIN
	DELETE FROM realty_agency.address
	WHERE id NOT IN (SELECT DISTINCT `address`	FROM housing_characteristics);
END //

call del_address_not_connected();
#DISTINCT - чтобы уникальные значения выбрать