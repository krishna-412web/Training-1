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
<cfset uploadRow = structNew()>
<cfoutput query="contactData">
	<cfset uploadRow = structNew()>
	<cfset local.row = {rowno= contactData.currentRow,
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
	<cfset local.result= obj1.excelValidate(local.row)>
	<cfset structInsert(local.row,"RESULT","#local.result#")>
	<cfset arrayappend(local.uploadResult,local.row)>
</cfoutput>



<cfset obj = CreateObject("component", "components.database")>
<cfset local.get = obj.selectEmail()>
<cfset emailArray = ValueArray(local.get,"EMAIL")>

<cfif NOT ArrayIsEmpty(local.uploadResult)>
	<cfloop array="#local.uploadResult#" index="j" item="i">
		<cfif NOT structKeyExists(i.RESULT,"REMARKLIST")>
			<cfif ArrayContains(emailArray,i.email)>
				<cfset local.uploadResult[j].operation="updated">
				<cfset imgPath="">
				<cfset input = obj1.excelGetHobby(i)>
				<cfset result = obj1.updateContact(i.RESULT.titleVal,
								i.firstName,
								i.lastName,
								i.RESULT.genderVal,
								i.dob,
								i.house_flat,
								i.street,
								i.city,
								i.state,
								i.pincode,
								i.email,
								i.phone,
								input,
								imgPath,
								input.logId)>
			<cfelse>
				<cfset local.uploadResult[j].operation="added">
				<cfset imgPath="./images/signup.png">
				<cfset local.hobbies = ListToArray(i.RESULT.hobbielist)>
				<cfset message= obj1.addContact(i.RESULT.titleVal,
								i.firstName,
								i.lastName,
								i.RESULT.genderVal,
								i.dob,
								i.house_flat,
								i.street,
								i.city,
								i.state,
								i.pincode,
								i.email,
								i.phone,
								local.hobbies,
								imgPath)>
			</cfif>
		<cfelse>
			<cfset local.uploadResult[j].operation="error">
		</cfif>
	</cfloop>
	<cfset local.sortedArray=obj.ArrayChange(local.uploadResult)>
	<cfset session.uploadResult=arrayNew(1)>
	<cfset  session.uploadResult = duplicate(local.sortedArray)>
<cfelse>
	<script>alert("*Uploaded spreadsheet is empty");</script>
</cfif>