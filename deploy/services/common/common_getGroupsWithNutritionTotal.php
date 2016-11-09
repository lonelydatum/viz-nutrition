<?php
		$NT_ID = $_REQUEST['NT_ID'];

	$q = "SELECT foodName.FD_GRP_ID, g.FD_GRP_NME, sum(nt.NT_VALUE) as sumOfNutrition
FROM NT_AMT as nt
JOIN FOOD_NM as foodName
ON nt.FD_ID=foodName.FD_ID
JOIN FOOD_GRP as g
ON foodName.FD_GRP_ID=g.FD_GRP_ID
WHERE NT_ID=$NT_ID
GROUP BY g.FD_GRP_ID
ORDER BY sumOfNutrition DESC;";

	define('QUERY_STATEMENT', $q);

?>