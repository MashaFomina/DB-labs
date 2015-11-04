CREATE DATABASE IF NOT EXISTS `realty_agency`;
DROP TABLE IF EXISTS`commission_realtors`;
DROP TABLE IF EXISTS `subject_req`;
DROP TABLE IF EXISTS `deal`;
DROP TABLE IF EXISTS `request`;
DROP TABLE IF EXISTS `realtor`;
DROP TABLE IF EXISTS `type_request`;
DROP TABLE IF EXISTS `rooms`;
DROP TABLE IF EXISTS `housing_characteristics`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `station_metro`;
DROP TABLE IF EXISTS `district`;
DROP TABLE IF EXISTS `town_region`;
DROP TABLE IF EXISTS `type_housing`;
DROP TABLE IF EXISTS `group_house_type`;
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id человека',
  `last_name` varchar(50) NOT NULL COMMENT 'Фамилия',
  `first_name` varchar(50) NOT NULL COMMENT 'Имя',
  `patronymic` varchar(50) NOT NULL COMMENT 'Отчество',
  `email` varchar(100) NOT NULL COMMENT 'email' CHECK (`email` LIKE ('%_@__%.__%')),
  `telephone` bigint unsigned NOT NULL COMMENT 'номер телефона' CHECK (`telephone` < 100000000000000),
  `passport` varchar(400) NOT NULL COMMENT 'Паспортные данные: серия,номер; год рождения; пол; кем, когда выдан; место регистрации',
  `password` varchar(30) COMMENT 'пароль',
  `INN` bigint unsigned COMMENT 'ИНН физического лица' CHECK (`INN` < 1000000000000),
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о человеке (клиенте, риэлторе)';

CREATE TABLE `group_house_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id типа дома',
  `group_house_type` varchar(100) NOT NULL COMMENT 'Наименование группы типов домов',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о типе дома';

CREATE TABLE `type_housing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id типа жилья',
  `type_housing` varchar(100) NOT NULL COMMENT 'Наименование типов жилья',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о типе жилья';

CREATE TABLE `town_region` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id города/области',
  `town_region` varchar(100) NOT NULL COMMENT 'Название городов/областей',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о городах/областях';

CREATE TABLE `district` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id района',
  `district` varchar(100) NOT NULL COMMENT 'Название района',
  `id_town_region` int(10) unsigned NOT NULL COMMENT 'FK города/области',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_town_region`) REFERENCES `town_region`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о районах городов/областей';

CREATE TABLE `station_metro` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id станции метро',
  `station` varchar(100) NOT NULL COMMENT 'Название станции метро',
  `id_district` int(10) unsigned NOT NULL COMMENT 'FK района',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_district`) REFERENCES `district`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о станциях метро, относящихся к району';

CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id адреса',
  `id_district` int(10) unsigned NOT NULL COMMENT 'FK района',
  `street` varchar(100) NOT NULL COMMENT 'Название поселка, улицы и т.п.',
  `house_number` smallint unsigned NOT NULL COMMENT 'Номер дома',
  `housing` tinyint unsigned COMMENT 'Корпус дома',
  `flat_number` smallint unsigned COMMENT 'Номер квартиры',
  `porch_number` tinyint unsigned COMMENT 'Номер парадной',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_district`) REFERENCES `district`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о адресе жилья';

CREATE TABLE `housing_characteristics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id характеристик',
  `type_housing` int(10) unsigned NOT NULL COMMENT 'FK типа жилья',
  `group_house_type` int(10) unsigned NOT NULL COMMENT 'FK типа дома',
  `station_metro` int(10) unsigned COMMENT 'FK станции метро',
  `address` int(10) unsigned NOT NULL COMMENT 'FK адреса',
  `square_common` decimal(10,3) unsigned NOT NULL COMMENT 'Площадь общая',
  `square_kitchen` decimal(5,2) unsigned COMMENT 'Площадь кухни',
  `floor` tinyint unsigned NOT NULL COMMENT 'Номер этажа жилья',
  `comment` text COMMENT 'Дополнительная информация',
  `elevator` tinyint(1) NOT NULL default false COMMENT 'Показывает есть ли лифт',
  `rubbish_chute` tinyint(1) NOT NULL default false COMMENT 'Показывает есть ли мусоропровод',
  `shared_bathroom` tinyint(1) NOT NULL default false COMMENT 'Показывает разделенный ли санузел',
  `completion date` date NOT NULL default "0000-00-00" COMMENT 'Срок сдачи в эксплуатацию',
  `distance_metro` time NOT NULL default "00:00:00" COMMENT 'Удаленность от метро',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`type_housing`) REFERENCES `type_housing`(`id`),
  FOREIGN KEY (`group_house_type`) REFERENCES `group_house_type`(`id`),
  FOREIGN KEY (`station_metro`) REFERENCES `station_metro`(`id`),
  FOREIGN KEY (`address`) REFERENCES `address`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о адресе жилья';

CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id комнаты',
  `id_house` int(10) unsigned NOT NULL COMMENT 'FK характеристик',
  `square_rooms` decimal(5,2) unsigned NOT NULL COMMENT 'Площадь комнаты',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_house`) REFERENCES `housing_characteristics`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о комнатах';

CREATE TABLE `type_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id типа заявки',
  `type_request` varchar(100) NOT NULL COMMENT 'Наименование типа заявки',
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о типах заявок';

CREATE TABLE `request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID заявки',
  `id_client` int(10) unsigned NOT NULL COMMENT 'FK клиента, подавшего заявкy',
  `date_req` date NOT NULL default "0000-00-00" COMMENT 'Дата создания заявки',
  `type_req` int(10) unsigned NOT NULL COMMENT 'FK тип заявки',
  `notes` text COMMENT 'Примечания',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_client`) REFERENCES `person`(`id`),
  FOREIGN KEY (`type_req`) REFERENCES `type_request`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о заявках';

CREATE TABLE `deal` (
  `number_contract` int(10) unsigned NOT NULL COMMENT 'Номер договора',
  `id_req1` int(10) unsigned  NOT NULL COMMENT 'FK заявки 1',
  `id_req2` int(10) unsigned COMMENT 'FK заявки 2 (если она существует)',
  `date_deal` date NOT NULL default "0000-00-00" COMMENT 'Дата заключения сделки',
  `fact_cost` bigint unsigned NOT NULL COMMENT 'Фактическая стоимость (аренда/мес или стоимость продажи)',
  `notes` text COMMENT 'Примечания',
  `commission` bigint unsigned NOT NULL COMMENT 'Комиссия агенства',
  PRIMARY KEY (`number_contract`),
  FOREIGN KEY (`id_req1`) REFERENCES `request`(`id`),
  FOREIGN KEY (`id_req2`) REFERENCES `request`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о заключенной посредством агенства сделке';

CREATE TABLE `subject_req` (
  `id_req` int(10) unsigned NOT NULL COMMENT 'FK заявки',
  `id_apartment` int(10) unsigned NOT NULL COMMENT 'FK жилья',
  `desire_cost` bigint unsigned NOT NULL COMMENT 'Желаемая стоимость продажи',
  PRIMARY KEY (`id_req`,`id_apartment`),
  FOREIGN KEY (`id_req`) REFERENCES `request`(`id`),
  FOREIGN KEY (`id_apartment`) REFERENCES `housing_characteristics`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о человеке (клиенте, риэлторе)';