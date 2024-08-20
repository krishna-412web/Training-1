<!DOCTYPE html>
<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task25</title>
	</head>
	<body>
		<link rel="stylesheet" href="./css/styles.css">
    		<form action="" method="post">
			<div>
				<label for="text">Enter the text:</label>
				<textarea id="text" name="text"></textarea>
			</div>
			<input type="submit" name="submit"/>
		</form>
	</body>
</html>

<cfif structKeyExists(form,"submit")>	
	<cfset obj=createObject("component","tagCloud")>
	<cfset obj.init(form.text)>
	<cfset obj.insert()>
	<cfset s=obj.get()>
	<cfset d=obj.process(s)>
	<cfset obj.output(d)>
</cfif>
