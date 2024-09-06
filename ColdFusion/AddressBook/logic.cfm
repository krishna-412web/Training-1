<cfoutput>

	<cfif structKeyExists(session,"result") AND session.result EQ 1>
		<cfif structKeyExists(form,"submit")>
			session.result=0;
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>

		<cfif structKeyExists(form, "submit1")>
			<cfinclude template ="image.cfm">
        		<cfset obj1=CreateObject("component","components.database")>
			<cfset message=obj1.addContact(form.title,form.firstName,form.lastName,form.gender,form.dob,
						"#imgPath#",form.houseName,form.street,form.city,form.state,form.pincode,form.email,form.phone)>
			<script>alert("#message#");</script>	
		</cfif>
		<cfif structKeyExists(form,"submit2")>
			<cfif structKeyExists(form, "profile") AND Len(Trim(form.profile)) GT 0>
				<cfinclude template="image.cfm">		
			</cfif>
			<cfif structKeyExists(form, "dob") AND Len(Trim(form.dob)) GT 0>
				<cfquery name="update" datasource="AddressBook">
					UPDATE 
						log_book
					SET 
						dob = <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">
					WHERE 
						log_id= <cfqueryparam value="#form.logId#" cfsqltype="cf_sql_integer">
				</cfquery>
			</cfif>	
			<cfquery name="updateRest" datasource="AddressBook">
				UPDATE
					log_book
				SET
					title= <cfqueryparam value="#form.title#" cfsqltype="cf_sql_integer">,
					firstname= <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
					lastname= <cfqueryparam value="#form.secondName#" cfsqltype="cf_sql_varchar">,
					gender= <cfqueryparam value="#form.gender#" cfsqltype="cf_sql_varchar">,
					house_flat= <cfqueryparam value="#form.houseName#" cfsqltype="cf_sql_varchar">,
					street= <cfqueryparam value="#form.street#" cfsqltype="cf_sql_varchar">,
					city= <cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
					state= <cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
					pincode= <cfqueryparam value="#form.pincode#" cfsqltype="cf_sql_integer">,
					email= <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
					phone= <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_decimal">
				WHERE
					log_id= <cfqueryparam value="#form.logId#" cfsqltype="cf_sql_integer">;
			</cfquery>
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>