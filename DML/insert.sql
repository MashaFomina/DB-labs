DROP PROCEDURE IF EXISTS realty_agency.insert_th;
DROP PROCEDURE IF EXISTS realty_agency.insert_person;
DROP PROCEDURE IF EXISTS realty_agency.insert_ght;
DROP PROCEDURE IF EXISTS realty_agency.insert_tr;
DROP PROCEDURE IF EXISTS realty_agency.insert_town_reg;
DROP PROCEDURE IF EXISTS realty_agency.insert_district;
DROP PROCEDURE IF EXISTS realty_agency.insert_metro;
DROP PROCEDURE IF EXISTS realty_agency.insert_realtor;
DROP PROCEDURE IF EXISTS realty_agency.insert_address;
DROP PROCEDURE IF EXISTS realty_agency.insert_house_ch;
DROP PROCEDURE IF EXISTS realty_agency.insert_rooms;
DROP PROCEDURE IF EXISTS realty_agency.insert_request;
DROP PROCEDURE IF EXISTS realty_agency.insert_subject_req;
DROP PROCEDURE IF EXISTS realty_agency.insert_deal;
DROP PROCEDURE IF EXISTS realty_agency.insert_commission_realtors;

DELIMITER //
CREATE PROCEDURE realty_agency.insert_th (th varchar(100) charset utf8)
BEGIN
	INSERT INTO realty_agency.type_housing(type_housing) VALUES (th);
END //

#call insert_th('temp th');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_person (last_name varchar(50) charset utf8,first_name varchar(50) charset utf8,patronymic varchar(50) charset utf8,email varchar(100),
  telephone bigint unsigned,passport varchar(400) charset utf8, passw varchar(30),INN bigint unsigned)
BEGIN
	INSERT INTO realty_agency.person(`last_name`,`first_name`,`patronymic`,`email`,`telephone`,`passport`,`password`,`INN`) VALUES
	(last_name,first_name,patronymic,email,telephone,passport,passw,INN);
END //
#call insert_person('Корчагина','Александра', 'Викторовна', 'korcagina1_a_v@mail.ru', 89013456789, '4008,685307,04.02.1991,ж,ТП №29 отдела УФМСВ по СПБ и ЛО,04.03.2011,г.СПб пр.Ветеранов д.77 кв.33','lalala',400000000000);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_ght(group_house varchar(100) charset utf8)
BEGIN
	INSERT INTO realty_agency.group_house_type(`group_house_type`) VALUES (group_house);
END //
#call insert_ght('Новый тип');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_tr(type_req varchar(100) charset utf8)
BEGIN
	INSERT INTO realty_agency.type_request(`type_request`) VALUES (type_req);
END //
#call insert_tr('Новый тип');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_town_reg(town varchar(100) charset utf8)
BEGIN
	INSERT INTO realty_agency.town_region(`town_region`) VALUES (town);
END //
#call insert_town_reg('Новый тип');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_district(distr varchar(100) charset utf8,id_town_region int(10) unsigned)
BEGIN
	INSERT INTO realty_agency.district(`district`,`id_town_region`) VALUES (distr,id_town_region);
END //
#call insert_district('Новый район',1);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_metro(id_district int(10) unsigned,station varchar(100) charset utf8)
BEGIN
	INSERT INTO realty_agency.station_metro (`id_district`,`station`) VALUES (id_district,station);
END //
#call insert_metro(5,'Станция новая');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_realtor(id_person int(10) unsigned,date_reception date,commission_percent smallint unsigned,childrens tinyint(1),notes text charset utf8)
BEGIN
	INSERT INTO realty_agency.realtor (`id_person`, `date_reception`,`commission_percent`,`childrens`,`notes`) VALUES (id_person,date_reception,commission_percent,childrens,notes);
END //
#call insert_realtor(110,'2015-03-05',8,0,'Ляя-ляя');

DELIMITER //
CREATE PROCEDURE realty_agency.insert_address(id_district int(10) unsigned,street varchar(100) charset utf8,house_number smallint unsigned,housing tinyint unsigned,flat_number smallint unsigned,porch_number tinyint unsigned)
BEGIN
	INSERT INTO realty_agency.address (`id_district`,`street`,`house_number`,`housing`,`flat_number`,`porch_number`) VALUES (id_district,street,house_number,housing,flat_number,porch_number);
END //
#call insert_address(5, 'пр. Ветеранов',86,null,15,null);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_house_ch (th int(10) unsigned,ght int(10) unsigned,station int(10) unsigned,adr int(10) unsigned,
  square_c decimal(10,3),square_k decimal(5,2) unsigned,fl_r tinyint unsigned,comment_ text charset utf8,elev tinyint(1),
  rubbish tinyint(1),shared_b tinyint(1),completion_date date,dist_metro time)
BEGIN
	INSERT INTO realty_agency.housing_characteristics (`type_housing`,`group_house_type`,`station_metro`,`address`,`square_common`,`square_kitchen`,
	`floor`,`comment`,`elevator`,`rubbish_chute`,`shared_bathroom`,`completion date`,`distance_metro`) VALUES
	(th,ght,station,adr,square_c,square_k,fl_r,comment_,elev,rubbish,shared_b,completion_date,dist_metro);
END //
#call insert_house_ch(2,1,2,100007,50,10,2,null,1,1,1,"0000-00-00","00:12:00");

DELIMITER //
CREATE PROCEDURE realty_agency.insert_rooms(id_house int(10) unsigned,square_room decimal(5,2) unsigned)
BEGIN
	INSERT INTO realty_agency.rooms (`id_house`,`square_rooms`) VALUES (id_house,square_room);
END //
#call insert_rooms(100007,30.15);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_request(id_client int(10) unsigned,date_req date,type_req int(10) unsigned,notes text charset utf8,commission bigint unsigned,id_realtor int(10) unsigned)
BEGIN
	INSERT INTO realty_agency.request (`id_client`,`date_req`,`type_req`,`notes`,`commission`,`id_realtor`) VALUES
	(id_client,date_req,type_req,notes,commission,id_realtor);
END //
#call insert_request(100007,"2015-10-15",2,null,115000,97);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_subject_req(id_req int(10) unsigned,id_apartment int(10) unsigned,desire_cost bigint unsigned)
BEGIN
	INSERT INTO realty_agency.subject_req (`id_req`,`id_apartment`,`desire_cost`) VALUES (id_req,id_apartment,desire_cost);
END //
#call insert_subject_req((SELECT MAX(`id`) FROM(`request`)),100007,3000000);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_deal(number_contract int(10) unsigned,id_req1 int(10) unsigned,id_req2 int(10) unsigned,date_deal date,fact_cost bigint unsigned,notes text charset utf8,prev_contract_number int(10) unsigned)
BEGIN
	INSERT INTO realty_agency.deal (`number_contract`,`id_req1`,`id_req2`,`date_deal`,`fact_cost`,`notes`,`prev_contract_number`) VALUES
	(number_contract,id_req1,id_req2,date_deal,fact_cost,notes,prev_contract_number);
END //
#call insert_deal ((SELECT MAX(number_contract) FROM(deal))+1,(SELECT MAX(id) FROM(request)),null,"2015-10-15",3200000,null,null);

DELIMITER //
CREATE PROCEDURE realty_agency.insert_commission_realtors(id_req int(10) unsigned,commission bigint unsigned,date_reception date)
BEGIN
	INSERT INTO realty_agency.commission_realtors (`id_req`,`commission`,`date_reception`) VALUES (id_req,commission,date_reception);
END //
#call insert_commission_realtors ((SELECT MAX(id) FROM(request)),(SELECT commission_percent FROM(realtor) WHERE id=97)*115000/100,"2015-11-15");
