<?php
		$NT_ID = $_REQUEST['NT_ID'];

	$q = "SELECT nt_amt.FD_ID, nt_amt.NT_VALUE, foodName.L_FD_NME as A_FD_NME, foodName.FD_GRP_ID, g.FD_GRP_NME
FROM NT_AMT as nt_amt
JOIN FOOD_NM as foodName
ON nt_amt.FD_ID=foodName.FD_ID
JOIN FOOD_GRP as g
ON foodName.FD_GRP_ID=g.FD_GRP_ID
WHERE NT_ID=$NT_ID
ORDER BY nt_amt.NT_VALUE DESC;";

	define('QUERY_STATEMENT', $q);

?>