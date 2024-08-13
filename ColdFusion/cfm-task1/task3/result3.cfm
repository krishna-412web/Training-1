<cfoutput>
	<cfif structKeyExists(form,"submit")>	
		<cfset s= arrayNew(1)>
		<cfset arr=ListtoArray("#form.num#")>
		<cfloop array="#arr#" item="n">
		<cfif n % 3 NEQ 0>
			<cfcontinue>
		</cfif>	
		<cfset ArrayAppend(s,#n#)>	
		</cfloop>
		<cfset r= ArrayToList(s)>
		#r#
	</cfif>
</cfoutput>