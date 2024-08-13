<cfoutput>
	<cfif structKeyExists(form, "submit")>
    		<cfmail to="#form.email#" from="krenjith567@gmail.com" subject="Happy Birthday #form.name#" type="html">
            		<h1>Happy Birthday #form.name#</h1>
            		<p>#form.wish#</p>
    		</cfmail>
    		Mail successfully sent!!!
	</cfif>
</cfoutput>
