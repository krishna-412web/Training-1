 <cfcomponent>
	<cfproperty name="userName" type="string">
	<cfproperty name="hashedPassword" type="string">
	<cfproperty name="salt" type="string">
	<cfset variables.key="baiYIM2yvVW258BNOmovjQ==">

	

	<cffunction name="access" access="public" returnType="struct">
		<cfargument name="userName" type="string">
		<cfargument name="passWord" type="string">
		<cfquery name="local.get" result="r">
			SELECT 
				uid,name,email,password,salt
			FROM 
				user 
			WHERE 
				username= <cfqueryparam value="#arguments.userName#" cfsqltype="varchar">;
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfset local.hashedPassword=local.get.password>
			<cfset local.salt=local.get.salt>
			<cfset local.checkPassword=HashPassword(arguments.passWord,local.salt)>
			<cfif local.checkPassword EQ local.hashedPassword>
				<cfset local.result = structNew()>
				<cfset local.result.value = 1 >
				<cfset session.uid=local.get.uid>
				<cfset session.user=local.get.name>
				<cfset session.email=local.get.email>
			<cfelse>
				<cfset local.result.value = 0 >
			</cfif>	
		<cfelse> 
			<cfset local.result.value = 0>
		</cfif>
		<cfreturn local.result>
	</cffunction>
	
	<cffunction name="HashPassword">
		<cfargument name="passWord" type="string">
		<cfargument name="salt" type="string">
		<cfset local.saltedPassword = arguments.passWord & arguments.salt>
		<cfset local.hashedPassword = hash(local.saltedPassword,"SHA-256","UTF-8")>	
		<cfreturn local.hashedPassword/>
	</cffunction>

	<cffunction name="createUser">
		<cfargument name="name" type="string">
		<cfargument name="email" type="string">
		<cfargument name="userName" type="string">
		<cfargument name="passWord" type="string">
		<cfset local.salt=generateSecretKey("AES")>
		<cfset local.hashedPassword = HashPassword(arguments.passWord,local.salt)>
		<cfset local.createResult = structNew()>
		<cfset local.createResult.value = 0>

		<cfquery name="local.checkUsername" result="r1">
			SELECT uid FROM user WHERE username = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar"> 
		</cfquery>

		<cfquery name="local.checkemail" result="r2">
			SELECT uid FROM user WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
		
		<cfif r1.RECORDCOUNT EQ 0 AND r2.RECORDCOUNT EQ 0>
			<cfquery name="createUser" result="r">
				INSERT INTO 
					USER(name,email,username,password,salt) 
				VALUES (<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,       
					<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#local.hashedPassWord#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">)
			</cfquery>
			<cfset local.createResult.value = 1 />
		<cfelseif local.checkUsername.uid EQ local.checkemail.uid>
			<cfset session.errorMessage="*account already exists">
		<cfelseif r1.RECORDCOUNT NEQ 0 AND r2.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*username and email already used">
		<cfelseif r1.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*username already used">
		<cfelseif r2.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*email already used">
		</cfif>
		<cfreturn local.createResult />
	</cffunction>

	<cffunction name="selectdata" access="remote" returnFormat="JSON">
		<cfargument name="log_id" type="string" required="false">
		<cfif structKeyExists(arguments,"log_id")>
			<cfset local.logId = decryptData(arguments.log_id)>	
		</cfif>
		<cfquery name="local.getContacts" returnType="struct">
			SELECT 
            			log_book.log_id,
				log_book.title,
            			log_book.firstname,
            			log_book.lastname,
				log_book.gender,
            			log_book.dob,
            			log_book.profile,
            			log_book.house_flat,
            			log_book.street,
            			log_book.city,
            			log_book.state,
            			log_book.pincode,
            			log_book.email,
            			log_book.phone,
				title.value AS titleName,
				gender.gendername AS genderName,
				GROUP_CONCAT(hobbieContact.hobbieid) AS hobbieid,
            			GROUP_CONCAT(hobbies.hobbieName) AS hobbies
        		FROM
            			log_book
        		LEFT JOIN
            			hobbieContact ON log_book.log_id = hobbieContact.log_id
        		LEFT JOIN
         	   		hobbies ON hobbieContact.hobbieid = hobbies.hobbieid
			LEFT JOIN
				title ON log_book.title = title.id
			LEFT JOIN
				gender ON log_book.gender = gender.genderid
        		WHERE 
            			log_book.user_id = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">

				<cfif structKeyExists(arguments,"log_id")>
					AND
					log_book.log_id = <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">

				</cfif>


        		GROUP BY
            			log_book.log_id;
		</cfquery>
		<cfset local.metadataStruct = {
        		type = "struct",
     			fields = {
            		log_id: {type = "string"},
            		title: {type: "numeric"},
            		firstname: {type = "string"},
            		lastname: {type = "string"},
            		gender: {type = "string"},
            		dob: {type = "date"},
            		profile: {type = "string"},
           	 	house_flat: {type = "string"},
            		street: {type = "string"},
            		city: {type = "string"},
            		state: {type = "string"},
            		pincode: {type = "numeric"},
            		email: {type = "string"},
           		phone: {type = "numeric"},
            		titleName: {type = "string"},
            		genderName: {type = "string"},
            		hobbieid: {type = "string"},
            		hobbies: {type = "array", items = "string"}
        		}
    		}>
		<cfloop array="#local.getContacts.RESULTSET#" index="local.i">
			<cfset local.encryptedText= encrypt(toString(local.i.log_id),variables.key,"AES","Hex")>
			<cfset local.i.log_id= local.encryptedText >
			<cfif structKeyExists(local.i,"hobbies")>
				<cfset local.hobbieArray = listToArray(local.i.hobbies)>
				<cfset local.i.hobbies = local.hobbieArray>
			</cfif>
			<cfset structSetMetaData(local.i, local.metadataStruct)>
		</cfloop>
		<!---<cfdump var="#structGetMetaData(local.getContacts.RESULTSET[1])#">--->
		<cfreturn local.getContacts.RESULTSET/>
	</cffunction>

	<cffunction name="dynamicForm" returnType="struct">
		<cfset local.result = structNew()>
		<cfset local.genderArray = []>
		<cfset local.result.genderList = "">
		<cfset local.titleArray = []>
		<cfset local.result.titleList = "">
		<cfset local.HobbieArray = []>
		<cfset local.result.HobbieList = "">
		<cfquery name="local.getTitle" returnType="struct">
			SELECT 
				id,
				value
			FROM
				title;
		</cfquery>
		<cfquery name="local.getGender" returnType="struct">
			SELECT 
				genderid,
				gendername
			FROM
				gender;
		</cfquery>
		<cfquery name="local.getHobbies" returnType="struct">
			SELECT 
				hobbieid,
				hobbieName
			FROM
				hobbies;
		</cfquery>
		<cfset local.titleNameList=''>
		<cfloop array="#local.getTitle.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.titleArray,local.i.id)>
			<cfset local.titleNameList = listAppend(local.titleNameList, local.i.value)>
		</cfloop>
		<cfset local.genderName=''>
		<cfloop array="#local.getGender.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.genderArray,local.i.genderid)>
			<cfset local.genderName=listAppend(local.genderName, local.i.gendername)>
		</cfloop>
		<cfset local.hobbieNameList=''>
		<cfloop array="#local.getHobbies.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.hobbieArray,local.i.hobbieid)>
			<cfset local.hobbieNameList=listAppend(local.hobbieNameList, local.i.hobbieName)>
		</cfloop>

		<cfset local.result.title = local.getTitle.RESULTSET>
		<cfset local.result.titleList = ArrayToList(local.titleArray)>
		<cfset local.result.gender = local.getGender.RESULTSET>
		<cfset local.result.genderList = ArrayToList(local.genderArray)>
		<cfset local.result.hobbies = local.getHobbies.RESULTSET>
		<cfset local.result.hobbieList = ArrayToList(local.hobbieArray)>
		<cfset local.result.titleNameList = local.titleNameList>
		<cfset local.result.genderName = local.genderName>
		<cfset local.result.hobbieNames = local.hobbieNameList>

		<cfreturn local.result>
	</cffunction>

	<cffunction name="decryptData">
		<cfargument name="encryptedText" type="string">
		<cfset local.decryptedText= decrypt(encryptedText,variables.key,"AES","Hex")>
		<cfreturn local.decryptedText/>
	</cffunction>
	
	<cffunction name="ArrayDiff">
		<cfargument name="pastHobbyArray" type="array">
		<cfargument name="presentHobbyArray" type="array">
		<cfset local.result = {}>
		<cfset local.result.hobbies = ArraytoList(presentHobbyArray)>
		<cfset local.insertArray=[]>
		<cfloop array="#arguments.presentHobbyArray#" index="local.i">
			<cfif NOT ArrayContains(pastHobbyArray,local.i)>
				<cfset ArrayAppend(local.insertArray,local.i)>
			</cfif>
		</cfloop>
		<cfif NOT ArrayIsEmpty(local.insertArray)>
			<cfset local.result.insertList = ArraytoList(local.insertArray)>
		</cfif>
		<cfreturn local.result>	
	</cffunction>	
	
	<cffunction name="excelGetDetails">
		<cfargument name="inputRow" type="struct">
		<cfset local.hobbies = ListToArray(inputRow.RESULT.hobbielist)>
		<cfset local.result = structNew()>
		<cfquery name="getlogId" returnType="struct">
			SELECT log_id
			FROM log_book
			WHERE
				email= <cfqueryparam value="#arguments.inputRow.email#" cfsqltype="cf_sql_varchar">
			AND
				user_id=<cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">;					
		</cfquery>
		<cfquery name="getHobby">
			SELECT 
				hobbieid 
			FROM 
				hobbiecontact
			WHERE
				log_id = <cfqueryparam value="#getlogId.RESULTSET[1].log_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfset previousHobbyArray = ValueArray(getHobby,"hobbieid")>
		<cfset presentHobbyArray = listToArray(inputRow.RESULT.hobbieList)>
		<cfset local.logId = getlogId.RESULTSET[1].log_id>
		<cfset local.result = ArrayDiff(previousHobbyArray,presentHobbyArray)>
		<cfset local.result.logId = getlogId.RESULTSET[1].log_id>
		<cfreturn local.result>
	</cffunction>	

	<cffunction name="updateContact">
		<cfargument name="title" type="numeric">
		<cfargument name="firstName" type="string">
		<cfargument name="lastName" type="string">
		<cfargument name="gender" type="numeric">
		<cfargument name="dob" type="date">
		<cfargument name="house_flat" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="state" type="string">
		<cfargument name="pincode" type="string">
		<cfargument name="email" type="string">
		<cfargument name="phone" type="string">
		<cfargument name="hobbies" type="string">
		<cfargument name="imgPath" type="string">
		<cfargument name="logId" type="string" required="false" default="0">
		<cfset local.message = {"value" : ""}>
		<cfif structKeyExists(arguments,"logId") AND val(arguments.logId)>
			<cfquery name="updateRest">
				UPDATE
					log_book
				SET
					title= <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_integer">,
					firstname= <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
					lastname= <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
					gender= <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_integer">,
					house_flat= <cfqueryparam value="#arguments.house_flat#" cfsqltype="cf_sql_varchar">,
					street= <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
					city= <cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
					state= <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
					pincode= <cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_integer">,
					email= <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
					phone= <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_decimal">,
					dob= <cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_date">
					<cfif Len(Trim(arguments.imgPath)) GT 0>
						,profile = <cfqueryparam value="#arguments.imgPath#" cfsqltype="cf_sql_varchar">
					</cfif>
				WHERE
					log_id= <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">;
			</cfquery>
		
			<cfquery name="deleteHobby">
				DELETE FROM
					hobbiecontact
				WHERE 
					log_id= <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">
				AND
					hobbieid NOT IN (<cfqueryparam value="#arguments.hobbies#" cfsqltype="cf_sql_integer" list="true">);
			</cfquery>

			<cfquery name="local.newHobby">
				SELECT 
					H.hobbieid
				FROM 
					hobbies H
				WHERE
					H.hobbieid IN (<cfqueryparam value="#arguments.hobbies#" cfsqltype="cf_sql_integer" list="true">)
					AND NOT EXISTS(SELECT 1 FROM hobbiecontact UH WHERE UH.log_Id = <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer"> 
									AND UH.hobbieid=H.hobbieid);
			</cfquery>	
			<cfif local.newHobby.RECORDCOUNT>
				<cfquery name="updateHobby">
					INSERT INTO
						hobbiecontact(
							log_id,
							hobbieid
						)
					VALUES
						<cfloop query="#local.newHobby#">
							(
								<cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#local.newHobby.hobbieid#" cfsqltype="cf_sql_integer">
							)
							<cfif local.newHobby.CURRENTROW NEQ local.newHobby.RECORDCOUNT>,</cfif>
						</cfloop>
					;
				</cfquery>
			</cfif>
			<cfset local.message.value = "Data Updated Successfully">
		<cfelse>
			<cfquery name="local.addData" result="r">
				INSERT INTO 
					log_book(user_id,
						title,
						firstname,
						lastname,
						gender,
						dob,
						profile,
						house_flat,
						street,
						city,
						state,
						pincode,
						email,
						phone) 
				VALUES (<cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#arguments.imgPath#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.house_flat#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_decimal">);
			</cfquery>
			<cfquery name="local.insertHobbies">
				INSERT INTO
					hobbiecontact(
						log_id,
						hobbieid
					)
				VALUES
					<cfloop list="#arguments.hobbies#" index="local.j" item="local.i">
						(
							<cfqueryparam value="#r.GENERATEDKEY#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#local.i#" cfsqltype="cf_sql_integer">
						)
						<cfif local.j NEQ Listlen(arguments.hobbies)>,</cfif>
					</cfloop>
				;
			</cfquery>	
			<cfset local.message.value = "Data Inserted Successfully">
		</cfif>
		<cfreturn local.message>
	</cffunction>

	<cffunction name="deleteContact" access="remote" returnFormat="JSON">
		<cfargument name="logId" type="string">
		<cfset local.logId = decryptData(arguments.logId)>
		<cfquery name="deleteHobby">
			DELETE FROM
				hobbiecontact
			WHERE 
				log_id = <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfquery name="delete" result="r">
			DELETE FROM 
				log_book	 
			WHERE (log_id = <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">);
		</cfquery>
	</cffunction>
	<cffunction name="formValidate">
		<cfargument name="data" type="struct" required="true">
		<cfset local.message = {
				"errors" = []
		}>
		<cfset local.addErrorMessage="*add operation unsuccessfull">
		<cfset local.editErrorMessage="*edit operation unsuccessfull">
		<cfset local.allowedExtensions = "jpg,jpeg,png,gif,bmp,tiff">
		<cfset local.result = dynamicForm()>

		<cfif len(trim(arguments.data.firstName)) EQ 0>
			<cfset arrayAppend(local.message.errors, "*firstname is required.")>
		</cfif>

		<cfif len(trim(arguments.data.lastName)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*lastname is required.")>
		</cfif>

		<cfif len(trim(arguments.data.email)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*email is required.")>
		<cfelseif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", arguments.data.email)>
			<cfset arrayAppend(local.message.errors, "*email input is invalid.")>
		</cfif>

		<cfif len(trim(arguments.data.houseName)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*housename is required.")>
		</cfif>

		<cfif len(trim(arguments.data.street)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*street is required.")>
		</cfif>

		<cfif len(trim(arguments.data.city)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*city is required.")>
		</cfif>

		<cfif len(trim(arguments.data.state)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*state is required.")>
		</cfif>

		<cfif NOT Len(trim(arguments.data.phone)) EQ 10 OR NOT REFind("^[0-9]{10}$", arguments.data.phone)>
    			<cfset arrayAppend(local.message.errors, "*phone no is required/not in valid format.")>
		</cfif>
		
		<cfif len(trim(arguments.data.pincode)) EQ 0>
    			<cfset arrayAppend(local.message.errors, "*pincode is required.")>
		</cfif>
		
		<cfif structKeyExists(arguments.data,'gender')>
			<cfif len(trim(arguments.data.gender)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*gender field is required.")>
			<cfelseif NOT listFind(local.result.genderList,arguments.data.gender)>
				<cfset arrayAppend(local.message.errors,"*invalid value for gender field")>
			</cfif>
		<cfelseif structKeyExists(arguments.data,'genderName')>
			<cfif len(trim(arguments.data.genderName)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*gender field is required.")>
			<cfelseif NOT listFind(local.result.genderName,arguments.data.genderName)>
				<cfset arrayAppend(local.message.errors,"*invalid value for gender field")>
			</cfif>
		<cfelse>
			<cfset arrayAppend(local.message.errors,"*gender field is missing")>
		</cfif>

		<cfif structKeyExists(arguments.data,'title')>
			<cfif len(trim(arguments.data.title)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*title field is required.")>
			<cfelseif NOT listFind(local.result.titleList,arguments.data.title)>
				<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
			</cfif>
		<cfelseif structKeyExists(arguments.data,'titleName')>
			<cfif len(trim(arguments.data.titleName)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*title field is required.")>
			<cfelseif NOT listFind(local.result.titleNameList,arguments.data.titleName)>
				<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
			</cfif>			
		<cfelse>
			<cfset arrayAppend(local.message.errors,"*title field is missing")>
		</cfif>

		<cfif structKeyExists(arguments.data,"hobbies")>
			<cfloop list="#arguments.data.hobbies#" index="local.i">
				<cfif NOT listFind(local.result.hobbieList,local.i)>
					<cfset arrayAppend(local.message.errors,"*invalid value for hobbies field")>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfelseif structKeyExists(arguments.data,"hobbieNames")>
			<cfloop list="#arguments.data.hobbieNames#" index="local.i">
				<cfif NOT listFind(local.result.hobbieNames,local.i)>
					<cfset arrayAppend(local.message.errors,"*invalid value for hobbies field")>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfelse> 
			<cfset arrayAppend(local.message.errors,"*hobbies field is required.")>
		</cfif>
		<cfif structKeyExists(arguments.data,"profile")>
			<cfif len(trim(arguments.data.profile)) EQ 0 AND NOT (structKeyExists(arguments.data, "logId") AND len(trim(arguments.data.logId)))>
					<cfset arrayAppend(local.message.errors,"*image field is required.")>
			<cfelseif len(trim(arguments.data.profile))> 
				<cfset local.uploadDir = expandPath('./temp/')>        
				<cfif not directoryExists(local.uploadDir)>
					<cfdirectory action="create" directory="#local.uploadDir#">
				</cfif>
				<cffile action="upload"
					filefield="profile"
					destination="#local.uploadDir#"
					nameConflict="makeunique">
				<cfset local.imgPath="#local.uploadDir##cffile.serverFile#">
				<cfset local.uploadedFileExt = cffile.SERVERFILEEXT>
				<cfif NOT listFindNoCase(local.allowedExtensions, local.uploadedFileExt)>
					<cfset arrayAppend(local.message.errors,"*image invalid extensions(jpg/png allowed).")>
				</cfif>
				<cffile action="delete" file="#local.imgPath#">			
			</cfif>
		</cfif>
		
		<cfif len(trim(arguments.data.dob)) EQ 0>
			<cfset arrayAppend(local.message.errors,"*date field is required.")>
		<cfelseif NOT isDate(arguments.data.dob)>
			<cfset arrayAppend(local.message.errors,"*date input is invalid.")>
		</cfif>

		<cfreturn local.message>
	</cffunction>
	<cffunction name="registerValidate">
		<cfargument name="form" type="struct">
		<cfset local.message=structNew()>
		<cfset local.message.errors = []>
		<cfset local.message.flag = 1>
		<cfif len(trim(arguments.form.name)) eq 0>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*firstname is required.")>
		</cfif>
		<cfif len(trim(arguments.form.email)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*email is required.")>
		<cfelseif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", arguments.form.email)>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*email input is invalid.")>
		</cfif>
		<cfif len(trim(arguments.form.userName)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*userName is required.")>
		<cfelseif NOT REFind("^\w{5,}$", arguments.form.userName)>
				<cfset local.message.flag = 0 >
				<cfset arrayAppend(local.message.errors, "*userName input is invalid.")>
		</cfif>
		<cfif len(trim(arguments.form.passWord)) eq 0 AND len(trim(arguments.form.confirmPassWord)) eq 0>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*passwords must not left empty.")>
		<cfelseif len(trim(arguments.form.passWord)) eq 0 AND NOT REFind("^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$", arguments.form.passWord)>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*password must not left empty/invalid input.")>
		<cfelseif len(trim(arguments.form.confirmPassWord)) eq 0 AND NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", arguments.form.confirmPassWord)>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*confirm password must not left empty/invalid input.")>
		<cfelse>
			<cfif arguments.form.passWord NEQ arguments.form.confirmPassWord>
				<cfset local.message.flag = 0 >
				<cfset arrayAppend(local.message.errors, "*passwords do not match.")>
			</cfif>
		</cfif>
		<cfreturn local.message>
	</cffunction>
	<cffunction name="selectEmail">
		<cfquery name="local.getEmail">
			SELECT
				email
			FROM
				log_book
			WHERE
				user_id=<cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn local.getEmail>
	</cffunction>
</cfcomponent>