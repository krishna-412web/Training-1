<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0,0,15,0)>
    <cfset this.datasource = "AddressBook">

    <cffunction name="onApplicationStart" returnType="void">
        <cfset application.obj = CreateObject("component", "components.database")>
    </cffunction>
    <cffunction name="onRequestStart" returnType="void">
        <cfargument name="requestname" required="true">
        <cfif structKeyExists(url,"reload") AND url.reload EQ 1>
            <cfset onApplicationStart()>
        </cfif>
        <cfset local.publicPages = ["index.cfm","register.cfm"]>
        <cfif NOT(structKeyExists(session,"result") 
                    AND session.result.value EQ 1)
                    AND NOT arrayFindNoCase(local.publicPages, ListLast(CGI.SCRIPT_NAME,'/'))>
		    <cflocation url="index.cfm" addToken="no">
	    </cfif>
    </cffunction>

    <cffunction name="onSessionEnd" returntype="void">
        <cfargument name="session" type="struct" required="true">
    </cffunction>
</cfcomponent>

