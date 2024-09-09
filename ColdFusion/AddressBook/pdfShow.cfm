<cfset obj = CreateObject("component","components.database")>
<cfset get = obj.selectdata()>
<!DOCTYPE html>
<html>
	<head></head>
	<body>
		<table border="1" cellpadding="5" cellspacing="0">	
			<thead>
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Phone</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="get">
					<tr>
						<td>#firstname# #lastname#</td>
						<td>#email#</td>
						<td>#phone#</td>
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</body>
</html>
