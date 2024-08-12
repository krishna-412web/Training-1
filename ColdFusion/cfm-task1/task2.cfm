<cfform action="">
	<label for="num">Enter Number:</label>
	<cfinput type="text" name="num" id="num" required="yes" message="Enter Number:" placeholder="1to5">
	<cfinput type="submit" name="submit" required="yes" value="Submit">
	<input type="hidden" name="sub" value="1">
</cfform>

<cfif NOT isNull(form.submit)>
	<cfswitch expression="#form.num#">
		<cfcase value="5"><cfoutput>Very good<br></cfoutput></cfcase>
		<cfcase value="4"><cfoutput>good<br></cfoutput></cfcase>
		<cfcase value="3"><cfoutput>fair<br></cfoutput></cfcase>
		<cfcase value="2"><cfoutput>ok<br></cfoutput></cfcase>
		<cfcase value="1"><cfoutput>ok<br></cfoutput></cfcase>
		<cfdefaultcase>You entered wrong character(1to5)</cfdefaultcase>
	</cfswitch>
	
</cfif>



