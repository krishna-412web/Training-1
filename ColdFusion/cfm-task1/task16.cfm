<cfoutput>
<style>
	th {
		padding: 10px;
	}
</style>
<table>
	<cfloop from="1" to="3" index="i">
		<tr>
		<cfloop from="0" to="6" step="3" index="j">
			<th>#i+j#</th>
		</cfloop>
		</tr>
	</cfloop>
</table>
</cfoutput>