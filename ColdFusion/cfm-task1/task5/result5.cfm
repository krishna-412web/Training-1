<cfoutput>
	<cfif structKeyExists(form,"submit")>
		The son's age is #Datediff("yyyy",form.son,now())#<br>
		The Mother's age when she delivered is #Datediff("yyyy",form.mother,form.son)#<br>
		<!---<cfset md=CreateDate(Year(now()),Month(form.mother),Day(form.mother))>--->

		<cfif form.mother.setYear(Year(now())) GT now()>
			Remaining Days  for Mother's birthday: #Datediff("d",now(),form.mother.setYear(Year(now())))#<br>
			<cfelse>
			Remaining Days  for Mother's birthday: #Datediff("d",now(),form.mother.setYear(Year(now())+1))#<br>
		</cfif>

		<cfif form.son.setYear(Year(now())) GT now()>
			Remaining Days  for Son's birthday: #Datediff("d",now(),form.son.setYear(Year(now())))#<br>
		<cfelse>
			Remaining Days  for Son's birthday: #Datediff("d",now(),form.son.setYear(Year(now())+1))#<br>
		</cfif>

	</cfif>
</cfoutput>
