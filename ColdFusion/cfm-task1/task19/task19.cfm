<cfapplication name="COOKIE TASK"  setClientCookies="yes">

<form id=form action="" method="post">
	<input name="submit" type="submit">
</form>

<cfif structKeyExists(form,"submit")>
	<cfif structKeyExists(Cookie,"count")>
		<cfset cookie.count=cookie.count+1>
	<cfelse>
		<cfcookie name="count" value="0"  expires=#CreateTimeSpan(0,0,2,0)# >
		<cfset cookie.count=1>
	</cfif>
	<cfoutput>Visited=#cookie.count#</cfoutput>
	<cfdump var="#cookie#">
</cfif>