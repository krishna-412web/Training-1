<cfcomponent>
	<cfproperty name="userName" type="string">
	<cfproperty name="hashedPassword" type="string">
	<cfproperty name="salt" type="string">
	<cfproperty name="flag" type="number">

	<cffunction name="getInfo" access="public" returnType="string">
		<cfargument name="userName" type="string">
		<cfargument name="passWord" type="string">
		<cfquery datasource="test1" name="get" result="r">
			SELECT 
				pwd,salt 
			FROM 
				user 
			WHERE 
				username="#arguments.userName#";
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfoutput query="get">
				<cfset local.hashedPassword="#pwd#">
				<cfset local.salt="#salt#">
			</cfoutput>
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
		<cfargument name="userName" type="string">
		<cfargument name="role" type="string">
		<cfargument name="passWord" type="string">
		<cfset local.salt=generateSecretKey("AES")>
		<cfset local.hashedPassword = HashPassword(arguments.passWord,local.salt)>
		<cfquery datasource="test1" name="createUser" result="r">
			INSERT INTO 
				USER(username,role,pwd,salt) 
			VALUES (<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.role#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.hashedPassWord#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">);
		</cfquery>
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
		<cfargument name="pageId" type="number">
		<cfargument name="pageName" type="string">
		<cfargument name="pageDesc" type="string">
		<cfquery name="update" datasource="test1">
			UPDATE  SET `pagename` = 'MyName' WHERE (`pagename` = 'Krishna');
		</cfquery>
	</cffunction>

</cfcomponent>