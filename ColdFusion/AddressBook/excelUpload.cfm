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
<cfset session.errorArray = arrayNew(1)>
<cfset session.successArray = arrayNew(1)>
<cfset uploadResult = arrayNew(1)>
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
		<cfset ArrayAppend(session.errorArray,excelRow)>
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
		<cfset arrayAppend(session.successArray, excelRow)>
	</cfif>
</cfoutput>
<cfset session.uploadResult = arraynew(1)>
<cfset arrayAppend(session.uploadResult, session.errorArray)>
<cfset arrayAppend(session.uploadResult, session.successArray)>
<!---<cfdump var="#errorArray#">
<cfdump var="#successArray#" abort>--->


