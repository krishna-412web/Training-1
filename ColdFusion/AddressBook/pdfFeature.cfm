<cfset obj = CreateObject("component","components.database")>
<cfset get = obj.selectdata()>
<cfheader name="Content-Disposition" value="attachment; filename=example.pdf">
<cfheader name="Content-Type" value="application/pdf">

<cfcontent type="application/pdf" reset="true">


<cfdocument format="PDF" orientation="portrait">
	<h1 style="text-align: center;">Address Book</h1>
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
</cfdocument>

