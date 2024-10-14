<cfoutput>
	<cfif structKeyExists(session,"result") AND session.result.value EQ 1>
		<cfif structKeyExists(form,"submit")>
			<cfset session.result.value = 0>
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfset obj1=CreateObject("component","components.database")>
		<cfif structKeyExists(form, "submit1")>
			<cfset variables.message = obj1.formValidate()>
			<cfif variables.message.flag EQ 1>
				<cfif structKeyExists(form,"profile") AND len(trim(form.profile)) GT 0>
					<cfinclude template="image.cfm">
				<cfelseif structKeyExists(form,"logId")>
					<cfset imgPath="">
				<cfelse>
					<cfset imgPath="./images/signup.png">
				</cfif>
				<cfif structKeyExists(form,"logId")>
					<cfset local.logId = obj1.decryptData(form.logId)>
					<cfset previousHobbyArray = listToArray(form.prevHobbieList)>
					<cfset presentHobbyArray = listToArray(form.hobbies)>
					<cfset local.result = obj1.ArrayDiff(previousHobbyArray,presentHobbyArray)>
					<cfset message = obj1.updateContact(title=form.title,
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
					<cfset message= obj1.updateContact(title=form.title,
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
			<cfset obj1.deleteContact(form.logId)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfif structKeyExists(form,"uploadSubmit")>
			<cfinclude template="excelUpload.cfm">
		<cfelseif NOT structKeyExists(form,"uploadSubmit") AND structKeyExists(session,"uploadResult")>
			<cfset StructDelete(session, "uploadResult")>
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>