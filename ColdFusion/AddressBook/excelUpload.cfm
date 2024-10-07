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
	<cfset local.row = {email = EMAIL, 
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
	<cfdump var="#local.row#">
	<cfset local.result= obj1.excelValidate(local.row)>
	<cfset structInsert(local.row,"RESULT","#local.result#")>
	<cfset arrayappend(local.uploadResult,local.row)>
</cfoutput>
cfdump var="#local.uploadResult#">
<cfdump var="#local.uploadResult#">
<cfif NOT ArrayIsEmpty(local.uploadResult)>
	<cfinclude template="uploadResult.cfm">
<cfelse>
	<script>alert("*Uploaded spreadsheet is empty");</script>
</cfif>