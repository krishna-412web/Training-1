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
				uid,name,password,salt
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
		<cfset local.message = structNew()>
		<cfinclude template="../image.cfm">
		<cfset hobbies = ListToArray(form.hobbies)>
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
				<cfqueryparam value="#form.title#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.gender#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#imgPath#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.houseName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.street#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.pincode#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.phone#" cfsqltype="cf_sql_decimal">);
		</cfquery>
		<cfquery name="local.insertHobbies">
			INSERT INTO
				hobbiecontact(
					log_id,
					hobbieid
				)
			VALUES
				<cfloop list="#form.hobbies#" index="local.i">
					(
						<cfqueryparam value="#r.GENERATEDKEY#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#local.i#" cfsqltype="cf_sql_integer">
					)
					<cfif i NEQ listLast(form.hobbies,",")>,</cfif>
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
            		title: {name: "tt", type: "numeric"},
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
		<!---<cfset arraySetMetaData(local.getContacts.RESULTSET, local.metadataStruct)>--->
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
		<cfset local.insertArray=[]>
		<cfset local.deleteArray=[]>
		<cfloop array="#arguments.presentHobbyArray#" index="local.i">
			<cfif NOT ArrayContains(pastHobbyArray,#local.i#)>
				<cfset ArrayAppend(local.insertArray,#local.i#)>
			</cfif>
		</cfloop>
		<cfloop array="#arguments.pastHobbyArray#" index="local.i">
			<cfif NOT ArrayContains(presentHobbyArray,#local.i#)>
				<cfset ArrayAppend(local.deleteArray,#local.i#)>
			</cfif>
		</cfloop>
		<cfif NOT ArrayIsEmpty(local.insertArray)>
			<cfset local.result.insertList = ArraytoList(local.insertArray)>
		</cfif>
		<cfif NOT ArrayIsEmpty(local.deleteArray)>
			<cfset local.result.deleteList = ArraytoList(local.deleteArray)>
		</cfif>
		<cfreturn local.result>
		
	</cffunction>	
		
	<cffunction name="updateContact">
		<cfset local.logId = decryptData(form.logId)>
		<cfset previousHobbyArray = listToArray(form.prevHobbieList)>
		<cfset presentHobbyArray = listToArray(form.hobbies)>
		<cfset local.result = ArrayDiff(previousHobbyArray,presentHobbyArray)>
		<cfif structKeyExists(form, "profile") AND Len(Trim(form.profile)) GT 0>
			<cfinclude template="../image.cfm">
			<cfquery name="update">
				UPDATE 
					log_book
				SET 
					profile = <cfqueryparam value="#imgPath#" cfsqltype="cf_sql_varchar">
				WHERE 
					log_id= <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">
			</cfquery>
					
		</cfif>
		<cfquery name="updateRest">
			UPDATE
				log_book
			SET
				title= <cfqueryparam value="#form.title#" cfsqltype="cf_sql_integer">,
				firstname= <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
				lastname= <cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">,
				gender= <cfqueryparam value="#form.gender#" cfsqltype="cf_sql_varchar">,
				house_flat= <cfqueryparam value="#form.houseName#" cfsqltype="cf_sql_varchar">,
				street= <cfqueryparam value="#form.street#" cfsqltype="cf_sql_varchar">,
				city= <cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
				state= <cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
				pincode= <cfqueryparam value="#form.pincode#" cfsqltype="cf_sql_integer">,
				email= <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
				phone= <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_decimal">,
				dob= <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">
			WHERE
				log_id= <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfif structKeyExists(local.result,'deleteList')>
			<cfquery name="deleteHobby">
				DELETE FROM
					hobbiecontact
				WHERE 
					log_id= <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">
				AND
					hobbieid IN 
						(<cfqueryparam value="#local.result.deleteList#" cfsqltype="cf_sql_integer" list="true">);
			</cfquery>
		</cfif>
		
		<cfif structKeyExists(local.result,'insertList')>
			<cfquery name="updateHobby">
				INSERT INTO
					hobbiecontact(
						log_id,
						hobbieid
					)
				VALUES
					<cfloop list="#local.result.insertList#" index="local.i">
						(
							<cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#local.i#" cfsqltype="cf_sql_integer">
						)
						<cfif i NEQ listLast(local.result.insertList,",")>,</cfif>
					</cfloop>
				;
			</cfquery>
		</cfif>
		<cfreturn local.result>
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
		<cfset local.message.tflag = 1>
		<cfset local.message.gflag = 1>
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
		<cfelse>
			<cfif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", form.email)>
				<cfset local.message.flag = 0 >
				<cfset arrayAppend(local.message.errors, "*email input is invalid.")>
			</cfif>
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
		<cfelse>
			<cfif NOT listFind(local.result.genderList,form.gender)>
				<cfset local.message.flag=0>
				<cfset local.message.gflag=0>
			</cfif>
			<cfif local.message.gflag EQ 0>
				<cfset arrayAppend(local.message.errors,"*invalid value for gender field")>
			</cfif>
		</cfif>

	
		<cfif len(trim(form.title)) EQ 0>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*title field is required.")>
		<cfelse>
			<cfif NOT listFind(local.result.titleList,form.title)>
				<cfset local.message.flag=0>
				<cfset local.message.tflag=0>
			</cfif>
			<cfif local.message.tflag EQ 0>
				<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
			</cfif>
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
		</cfif>
		
		<cfif len(trim(form.dob)) EQ 0>
			<cfset local.message.flag=0>
			<cfset arrayAppend(local.message.errors,"*date field is required.")>
		<cfelse>
			<cfif NOT isDate(form.dob)>
				<cfset local.message.flag=0>
				<cfset arrayAppend(local.message.errors,"*date input is invalid.")>
			</cfif>
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
		<cfelse>
			<cfif NOT REFind("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", arguments.form.email)>
				<cfset local.message.flag = 0 >
				<cfset arrayAppend(local.message.errors, "*email input is invalid.")>
			</cfif>
		</cfif>
		<cfif len(trim(arguments.form.userName)) eq 0>
			<cfset local.message.flag = 0 >
    			<cfset arrayAppend(local.message.errors, "*userName is required.")>
		<cfelse>
			<cfif NOT REFind("^\w{5,}$", arguments.form.userName)>
				<cfset local.message.flag = 0 >
				<cfset arrayAppend(local.message.errors, "*userName input is invalid.")>
			</cfif>
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

</cfcomponent>