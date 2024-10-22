<cfset uploadDir = expandPath('./temp/')>
<cffile action="upload"
        filefield="spreadsheet"
        destination="#uploadDir#"
        nameConflict="makeunique">
<cfset uploadedFileName = cffile.serverFile>
<cfset excelPath="#uploadDir##cffile.serverFile#">
<cfspreadsheet   
    	action="read" 
    	src="#excelPath#" 
    	query="contactData" 
    	sheetname="AddressBook"
	excludeHeaderRow = "true"
    	headerrow="1">
<!---<cfdump var="#contactData#" abort>--->
<cfset errorArray = arrayNew(1)>
<cfset successArray = arrayNew(1)>
<cfoutput query="contactData">
	<cfset excelRow = structNew()>
	<cfset excelRow = {"rowno"= contactData.currentRow,
			"email" = contactData.EMAIL, 
		    "firstname" = contactData.FIRSTNAME,
			"lastname" = contactData.LASTNAME, 
			"phone" = contactData.PHONE,
			"houseName" = contactData.HOUSE_FLAT,
			"hobbieNames" = contactData.HOBBIES,
			"street" = contactData.STREET,
			"city" = contactData.CITY,
			"state" = contactData.STATE,
			"pincode" = contactData.PINCODE,
			"titleName" = contactData.TITLE,
			"genderName" = contactData.GENDER,
			"dob" = contactData.DOB
			}>
	<cfset local.result= application.obj.formValidate(data = excelRow)>
	<cfif arrayLen(local.result.errors)>
		<cfset excelRow.status = 0>
		<cfset excelRow.result.errors = local.result.errors>
		<cfset ArrayAppend(errorArray,excelRow)>
	<cfelse>
		<cfquery name="getCOntact">
			SELECT
				log_id
			FROM
				log_book
			WHERE
				email = <cfqueryparam value="#excelRow.email#" cfsqltype="cf_sql_varchar">
				AND
				user_id = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfquery name="getTitleId">
			SELECT
				id
			FROM
				title
			WHERE
				value = <cfqueryparam value="#excelRow.titleName#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfquery name="getGenderid">
			SELECT
				genderid
			FROM
				gender
			WHERE
				gendername = <cfqueryparam value="#excelRow.genderName#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfquery name="getHobbieId">
			SELECT
				hobbieid
			FROM
				hobbies
			WHERE
				hobbieName IN (<cfqueryparam value="#excelRow.hobbieNames#" cfsqltype="cf_sql_varchar" list="true">)
		</cfquery>
		<cfset logId = Val(getCOntact.log_id)>
		<cfset titleId = Val(getTitleId.id)>
		<cfset genderId = Val(getGenderid.genderid)>
		<cfset hobbieList = ValueList(getHobbieId.hobbieid)>
		<cfset message = application.databaseObj.updateContact(
			title=titleId,
			firstName=excelRow.firstName,
			lastName=excelRow.lastName,
			gender=genderId,
			dob=excelRow.dob,
			house_flat=excelRow.houseName,
			street=excelRow.street,
			city=excelRow.city,
			state=excelRow.state,
			pincode=excelRow.pincode,
			email=excelRow.email,
			phone=excelRow.phone,
			hobbies=hobbieList,
			imgPath= val(logId) ? "" : "./images/signup.png",
			logId=logId
		)>
		<cfset excelRow.status = 1>
		<cfset excelRow.result = val(logId) ? 'Updated' : "Added">
		<cfset arrayAppend(successArray, excelRow)>
	</cfif>
</cfoutput>

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
<cfset spreadsheetSetCellValue(spreadsheetObj, "REMARKS",1,14)>

<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 1)>

<cfif arrayLen(errorArray) GT 0>
	<cfloop array="#errorArray#" index="j" item="i">
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
<cfelseif arrayLen(successArray) GT 0>
	<cfloop array="#successArray#" index="j" item="i">
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

<cfloop from="3" to="#3+ArrayLen(errorArray)+ArrayLen(successArray)#" index="i">
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
<cfset uniqueFileName = CreateUUID() & ".xlsx">
<cfset destinationPath = ExpandPath("./temp/") & uniqueFileName>
<cffile action="write" file="#destinationPath#" output="#binary#" addnewline="no">

