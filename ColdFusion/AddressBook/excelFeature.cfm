<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectdata()>


<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>


<cfset SpreadsheetAddRow(spreadsheetObj,'Name,email,phone')>


<cfoutput query="get">

    <cfset fullName = firstname & " " & lastname>
    

    <cfset SpreadsheetAddRow(spreadsheetObj,'#fullName#,#email#,#phone#')>
</cfoutput>




<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>


<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >