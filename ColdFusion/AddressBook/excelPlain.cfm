<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectdata()>


<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>


<cfset myFormat=StructNew()>
<cfset myFormat.bold="true">
<cfset myFormat.alignV="center">

<cfset data={color="white",fgcolor="grey_50_percent",alignV="center"}>
<cfset dataHead={color="white",fgcolor="grey_50_percent",bold="true",alignV="center"}>

<cfset spreadsheetSetCellValue(spreadsheetObj, "USER:", 1, 1)>
<cfset spreadsheetSetCellValue(spreadsheetObj, session.user, 1, 2)>

<cfset spreadsheetSetCellValue(spreadsheetObj, "NAME", 2, 1)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "EMAIL", 2, 2)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "PHONE", 2, 3)>
<cfset spreadsheetSetCellValue(spreadsheetObj, "HOBBIES",2,4)>

<cfset SpreadsheetFormatRow (spreadsheetObj, myFormat, 1)>
<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 2)>

<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,35)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,35)>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>


<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >