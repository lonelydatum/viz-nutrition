<?php
	require_once('common_mysql.php');
	require_once('../common/common_getAllFoodsByNutrient.php');
	
		

	$result = mysql_query( QUERY_STATEMENT, $connection ) or die(mysql_error()); 
	$rows = array();
	while($r = mysql_fetch_assoc($result)) {
	    $rows[] = $r;
	}
	print json_encode($rows);
?>
