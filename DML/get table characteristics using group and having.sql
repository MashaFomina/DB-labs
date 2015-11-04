#запрос, рассчитывающий количество комнат с использованием группировки, ограничение на результат группировки - количество комнат больше 3
DROP VIEW IF EXISTS count_rooms;
CREATE VIEW count_rooms
AS SELECT id_house,count(square_rooms) as count_rooms,sum(square_rooms) as square_all_rooms
FROM rooms
GROUP BY id_house
HAVING count(square_rooms)>3;