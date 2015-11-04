<html><head><title></title></head>
<body>
<?php
/* Предварительно выполнен скрипт fill_db.sql*/
$mysqli = mysqli_connect("localhost", "root", "vertrigo", "realty_agency")
					or die("<br/>There was error during connection:<br/>" . mysql_error());
					echo "<br/>You are successfully connected.<br/>";

$mysqli->set_charset("utf8");
$query=array();
$N = 5000;
$M = 20;
$apartment_count=7;
for ($i=0;$i<$M;$i++)
{
	if ($i == 0)
	{
		$query = array();
		$query[] = 'INSERT INTO `person` (`last_name`,`first_name`,`patronymic`,`email`,`telephone`,`passport`,`password`,`INN`) VALUES ';
		for ($count=0; $count<$N;$count++) {
			$query[]=' ("Фамилия'.($count+$N*$i).'","Имя'.($count+$N*$i).'","Отчество'.($count+$N*$i).'","some_email_'.($count+$N*$i).'@mail.ru",'.(89520000000+$count+$N*$i).',"Паспортные данные '.($count+$N*$i).'","Пароль'.($count+$N*$i).'",'.(400000000100+$count+$N*$i).')'.(($count==$N-1) ? ";":",");
		}
		$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");
	}
	$query = array();
	$query[] = 'INSERT INTO `person` (`last_name`,`first_name`,`patronymic`,`email`,`telephone`,`passport`,`password`,`INN`) VALUES ';
	for ($count=0; $count<$N;$count++) {
		$query[]=' ("Фамилия2_'.($count+$N*$i).'","Имя2_'.($count+$N*$i).'","Отчество2_'.($count+$N*$i).'","some_email2_'.($count+$N*$i).'@mail.ru",'.(89620000000+$count+$N*$i).',"Паспортные данные2 '.($count+$N*$i).'","Пароль2_'.($count+$N*$i).'",'.(410000000100+$count+$N*$i).')'.(($count==$N-1) ? ";":",");
	}
	$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");
	
	$query = array();
	$query[] = 'INSERT INTO `person` (`last_name`,`first_name`,`patronymic`,`email`,`telephone`,`passport`,`password`,`INN`) VALUES ';
	for ($count=0; $count<$N;$count++) {
		$query[]=' ("Фамилия3_'.($count+$N*$i).'","Имя3_'.($count+$N*$i).'","Отчество3_'.($count+$N*$i).'","some_email3_'.($count+$N*$i).'@mail.ru",'.(89630000000+$count+$N*$i).',"Паспортные данные3 '.($count+$N*$i).'","Пароль3_'.($count+$N*$i).'",'.(430000000100+$count+$N*$i).')'.(($count==$N-1) ? ";":",");
	}
	$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");
	
	if ($i == 0)
	{
		$NN = 60;
		$query=array();
		$query[] = 'INSERT INTO `station_metro` (`id_district`,`station`) VALUES ';
		for ($count=0; $count<$NN;$count++) {
			$query[]=' ('.rand(1,19).',"Станция'.(7+$count).'")'.(($count==$NN-1) ? ";":",");
		}
		$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");

		
		$NN = 100;
		$query=array();
		$percent=array(1=>7,2=>10,3=>30,4=>25,5=>57);
		$query[] = 'INSERT INTO `realtor` (`id_person`, `date_reception`,`commission_percent`,`childrens`) VALUES ';
		for ($count=0; $count<$NN;$count++) {
			$percent[6+$count]=rand(7,35);
			$query[]=' ('.(10+$count).',"'.rand(2000,2015).'-'.rand(10,12).'-'.rand(10,28).'",'.$percent[6+$count].','.rand(0,1).')'.(($count==$NN-1) ? ";":",");
		}
		$result=$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");
	}

	$query = array();
	$query[] = 'INSERT INTO `address` (`id_district`,`street`,`house_number`,`housing`,`flat_number`,`porch_number`) VALUES ';
	for ($count=0; $count<$N/20*19;$count++) {
		$query[]=' ('.rand(1,19).',"Улица'.rand(1,150).'",'.rand(1,400).','.rand(1,4).','.rand(1,700).','.rand(0,9).'),';
	}
	for ($count=0; $count<$N/20;$count++) {
		$query[]=' (2,"Улица'.$count.'",'.rand(1,400).',null,null,null)'.(($count==$N/20-1) ? ";":",");
	}
	$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");

	$query = array();
	$common_s=array();
	$query[] = 'INSERT INTO `housing_characteristics` (`type_housing`,`group_house_type`,`station_metro`,`address`,`square_common`,`square_kitchen`,
	`floor`,`elevator`,`rubbish_chute`,`shared_bathroom`,`completion date`,`distance_metro`) VALUES ';
	for ($count=0; $count<$N;$count++) {
		$station=rand(0,66);
		$common_s[$count]=rand(30,200);
		$type_house[$count]=rand(1,3);
		$query[]=' ('.$type_house[$count].','.rand(1,7).','.(($station==0)?'null':$station).','.(7+$count+$N*$i).','.$common_s[$count].','.rand(5,10).','.(($type_house[$count]==1)?1:rand(1,12)).','.(($type_house[$count]==1)?0:rand(0,1)).','.(($type_house[$count]==1)?0:rand(0,1)).','.rand(0,1).',"0000-00-00","00:'.(($station==0)?'00:00':(rand(0,59).':'.rand(0,59))).'")'.(($count==$N-1) ? ";":",");
	}
	$mysqli->query(implode("\n",$query)) or printf("Error: %s</br>", $mysqli->error ."</br>");

	$query = array();
	$query[] = 'INSERT INTO `rooms` (`id_house`,`square_rooms`) VALUES ';
	foreach($common_s as $ind=>$s)
	{
		$id_house=7+$ind+$N*$i;
		if ($type_house[$ind]==3)
			$query[]=' ('.$id_house.','.($s-15).')'.",";
		else
		{
			$sq_rs=$s-15;
			while($sq_rs>7)
			{
				if (($sq_rs-30)<=0)
				{
					$query[]=' ('.$id_house.','.$sq_rs.')'.",";
					break;
				}
				else {
					$ss=rand(10,30);
					$query[]=' ('.$id_house.','.$ss.')'.",";
					$sq_rs=$sq_rs-$ss;
				}
			}
		}
		if (count($query) == 5000) {
			$str = implode("\n",$query);
			$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
			$query = array();
			$query[] = 'INSERT INTO `rooms` (`id_house`,`square_rooms`) VALUES ';
		}
	}
	if (count($query)>1)
	{
		$str = implode("\n",$query);
		$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
	}
	
	$query = array();
	$query[] = 'INSERT INTO `request` (`id_client`,`date_req`,`type_req`,`commission`,`id_realtor`) VALUES ';
	$number=0;
	$commission = array();
	$commission1 = array();
	$type_req=array();
	$year_req=array();
	$month_req=array();
	$day_req=array();
	for ($count=0; $count<$N;$count++) {
		if ($count == 0) {
			$ind=$count;
			$ind1=$count+1;
		}
		else {
			$ind=$ind1+1;
			$ind1=$ind1+2;
		}
		if ($count == 0)
			$type_req[$ind]=2;
		else if ($ind>0 && $type_req[$ind-2]==4)
			$type_req[$ind]=2;
		else
			$type_req[$ind]=4;

		$id_realtor[$ind]=rand(1,105);
		$id_realtor1[$ind1]=rand(1,105);
		if ($i != 19)
		{
			$year_req[$ind]=rand(2000,2014);
			$month_req[$ind]=rand(01,12);
			$day_req[$ind]=rand(01,28);
			$commission[$ind]=(($type_req[$ind]==4)?rand(15000,25000):rand(50000,150000));
			$query[]=' ('.(107+$ind+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.$day_req[$ind].'",'.$type_req[$ind].','.$commission[$ind].','.$id_realtor[$ind].'),';
			$commission1[$ind1]=((($type_req[$ind]-1)==3)?rand(15000,25000):rand(50000,150000));
			$query[]=' ('.(107+$ind1+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.($day_req[$ind]+2).'",'.($type_req[$ind]-1).','.$commission1[$ind1].','.$id_realtor1[$ind1].'),';
		}
		else {
			$year_req[$ind]=2015;
			$month_req[$ind]=rand(01,10);
			$day_req[$ind]=rand(01,28);
			if($number==3)
			{
				$commission1[$ind1]=((($type_req[$ind]-1)==3)?rand(15000,25000):rand(50000,150000));
				$commission[$ind]=(($type_req[$ind]==4)?rand(15000,25000):rand(50000,150000));
				$query[]=' ('.(107+$ind+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.$day_req[$ind].'",'.$type_req[$ind].','.$commission[$ind].','.$id_realtor[$ind].'),';
				$query[]=' ('.(107+$ind1+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.($day_req[$ind]+2).'",'.($type_req[$ind]-1).','.$commission1[$ind1].','.$id_realtor1[$ind1].'),';
				$number=0;
			}
			else
			{
				$query[]=' ('.(107+$ind+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.$day_req[$ind].'",'.$type_req[$ind].',null,'.$id_realtor[$ind].'),';
				$query[]=' ('.(107+$ind1+$i*$N).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.($day_req[$ind]+2).'",'.($type_req[$ind]-1).',null,'.$id_realtor1[$ind1].'),';
			}
			$number++;
		}
		if (count($query) >= 5000) {
			$str = implode("\n",$query);
			$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
			$query = array();
			$query[] = 'INSERT INTO `request` (`id_client`,`date_req`,`type_req`,`commission`,`id_realtor`) VALUES ';
		}
	}
	if (count($query)>1)
	{
		$str = implode("\n",$query);
		$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
	}

	$query = array();
	$desire_cost = array();
	$query[] = 'INSERT INTO `subject_req` (`id_req`,`id_apartment`,`desire_cost`) VALUES ';
	foreach($type_req as $ind=>$tr)
	{
		$desire_cost[$ind]=(($tr==2)?rand(2000000,5000000):rand(20000,40000));
		$query[]=' ('.(7+$ind+$i*$N*2).','.$apartment_count.','.$desire_cost[$ind].')'.",";
		$apartment_count++;
	}
	$str = implode("\n",$query);
	$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");

	$count=0;
	$query = array();
	$query[] = 'INSERT INTO `deal` (`number_contract`,`id_req1`,`id_req2`,`date_deal`,`fact_cost`,`prev_contract_number`) VALUES';
	foreach($commission  as $ind=>$com)
	{
		$month_req[$ind]++;
		if ($month_req[$ind] == 13) {
			$month_req[$ind]=1;
			$year_req[$ind]++;
		}
		$day_req[$ind]=rand(01,25);
		$query[]=' ('.(123460+$count+$i*$N*2).','.(7+$ind+$i*$N*2).','.(8+$ind+$i*$N*2).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.$day_req[$ind].'",'.($desire_cost[$ind]+rand(1000,10000)).',null),';
		$count++;
	}
	$str = implode("\n",$query);
	$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
	
	$query = array();
	$query[] = 'INSERT INTO `commission_realtors` (`id_req`,`commission`,`date_reception`) VALUES';
	foreach($commission  as $ind=>$com)
	{
		$query[]=' ('.(7+$ind+$i*$N*2).','.($percent[$id_realtor[$ind]]*$com/100).',"'.$year_req[$ind].'-'.$month_req[$ind].'-'.($day_req[$ind]+2).'"),';
	}
	$str = implode("\n",$query);
	$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
	
	$query = array();
	$query[] = 'INSERT INTO `commission_realtors` (`id_req`,`commission`,`date_reception`) VALUES';
	foreach($commission1  as $ind=>$com)
	{
		$ind1=$ind-1;
		$query[]=' ('.(7+$ind+$i*$N*2).','.($percent[$id_realtor1[$ind]]*$com/100).',"'.$year_req[$ind1].'-'.$month_req[$ind1].'-'.($day_req[$ind1]+2).'"),';
	}
	$str = implode("\n",$query);
	$mysqli->query(substr($str,0,strlen($str)-1).";") or printf("Error: %s</br>", $mysqli->error ."</br>");
	
}

$mysqli->close();
echo "<br/>Query requests are executed successfully.<br/>";
?>
</body></html>