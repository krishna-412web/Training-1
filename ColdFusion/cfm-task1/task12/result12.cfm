<cfquery name="showData" datasource="test1"> SELECT firstname,lastname from NAMES;</cfquery>



<cfif structKeyExists(form,"submit")>
	<cfif form.num GTE 1 AND form.num LTE 10>
		<table border="2px solid black">
			<tr>
					<th>FirstName</th>
					<th>LastName</th>
			</tr>
			<cfoutput query="showData">
				<tr>
						<td>#firstname#</td>
						<td>#lastname#</td>
				</tr>
			</cfoutput>
		</table>
		<cfset firstName=showData.firstname[form.num]>
		<cfoutput><br></cfoutput>
		<cfoutput>Row :#form.num# <br> FirstName:#firstName#</cfoutput>
	<cfelse>
			<cfoutput>ENTER NUMBERS FROM 1 TO 10</cfoutput>
	</cfif>
</cfif>

