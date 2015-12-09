DROP TRIGGER IF EXISTS auto_deal;
DELIMITER //
CREATE TRIGGER auto_deal BEFORE INSERT ON deal FOR EACH ROW
BEGIN
IF (SELECT count(*) FROM deal WHERE number_contract = new.number_contract) > 0 then
 SET new.number_contract = (SELECT MAX(number_contract) FROM deal)+1;
END IF;
END; //

call insert_deal ((SELECT MAX(number_contract) FROM(deal))+1,100,null,"2015-10-15",3200000,null,null); #Не существующий
SELECT MAX(number_contract) FROM deal;
call insert_deal ((SELECT MAX(number_contract) FROM(deal)),101,null,"2015-10-15",3200000,null,null);#Вставляем уже существующий номер контракта