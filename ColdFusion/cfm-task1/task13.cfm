<cfform action="" method="post">
	<label for="str">Enter String:</label>
	<input type="text" id="str" name="str" placeholder="A dog.">
	<input type="submit" name="submit" value="submit"/>
</cfform>

<cfset s="the quick brown fox jumps over the lazy dog">

<cfif structKeyExists(form,"submit")>
	
	<cfset n=ListValueCountNoCase(s,form.str," ")>
	<cfoutput>Found the key word entered in #n# times-#s#</cfoutput>
</cfif>

