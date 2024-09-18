<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0,0,8,0)>
    <cfset this.datasource = "AddressBook">

    <cffunction name="onSessionEnd" returntype="void">
        <cfargument name="session" type="struct" required="true">
        <cflocation url="index.cfm" addtoken="false">
    </cffunction>
</cfcomponent>

