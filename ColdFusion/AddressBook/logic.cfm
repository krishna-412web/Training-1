
<cfif structKeyExists(url,"logout") AND url.logout EQ 1>
		<cfset session.result.value = 0>
		<cflocation url="index.cfm" addToken="no">
</cfif>
<cfset application.obj=CreateObject("component","components.database")>
<cfif structKeyExists(form, "submit1")>
	<cfset variables.message = application.obj.formValidate()>
	<cfif ArrayLen(variables.message.errors) EQ 0>
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
		<cfif structKeyExists(form,"logId")>
			<cfset local.logId = application.obj.decryptData(form.logId)>
			<cfset previousHobbyArray = listToArray(form.prevHobbieList)>
			<cfset presentHobbyArray = listToArray(form.hobbies)>
			<cfset local.result = application.obj.ArrayDiff(previousHobbyArray,presentHobbyArray)>
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
							result=local.result,
							imgPath=imgPath,
							logId=local.logId
							)>
		<cfelse>
			<cfset local.hobbies = ListToArray(form.hobbies)>
			<cfset local.result = structNew()>
			<cfset structInsert(local.result,"hobbies",local.hobbies)>
			<cfset message= application.obj.updateContact(title=form.title,
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
							result=local.result,
							imgPath=imgPath)>				
		</cfif>
	</cfif>
</cfif>
<cfif structKeyExists(form,"deleteSubmit")>
	<cfset application.obj.deleteContact(form.logId)>
	<cflocation url="welcome.cfm" addToken="no" >
</cfif>
<cfif structKeyExists(form,"uploadSubmit")>
	<cfinclude template="excelUpload.cfm">
<cfelseif NOT structKeyExists(form,"uploadSubmit") AND structKeyExists(session,"uploadResult")>
	<cfset StructDelete(session, "uploadResult")>
</cfif>
<cfinvoke 
	component = "components.database" 	
	method = "dynamicForm" 
	returnVariable = "variables.result">