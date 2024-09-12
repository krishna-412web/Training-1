<cfset obj = CreateObject("component", "components.database")>
<cfset get = obj.selectdata()>


<cfset spreadsheetObj = SpreadsheetNew("AddressBook",false)>


 <cfset myFormat=StructNew()>
 <cfset myFormat.bold="true">


<cfset data={color="white",fgcolor="grey_50_percent"}>
<cfset dataHead={color="white",fgcolor="grey_50_percent",bold="true"}>

<cfset SpreadsheetAddRow(spreadsheetObj,'#session.user#,,#dateFormat(now(), "dd/mm/yyyy HH:mm:ss me")#')>
<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,2)>


<cfset SpreadsheetAddRow(spreadsheetObj,'NAME,EMAIL,PHONE')>

<cfset SpreadsheetFormatRow (spreadsheetObj, myFormat, 1)>
<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 2)>

<cfloop array="#get#" index="item">

    <cfset fullName = item.firstname & " " & item.lastname>
    <cfset SpreadsheetAddRow(spreadsheetObj,'#fullName#,#item.email#,#item.phone#')>
</cfloop>

<cfloop from="3" to="#3+ArrayLen(get)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,data,i)>
	</cfif>
</cfloop>

<cfloop from="1" to="#SpreadsheetGetColumnCount(spreadsheetObj,'AddressBook')#" index="i">
	<cfset SpreadSheetSetColumnWidth (spreadsheetobj,i,30)>
</cfloop>




<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>


<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">


<!--- Serve the file and delete it after download --->
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >