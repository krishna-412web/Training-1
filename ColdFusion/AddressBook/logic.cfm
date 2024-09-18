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
						"#imgPath#",form.houseName,form.street,form.city,form.state,form.pincode,form.email,form.phone,form.hobbies)>
			<script>alert("#message#");</script>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">	
		</cfif>
		<cfif structKeyExists(form,"submit2")>
			<cfdump var="#form.hobbies#">
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