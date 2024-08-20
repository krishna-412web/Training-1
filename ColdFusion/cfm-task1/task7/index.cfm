<cfset session.s = StructNew()>

<cfapplication
	name="CFCTASK7"
	sessionManagement="yes"
	sessionTimeOut=#CreateTimeSpan(0,0,2,0)# >

<cfinclude template="task7.cfm">

<cfif structKeyExists(form,"submit")>
	<cfset session.s["#form.keys#"]=#form.value#>
	<cfdump var="#session.s#">
</cfif>





