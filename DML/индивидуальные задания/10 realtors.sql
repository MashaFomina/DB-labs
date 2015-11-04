#Выведем 10 риэлторов, которые получили максимальные комиссионные (т.е. вся сумма, котороя пошла агенству, включая проценты, которые пошли агенту) по сделкам в районе за период

#Хотелось сделать процедуру с параметрами, но оказалось, что при создании VIEW нельзя использовать параметры,
#поэтому просто создается VIEW с определенными значениями

#DROP PROCEDURE IF EXISTS realty_agency.show_realtor_com_in_district_period;
#DELIMITER //
#CREATE PROCEDURE realty_agency.show_realtor_com_in_district_period (district_name varchar(100) charset utf8,start_date date,end_date date)
#BEGIN
	DROP VIEW IF EXISTS realtors_10_max_com;
	CREATE VIEW realtors_10_max_com AS
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
#END //

#call show_realtor_com_in_district_period ('Кировский','2015-01-01','2016-01-01');