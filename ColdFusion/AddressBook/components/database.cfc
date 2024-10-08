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

	<cffunction name="addContact">

		<cfargument name="title" type="string">
		<cfargument name="firstName" type="string">
		<cfargument name="lastName" type="string">
		<cfargument name="gender" type="string">
		<cfargument name="dob" type="string">
		<cfargument name="house_flat" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="state" type="string">
		<cfargument name="pincode" type="string">
		<cfargument name="email" type="string">
		<cfargument name="phone" type="string">
		<cfargument name="hobbies" type="array">
		<cfargument name="imgPath" type="string">

		<!---<cfset local.mainstruct= structNew()>
		<cfif NOT structIsEmpty(arguments.form)>
			<cfset local.mainstruct=arguments.form>
			<cfset local.hobbies = ListToArray(form.hobbies)>
		<cfelseif NOT structIsEmpty(arguments.inputRow)>
			<cfset structAppend(local.mainstruct,arguments.inputRow)>
			<cfset local.hobbies = ListToArray(inputRow.RESULT.hobbielist)>
		</cfif>
		<cfdump var="#local.mainstruct#">
		<cfset local.message = structNew()>--->

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
				<cfloop array="#arguments.hobbies#" index="j" item="local.i">
					(
						<cfqueryparam value="#r.GENERATEDKEY#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#local.i#" cfsqltype="cf_sql_integer">
					)
					<cfif j NEQ Arraylen(arguments.hobbies)>,</cfif>
				</cfloop>
			;
		</cfquery>	
		<cfset local.message.value = "Data Inserted Successfully">
		<cfreturn local.message/>
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

		<cfloop array="#local.getTitle.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.titleArray,local.i.id)>
		</cfloop>
		<cfloop array="#local.getGender.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.genderArray,local.i.genderid)>
		</cfloop>
		<cfloop array="#local.getHobbies.RESULTSET#" index="local.i">
			<cfset ArrayAppend(local.hobbieArray,local.i.hobbieid)>
		</cfloop>

		<cfset local.result.title = local.getTitle.RESULTSET>
		<cfset local.result.titleList = ArrayToList(local.titleArray)>
		<cfset local.result.gender = local.getGender.RESULTSET>
		<cfset local.result.genderList = ArrayToList(local.genderArray)>
		<cfset local.result.hobbies = local.getHobbies.RESULTSET>
		<cfset local.result.hobbieList = ArrayToList(local.hobbieArray)>

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
	
	<cffunction name="excelGetHobby">
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
		<cfargument name="title" type="string">
		<cfargument name="firstName" type="string">
		<cfargument name="lastName" type="string">
		<cfargument name="gender" type="string">
		<cfargument name="dob" type="string">
		<cfargument name="house_flat" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="state" type="string">
		<cfargument name="pincode" type="string">
		<cfargument name="email" type="string">
		<cfargument name="phone" type="string">
		<cfargument name="result" type="struct">
		<cfargument name="imgPath" type="string">
		<cfargument name="logId" type="string" required="false">

		<cfset local.output= structNew()>
		<!---<cfif NOT structIsEmpty(arguments.form)>
			<cfset local.mainstruct=arguments.form>
			<cfset local.logId = decryptData(local.mainstruct.logId)>
			<cfset previousHobbyArray = listToArray(local.mainstruct.prevHobbieList)>
			<cfset presentHobbyArray = listToArray(local.mainstruct.hobbies)>
			<cfset local.result = ArrayDiff(previousHobbyArray,presentHobbyArray)>
		<cfelseif NOT structIsEmpty(arguments.inputRow)>
			<cfset structAppend(local.mainstruct,arguments.inputRow)>
			
		</cfif>--->
		<cfif NOT arguments.imgPath EQ "" AND Len(Trim(arguments.imgPath)) GT 0>
				<cfinclude template="../image.cfm">
				<cfquery name="update">
					UPDATE 
						log_book
					SET 
						profile = <cfqueryparam value="#arguments.imgPath#" cfsqltype="cf_sql_varchar">
					WHERE 
						log_id= <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">
				</cfquery>		
			</cfif>
		<cfset local.message = structNew()>
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
			WHERE
				log_id= <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfquery name="deleteHobby">
			DELETE FROM
				hobbiecontact
			WHERE 
				log_id= <cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">
			AND
				hobbieid NOT IN 
					(<cfqueryparam value="#arguments.result.hobbies#" cfsqltype="cf_sql_integer" list="true">);
		</cfquery>

		
		<cfif structKeyExists(arguments.result,'insertList')>
			<cfquery name="updateHobby">
				INSERT INTO
					hobbiecontact(
						log_id,
						hobbieid
					)
				VALUES
					<cfloop list="#arguments.result.insertList#" index="local.i">
						(
							<cfqueryparam value="#arguments.logId#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#local.i#" cfsqltype="cf_sql_integer">
						)
						<cfif i NEQ listLast(arguments.result.insertList,",")>,</cfif>
					</cfloop>
				;
			</cfquery>
		</cfif>
		<cfset local.output.value = 1>
		<cfreturn local.output>
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
		<!---<cfargument name="form" type="struct">--->
		<cfset local.message=structNew()>
		<cfset local.message.errors = []>
		<cfset local.addErrorMessage="*add operation unsuccessfull">
		<cfset local.editErrorMessage="*edit operation unsuccessfull">
		<cfset local.message.flag = 1 >
		<cfset local.message.hflag = 1>
		<cfset local.allowedExtensions = "jpg,jpeg,png,gif,bmp,tiff">
		<cfset local.result = dynamicForm()>

		<cfif len(trim(form.firstName)) eq 0>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*firstname is required.")>
		</cfif>

		<cfif len(trim(form.lastName)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*lastname is required.")>
		</cfif>

		<cfif len(trim(form.email)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*email is required.")>
		<cfelseif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", form.email)>
			<cfset local.message.flag = 0 >
			<cfset arrayAppend(local.message.errors, "*email input is invalid.")>
		</cfif>

		<cfif len(trim(form.houseName)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*housename is required.")>
		</cfif>

		<cfif len(trim(form.street)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*street is required.")>
		</cfif>

		<cfif len(trim(form.city)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*city is required.")>
		</cfif>

		<cfif len(trim(form.state)) eq 0>
			<cfset local.message.flag = false >
    			<cfset arrayAppend(local.message.errors, "*state is required.")>
		</cfif>

		<cfif NOT Len(trim(form.phone)) EQ 10 OR NOT REFind("^[0-9]{10}$", form.phone)>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*phone no is required/not in valid format.")>
		</cfif>
		
		<cfif len(trim(form.pincode)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*pincode is required.")>
		</cfif>
		
		<cfif len(trim(form.gender)) EQ 0>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*gender field is required.")>
		<cfelseif NOT listFind(local.result.genderList,form.gender)>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*invalid value for gender field")>
		</cfif>

	
		<cfif len(trim(form.title)) EQ 0>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*title field is required.")>
		<cfelseif NOT listFind(local.result.titleList,form.title)>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
		</cfif>

		<cfif structKeyExists(form,"hobbies")>
			<cfloop list="#form.hobbies#" index="local.i">
				<cfif NOT listFind(local.result.hobbieList,local.i)>
					<cfset local.message.flag=0>
					<cfset local.message.hflag=0>
				</cfif>
			</cfloop>
			<cfif local.message.hflag EQ 0>
				<cfset arrayAppend(local.message.errors,"*invalid value for hobbies field")>
			</cfif>
		<cfelse> 
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*hobbies field is required.")>
		</cfif>

		<cfif len(trim(form.profile)) EQ 0 >
			<cfif form.operation NEQ "edit">
				<cfset local.message.flag=0>
				<cfset arrayAppend(local.message.errors,"*image field is required.")>
			</cfif>
		<cfelse> 
			<cfinclude template="../temp.cfm">
			<cfif NOT listFindNoCase(local.allowedExtensions, local.uploadedFileExt)>
				<cfset local.message.flag=0>
				<cfset arrayAppend(local.message.errors,"*image invalid extensions(jpg/png allowed).")>
			</cfif>
			<cffile action="delete"
				file="#local.imgPath#">			
		</cfif>
		
		<cfif len(trim(form.dob)) EQ 0>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*date field is required.")>
		<cfelseif NOT isDate(form.dob)>
			<cfset local.message.flag=0>
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
	<cffunction name="excelValidate">
		<cfargument name="inputRow" type="struct">
		<cfset local.result=structNew()>
		<cfset local.result.remarks = []>
		<cfset local.result.flag = 1 >
		<cfset local.result.hflag = 0>
		<cfset local.result.hobbieVal = arraynew(1)>
		<cfset local.result.gflag = 0>
		<cfset local.result.genderVal = 0>
		<cfset local.result.tflag = 0>
		<cfset local.result.titleVal = 1>
		<cfset local.result.errors=0>
		<cfset local.hobbieName= listtoArray(arguments.inputRow.hobbies)>
		<cfset local.checkData = dynamicForm()>
		<!---<cfset result.temp = ValueArray(selectEmail(),"EMAIL")>--->
		

		<cfif len(trim(inputRow.firstName)) eq 0>
			<cfset local.result.flag = 0 >
			<cfset arrayAppend(local.result.remarks, "*firstname is required.")>
		</cfif>

		<cfif len(trim(inputRow.lastName)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*lastname is required.")>
		</cfif>

		<cfif len(trim(inputRow.email)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*email is required.")>
		<cfelseif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", inputRow.email)>
			<cfset local.result.flag = 0 >
			<cfset arrayAppend(local.result.remarks, "*email input is invalid.")>
		</cfif>

		<cfif len(trim(inputRow.house_flat)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*housename is required.")>
		</cfif>

		<cfif len(trim(inputRow.street)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*street is required.")>
		</cfif>

		<cfif len(trim(inputRow.city)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*city is required.")>
		</cfif>

		<cfif len(trim(inputRow.state)) eq 0>
			<cfset local.result.flag = false >
    			<cfset arrayAppend(local.result.remarks, "*state is required.")>
		</cfif>

		<cfif NOT Len(trim(inputRow.phone)) EQ 10 OR NOT REFind("^[0-9]{10}$", inputRow.phone)>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*phone no is required/not in valid format.")>
		</cfif>
		
		<cfif len(trim(inputRow.pincode)) eq 0>
			<cfset local.result.flag = 0 >
    			<cfset arrayAppend(local.result.remarks, "*pincode is required.")>
		</cfif>
		
		<cfif len(inputRow.title) GT 0>
			<cfloop array="#local.checkData.title#" index="i">
				<cfif FindNoCase(inputRow.title,i.value) NEQ 0 >
					<cfset local.result.tflag=1>
					<cfset local.result.titleVal = i.id>
				</cfif>
			</cfloop>
		</cfif>

		<cfif len(inputRow.gender) GT 0>
			<cfloop array="#local.checkData.gender#" index="i">
				<cfif CompareNoCase(inputRow.gender,i.gendername) EQ 0>
					<cfset local.result.gflag=1>
					<cfset local.result.genderVal = i.genderid>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>

		<cfif len(inputRow.hobbies) GT 0>
			<cfloop array="#local.checkData.hobbies#" index="i">
				<cfif ArrayFindNoCase(local.hobbieName,i.hobbieName) NEQ 0 >
					<cfset ArrayAppend(local.result.hobbieVal,i.hobbieid)>
				</cfif>
			</cfloop>
			<cfif NOT ArrayIsEmpty(local.result.hobbieVal)>
				<cfset local.result.hflag =  1>
				<cfset local.result.hobbieList = ArraytoList(local.result.hobbieVal)>
			</cfif>			
		</cfif>
		
		<cfif local.result.gflag EQ 0 OR local.result.genderVal EQ 0>
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*gender field is required/invalid.")>
		</cfif>

		<cfif local.result.tflag EQ 0 OR local.result.titleVal EQ 0>
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*title field is required/invalid.")>
		</cfif>

		<cfif  len(trim(inputRow.hobbies)) EQ 0 >
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*hobbie is required")>	
		<cfelseif local.result.hflag EQ 0 > 
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*hobbie invalid value")>
		<cfelseif arraylen(local.hobbieName) NEQ arraylen(local.result.hobbieVal)>
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*hobbie invalid value")>
		</cfif>
		
		<cfif len(trim(inputRow.dob)) EQ 0>
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*date field is required.")>
		<cfelseif NOT isDate(inputRow.dob)>
			<cfset local.result.flag=0>
			<cfset arrayAppend(local.result.remarks,"*date input is invalid.")>
		</cfif>

		<cfif NOT ArrayIsEmpty(local.result.remarks)>
			<cfset local.result.remarkList = ArraytoList(local.result.remarks)>
		</cfif>

		<cfreturn local.result>
		
	</cffunction>
	<cffunction name="Arraychange">
		<cfargument name="uploadResult" type="array">
		<cfset sortedArray = arrayNew(1)>
		<cfset checkedArray = arrayNew(1)>
		<cfloop array="#arguments.uploadResult#" index="i" >
			<cfif i.operation EQ "error">
				<cfset ArrayAppend(sortedArray,i)>
			<cfelse>
				<cfset ArrayAppend(checkedArray,i)>
			</cfif>
		</cfloop>
		<cfset ArrayAppend(sortedArray,checkedArray,"true")>
		<cfreturn sortedArray/>
	</cffunction>
</cfcomponent>