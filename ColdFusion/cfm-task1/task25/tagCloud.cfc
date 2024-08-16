<cfcomponent>
	<cfproperty name="c1" type="number">
	<cfproperty name="s" type="string">
	
	<cfset c1=0>
	<cfinclude template="Index2.cfm">

	<cffunction name="init" access="public">
		<cfset s= SerializeJSON(select1,"struct")>
	</cffunction>

	
	<cffunction name="get" returnType="string">
		<cfreturn s>
	</cffunction>

	<cffunction name="process" returnType="array">
		<cfargument name="text" type="string">
		<cfset d= deSerializeJSON(text)>
		<cfreturn d>
	</cffunction>	

	<cffunction name="output">	
		<cfargument name="d" type="array">
		<cfoutput>	
			<cfloop array="#d#" index="i">
				<cfset c1=c1+1>
				-<span class="output" id="n#c1#" style="font-size:#i.count#em">#i.word# (#i.count#)</span><br>
			</cfloop>
			<script src="./js/script.js"></script>	
		</cfoutput>
	</cffunction>
	

	
</cfcomponent>