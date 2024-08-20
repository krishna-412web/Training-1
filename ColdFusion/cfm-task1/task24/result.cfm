<cfif structKeyExists(form,"submit")>
	<cfquery name="storeData" datasource="test1">
		INSERT INTO
			subscribe(firstName,emailId)
		VALUES
			(<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">);
	</cfquery>
	<cfoutput>Data Inserted Succesfully..</cfoutput>
</cfif>