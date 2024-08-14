<cfquery name="select1" datasource="test1">
	SELECT word,COUNT(word) AS count
	FROM paragraph group by word 
	HAVING length(word)>=3 
	ORDER BY count(word) DESC, length(word) DESC, word ASC;	
</cfquery>


