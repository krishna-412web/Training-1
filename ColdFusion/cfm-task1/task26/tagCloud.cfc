<cfcomponent>
	<cfproperty name="c1" type="number">
	<cfproperty name="s" type="string">
	
	<cfset c1=0>
	<cffunction name="init" access="public">
		<cfquery name="select1" datasource="test1">
		SELECT 
			word,
			COUNT(word) AS count
		FROM 
			paragraph 
		group by 
			word 
		HAVING 
			length(word)>=3 
		ORDER BY 
				count(word) DESC, length(word) DESC, word ASC;	
		</cfquery>

		<cfset s= SerializeJSON(select1,"struct")>
		<cfreturn s>
	</cffunction>

	


	<cffunction name="process" returnType="array">
		<cfargument name="text" type="string">
		<cfset local.d= deSerializeJSON(text)>
		<cfreturn local.d>
	</cffunction>	

	<cffunction name="output">	
		<cfargument name="d" type="array">
		<cfoutput>	
			<cfloop array="#arguments.d#" index="local.i">
				<cfset c1=c1+1>
				-<span class="output" id="n#c1#" style="font-size:#local.i.count#em">#local.i.word# (#local.i.count#)</span><br>
			</cfloop>
			<script src="./js/script.js"></script>	
		</cfoutput>
	</cffunction>
	

	
</cfcomponent>