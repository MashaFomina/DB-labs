SELECT req.id_realtor as id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM request as req
INNER JOIN person as pers
on id_realtor=pers.id
INNER JOIN commission_realtors as cr
on req.id=cr.id_req
INNER JOIN subject_req as s_r
ON s_r.id_req=(CASE WHEN (req.type_req = 1 OR req.type_req = 3) THEN 
(SELECT id_req1 FROM deal WHERE id_req2=req.id AND id_req1 IS NOT NULL UNION SELECT id_req2 FROM deal WHERE id_req1=req.id AND id_req2 IS NOT NULL)
ELSE req.id END)
INNER JOIN housing_characteristics as h_c
ON s_r.id_apartment=h_c.id
INNER JOIN address as adr
ON h_c.address=adr.id
INNER JOIN district as dist
ON adr.id_district=dist.id
WHERE (req.commission IS NOT NULL) AND dist.district='Кировский' AND
(cr.date_reception BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY id_realtor
ORDER BY sum_commissions DESC
LIMIT 10;