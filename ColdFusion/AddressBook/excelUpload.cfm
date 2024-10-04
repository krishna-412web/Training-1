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


<cfoutput query="contactData">
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
	<cfset local.result= obj1.excelValidate(local.row )>
	<cfdump var="#local.result#">
</cfoutput>

<cfdump var="#contactData#">