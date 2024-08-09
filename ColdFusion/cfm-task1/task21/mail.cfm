<cfif structKeyExists(form, "submit")>
    <!--- Send an email if the "submit" key exists in the form scope --->
    <cfmail to="#form.email#" from="krenjith567@gmail.com" subject="My first mail" type="html">
        <cfoutput>
            <h1>Happy Birthday #form.name#</h1>
            <p>#form.wish#</p>
        </cfoutput>
    </cfmail>
    <!--- Display success message --->
    <cfoutput>Mail successfully sent!!!</cfoutput>
</cfif>
