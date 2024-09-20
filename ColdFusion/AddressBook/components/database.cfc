 <cfcomponent>
	<cfproperty name="userName" type="string">
	<cfproperty name="hashedPassword" type="string">
	<cfproperty name="salt" type="string">
	<cfset variables.key="baiYIM2yvVW258BNOmovjQ==">

	<cffunction name="getInfo" access="public" returnType="struct">
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
		<cfargument name="profile" type="string">
		<cfset local.message = structNew()>

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
				<cfqueryparam value="#form.profile#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.houseName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.street#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.pincode#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.phone#" cfsqltype="cf_sql_decimal">);
		</cfquery>
		<cfquery name="local.getContactId" returnType="struct">
    			SELECT LAST_INSERT_ID() AS contactid;
		</cfquery>
		<cfquery name="local.insertHobbies">
			INSERT INTO
				contacthobbies(
					log_id,
					hobbieid
				)
			VALUES
				<cfloop list="#form.hobbies#" index="i">
					(
						<cfqueryparam value="#local.getContactId.RESULTSET[1].contactid#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
					)
					<cfif i NEQ listLast(form.hobbies,",")>,</cfif>
				</cfloop>
			;
		</cfquery>	
		<cfset local.message.value = "Data Inserted Successfully">
		<cfreturn message/>
	</cffunction>

	<cffunction name="selectdata" access="remote" returnFormat="JSON">
		<cfquery name="local.getData" returnType="struct">
			SELECT 
				log_id,
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
				phone
			FROM
				log_book
			WHERE 	
				user_id= <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfloop array="#local.getData.RESULTSET#" index="i">
			<cfset local.encryptedText= encrypt(toString(i.log_id),variables.key,"AES","Hex")>
			<cfset i.log_id= local.encryptedText >
		</cfloop>
		<cfreturn local.getData.RESULTSET/>
	</cffunction>

	<cffunction name="decryptData">
		<cfargument name="encryptedText" type="string">
		<cfset local.decryptedText= decrypt(encryptedText,variables.key,"AES","Hex")>
		<cfreturn local.decryptedText/>
	</cffunction>
	

	<cffunction name="setid" access="remote" returnFormat="JSON">
		<cfargument name="logId" type="string">
		<cfset session.logId = arguments.logId>
		<cfreturn 1/>
	</cffunction>	
		
	<cffunction name="updateContact">
		<cfargument name="form" type="struct">
		<cfset local.logId = decryptData(form.logId)>
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
		<cfif structKeyExists(form, "dob") AND Len(Trim(form.dob)) GT 0>
			<cfquery name="update">
				UPDATE 
					log_book
				SET 
					dob = <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">
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
			WHERE
				log_id= <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">;
		</cfquery>
	</cffunction>

	<cffunction name="deleteContact" access="remote" returnFormat="JSON">
		<cfargument name="logId" type="string">
		<cfset local.logId = decryptData(arguments.logId)>
		<cfquery name="delete" result="r">
			DELETE FROM 
				log_book	 
			WHERE (log_id = <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">);
		</cfquery>
	</cffunction>

	<cffunction name="selectContact" access="remote" returnFormat="JSON">
		<cfargument name="logId" type="string">
		<cfset local.logId = decryptData(arguments.logId)>
		<cfquery name="local.getContact" returnType="struct">
			SELECT
				log_id,
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
				phone
			FROM 
				log_book	 
			WHERE (log_id = <cfqueryparam value="#local.logId#" cfsqltype="cf_sql_integer">);
			
		</cfquery>
		<cfreturn local.getContact.RESULTSET />
	</cffunction>

	<cffunction name="viewHobbies" access="remote" returnFormat="JSON">
		<cfargument name="hobbieId" type="string">
		<cfset local.result = arrayNew(1)>
		<cfset local.hobbie = listToArray(arguments.hobbieId)>
		<cfloop array="#local.hobbie#" index="i">
			<cfquery name="local.getHobby" returnType="struct">
				SELECT 
					hobbieName
				FROM
					hobbies
				WHERE 
					hobbieId = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">;
			</cfquery>
			<cfset arrayappend(local.result,local.getHobby.RESULTSET[1].hobbieName)>
		</cfloop>
		<cfreturn local.result />
	</cffunction>

</cfcomponent>