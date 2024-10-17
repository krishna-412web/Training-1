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
<cfset uploadResult = arrayNew(1)>
<cfoutput query="contactData">
	<cfset local.excelRow = structNew()>
	<cfset local.excelRow = {rowno= contactData.currentRow,
			email = contactData.EMAIL, 
		    firstname = contactData.FIRSTNAME,
			lastname = contactData.LASTNAME, 
			phone = contactData.PHONE,
			house_flat = contactData.HOUSE_FLAT,
			hobbies = contactData.HOBBIES,
			street = contactData.STREET,
			city = contactData.CITY,
			state = contactData.STATE,
			pincode = contactData.PINCODE,
			title = contactData.TITLE,
			gender = contactData.GENDER,
			dob = contactData.DOB
			}>
	<cfset local.result= application.obj.excelValidate(data = local.excelRow)>
	<cfif arrayLen(local.result.errors)>
	<cfelse>
	</cfif>
	<cfset structInsert(local.excelRow,"RESULT","#local.result#")>
	<cfset arrayappend(uploadResult,local.excelRow)>
</cfoutput>




<cfset local.get = application.obj.selectEmail()>
<cfset emailArray = ValueArray(local.get,"EMAIL")>

<cfif NOT ArrayIsEmpty(uploadResult)>
	<cfloop array="#uploadResult#" index="j" item="i">
		<cfif NOT structKeyExists(i.RESULT,"REMARKLIST")>
			<cfif ArrayContains(emailArray,i.email)>
				<cfset uploadResult[j].operation="updated">
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
				<cfset uploadResult[j].operation="added">
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
			<cfset uploadResult[j].operation="error">
		</cfif>
	</cfloop>
	<cfset local.errorArray = arrayNew(1)>
	<cfset local.checkedArray = arrayNew(1)>
	<cfloop array="#uploadResult#" index="i" >
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