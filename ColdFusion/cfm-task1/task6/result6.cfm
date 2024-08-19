<cfset s = StructNew()>

<cfif structKeyExists(form,"submit")>
	<cfif StructIsEmpty(s)>
		<cfset StructInsert(s,form.keys,form.value)>
	<cfelse>
		<cfset s["#form.keys#"]=form.value >
	</cfif>
	<cfdump var="#s#">
</cfif>