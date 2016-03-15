SELECT req.id_realtor as id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM request as req
LEFT JOIN person as pers
on id_realtor=pers.id
LEFT JOIN commission_realtors as cr
on req.id=cr.id_req
LEFT JOIN subject_req as s_r
ON req.id=s_r.id_req
LEFT JOIN housing_characteristics as h_c
ON (CASE WHEN (s_r.id_apartment IS NULL) THEN 
(SELECT id_apartment FROM subject_req WHERE id_req=
(SELECT id_req1 FROM deal WHERE id_req2=req.id UNION SELECT id_req2 FROM deal WHERE id_req1=req.id))
ELSE s_r.id_apartment END)=h_c.id
LEFT JOIN address as adr
ON h_c.address=adr.id
LEFT JOIN district as dist
ON adr.id_district=dist.id
WHERE (req.commission IS NOT NULL) AND dist.district='Кировский' AND
(cr.date_reception BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY id_realtor
ORDER BY sum_commissions DESC
LIMIT 10;