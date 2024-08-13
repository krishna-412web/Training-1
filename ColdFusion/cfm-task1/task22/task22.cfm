<cfset jsonString='[{"Name":"saravann","Age":"27","LOCATION":"dubai"},{"Name":"Ram","Age":"26","LOCATION":"Kovilpatti"}]'>
<cfset data=deserializeJSON(jsonString)>
<cfdump var="#data#">
<cfoutput>
	<table cellspacing="5" cellpadding="5">
		<thead>
			<th>Name</th>
			<th>Age</th>
			<th>Location</th>
		</thead>
		<tbody>
			<cfloop array="#data#" index="i">
				<tr>
					<td>#i.Name#</td>
				 	<td>#i.Age#</td>
				  	<td>#i.LOCATION#</td>
				<tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>