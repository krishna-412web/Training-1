<cfset session.s1 = StructNew()>


<cfapplication
	name="CFCTASK7"
	sessionManagement="yes"
	sessionTimeOut=#CreateTimeSpan(0,0,2,0)# >

<cfinclude template="index.cfm">

<cfoutput>
<cfif structKeyExists(form,"submit")>
		<cfif StructKeyExists(session.s1,"#form.keys#")>
			#form.keys# already present.Cannot add again.
		<cfelse>
			<cfset session.s1["#form.keys#"]=#form.value# >
		</cfif>
		<cfdump var="#session.s1#">
	</cfif>
</cfoutput>