<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectdata()>

<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>


<cfset myFormat=StructNew()>
<cfset myFormat.bold="true">
<cfset myFormat.alignV="center">

<cfset data={color="white",fgcolor="grey_50_percent",alignV="center"}>
<cfset dataHead={color="white",fgcolor="grey_50_percent",bold="true",alignV="center"}>

<cfset spreadsheetSetCellValue(spreadsheetObj, "TITLE", 2, 1)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "FIRSTNAME", 2, 2)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "LASTNAME", 2, 3)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "GENDER", 2, 4)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "DOB", 2, 5)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "EMAIL", 2, 6)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "PHONE", 2, 7)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "HOBBIES",2,8)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "HOUSE_FLAT",2,9)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "STREET",2,10)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "CITY",2,11)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "STATE",2,12)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "PINCODE",2,13)>

<cfset SpreadsheetFormatRow (spreadsheetObj, myFormat, 1)>
<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 2)>

<cfloop from="1" to="#ArrayLen(get)#" index="i">
	<cfset fullName = get[i].firstname & " " & get[i].lastname>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].titlename#", i+2, 1)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].firstname#", i+2, 2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].lastname#", i+2, 3)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].gendername#", i+2, 4)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].dob#", i+2, 5)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].email#", i+2, 6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].phone#", i+2, 7)>
	<cfset hobbieList = ArraytoList(get[i].hobbies)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#hobbieList#", i+2, 8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].house_flat#", i+2, 9)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].street#", i+2, 10)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].city#", i+2, 11)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].state#", i+2, 12)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#get[i].pincode#", i+2, 13)>
	<cfset SpreadsheetSetRowHeight(spreadsheetObj,i+2,20)>
</cfloop>

<cfloop from="3" to="#3+ArrayLen(get)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,data,i)>
	</cfif>
</cfloop>

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


<cfheader name="Content-Disposition" value="attachment; filename=Template_With_Data.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >