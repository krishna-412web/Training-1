<cfloop from="1" to="3" index="i">
	<cfset a=#i#>
	<cfloop from="1" to="3"index="j">
		<cfoutput>#a#</cfoutput>
		<cfset a= a+3>
	</cfloop>
	<br>
</cfloop>