DROP PROCEDURE IF EXISTS realty_agency.update_percent_realtor;
#Увеличивает процентную ставку на percent_inc для риэлторов, у кого ставка меньше for_less_perc, также им в поле notes записывает, что ставка была увеличена
DELIMITER //
CREATE PROCEDURE realty_agency.update_percent_realtor(percent_inc smallint unsigned,for_less_perc smallint unsigned)
BEGIN
	UPDATE realty_agency.realtor 
	SET commission_percent=commission_percent+percent_inc,notes=CONCAT('Ставка повышена на ',percent_inc,' процента (',(SELECT CURDATE()),')')
	WHERE commission_percent<for_less_perc;
END //
#Было изменено 36 строк
#call update_percent_realtor(2,15);