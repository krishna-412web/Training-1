<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectEmail()>
<cfset emailArray = ValueArray(get,"EMAIL")>

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
<cfset spreadsheetSetCellValue(spreadsheetObj, "REMARKS",2,14)>

<cfset SpreadsheetFormatRow (spreadsheetObj, myFormat, 1)>
<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 2)>

<cfset imgPath="./images/signup.png">
<cfloop array="#local.uploadResult#" index="j" item="i">
	<cfif NOT structKeyExists(i.RESULT,"REMARKLIST")>
		<cfif ArrayContains(emailArray,i.email)>
			<cfset local.operation="update">
			<cfset result = obj1.updateContact({},i)>
		<cfelse>
			<cfset local.operation="add">
			<cfset message= obj1.addContact({},i,imgPath)>
		</cfif>
		<!---<cfset obj1.excelInsert(i,local.operation)>--->
	</cfif>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.title#", j+2, 1)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.firstname#", j+2, 2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.lastname#", j+2, 3)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.gender#", j+2, 4)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.dob#", j+2, 5)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.email#", j+2, 6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.phone#", j+2, 7)>
	<!---<cfset hobbieList = ArraytoList(i.hobbies)>--->
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.hobbies#", j+2, 8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.house_flat#", j+2, 9)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.street#", j+2, 10)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.city#", j+2, 11)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.state#", j+2, 12)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.pincode#", j+2, 13)>
	<cfif structKeyExists(i.RESULT,"REMARKLIST")>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "#i.RESULT.REMARKLIST#", j+2, 14)>
		<cfif NOT j+2 EQ 3>
			<cfset SpreadsheetShiftRows(spreadsheetObj,3,j+2,1)>
			<cfset SpreadsheetShiftRows(spreadsheetObj,j+3,-(j))>
		</cfif>
	<cfelseif local.operation EQ "add">
		<cfset spreadsheetSetCellValue(spreadsheetObj, "Added", j+2, 14)>
	<cfelseif local.operation EQ "update">
		<cfset spreadsheetSetCellValue(spreadsheetObj, "Updated", j+2, 14)>
	</cfif>
	<cfset SpreadsheetSetRowHeight(spreadsheetObj,j+2,20)>
</cfloop>

<cfloop from="3" to="#3+ArrayLen(local.uploadResult)#" index="i">
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
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,14,30)>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>


<cfheader name="Content-Disposition" value="attachment; filename=Upload_Result.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >

<cflocation url="welcome.cfm">