

<cfobject component="result" name="mycomp">

<cfset obj1=CreateObject("component","result")>

<cfinvoke component="result" method="multiply" returnvariable="var">
	<cfinvokeargument name="n1" value="1">
	<cfinvokeargument name="n2" value="2">
</cfinvoke>

<cfoutput><b>cfinvoke</b> function used to call <b>multiply(1,2)</b> to get result <b>#var#</b><br></cfoutput>

<cfset var1=mycomp.multiply(1,2,3)>
<cfoutput><b>cfobject</b> function used to call <b>multiply(1,2,3)</b> to get result <b>#var1#</b><br></cfoutput>

<cfset var2=obj1.multiply(1,2,3,4)>
<cfoutput><b>createObject()</b> function used to call <b>multiply(1,2,3,4)</b> to get result <b>#var2#</b><br></cfoutput>

