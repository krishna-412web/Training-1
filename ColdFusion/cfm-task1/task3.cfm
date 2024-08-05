<cfform action="">
<label for="num">Enter Number:</label>
<cfinput type="text" name="num" id="num" required="yes" message="Enter Number:" placeholder="1,3,5,6,7">
<cfinput type="submit" name="submit" required="yes" value="Submit">
<input type="hidden" name="sub" value="1">
</cfform>


<cfif NOT isNull(form.submit)>
		
		<cfset s= arrayNew(1)>
		<cfset arr=ListtoArray("#form.num#")>
		<cfloop array="#arr#" item="n">
			<cfif n % 3 NEQ 0>
				<cfcontinue>
			</cfif>	
			<cfset ArrayAppend(s,#n#)>	
		</cfloop>
		<cfset r= ArrayToList(s)>
		<cfoutput>#r#</cfoutput>

</cfif>
