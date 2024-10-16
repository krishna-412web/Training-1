<cfset variables.fileName="Plain_Template.xlsx">
<cfset variables.pageMode="plain">
<cfif structKeyExists(url,"excelData")>
	<cfset variables.fileName="Template_With_Data.xlsx">
	<cfset variables.pageMode="data">
	<cfset application.obj = CreateObject("component", "components.database")>
	<cfset get = application.obj.selectdata()>
</cfif>

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

<cfif variables.pageMode EQ "data">
	<cfloop from="1" to="#ArrayLen(get)#" index="i">
		<cfset fullName = get[i].firstname & " " & get[i].lastname>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].titlename#", i+1, 1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].firstname#", i+1, 2)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].lastname#", i+1, 3)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].gendername#", i+1, 4)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].dob#", i+1, 5)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].email#", i+1, 6)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].phone#", i+1, 7)>
		<cfset hobbieList = ArraytoList(get[i].hobbies)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#hobbieList#", i+1, 8)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].house_flat#", i+1, 9)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].street#", i+1, 10)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].city#", i+1, 11)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].state#", i+1, 12)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].pincode#", i+1, 13)>
		<cfset SpreadsheetSetRowHeight(spreadsheetObj,i+1,20)>
	</cfloop>

	<cfloop from="2" to="#2+ArrayLen(get)#" index="i">
		<cfif i%2 EQ 0>
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