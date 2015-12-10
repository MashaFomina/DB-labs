#Посмотрим комиссии, полученные от продаж квартир у станции метро пл. Мужества
# Query 1
SELECT SUM(CASE WHEN (request.commission IS NULL) THEN 0 ELSE request.commission END) as commission
FROM deal
INNER JOIN request
ON deal.id_req1=request.id OR deal.id_req2=request.id
INNER JOIN subject_req
ON request.id=subject_req.id_req
INNER  JOIN housing_characteristics
ON subject_req.id_apartment=housing_characteristics.id
WHERE housing_characteristics.station_metro=1 AND request.type_req=2; 
# Длительность  1 query: 0.109 sec
# Query 2
SELECT SUM(CASE WHEN (req1.commission IS NULL) THEN 0 ELSE req1.commission END) as commission
FROM deal as bis
LEFT JOIN request as req1
ON bis.id_req1=req1.id OR bis.id_req2=req1.id
LEFT JOIN subject_req as s_r1
ON req1.id=s_r1.id_req
LEFT JOIN housing_characteristics as h_c1
ON s_r1.id_apartment=h_c1.id
WHERE h_c1.station_metro=1 AND req1.type_req=2; 
#Длительность  2 queries: 0.188 sec.
# Query 3
SELECT SUM(CASE WHEN (commission IS NULL) THEN 0 ELSE commission END) as commission
FROM request 
WHERE request.type_req=2 AND (request.id IN (SELECT id_req1 FROM deal WHERE id_req1 is not null) OR request.id IN (SELECT id_req2 FROM deal WHERE id_req2 is not null)) AND 
request.id IN (SELECT id_req FROM subject_req WHERE id_apartment IN (SELECT id FROM  housing_characteristics WHERE station_metro=1));
# Длительность  3 queries: 2.637 sec
# При выполнении всех трех запросов получен один и тот же результат commission=90324048