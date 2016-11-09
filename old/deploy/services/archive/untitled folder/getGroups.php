<?php

	require_once('../lib/bwSQLite3.php');
	$q = "SELECT FD_GRP_ID, FD_GRP_NME, FD_GRP_NMF FROM FOOD_GRP";
	$db = new bwSQLite3('/Users/Gar/sqlite3_data/food.db');
	
	$newArray = array();

	foreach ($db->sql_query( $q ) as $row) {
            array_push($newArray,$row);
	$inc++;
        }
		
	$json = json_encode($newArray); 

        print($json);


	
/*
	define('DATABASE', '/Users/Gar/sqlite3_data/food.db');
	
	try {
		$db = new PDO('sqlite:' . DATABASE);
		$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );        
		$sth = $db->query(
			"SELECT FD_GRP_ID, FD_GRP_NME FROM FOOD_GRP"
		);
		
		$row = $sth->fetch(PDO::FETCH_ASSOC);
		$rowarray = $sth->fetchall(PDO::FETCH_ASSOC);
		
		$json = json_encode($rowarray);        
		print_r($json);             
    	} catch(PDOException $e) {
        	error($e->getMessage());
	    }
*/	   
?>
