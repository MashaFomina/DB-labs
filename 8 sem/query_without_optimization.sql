SELECT req.id_realtor as id_realtor,pers.first_name,pers.last_name,pers.patronymic,sum(req.commission) as sum_commissions
FROM request as req
LEFT JOIN person as pers
on id_realtor=pers.id
WHERE (req.commission IS NOT NULL) AND 
(SELECT district FROM district WHERE (SELECT id_district FROM address WHERE 
(SELECT address FROM housing_characteristics
WHERE (CASE WHEN ((SELECT id_apartment FROM subject_req WHERE req.id=id_req) IS NULL) THEN 
(SELECT id_apartment FROM subject_req WHERE id_req=(SELECT id_req1 FROM deal WHERE id_req2=req.id AND id_req1 IS NOT NULL UNION SELECT id_req2 FROM deal WHERE id_req1=req.id AND id_req2 IS NOT NULL))
ELSE (SELECT id_apartment FROM subject_req WHERE req.id=id_req) END)=id)=id)=id)='Кировский' AND
((SELECT date_reception FROM commission_realtors WHERE req.id=id_req) BETWEEN '2013-01-01' AND '2016-01-01')
GROUP BY id_realtor
ORDER BY sum_commissions DESC
LIMIT 10;