<cfif structKeyExists(form, "submit")>
	<cfif form.captcha EQ form.pass>
		<cfoutput>
			<!---<link href="./css/styles.css" rel="stylesheet">--->
			<div class="output">
				<h3>#form.mail# is successfully subscribed to our newsletter</h3>
			</div>
		</cfoutput>
	<cfelse>
		<cfoutput><b style="color:red; ">*enter correct code<b></cfoutput>
	</cfif>
</cfif>