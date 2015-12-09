# Вычислить среднюю стоимость сделки в зависимости от длины цепочки.
# Стоимость считать каждой сделки отдельно, а не суммарную стоимость по
# цепочке.
# Стоимость сделки будем считать по деньгам полученным непосредственно агенством
DROP PROCEDURE IF EXISTS realty_agency.average_cost_deal_length_chain;
DROP FUNCTION IF EXISTS realty_agency.get_length_chain;
DELIMITER //
CREATE FUNCTION realty_agency.get_length_chain (nc int,ncp int)
RETURNS INT
BEGIN
declare i int;
declare finish tinyint(1);
set i=1;
set finish=0;
WHILE (finish=0) DO
		if ((SELECT count(*) FROM deal WHERE prev_contract_number=nc) + (SELECT count(*) FROM deal WHERE number_contract=ncp)) > 0 then
		begin
			
			if (SELECT count(*) FROM deal WHERE prev_contract_number=nc) > 0 then
				set nc=(SELECT number_contract FROM deal WHERE prev_contract_number=nc);
				set i=i+1;
			end if;
			if (SELECT count(*) FROM deal WHERE number_contract=ncp) > 0 then
				set ncp=(SELECT prev_contract_number FROM deal WHERE number_contract=ncp);
				set i=i+1;
			end if;
		end;
		else begin
			set finish=1;
		end;
		end if;
END WHILE;
return(i);
END; //
DELIMITER //
CREATE PROCEDURE realty_agency.average_cost_deal_length_chain ()
BEGIN
	SELECT (CASE WHEN ((bis.prev_contract_number IS NULL) AND (bis.number_contract NOT IN (SELECT prev_contract_number FROM deal WHERE prev_contract_number=bis.number_contract))) 
	THEN	1 ELSE realty_agency.get_length_chain(bis.number_contract,bis.prev_contract_number) END) as length_chain,count(*) as count_of_deals,
	AVG(CASE WHEN(req2.id is null) then req1.commission else case when(req1.id is null) then req2.commission else
	 req2.commission + req1.commission end end) as average_cost
	
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
	
	GROUP BY length_chain;
END //

call realty_agency.average_cost_deal_length_chain();