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
    	headerrow="2">

<cfset local.uploadResult = arrayNew(1)>
<cfoutput query="contactData">
	<cfset local.excelRow = structNew()>
	<cfset local.excelRow = {rowno= contactData.currentRow,
			email = EMAIL, 
		    	firstname = FIRSTNAME,
			lastname = LASTNAME, 
			phone = PHONE,
			house_flat = HOUSE_FLAT,
			hobbies = HOBBIES,
			street = STREET,
			city = CITY,
			state = STATE,
			pincode = PINCODE,
			title = TITLE,
			gender = GENDER,
			dob = DOB
			}>
	<cfset local.result= application.obj.excelValidate(local.excelRow)>
	<cfset structInsert(local.excelRow,"RESULT","#local.result#")>
	<cfset arrayappend(local.uploadResult,local.excelRow)>
</cfoutput>



<cfset application.obj = CreateObject("component", "components.database")>
<cfset local.get = application.obj.selectEmail()>
<cfset emailArray = ValueArray(local.get,"EMAIL")>

<cfif NOT ArrayIsEmpty(local.uploadResult)>
	<cfloop array="#local.uploadResult#" index="j" item="i">
		<cfif NOT structKeyExists(i.RESULT,"REMARKLIST")>
			<cfif ArrayContains(emailArray,i.email)>
				<cfset local.uploadResult[j].operation="updated">
				<cfset imgPath="">
				<cfset local.updateDetails = application.obj.excelGetDetails(i)>
				<cfset result = application.obj.updateContact(title=i.RESULT.titleVal,
								firstName=i.firstName,
								lastName=i.lastName,
								gender=i.RESULT.genderVal,
								dob=i.dob,
								house_flat=i.house_flat,
								street=i.street,
								city=i.city,
								state=i.state,
								pincode=i.pincode,
								email=i.email,
								phone=i.phone,
								result=local.updateDetails,
								imgPath=imgPath,
								logId=local.updateDetails.logId)>
			<cfelse>
				<cfset local.uploadResult[j].operation="added">
				<cfset imgPath="./images/signup.png">
				<cfset local.hobbies = ListToArray(i.RESULT.hobbielist)>
				<cfset local.result=structNew()>
				<cfset structInsert(local.result,"hobbies",local.hobbies)>
				<cfset message= application.obj.updateContact(title=i.RESULT.titleVal,
								firstName=i.firstName,
								lastName=i.lastName,
								gender=i.RESULT.genderVal,
								dob=i.dob,
								house_flat=i.house_flat,
								street=i.street,
								city=i.city,
								state=i.state,
								pincode=i.pincode,
								email=i.email,
								phone=i.phone,
								result=local.result,
								imgPath=imgPath)>
			</cfif>
		<cfelse>
			<cfset local.uploadResult[j].operation="error">
		</cfif>
	</cfloop>
	<cfset local.errorArray = arrayNew(1)>
	<cfset local.checkedArray = arrayNew(1)>
	<cfloop array="#local.uploadResult#" index="i" >
		<cfif i.operation EQ "error">
			<cfset ArrayAppend(local.errorArray,i)>
		<cfelse>
			<cfset ArrayAppend(local.checkedArray,i)>
		</cfif>
	</cfloop>
	<cfset ArrayAppend(local.errorArray,local.checkedArray,"true")>
	<cfset session.uploadResult=arrayNew(1)>
	<cfset  session.uploadResult = duplicate(local.errorArray)>
<cfelse>
	<script>alert("*Uploaded spreadsheet is empty");</script>
</cfif>