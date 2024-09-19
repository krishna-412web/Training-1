<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0,0,15,0)>
    <cfset this.datasource = "AddressBook">

    <cffunction name="onSessionEnd" returntype="void">
        <cfargument name="session" type="struct" required="true">
        <cflocation url="welcome.cfm" addToken="no" statusCode="302">
    </cffunction>
</cfcomponent>

