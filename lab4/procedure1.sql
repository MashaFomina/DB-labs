# Вывести динамику статистики продаж по районам: поквартальный объем
# продаж в сравнении с аналогичным периодом годом ранее.
DROP PROCEDURE IF EXISTS realty_agency.stat_this_prev_year;
DELIMITER //
CREATE PROCEDURE realty_agency.stat_this_prev_year (year_comp int)
BEGIN
#Будем выводить районы, разницу количества продаж в районе, разницу комиссионных 
	SELECT CASE WHEN (dist1.district IS NULL) THEN dist2.district ELSE dist1.district END as district_of_deals,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 1 AND 3) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN 1 ELSE -1 END) END) as I_diff_count,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 4 AND 6) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN 1 ELSE -1 END) END) as II_diff_count,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 7 AND 9) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN 1 ELSE -1 END) END) as III_diff_count,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 10 AND 12) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN 1 ELSE -1 END) END) as IV_diff_count,
	
# Думала выводить суммарные фактические стоимости продаж за год по кварталам, но решила, что лучше выврдить разницу в деньгах, которую получило именно агенство
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 1 AND 3) AND year(bis.date_deal)=year_comp-1) THEN bis.fact_cost ELSE 0 END) as I_prev,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 4 AND 6) AND year(bis.date_deal)=year_comp-1) THEN bis.fact_cost ELSE 0 END) as II_prev,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 7 AND 9) AND year(bis.date_deal)=year_comp-1) THEN bis.fact_cost ELSE 0 END) as III_prev,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 10 AND 12) AND year(bis.date_deal)=year_comp-1) THEN bis.fact_cost ELSE 0 END) as IV_prev,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 1 AND 3) AND year(bis.date_deal)=year_comp) THEN bis.fact_cost ELSE 0 END) as I_current,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 4 AND 6) AND year(bis.date_deal)=year_comp) THEN bis.fact_cost ELSE 0 END) as II_current,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 7 AND 9) AND year(bis.date_deal)=year_comp) THEN bis.fact_cost ELSE 0 END) as III_current,
#	SUM(CASE WHEN ((month(bis.date_deal) BETWEEN 10 AND 12) AND year(bis.date_deal)=year_comp) THEN bis.fact_cost ELSE 0 END) as IV_current,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 1 AND 3) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN (CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) ELSE -(CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) END) ELSE 0 END) as I_diff,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 4 AND 6) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN (CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) ELSE -(CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) END) ELSE 0 END) as II_diff,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 7 AND 9) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN (CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) ELSE -(CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) END) ELSE 0 END) as III_diff,
	SUM(CASE WHEN (month(bis.date_deal) BETWEEN 10 AND 12) THEN (CASE WHEN year(bis.date_deal)=year_comp THEN (CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) ELSE -(CASE WHEN (req2.type_req=2) THEN req2.commission ELSE req1.commission END) END) ELSE 0 END) as IV_diff
	
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
	
	WHERE (req1.type_req=2 OR req2.type_req=2) AND bis.date_deal>concat(year_comp-1,'-01-01')
	GROUP BY district_of_deals;
END //

call realty_agency.stat_this_prev_year(2014);