<cfcomponent>
	<cfif structKeyExists(form,"submit")>
		<cfset date=DateFormat(#form.doj#,"yyyy-mm-dd")>
		<cfquery name="InsertData" datasource="test1" result="res">
			INSERT INTO form_table(position,relocateChoice,doj,webSite,resume,salary,name,email,phoneNumber)
			VALUES
				(<cfqueryparam value="#form.position#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#form.choice#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#date#" cfsqltype="CF_SQL_DATE">,
				<cfqueryparam value="#form.website#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#form.resume#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value=#form.salary# cfsqltype="CF_SQL_INTEGER">,
				<cfqueryparam value="#form.name#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">,
				<cfqueryparam value=#form.phoneNumber# cfsqltype="CF_SQL_BIGINT">);
		</cfquery>
		Query Exexuted Successfully!!!
		<br>
		<cfdump var="#res#">
		
	</cfif>
</cfcomponent>