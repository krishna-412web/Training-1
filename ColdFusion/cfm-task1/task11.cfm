<cffunction name="multiply" returnType="numeric">
	<cfargument name="n1" type="numeric" default="1">
	<cfargument name="n2" type="numeric" default="1">
	<cfargument name="n3" type="numeric" default="1">
	<cfargument name="n4" type="numeric" default="1">
	<cfset var r= n1*n2*n3*n4>
	<cfreturn r/>
</cffunction>

<cfset res=multiply(1,2)>
<cfdump var="#res#">
<cfoutput><br></cfoutput>

<cfset res=multiply(1,2,3)>
<cfdump var="#res#">
<cfoutput><br></cfoutput>

<cfset res=multiply(1,2,3,4)>
<cfdump var="#res#">
<cfoutput><br></cfoutput>