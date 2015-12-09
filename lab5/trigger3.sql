# Триггер который заполняет `buy_sell_req` запросами на покупки и подходящими запросами на продажу
DROP TRIGGER IF EXISTS make_connections;
DELIMITER //
CREATE TRIGGER make_connections AFTER INSERT ON criterion_req FOR EACH ROW
BEGIN
	INSERT INTO `buy_sell_req` (`req_buy`,`req_sell`)
	SELECT new.id_req, req.id
	FROM request as req
	LEFT JOIN subject_req as s_r
	ON req.id=s_r.id_req
	LEFT JOIN housing_characteristics as h_c
	ON s_r.id_apartment=h_c.id
	LEFT JOIN address as adr
	ON h_c.address=adr.id
	LEFT JOIN district as dist
	ON adr.id_district=dist.id
	WHERE (req.type_req=2
	AND CASE WHEN (new.type_housing is not null) THEN h_c.type_housing=new.type_housing ELSE h_c.type_housing LIKE '%' END
	AND CASE WHEN (new.district is not null) THEN dist.id=new.district ELSE dist.id LIKE '%' END
	AND CASE WHEN (new.square_common_min is not null and new.square_common_max is not null) THEN h_c.square_common BETWEEN new.square_common_min AND new.square_common_max ELSE 
	CASE WHEN (new.square_common_min is not null) THEN h_c.square_common>=new.square_common_min ELSE CASE WHEN (new.square_common_max is not null) THEN h_c.square_common<=new.square_common_max
	ELSE h_c.square_common LIKE '%' END END END
	AND CASE WHEN (new.elevator is not null) THEN h_c.elevator=new.elevator ELSE h_c.elevator LIKE '%' END
	AND CASE WHEN (new.rubbish_chute is not null) THEN h_c.rubbish_chute=new.rubbish_chute ELSE h_c.rubbish_chute LIKE '%' END
	AND CASE WHEN (new.shared_bathroom is not null) THEN h_c.shared_bathroom=new.shared_bathroom ELSE h_c.shared_bathroom LIKE '%' END
	
	AND CASE WHEN (new.desire_cost_min is not null and new.desire_cost_max is not null) THEN s_r.desire_cost BETWEEN new.desire_cost_min AND new.desire_cost_max ELSE 
	CASE WHEN (new.desire_cost_min is not null) THEN s_r.desire_cost>=new.desire_cost_min ELSE CASE WHEN (new.desire_cost_max is not null) THEN s_r.desire_cost<=new.desire_cost_max
	ELSE s_r.desire_cost LIKE '%' END END END
	AND ((SELECT count(*) FROM deal WHERE id_req1=req.id) + (SELECT count(*) FROM deal WHERE id_req2=req.id)) = 0
	);
END; //
call insert_criterion_req(1000,"2015-10-15",null,97,2,4,null,70,1,1,null,1000000,5000000);