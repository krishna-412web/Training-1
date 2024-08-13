<cfif structKeyExists(form,"submit")>
	<style>
		.odd { color:blue; }
		.even { color:green; }
	</style>
	<cfoutput>
		<cfset n= form.num>

		<cfloop from="1" to="#n#" index="i">
			<cfif i mod 2 EQ 0>
				<cfoutput><span class="even">#i#</span><br></cfoutput>
			<cfelse>
				<cfoutput><span class="odd">#i#</span><br></cfoutput>
			</cfif>
		</cfloop>
 
	</cfoutput>	
</cfif>