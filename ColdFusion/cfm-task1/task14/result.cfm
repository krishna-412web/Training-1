<cfparam name="form.submit" default="">


<cfif NOT isNull(form.submit)>
	
	<style>
		#container {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
		}
		#container img {
			max-width: 75vw;
		}
		h3 {	
			margin: 1vw 2vw;
		}
	</style>
	
	<cfoutput>
		<div id="container">
			<h1>#form.imgname#</h1>
			<img src="./uploads/#form.imgpath#"/>
			<h3>#form.imgdesc#</h3>
		</div>
	</cfoutput>
</cfif>