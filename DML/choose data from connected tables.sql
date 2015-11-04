#Выборка данных из связанных таблиц (не менее двух примеров)

DROP VIEW IF EXISTS house_with_req;
CREATE VIEW house_with_req
AS SELECT c.id_req,id_client,id_realtor,type_req,c.id_apartment,c.desire_cost, d.address,d.square_common,d.station_metro
FROM request
LEFT JOIN subject_req as c
ON id=c.id_req
LEFT JOIN housing_characteristics as d
ON c.id_apartment=d.id
WHERE commission IS NULL AND (type_req=2 OR type_req=4)
ORDER BY c.id_req;

DROP VIEW IF EXISTS realtor_with_full_info;
CREATE VIEW realtor_with_full_info
AS SELECT c.first_name,c.last_name,c.patronymic,c.telephone,c.email,date_reception,commission_percent,childrens,notes
FROM realtor
LEFT JOIN person as c
ON id_person=c.id
WHERE commission_percent > 20
ORDER BY c.first_name ASC;