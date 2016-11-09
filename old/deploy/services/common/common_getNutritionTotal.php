<?php
	$q = "SELECT ntName.NT_ID, ntName.NT_NME, ntName.DESCRIPTION as description, sum(ntAmount.NT_VALUE)as Total, ntName.UNIT, ntName.DRI
FROM NT_AMT as ntAmount
JOIN NT_NM as ntName
ON ntName.NT_ID=ntAmount.NT_ID
GROUP BY ntAmount.NT_ID 
ORDER BY ntName.NT_NME ASC";

	define('QUERY_STATEMENT', $q);

?>