<?php

	require_once('common.php');	
	require_once('../common/common_getNutritionTotal.php');
	$db = new bwSQLite3( BASEPATH.DATABASE );

	

		
	$newArray = array();

	foreach ($db->sql_query( $q ) as $row) {
            array_push($newArray,$row);
	$inc++;
        }
		
	$json = json_encode($newArray); 

        print($json);

/*	
	
	
	try {
		$db = new PDO('sqlite:' . DATABASE);
		$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );        
		$sth = $db->query(
			"SELECT ntName.NT_ID, ntName.NT_NME, Cast( sum(ntAmount.NT_VALUE) as Integer ) as Total
FROM NT_AMT as ntAmount
JOIN NT_NM as ntName
ON ntName.NT_ID=ntAmount.NT_ID
GROUP BY ntAmount.NT_ID 
ORDER BY Total ASC"
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
