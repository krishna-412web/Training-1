<cfcomponent>
	<cfproperty name="local.s" type="string">
	<cfproperty name="word" type="string">

	<cffunction name="init" access="public">
		<cfargument name="s" type="string">
		<cfset word=arguments.s>
	</cffunction>

	<cffunction name="select" access="public">
		<cfquery name="local.selectData" datasource="test1">
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

		<cfset local.s= SerializeJSON(local.selectData,"struct")>
		<cfreturn local.s>
	</cffunction>

	<cffunction name="insert">
		<cfset delimitedPara = REReplace(word, "[^a-zA-Z0-9]", ",", "all")>
		<cfquery name="truncateTable" datasource="test1">
			TRUNCATE paragraph;
		</cfquery>
		<cfloop list="#delimitedPara#" item="i">
			<cfquery name="local.insertData" datasource="test1" result="r">
				INSERT INTO 
					paragraph(word) 
				VALUES 
					(<cfqueryparam value="#i#" cfsqltype="cf_sql_varchar">);
			</cfquery>
		</cfloop>
	</cffunction>
	
	<cffunction name="process" returnType="array">
		<cfargument name="text" type="string">
		<cfset local.d= deSerializeJSON(arguments.text)>
		<cfreturn local.d>
	</cffunction>	

	<cffunction name="output">	
		<cfargument name="d" type="array">
		<cfset local.c1 = 0>
		<cfoutput>	
			<cfloop array="#arguments.d#" index="local.i">
				<cfset local.c1=c1+1>
				-<span class="output" id="n#local.c1#" style="font-size:#local.i.count#em">#local.i.word# (#local.i.count#)</span><br>
			</cfloop>
			<script src="./js/script.js"></script>
		</cfoutput>
	</cffunction>
		
</cfcomponent>