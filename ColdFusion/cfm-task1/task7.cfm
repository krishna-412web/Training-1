<cfset session.s = StructNew()>



<cfapplication
	name="CFCTASK7"
	sessionManagement="yes"
	sessionTimeOut=#CreateTimeSpan(0,0,2,0)# >

<cfform action="" method="post" id="myForm">
<div>
	<label for="key">Enter Key:</label>
	<cfinput type="text" name="keys" id="key" required="yes" message="Enter key" placeholder="key">
</div>
<div>
	<label for="value">Enter Value:</label>
	<cfinput type="text" name="value" id="value" required="yes" message="Enter Value:" placeholder="value">
</div>
<cfinput type="submit" id="submit" name="submit" required="yes" value="Submit">
<input type="hidden" name="sub" value="1">
</cfform>


<cfif NOT isNull(form.submit)>
	<cfset session.s["#form.keys#"]=#form.value#>
	<cfdump var="#session.s#">
</cfif>
