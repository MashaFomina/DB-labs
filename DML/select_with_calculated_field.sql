#Получаем комиссию, которую принес каждый риэлтор за 2015 год
DROP VIEW IF EXISTS `realtor_2015_commission`;
CREATE VIEW `realtor_2015_commission`
AS SELECT `id_realtor`,SUM(commission)
FROM `request`
WHERE `date_req` LIKE '2015-%'
GROUP by `id_realtor`;