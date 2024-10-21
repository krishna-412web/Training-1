<!---<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectEmail()>
<cfset emailArray = ValueArray(get,"EMAIL")>--->

<cfif NOT structKeyExists(session,"uploadResult")>
	<script>alert("Session Expired");</script>
	<cflocation url="welcome.cfm" addToken="no">  
</cfif>

<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>


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
<cfset spreadsheetSetCellValue(spreadsheetObj, "REMARKS",1,14)>

<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 1)>

<cfif arrayLen(session.errorArray) GT 0>
	<cfloop array="#session.errorArray#" index="j" item="i">
		<cfset remarkList = ArraytoList(i.RESULT.errors)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.titleName#", j+1, 1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.firstname#", j+1, 2)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.lastname#", j+1, 3)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.genderName#", j+1, 4)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.dob#", j+1, 5)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.email#", j+1, 6)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.phone#", j+1, 7)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.hobbieNames#", j+1, 8)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.houseName#", j+1, 9)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.street#", j+1, 10)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.city#", j+1, 11)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.state#", j+1, 12)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.pincode#", j+1, 13)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#remarkList#", j+1, 14)>
		<cfset SpreadsheetSetRowHeight(spreadsheetObj,j+1,20)>
	</cfloop>
<cfelseif arrayLen(session.successArray) GT 0>
	<cfloop array="#session.successArray#" index="j" item="i">
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.titleName#", j+1, 1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.firstname#", j+1, 2)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.lastname#", j+1, 3)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.genderName#", j+1, 4)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.dob#", j+1, 5)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.email#", j+1, 6)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.phone#", j+1, 7)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.hobbieNames#", j+1, 8)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.houseName#", j+1, 9)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.street#", j+1, 10)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.city#", j+1, 11)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.state#", j+1, 12)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.pincode#", j+1, 13)>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.RESULT#", j+1, 14)>
		<cfset SpreadsheetSetRowHeight(spreadsheetObj,j+1,20)>
	</cfloop>
</cfif>

<cfloop from="3" to="#3+ArrayLen(session.uploadResult)#" index="i">
	<cfif i%2 NEQ 0>
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
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,14,30)>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>


<cfheader name="Content-Disposition" value="attachment; filename=Upload_Result.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >

<cflocation url="welcome.cfm">