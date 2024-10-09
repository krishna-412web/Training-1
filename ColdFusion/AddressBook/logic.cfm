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
					<cfset result = obj1.updateContact(form.title,
									form.firstName,
									form.lastName,
									form.gender,
									form.dob,
									form.houseName,
									form.street,
									form.city,
									form.state,
									form.pincode,
									form.email,
									form.phone,
									local.result,
									imgPath,
									local.logId
									)>
				<cfelse>
					<cfset local.hobbies = ListToArray(form.hobbies)>
					<cfset message= obj1.addContact(form.title,
									form.firstName,
									form.lastName,
									form.gender,
									form.dob,
									form.houseName,
									form.street,
									form.city,
									form.state,
									form.pincode,
									form.email,
									form.phone,
									local.hobbies,
									imgPath)>				
				</cfif>
			</cfif>
		</cfif>
		<cfif structKeyExists(form,"deleteSubmit")>
			<cfset obj1.deleteContact(form.logId)>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		</cfif>
		<cfif structKeyExists(form,"uploadSubmit")>
			<cfinclude template="excelUpload.cfm">
		</cfif>
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
	
</cfoutput>