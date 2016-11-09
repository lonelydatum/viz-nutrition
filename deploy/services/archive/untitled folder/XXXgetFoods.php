<?php
	
	define('DATABASE', '/Users/Gar/sqlite3_data/food.db');
	
	try {
		$db = new PDO('sqlite:' . DATABASE);
		$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );        
		$sth = $db->query(
			"SELECT FD_ID, A_FD_NME FROM FOOD_NM"
		);
		
		$row = $sth->fetch(PDO::FETCH_ASSOC);
		$rowarray = $sth->fetchall(PDO::FETCH_ASSOC);
		
		$json = json_encode($rowarray);        
		print_r($json);             
    	} catch(PDOException $e) {
        	error($e->getMessage());
	    }
	    
?>
