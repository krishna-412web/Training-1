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


<cfheader name="Content-Disposition" value="attachment; filename=Plain_Template.xlsx">



<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >