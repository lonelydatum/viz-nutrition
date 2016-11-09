<?php
	
	require_once('../lib/bwSQLite3.php');

	$GRP_ID = $_REQUEST['GRP_ID'];
	$NT_ID = $_REQUEST['NT_ID'];

	$q = "SELECT foodName.A_FD_NME as Food, nAmount.NT_VALUE as Amount, foodName.FD_ID as FD_ID FROM NT_AMT as nAmount 
			JOIN FOOD_NM as foodName
			ON foodName.FD_ID=nAmount.FD_ID
			WHERE nAmount.NT_ID=$NT_ID AND foodName.FD_GRP_ID=$GRP_ID AND nAmount.NT_VALUE>10
			ORDER BY nAmount.NT_VALUE DESC";

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

	$GRP_ID = $_REQUEST['GRP_ID'];
	$NT_ID = $_REQUEST['NT_ID'];
	
	
	try {
		$db = new PDO('sqlite:' . DATABASE);
		$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );        
		$sth = $db->query(
			"SELECT foodName.A_FD_NME as Food, nAmount.NT_VALUE as Amount, foodName.FD_ID as FD_ID
			FROM NT_AMT as nAmount
			JOIN FOOD_NM as foodName
			ON foodName.FD_ID=nAmount.FD_ID
			WHERE nAmount.NT_ID=$NT_ID AND foodName.FD_GRP_ID=$GRP_ID AND nAmount.NT_VALUE>10
			ORDER BY nAmount.NT_VALUE DESC"
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
