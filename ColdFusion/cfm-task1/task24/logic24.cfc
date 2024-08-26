<cfcomponent>
	<cffunction name="checkmail" access="remote" returnFormat="JSON">
		<cfargument name="email" type="string">
		<cfquery name="checkData" datasource="test1" result="r">
			SELECT 
				firstName,emailId
			FROM
				subscribe
			WHERE
				emailId = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"> ;
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfset local.result="exists">
		<cfelse>
			<cfset local.result="Notexists">
		</cfif>
		<cfreturn local.result/>
	</cffunction>
	<cffunction name="store">
		<cfquery name="storeData" datasource="test1">
			INSERT INTO
				subscribe(firstName,emailId)
			VALUES
				(<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
				 <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">);
		</cfquery>
	</cffunction>
</cfcomponent>