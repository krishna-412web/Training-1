 <cfcomponent>
	<cfproperty name="userName" type="string">
	<cfproperty name="hashedPassword" type="string">
	<cfproperty name="salt" type="string">

	<cffunction name="getInfo" access="public" returnType="string">
		<cfargument name="userName" type="string">
		<cfargument name="passWord" type="string">
		<cfquery datasource="AddressBook" name="local.get" result="r">
			SELECT 
				password,salt
			FROM 
				user 
			WHERE 
				username= <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfdump var="#get.password#">
		<cfif r.RECORDCOUNT GT 0>
			<cfset local.hashedPassword=local.get.password>
			<cfset local.salt=local.get.salt>
			<cfset local.checkPassword=HashPassword(arguments.passWord,local.salt)>
			<cfif local.checkPassword EQ local.hashedPassword>
				<cfreturn 1 >
			<cfelse>
				<cfreturn 0 >
			</cfif>	
		<cfelse> 
			<cfreturn 0 >
		</cfif>
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
		<cfset local.returnVar= 0>

		<cfquery datasource="AddressBook" name="local.checkUsername" result="r1">
			SELECT uid FROM user WHERE username = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar"> 
		</cfquery>

		<cfquery datasource="AddressBook" name="local.checkemail" result="r2">
			SELECT uid FROM user WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
		
		<cfif r1.RECORDCOUNT EQ 0 AND r2.RECORDCOUNT EQ 0>
			<!---<cfquery datasource="AddressBook" name="createUser" result="r">
				INSERT INTO 
					USER(name,email,username,password,salt) 
				VALUES (<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,       
					<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#local.hashedPassWord#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">)
			</cfquery>--->
			<cfset local.returnVar = 1 />
		<cfelseif local.checkUsername.uid EQ local.checkemail.uid>
			<cfset session.errorMessage="*account already exists">
		<cfelseif r1.RECORDCOUNT NEQ 0 AND r2.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*username and email already used">
		<cfelseif r1.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*username already used">
		<cfelseif r2.RECORDCOUNT NEQ 0>
			<cfset session.errorMessage = "*email already used">
		</cfif>
		<cfreturn local.returnVar />
	</cffunction>

	<cffunction name="addPage" returnType="string">
		<cfargument name="pageName" type="string">
		<cfargument name="pageDesc" type="string">
		<cfquery name="local.addData" datasource="test1" result="r">
			INSERT INTO 
				PAGE(pagename,pagedescs) 
			VALUES (<cfqueryparam value="#arguments.pagename#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.pageDesc#" cfsqltype="cf_sql_longvarchar">);
		</cfquery>
		<cfreturn "Data Inserted Successfully"/>
	</cffunction>

	<cffunction name="selectdata" access="remote" returnFormat="JSON">
		<cfquery name="local.getData" datasource="test1" result="r">
			SELECT 
				pageid,pagename,pagedescs
			FROM
				page;
		</cfquery>
		<cfset local.data1 = serializeJSON(local.getData)>
		<cfset session.tmpData = deserializeJSON(local.data1)>
		<cfreturn local.getData/>
	</cffunction>

	<cffunction name="viewdata" access="remote" returnFormat="JSON">
		<cfargument name="id" type="string">
		<cfset local.index = Val(id)>
		<cfset path = expandPath("./output.cfm")>
		<cffile action="write" file="#path#" output=""/>
		<cffile action="write" file="#path#" output="
			<cfoutput>
				#session.tmpData.DATA[local.index][2]#<br>
				#session.tmpData.DATA[local.index][3]#
			</cfoutput>"/>
		<cfreturn 1/>	
	</cffunction>

	<cffunction name="getid" access="remote" returnFormat="JSON">
		<cfargument name="id" type="string">
		<cfset session.id = arguments.id>
		<cfreturn 1/>
	</cffunction>	
		
	<cffunction name="updateData">
		<cfargument name="pageId" type="string">
		<cfargument name="pageName" type="string">
		<cfargument name="pageDesc" type="string">
		<cfquery name="update" datasource="test1">
			UPDATE 
				page
			SET 
				pagename = <cfqueryparam value="#arguments.pageName#" cfsqltype="cf_sql_varchar">,
				pagedescs= <cfqueryparam value="#arguments.pageDesc#" cfsqltype="cf_sql_longvarchar">
			WHERE 
				pageid = <cfqueryparam value="#arguments.pageId#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cflocation url="welcome.cfm" addToken="no" statusCode="302">
	</cffunction>

	<cffunction name="deletePage" access="remote" returnFormat="JSON">
		<cfquery name="delete" datasource="test1" result="r">
			DELETE FROM 
				page	 
			WHERE (pageid = <cfqueryparam value="#session.tmpData.DATA[session.id][1]#" cfsqltype="cf_sql_integer">);
		</cfquery>
		<cfreturn 1/>
	</cffunction>

</cfcomponent>