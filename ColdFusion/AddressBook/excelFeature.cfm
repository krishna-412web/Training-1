<cfset variables.fileName="Plain_Template.xlsx">
<cfset variables.pageMode="plain">
<cfif structKeyExists(url,"excelData")>
	<cfset variables.fileName="Template_With_Data.xlsx">
	<cfset variables.pageMode="excelData">
	<cfset contactList = application.obj.selectdata()>
<cfelseif structKeyExists(url,"pdfData")>
	<cfset variables.fileName="contactList.pdf">
	<cfset variables.pageMode="pdfData">
	<cfset contactList = application.obj.selectdata()>
</cfif>

<cfif variables.pageMode NEQ "pdfData">
	<cfset spreadsheetObj = SpreadsheetNew("AddressBook", true)>

	<cfset myFormat=StructNew()>
	<cfset myFormat.bold="true">
	<cfset myFormat.alignV="center">

	<cfset data={color="white",fgcolor="grey_50_percent",alignV="center"}>
	<cfset dataHead={color="white",fgcolor="grey_50_percent",bold="true",alignV="center"}>

	<cfset spreadsheetSetCellValue(spreadsheetObj, "TITLE", 1, 1)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "FIRSTNAME", 1, 2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "LASTNAME", 1, 3)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "GENDER", 1, 4)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "DOB", 1, 5)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "EMAIL", 1, 6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "PHONE", 1, 7)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "HOBBIES",1,8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "HOUSE_FLAT",1,9)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "STREET",1,10)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "CITY",1,11)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "STATE",1,12)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "PINCODE",1,13)>

	<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 1)>

	<cfif variables.pageMode EQ "excelData">
		<cfloop from="1" to="#ArrayLen(contactList)#" index="i">
			<cfset fullName = contactList[i].firstname & " " & contactList[i].lastname>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].titlename#", i+1, 1)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].firstname#", i+1, 2)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].lastname#", i+1, 3)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].gendername#", i+1, 4)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].dob#", i+1, 5)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].email#", i+1, 6)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].phone#", i+1, 7)>
			<cfset hobbieList = ArraytoList(contactList[i].hobbies)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#hobbieList#", i+1, 8)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].house_flat#", i+1, 9)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].street#", i+1, 10)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].city#", i+1, 11)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].state#", i+1, 12)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList[i].pincode#", i+1, 13)>
			<cfset SpreadsheetSetRowHeight(spreadsheetObj,i+1,20)>
		</cfloop>

		<cfloop from="3" to="#3+ArrayLen(contactList)#" index="i">
			<cfif i%2 NEQ 0>
				<cfset SpreadsheetFormatRow(spreadsheetObj,data,i)>
			</cfif>
		</cfloop>
	</cfif>

	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,6,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,7,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,8,35)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,9,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,10,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,11,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,12,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,13,20)>

	<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

	<cfheader name="Content-Disposition" value="attachment; filename=#variables.fileName#">
	<!--- Serve the file and delete it after download --->
	<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >
<cfelse>
	<cfheader name="Content-Disposition" value="attachment; filename=#variables.fileName#">
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
				<cfoutput>
					<cfloop array="#contactList#" index="item">
						<tr>
							<td>#item.firstname# #item.lastname#</td>
							<td>#item.email#</td>
							<td>#item.phone#</td>
						</tr>
					</cfloop>
				</cfoutput>
			</tbody>
		</table>
	</cfdocument>
</cfif>