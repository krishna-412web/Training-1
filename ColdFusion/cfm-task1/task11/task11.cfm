<cfoutput>
	<cfset obj=createObject("component","process")>
	<cfset res=obj.multiply(1,2)>
	<cfdump var="#res#">
	<br>

	<cfset res=obj.multiply(1,2,3)>
	<cfdump var="#res#">
	<br>

	<cfset res=obj.multiply(1,2,3,4)>
	<cfdump var="#res#">
	<br>
</cfoutput>
