<cfoutput>
	<cfif structKeyExists(form,"submit")>
		<cfswitch expression="#form.num#">
			<cfcase value="5">Very good<br></cfcase>
			<cfcase value="4">good<br></cfcase>
			<cfcase value="3">fair<br></cfcase>
			<cfcase value="2">ok<br></cfcase>
			<cfcase value="1">ok<br></cfcase>
			<cfdefaultcase>You entered wrong character(1to5)</cfdefaultcase>
		</cfswitch>
	</cfif>
</cfoutput>