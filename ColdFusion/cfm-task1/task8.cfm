<cfset session.s1 = StructNew()>


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
	<label for="son">Enter Value:</label>
	<cfinput type="text" name="value" id="value" required="yes" message="Enter Value:" placeholder="value">
</div>
<cfinput type="submit" id="submit" name="submit" required="yes" value="Submit">
<input type="hidden" name="sub" value="1">
</cfform>

<cfif NOT isNull(form.submit)>
	
	<cfif StructKeyExists(session.s1,"#form.keys#")>
		alert("Key Already Exists!!");
	<cfelse>
		<cfset session.s1["#form.keys#"]=#form.value# >
	</cfif>

	<cfdump var="#session.s1#">
</cfif>