<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectdata()>

<!--- Create a new spreadsheet object --->
<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>

<!--- Add headers to the spreadsheet --->
<cfset SpreadsheetAddRow(spreadsheetObj,'Name,email,phone')>

<!--- Loop through the query and add rows --->
<cfoutput query="get">
    <!--- Concatenate first and last name --->
    <cfset fullName = firstname & " " & lastname>
    
    <!--- Add the row to the spreadsheet (pass spreadsheetObj as the first argument) --->
    <cfset SpreadsheetAddRow(spreadsheetObj,'#fullName#,#email#,#phone#')>
</cfoutput>

<!--- Save the spreadsheet to a temporary file --->

<!--- <cfspreadsheet action="write" filename="AddressBook.xlsx" name="spreadsheetObj"> --->
<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<!--- Set the HTTP headers for file download --->
<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">
<!---<cfheader name="Content-Type" value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">--->

<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >