<cfform action="" method="post">
	<label for="num">Enter Number:</label>
	<cfinput type="text" name="num" id="num" required="yes" message="Enter Number:" placeholder="1to5">
	<cfinput type="submit" name="submit" required="yes" value="Submit">
	<input type="hidden" name="sub" value="1">
</cfform>

<cfif NOT isNull(form.submit)>
	<cfif form.num EQ 5><cfoutput>very good<br></cfoutput></cfif>
	<cfif form.num EQ 4><cfoutput>good<br></cfoutput></cfif>
	<cfif form.num EQ 3><cfoutput>fair<br></cfoutput></cfif>
	<cfif form.num EQ 2><cfoutput>ok<br></cfoutput></cfif>
	<cfif form.num EQ 1 ><cfoutput>ok<br></cfoutput></cfif>
</cfif>


<cfif NOT isNull(form.submit)>
		<cfif form.num EQ 5><cfoutput>Very Good</cfoutput>
		<cfelseif form.num EQ 4><cfoutput>Good</cfoutput>
		<cfelseif form.num EQ 3><cfoutput>Fair</cfoutput>
		<cfelseif form.num EQ 2><cfoutput>OK</cfoutput>
		<cfelseif form.num EQ 1 ><cfoutput>Ok</cfoutput>
		<cfelse><cfoutput>Wrong character entered(Enter 1 to 5)</cfoutput>
	</cfif>
</cfif>
