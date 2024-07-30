<cfparam name="form.submitted" default="0">
<cfif form.submitted>
	<cfoutput>Your Form is submitted <br><br> Review your details <br><br> </cfoutput>
	<cfoutput>Name: #form.firstName#   #form.lastName#<br></cfoutput>
	<cfoutput>Email: #form.email#<br></cfoutput>
	<cfoutput>Phone: #form.phoneNumber#<br></cfoutput>
</cfif>


