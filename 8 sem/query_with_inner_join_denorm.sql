SELECT req.id_realtor as id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM request_with_reception as req
INNER JOIN person as pers
on id_realtor=pers.id
INNER JOIN subject_req as s_r
ON s_r.id_req=(CASE WHEN (req.type_req = 1 OR req.type_req = 3) THEN 
(SELECT id_req1 FROM deal WHERE id_req2=req.id UNION SELECT id_req2 FROM deal WHERE id_req1=req.id)
ELSE req.id END)
INNER JOIN housing_characteristics_district_with_district as h_c
ON s_r.id_apartment=h_c.id
WHERE (req.commission IS NOT NULL) AND h_c.district='Кировский' AND
(req.date_reception BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY id_realtor
ORDER BY sum_commissions DESC
LIMIT 10;