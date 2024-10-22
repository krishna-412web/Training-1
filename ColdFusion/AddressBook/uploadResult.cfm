<!---<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectEmail()>
<cfset emailArray = ValueArray(get,"EMAIL")>--->


<cfif structKeyExists(url, "excelFileName")>
	<cfset destinationPath = ExpandPath("./temp/") & url.excelFileName>
    <cfset fileName = url.excelFileName>
	<cfif fileExists(destinationPath)>
    	<cfheader name="Content-Disposition" value="attachment; filename=#fileName#">
    	<cfheader name="Content-Type" value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
    	<cfcontent file="#destinationPath#" deleteFile="true">
	<cfelse>
		<cflocation url="welcome.cfm" addToken="no">
	</cfif>
<cfelse>
    <cflocation url="welcome.cfm" addToken="no">
</cfif>