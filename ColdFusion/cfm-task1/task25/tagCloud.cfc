<cfcomponent>
	<cfproperty name="c1" type="number">
	<cfset c1=0>
	<cfinclude template="Index2.cfm">
	<link href="./css/styles.css" rel="stylesheet">
	<cfoutput query="select1">
		<cfset c1=c1+1>
		-<span class="output" id="n#c1#" style="font-size:#count#em">#word# (#count#)</span><br>
	</cfoutput>
	<!---<script src="./js/script.js"></script>--->
	<script>
		let colours=["black","gold","blue","green","yellow","orange","red","forestgreen","lightgreen","cyan","magenta"];
		let i=n=0;
		let o=document.getElementsByClassName("output");
		for(i=0;i<o.length;i++)
		{	
			if(n >colours.length)
				n=0;
			o[i].style.color=colours[n];
			n+=1;	
		}
	</script>
	
</cfcomponent>