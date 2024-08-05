<cfset s = StructNew()>


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


<cfparam name="form.submit" default="">
<cfparam name="form.keys" default="">
<cfparam name="form.value" default="">

<cfif NOT isNull(form.submit)>
	
	<cfif StructIsEmpty(s)>
		<cfset StructInsert(s,"#form.keys#","#form.value#")>
	<cfelse>
		<cfset s["#form.keys#"]=#form.value# >
	</cfif>
	<cfdump var="#s#">
</cfif>






