<cfform action="" method="post">
	<div>
		<label for="mother">Enter Mother's dob:</label>
		<cfinput type="date" name="mother" id="mother" required="yes" message="Enter Number:" placeholder="1to5">
	</div>
	<div>
		<label for="son">Enter Son's dob:</label>
		<cfinput type="date" name="son" id="son" required="yes" message="Enter Number:" placeholder="1to5">
	</div>
	<cfinput type="submit" name="submit" required="yes" value="Submit">
	<input type="hidden" name="sub" value="1">
</cfform>



<cfif structKeyExists(form,"submit")>
	<cfoutput>The son's age is #Datediff("yyyy",form.son,now())#<br></cfoutput>
	<cfoutput>The Mother's age when she delivered is #Datediff("yyyy",form.mother,form.son)#<br></cfoutput>
	<!---<cfset md=CreateDate(Year(now()),Month(form.mother),Day(form.mother))>--->
	<!---<cfset sd=CreateDate(Year(now()),Month(form.son),Day(form.son))>--->

	<cfif form.mother.setYear(Year(now())) GT now()>
		<cfoutput>Remaining Days  for Mother's birthday: #Datediff("d",now(),form.mother.setYear(Year(now())))#<br></cfoutput>
		<cfelse>
		<cfoutput>Remaining Days  for Mother's birthday: #Datediff("d",now(),form.mother.setYear(Year(now())+1))#<br></cfoutput>
	</cfif>

	<cfif form.son.setYear(Year(now())) GT now()>
		<cfoutput>Remaining Days  for Son's birthday: #Datediff("d",now(),form.son.setYear(Year(now())))#<br></cfoutput>
		<cfelse>
		<cfoutput>Remaining Days  for Son's birthday: #Datediff("d",now(),form.son.setYear(Year(now())+1))#<br></cfoutput>
	</cfif>

	<!---<cfoutput>Remaining Days  for Mother's birthday: #Datediff("d",now(),md)#<br></cfoutput>--->
	<!---<cfoutput>Remaining Days  for Son's birthday: #Datediff("d",now(),sd)#<br></cfoutput>--->
</cfif>

