#Квартиры с площадью от 150 до 200 кв м
DROP VIEW IF EXISTS `flats_with_square_between_150_and_200`;
CREATE VIEW `flats_with_square_between_150_and_200`
AS SELECT *
FROM `housing_characteristics`
WHERE `type_housing`=2 AND `square_common` BETWEEN 150 AND 200;

#Жилье в Калининском районе
DROP VIEW IF EXISTS `house_in_kalininskom_district`;
CREATE VIEW `house_in_kalininskom_district`
AS SELECT *
FROM `housing_characteristics`
WHERE `station_metro` IN (1,4,9);

#Жилье напротив метро
DROP VIEW IF EXISTS `house_near_metro`;
CREATE VIEW `house_near_metro`
AS SELECT *
FROM `housing_characteristics`
WHERE `distance_metro` LIKE '00:00:%' OR `distance_metro` LIKE '00:01:%';