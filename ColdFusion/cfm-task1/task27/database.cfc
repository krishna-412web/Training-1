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
				hashedPassword,salt 
			FROM 
				users 
			WHERE 
				username="#arguments.userName#";
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfoutput query="get">
				<cfset local.checkPassword=HashPassword(arguments.passWord,#salt#)>
				<cfif local.checkPassword EQ local.hashedPassword>
					<cfreturn 1 >
				<cfelse>
					<cfreturn 0 >
				</cfif>	
			</cfoutput>
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
		<cfargument name="passWord" type="string">
		<cfset local.salt=generateSecretKey("AES")>
		<cfset hashedPassword = HashPassword(arguments.passWord,local.salt)>
		<cfquery datasource="test1" name="createUser" result="r">
			INSERT INTO 
				USERS(
					username,
					hashedPassword,
					salt
				) 
			VALUES (<cfqueryparam value="#userName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#hashedPassWord#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#salt#" cfsqltype="cf_sql_varchar">);
		</cfquery>
	</cffunction>

</cfcomponent>