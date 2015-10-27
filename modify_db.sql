CREATE TABLE IF NOT EXISTS `realtor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID риэлтора',
  `id_person` int(10) unsigned NOT NULL COMMENT 'FK человека',
  `date_reception` date NOT NULL default "0000-00-00" COMMENT 'Дата приема на работу',
  `commission_percent` smallint unsigned NOT NULL COMMENT 'Получаем процент комиссионных',
  `childrens` tinyint(1) NOT NULL default false COMMENT 'Показывает есть ли дети у работника',
  `notes` text COMMENT 'Примечания',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_person`) REFERENCES `person`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о риэлторах';

CREATE TABLE IF NOT EXISTS `commission_realtors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID уникальный',
  `id_req` int(10) unsigned NOT NULL COMMENT 'FK заявки',
  `commission` bigint unsigned NOT NULL COMMENT 'Комиссия риэлтора, руб',
  `date_reception` date NOT NULL default "0000-00-00" COMMENT 'Дата выдачи денег',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_req`) REFERENCES `request`(`id`)
) DEFAULT CHARSET=utf8 COMMENT='Хранит информацию о выданных риэлторам комиссионных';

ALTER TABLE `deal`
ADD `prev_contract_number` int(10) unsigned COMMENT 'Номер договора сделки, предшествующей в цепочке',
DROP COLUMN `commission`;

ALTER TABLE `request`
ADD `commission` bigint unsigned COMMENT 'Комиссия агенства',
ADD`id_realtor` int(10) unsigned NOT NULL COMMENT 'FK риэлтора',
ADD FOREIGN KEY (`id_realtor`) REFERENCES `realtor`(`id`);