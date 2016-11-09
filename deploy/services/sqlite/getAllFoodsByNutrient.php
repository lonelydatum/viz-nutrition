<?	
	require_once('common.php');
	require_once('../common/common_getAllFoodsByNutrient.php');

	$db = new bwSQLite3( BASEPATH.DATABASE );	
	$newArray = array();

	foreach ($db->sql_query( QUERY_STATEMENT ) as $row) {
            array_push($newArray,$row);	
        }
		
	$json = json_encode($newArray); 
        print($json);
?>