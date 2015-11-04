DROP VIEW IF EXISTS `all_type_request`;
CREATE VIEW `all_type_request`
as SELECT *
FROM `type_request`;

DROP VIEW IF EXISTS `all_group_house_type`;
CREATE VIEW `all_group_house_type`
as SELECT *
FROM `group_house_type`;

DROP VIEW IF EXISTS `all_type_housing`;
CREATE VIEW `all_type_housing`
as SELECT *
FROM `type_housing`;

DROP VIEW IF EXISTS `all_town_region`;
CREATE VIEW `all_town_region`
as SELECT *
FROM `town_region`;

DROP VIEW IF EXISTS `all_district`;
CREATE VIEW `all_district`
as SELECT *
FROM `district`;

DROP VIEW IF EXISTS `all_station_metro`;
CREATE VIEW `all_station_metro`
as SELECT *
FROM `station_metro`;

DROP VIEW IF EXISTS `all_realtor`;
CREATE VIEW `all_realtor`
as SELECT *
FROM `realtor`;

DROP VIEW IF EXISTS `all_person`;
CREATE VIEW `all_person`
as SELECT *
FROM `person`;

DROP VIEW IF EXISTS `all_address`;
CREATE VIEW `all_address`
as SELECT *
FROM `address`;

DROP VIEW IF EXISTS `all_housing_characteristics`;
CREATE VIEW `all_housing_characteristics`
as SELECT *
FROM `housing_characteristics`;

DROP VIEW IF EXISTS `all_rooms`;
CREATE VIEW `all_rooms`
as SELECT *
FROM `rooms`;

DROP VIEW IF EXISTS `all_request`;
CREATE VIEW `all_request`
as SELECT *
FROM `request`;

DROP VIEW IF EXISTS `all_subject_req`;
CREATE VIEW `all_subject_req`
as SELECT *
FROM `subject_req`;

DROP VIEW IF EXISTS `all_deal`;
CREATE VIEW `all_deal`
as SELECT *
FROM `deal`;

DROP VIEW IF EXISTS `all_commission_realtors`;
CREATE VIEW `all_commission_realtors`
as SELECT *
FROM `commission_realtors`;

