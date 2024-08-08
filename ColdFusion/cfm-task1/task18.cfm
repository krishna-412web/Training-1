<cfset a = ["1abge","2cdfr","1@fgh","cdbge","bas2@"]>
<cfform action="" method="post">
	<cfset i = randRange(1,5)>
	<div>
		<label for="mail">Enter email:</label>
		<cfinput  type="email" name="mail" id="mail" required>
	</div>

	<div>
		<label for="email">Enter Captcha:</label>
		<cfinput  type="text" name="captcha" id="captcha">
		<cfimage action="captcha" height="35" width="170" difficulty="low" text="#a[i]#">
		<cfinput type="hidden" name="pass" value="#a[i]#">
	</div>

	<cfinput type="submit" name="submit">
</cfform>


<cfparam name="form.submit" default="">
<cfparam name="form.pass" default="!!!!!">

<cfif NOT isNull(form.submit)>
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