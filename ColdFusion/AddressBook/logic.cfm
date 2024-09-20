<cfoutput>
	<cfif structKeyExists(session,"result") AND session.result.value EQ 1>
		<cfif structKeyExists(form,"submit")>
			<cfset session.result.value = 0>
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>

		<cfif structKeyExists(form, "submit1")>
			<cfinclude template ="image.cfm">
        		<cfset obj1=CreateObject("component","components.database")>
			<cfset message=obj1.addContact(imgPath)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">	
		</cfif>
		<cfif structKeyExists(form,"submit2")>
			<cfset obj2=CreateObject("component","components.database")>
			<cfset obj2.updateContact(form)>
		</cfif>
		<cfif structKeyExists(form,"deleteSubmit")>
			<cfset obj3=CreateObject("component","components.database")>
			<cfset obj3.deleteContact(form.logId)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>