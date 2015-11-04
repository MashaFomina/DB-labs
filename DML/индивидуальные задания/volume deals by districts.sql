#Выводим распределение суммарных объемов сделок по районам (я считала объем сделок по сумме коммисионных с закрытых заявок,
#т.е. по деньгам полученным непосредственно агенством)
DROP VIEW IF EXISTS volume_sum_deals_in_districts;
CREATE VIEW volume_sum_deals_in_districts
AS SELECT CASE WHEN (dist1.district IS NULL) THEN dist2.district ELSE dist1.district END as district_of_deals,
SUM((CASE WHEN (req2.commission IS NULL) THEN 0 ELSE req2.commission END)+(CASE WHEN (req1.commission IS NULL) THEN 0 ELSE req1.commission END)) as volume_daels

FROM deal as bis
LEFT JOIN request as req1
ON bis.id_req1=req1.id
LEFT JOIN subject_req as s_r1
ON req1.id=s_r1.id_req
LEFT JOIN housing_characteristics as h_c1
ON s_r1.id_apartment=h_c1.id
LEFT JOIN address as adr1
ON h_c1.address=adr1.id
LEFT JOIN district as dist1
ON adr1.id_district=dist1.id

LEFT JOIN request as req2
ON bis.id_req2=req2.id
LEFT JOIN subject_req as s_r2
ON req2.id=s_r2.id_req
LEFT JOIN housing_characteristics as h_c2
ON s_r2.id_apartment=h_c2.id
LEFT JOIN address as adr2
ON h_c2.address=adr2.id
LEFT JOIN district as dist2
ON adr2.id_district=dist2.id

WHERE req1.commission IS NOT NULL OR req2.commission IS NOT NULL
GROUP BY district_of_deals;