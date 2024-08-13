<cfcomponent>
	<cfif structKeyExists(form,"submit")>
		<cfset date=DateFormat(#form.doj#,"yyyy-mm-dd")>
		<cfquery name="InsertData" datasource="test1" result="res">
			INSERT INTO form_table(position,relocateChoice,doj,webSite,resume,salary,name,email,phoneNumber)
			VALUES
			("#form.position#","#form.choice#","#date#","#form.website#","#form.resume#",#form.salary#,"#form.name#","#form.email#",#form.phoneNumber#);
		</cfquery>
		Query Exexuted Successfully!!!
		<br>
		<cfdump var="#res#">
		
	</cfif>
</cfcomponent>