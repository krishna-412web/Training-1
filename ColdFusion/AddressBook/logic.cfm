
<cfif structKeyExists(url, "logout") AND url.logout EQ 1>
		<cfset structClear(session)>
		<cflocation url="index.cfm" addToken="no">
</cfif>

<cfif structKeyExists(form,"deleteSubmit")>
	<cfset application.obj.deleteContact(logId = form.logId)>
</cfif>

<cfif structKeyExists(form, "updateSubmit")>
	<cfset variables.message = application.obj.formValidate(data = form)>
	<cfif NOT ArrayLen(variables.message.errors)>
		<cfif structKeyExists(form,"profile") AND len(trim(form.profile)) GT 0>
			<cfset uploadDir = expandPath('./images/')>        
			<cfif not directoryExists(uploadDir)>
      			<cfdirectory action="create" directory="#uploadDir#">
			</cfif>
			<cffile action="upload"
        			filefield="profile"
        			destination="#uploadDir#"
        			nameConflict="makeunique">
			<cfset uploadedFileName = cffile.serverFile>
			<cfset imgPath="./images/#uploadedFileName#">
		<cfelseif structKeyExists(form,"logId")>
			<cfset imgPath="">
		<cfelse>
			<cfset imgPath="./images/signup.png">
		</cfif>
		<cfset local.logId = structKeyExists(form,"logId")? application.obj.decryptData(form.logId) : 0>
		<cfset message = application.obj.updateContact(title=form.title,
						firstName=form.firstName,
						lastName=form.lastName,
						gender=form.gender,
						dob=form.dob,
						house_flat=form.houseName,
						street=form.street,
						city=form.city,
						state=form.state,
						pincode=form.pincode,
						email=form.email,
						phone=form.phone,
						hobbies=form.hobbies,
						imgPath=imgPath,
						logId=local.logId
						)>
	</cfif>
<cfelseif structKeyExists(form,"uploadSubmit")>
	<cfinclude template="excelUpload.cfm">
<cfelseif NOT structKeyExists(form,"uploadSubmit") AND structKeyExists(session,"uploadResult")>
	<cfset structDelete(session, "uploadResult")>
</cfif>

<cfinvoke 
	component = "components.database" 	
	method = "dynamicForm" 
	returnVariable = "variables.result">