#удалим из таблицы address записи, с которыми не связано ни одно жильё
DROP PROCEDURE IF EXISTS realty_agency.del_district_not_connected;

DELIMITER //
CREATE PROCEDURE realty_agency.del_district_not_connected()
BEGIN
	DELETE FROM realty_agency.district
	WHERE id NOT IN (SELECT DISTINCT `id_district`	FROM station_metro UNION SELECT DISTINCT `id_district`	FROM address);
END //

call del_district_not_connected();