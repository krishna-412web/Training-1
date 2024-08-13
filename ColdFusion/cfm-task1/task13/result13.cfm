<cfset s="the quick brown fox jumps over the lazy dog">

<cfif structKeyExists(form,"submit")>	
	<cfset n=ListValueCountNoCase(s,form.str," ")>
	<cfoutput>Found the key word <b>"#form.str#"</b> entered in #n# times-#s#</cfoutput>
</cfif>