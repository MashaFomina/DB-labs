#ХП вставляет заявку на покупку в таблицу request и фильтры для поиска в criterion_req
#SET AUTOCOMMIT=0;
START TRANSACTION;
call insert_criterion_req(1000,"2015-10-15","for test4",97,2,4,null,70,1,1,null,1000000,2500000);
#COMMIT;
#ROLLBACK;