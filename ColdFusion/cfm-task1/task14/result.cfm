<cfparam name="form.submit" default="">


<cfif structKeyExists(form,"submit")>
	<cfoutput>
		<link href="./css/styles.css">
		<div id="container">
			<h1>#form.imgname#</h1>
			<img src="./uploads/#form.imgpath#"/>
			<h3>#form.imgdesc#</h3>
		</div>
	</cfoutput>
</cfif>