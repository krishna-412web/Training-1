<cfoutput>
	<cfif structKeyExists(form,"submit")>
		<cfif form.num EQ 5>very good<br></cfif>
		<cfif form.num EQ 4>good<br></cfif>
		<cfif form.num EQ 3>fair<br></cfif>
		<cfif form.num EQ 2>ok<br></cfif>
		<cfif form.num EQ 1 >ok<br></cfif>
	</cfif>

	<cfif structKeyExists(form,"submit")>
			<cfif form.num EQ 5>Very Good
			<cfelseif form.num EQ 4>Good
			<cfelseif form.num EQ 3>Fair
			<cfelseif form.num EQ 2>OK
			<cfelseif form.num EQ 1 >Ok
			<cfelse>Wrong character entered(Enter 1 to 5)
		</cfif>
	</cfif>
</cfoutput>