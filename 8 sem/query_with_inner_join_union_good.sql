select id_realtor, first_name, last_name, patronymic, sum(sum_commissions) as com
from
(SELECT req.id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM DEAL as deal
INNER JOIN request as req
ON req.id=deal.id_req1
INNER JOIN person as pers
on id_realtor=pers.id
INNER JOIN commission_realtors as cr
on req.id=cr.id_req
INNER JOIN subject_req as s_r
ON s_r.id_req=(CASE WHEN (req.type_req = 1 OR req.type_req = 3) THEN (deal.id_req2) ELSE req.id END)
INNER JOIN housing_characteristics as h_c
ON s_r.id_apartment=h_c.id
INNER JOIN address as adr
ON h_c.address=adr.id
INNER JOIN district as dist
ON adr.id_district=dist.id
WHERE dist.district='Кировский' AND
(cr.date_reception BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY req.id_realtor
UNION ALL
SELECT req.id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM DEAL as deal
INNER JOIN request as req
ON req.id=deal.id_req2
INNER JOIN person as pers
on id_realtor=pers.id
INNER JOIN commission_realtors as cr
on req.id=cr.id_req
INNER JOIN subject_req as s_r
ON s_r.id_req=(CASE WHEN (req.type_req = 1 OR req.type_req = 3) THEN (deal.id_req1) ELSE req.id END)
INNER JOIN housing_characteristics as h_c
ON s_r.id_apartment=h_c.id
INNER JOIN address as adr
ON h_c.address=adr.id
INNER JOIN district as dist
ON adr.id_district=dist.id
WHERE dist.district='Кировский' AND
(cr.date_reception BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY req.id_realtor) q
GROUP BY id_realtor
ORDER BY com DESC
LIMIT 10;
