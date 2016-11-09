<?
	require_once('../lib/bwSQLite3.php');

	$NT_ID = $_REQUEST['NT_ID'];

	$q = "SELECT nt.FD_ID, nt.NT_VALUE, foodName.A_FD_NME, foodName.FD_GRP_ID, g.FD_GRP_NME, CAST(sum(nt.NT_VALUE) as INTEGER ) as sumOfNutrition
FROM NT_AMT as nt
JOIN FOOD_NM as foodName
ON nt.FD_ID=foodName.FD_ID
JOIN FOOD_GRP as g
ON foodName.FD_GRP_ID=g.FD_GRP_ID
WHERE NT_ID=$NT_ID
GROUP BY g.FD_GRP_ID
ORDER BY sumOfNutrition DESC;";

	$db = new bwSQLite3('/Users/Gar/sqlite3_data/food.db');
	
	$newArray = array();

	foreach ($db->sql_query( $q ) as $row) {
            array_push($newArray,$row);	
        }
		
	$json = json_encode($newArray); 

        print($json);

?>