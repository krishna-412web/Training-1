<!DOCTYPE html>
<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task25</title>
	</head>
	<body>
    		<form action="" method="post">
			<div>
				Enter the text:
				<textarea id="text" name="text"></textarea>
				<input type="submit" name="submit"/>
			</div>
		</form>
	</body>
</html>

<cfif structKeyExists(form,"submit")>	
	<cfset obj=createObject("component","database")>
	<cfset obj.init(form.text)>
	<cfset obj.truncate()>
	<cfset obj.insert()>
	<!---<cfinclude template="index2.cfm">--->
	<!---<cfoutput query="select1">-#word# (#count#)<br></cfoutput>--->
	<cfset obj1=createObject("component","tagCloud")>
</cfif>
