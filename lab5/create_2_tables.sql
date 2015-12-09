DROP PROCEDURE IF EXISTS realty_agency.insert_criterion_req;
DROP TABLE IF EXISTS realty_agency.criterion_req;
DROP TABLE IF EXISTS realty_agency.buy_sell_req;
	
#Создание двух таблиц
CREATE TABLE `criterion_req` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id критериев',
	`id_req` int(10) unsigned NOT NULL COMMENT 'Id заявки на покупку',
  `type_housing` int(10) unsigned COMMENT 'FK типа жилья',
  `district` int(10) unsigned COMMENT 'FK района',
  `square_common_min` decimal(10,3) unsigned COMMENT 'Площадь общая минимальная',
  `square_common_max` decimal(10,3) unsigned COMMENT 'Площадь общая максимальная',
  `elevator` tinyint(1) COMMENT 'Показывает есть ли лифт',
  `rubbish_chute` tinyint(1) COMMENT 'Показывает есть ли мусоропровод',
  `shared_bathroom` tinyint(1) COMMENT 'Показывает разделенный ли санузел',
  `desire_cost_min` bigint unsigned COMMENT 'Желаемая стоимость покупки минимальная',
  `desire_cost_max` bigint unsigned COMMENT 'Желаемая стоимость покупки максимальная',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`type_housing`) REFERENCES `type_housing`(`id`),
  FOREIGN KEY (`id_req`) REFERENCES `request`(`id`),
  FOREIGN KEY (`district`) REFERENCES `district`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит критерии поиска квартиры';
CREATE TABLE `buy_sell_req` (
  `id_net` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK связи',
  `req_buy` int(10) unsigned NOT NULL COMMENT 'FK заяки на покупку',
  `req_sell` int(10) unsigned NOT NULL COMMENT 'FK подходящей заявки на продажу',
  PRIMARY KEY (`id_net`),
  FOREIGN KEY (`req_buy`) REFERENCES `request`(`id`),
  FOREIGN KEY (`req_sell`) REFERENCES `request`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит связи запросов на покупку с подходящими запросами на продажу';

#Создание процедуры для добавления новой заявки на покупку и ее критериев
DELIMITER //
CREATE PROCEDURE realty_agency.insert_criterion_req (id_client int(10) unsigned,date_req date,notes text charset utf8,id_realtor int(10) unsigned,
th int(10) unsigned,distr int(10) unsigned,
square_c_min decimal(10,3) unsigned,square_c_max decimal(10,3) unsigned,
elev tinyint(1),rubbish tinyint(1),shared_b tinyint(1),desire_cost_min bigint unsigned,`desire_cost_max` bigint unsigned)
BEGIN
	INSERT INTO realty_agency.request (`id_client`,`date_req`,`type_req`,`notes`,`id_realtor`) VALUES
	(id_client,date_req,1,notes,id_realtor);
	INSERT INTO realty_agency.criterion_req (`id_req`,`type_housing`,`district`,`square_common_min`,`square_common_max`,
	`elevator`,`rubbish_chute`,`shared_bathroom`,`desire_cost_min`,`desire_cost_max`) VALUES
	(LAST_INSERT_ID(),th,distr,square_c_min,square_c_max,elev,rubbish,shared_b,desire_cost_min,desire_cost_max);
END //
DELIMITER //
#call insert_criterion_req(1000,"2015-10-15",null,97,2,4,null,70,1,1,null,1000000,2500000);