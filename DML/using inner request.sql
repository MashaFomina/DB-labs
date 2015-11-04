#использование вложенного запроса
#Выбираем жильё по названию района - Кировский
DROP VIEW IF EXISTS houses_in_kirovskii_district;
CREATE VIEW houses_in_kirovskii_district
AS SELECT *
FROM housing_characteristics
WHERE station_metro IN (SELECT id FROM station_metro WHERE id_district=(SELECT id FROM district WHERE district="Кировский"));