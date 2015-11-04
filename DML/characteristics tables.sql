#Вычисление нескольких совокупных характеристик таблиц
#Число заявок с риэлторами, за них отвечающими
DROP VIEW IF EXISTS `count_not_closed_req`;
CREATE VIEW `count_not_closed_req`
AS SELECT `id_realtor`,count(`type_req`)
FROM `request`
WHERE `commission` IS NULL
GROUP BY `id_realtor`;

#Количество сделок в 2015 году
DROP VIEW IF EXISTS `count_deals_2015`;
CREATE VIEW `count_deals_2015`
AS SELECT count(`number_contract`)
FROM `deal`
WHERE `date_deal` LIKE '2015-%';