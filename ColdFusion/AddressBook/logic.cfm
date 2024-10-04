<cfoutput>
	<cfif structKeyExists(session,"result") AND session.result.value EQ 1>
		<cfif structKeyExists(form,"submit")>
			<cfset session.result.value = 0>
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfset obj1=CreateObject("component","components.database")>
		<cfif structKeyExists(form, "submit1")>
			<cfset variables.message = obj1.formValidate()>
			<cfif variables.message.flag EQ 1>
				<cfif structKeyExists(form,"logId")>
					<cfset result = obj1.updateContact()>
				<cfelse>
					<cfset message= obj1.addContact()>				
				</cfif>
			</cfif>
		</cfif>
		<cfif structKeyExists(form,"deleteSubmit")>
			<cfset obj1.deleteContact(form.logId)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfif structKeyExists(form,"uploadSubmit")>
			<cfinclude template="excelUpload.cfm">
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>