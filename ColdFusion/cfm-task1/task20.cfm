<CFOUTPUT>
<form action="" method="post">
	<div>
		<label for="mail">Enter email:</label>
		<input  type="email" name="mail" id="mail" required>
	</div>

	<div>
		<label for="email">Enter Captcha:</label>
		<input  type="text" name="captcha" id="captcha">
		<cfset key=mid(generateSecretKey("DES",56),1,5)>
		<cfimage action="captcha" height="35" width="180" difficulty="low" text="#key#">
		<input type="hidden" name="pass" value="#key#">
	</div>

	<input type="submit" name="submit">
</form>
</CFOUTPUT>
<!---<cfif NOT isNull(form.submit)>--->
<cfif structKeyExists(form, 'submit')>
	<cfif form.captcha EQ form.pass>
		<cfoutput>
			<style>
				.output{
					width: 70%;
					margin: 2vh auto;
					background-color: green;
					color : white;
					border: 1px double black;
				}
				
				.output h3{
					text-align: center;
				}
			</style>
			<div class="output">
				<h3>#form.mail# is successfully subscribed our newsletter</h3>
			</div>
		</cfoutput>
	<cfelse>
		<cfoutput><b style="color:red; ">*enter correct code<b></cfoutput>
	</cfif>
</cfif>
