<cfoutput>
	<cfif structKeyExists(session,"result") AND session.result.value EQ 1>
		<cfif structKeyExists(form,"submit")>
			<cfset session.result.value = 0>
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfset obj1=CreateObject("component","components.database")>
		<cfif structKeyExists(form, "submit1")>
			<cfif structKeyExists(form,"operation")>
				<cfif form.operation EQ "add">	
					<cfset message=obj1.addContact()>
				</cfif>
				<cfif form.operation EQ "edit">
					<cfset result = obj1.updateContact()>
					<cfdump var="#result#">					
				</cfif>
			</cfif>
		</cfif>
		<cfif structKeyExists(form,"deleteSubmit")>
			<cfset obj1.deleteContact(form.logId)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>