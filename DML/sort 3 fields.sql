DROP VIEW IF EXISTS `person_sort`;
CREATE VIEW `person_sort`
AS SELECT *
FROM `person`
ORDER BY `first_name` ASC, `last_name` ASC,`telephone` DESC;