INSERT INTO `type_housing` (`type_housing`) VALUES
('Загородный дом'),('Квартира'),('Комната');

INSERT INTO `group_house_type` (`group_house_type`) VALUES
('Кирпич'),('Монолит'),('Современная панель'),('Сталинские'),('Старая панель'),('Старый фонд'),('Дерево');

INSERT INTO `type_request` (`type_request`) VALUES
('Покупка'),('Продажа'),('Аренда'),('Сдача');

INSERT INTO `person` (`last_name`,`first_name`,`patronymic`,`email`,`telephone`,`passport`,`password`,`INN`) VALUES
('Корчагина','Александра', 'Владимировна', 'korcagina_a_v@mail.ru', 89513456789, '4008,685306,04.02.1990,ж,ТП №29 отдела УФМСВ по СПБ и ЛО,04.03.2010,г.СПб пр.Ветеранов д.78 кв.33','lalala',400000000001),
('Сегень','Татьяна', 'Владимировна', 'segenj_t_v@mail.ru', 89513456799, '4008,685307,04.02.1990,ж,ТП №50 отдела УФМСВ по СПБ и ЛО,04.03.2010,г.СПб шоссе Революции д.78 кв.33','lalada',400000000022),
('Филиппов','Александр', 'Владимирович', 'filippov_a_v@mail.ru', 89513456769, '4008,685308,04.02.1980,ж,ТП №55 отдела УФМСВ по СПБ и ЛО,04.03.2012,г.СПб пр.Палюстровский д.78 кв.33','gfdgf',400000000033),
('Корчагин','Александр', 'Александрович', 'korcagin_a_a@mail.ru', 89513456779, '4008,685309,04.05.1990,ж,ТП №60 отдела УФМСВ по СПБ и ЛО,04.05.2010,г.СПб пр.Ветеранов д.98 кв.73','gf',400000000034),
('Власова','Виктория', 'Викторовна', 'vlasova_v_v@mail.ru', 89513456781, '4008,685301,07.02.1990,ж,ТП №30 отдела УФМСВ по СПБ и ЛО,04.07.2010,г.СПб ул.Генерала Симоняка д.78 кв.77','lazala',400000000035),
('Козлов','Сергей', 'Максимович', 'kozlov_s_m@mail.ru', 89513456782, '4008,685302,04.02.1993,ж,ТП №27 отдела УФМСВ по СПБ и ЛО,04.03.2013,г.СПб ул.Козлова д.78 кв.33','lala',400000000036),
('Васильев','Максим', 'Сергеевич', 'vasilev_m_s@mail.ru', 89513456783, '4008,685303,04.02.1970,ж,ТП №25 отдела УФМСВ по СПБ и ЛО,04.03.2000,г.СПб пр.Ветеранов д.105 кв.1','lafala',400000000066),
('Суханов','Дмитрий', 'Алексеевич', 'suhanov_d_a@mail.ru', 89513456784, '4008,685304,04.05.1960,ж,ТП №20 отдела УФМСВ по СПБ и ЛО,04.07.2000,г.СПб пр.Невский д.78 кв.3','lalafa',400000000012),
('Зотова','Анастасия', 'Стапановна', 'zotova_a_s@mail.ru', 89513456785, '4008,685305,04.09.1972,ж,ТП №19 отдела УФМСВ по СПБ и ЛО,04.09.2000,г.СПб ул.Непокоренных д.78 кв.7','fdglala',400000000090);

INSERT INTO `town_region` (`town_region`) VALUES
('Санкт-Петербург'),('Ленинградская область');

INSERT INTO `district` (`district`,`id_town_region`) VALUES
( 'Адмиралтейский',   1) ,
( 'Василеостровский', 1),
( 'Выборгский',   1) ,
( 'Калининский', 1),
( 'Кировский', 1 ),
( 'Колпинский',   1) ,
( 'Красногвардейский', 1 ),
( 'Красносельский',   1) ,
( 'Кронштадтcкий', 1 ),
( 'Курортный', 1 ),
( 'Московский', 1 ),
( 'Невский',   1) ,
( 'Петроградский', 1 ),
( 'Петродворцовый',   1) ,
( 'Приморский', 1),
( 'Пушкинский', 1 ),
( 'Фрунзенский', 1 ),
( 'Центральный', 1),
( 'Всеволожский', 2 );

INSERT INTO `station_metro` (`id_district`,`station`) VALUES
( 4, 'пл. Мужества' ),
( 5, 'пр. Ветеранов' ),
( 5,   'Автово') ,
( 4, 'пл. Ленина' ),
( 11, 'Московская' ),
( 18,   'Гостиный двор');

INSERT INTO `realtor` (`id_person`, `date_reception`,`commission_percent`,`childrens`) VALUES
(5,'2015-03-05',7,0),
(6,'2014-03-05',10,0),
(7,'2004-05-05',30,1),
(8,'2006-05-05',25,1),
(9,'2005-05-05',27,1);

INSERT INTO `address` (`id_district`,`street`,`house_number`,`housing`,`flat_number`,`porch_number`) VALUES
(5, 'пр. Ветеранов',100,null,100,1),
(5,'ул. Козлова', 50,2,32,1),
(4,'пр. Непокоренных', 10,1,140,2),
(18,'пр. Невский',58,null,78,1),
(19,'Александровская',5,null,null,null),
(19,'Александровская',5,null,null,null);

INSERT INTO `housing_characteristics` (`type_housing`,`group_house_type`,`station_metro`,`address`,`square_common`,`square_kitchen`,
`floor`,`elevator`,`rubbish_chute`,`shared_bathroom`,`completion date`,`distance_metro`) VALUES
(2,1,2,1,50,10,7,1,1,0,"0000-00-00","00:12:00"),
(2,2,2,2,40,7,3,1,0,1,"0000-00-00","00:15:00"),
(2,3,4,3,35,6,6,1,1,1,"0000-00-00","00:05:00"),
(2,4,6,4,70,15,4,1,0,1,"0000-00-00","00:02:00"),
(1,7,null,5,100,15,2,0,0,0,"0000-00-00","00:00:00"),
(1,7,null,6,80,10,1,0,0,0,"0000-00-00","00:00:00");

INSERT INTO `rooms` (`id_house`,`square_rooms`) VALUES
(1,10),
(1,17),
(2,18),
(3,16),
(4,10),
(4,10),
(4,15),
(5,30),
(5,20),
(5,10),
(6,10),
(6,20),
(6,15);

INSERT INTO `request` (`id_client`,`date_req`,`type_req`,`commission`,`id_realtor`) VALUES
(1,"2015-10-15",1,100000,1),
(1,"2015-10-15",2,null,1),
(2,"2015-10-15",2,70000,2),
(3,"2015-10-15",2,50000,3),
(4,"2015-10-15",2,null,4),
(5,"2015-10-15",2,null,5);

INSERT INTO `subject_req` (`id_req`,`id_apartment`,`desire_cost`) VALUES
(2,6,3000000),
(3,1,2000000),
(4,2,4000000),
(5,3,3500000),
(6,4,3500000);

INSERT INTO `deal` (`number_contract`,`id_req1`,`id_req2`,`date_deal`,`fact_cost`,`prev_contract_number`) VALUES
(123456,2,null,"2015-10-15",3200000,null),
(123457,1,3,"2015-10-17",2100000,123456),
(123458,4,null,"2015-10-20",4100000,null);

INSERT INTO `commission_realtors` (`id_req`,`commission`,`date_reception`) VALUES
(1,7000,"2015-10-25"),
(3,7000,"2015-10-25"),
(4,15000,"2015-10-25");