<cfcomponent>
	<cfproperty name="word" type="string">
	<cfproperty name="count" type="number">

	<cffunction name="init" access="public">
		<cfargument name="s" type="string">
		<cfset word=arguments.s>
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
</cfcomponent>