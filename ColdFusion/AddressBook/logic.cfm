<cfoutput>
	<cfif structKeyExists(form, "submit1")>
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
		<cfset obj1=CreateObject("component","components.database")>
		<cfset message=obj1.addContact(form.title,form.firstName,form.lastName,form.gender,form.dob,
						"#imgPath#",form.houseName,form.street,form.city,form.state,form.pincode,form.email,form.phone)>
		<script>alert("#message#");</script>	
	</cfif>
	<cfif structKeyExists(form,"submit2")>
		
	</cfif>
</cfoutput>