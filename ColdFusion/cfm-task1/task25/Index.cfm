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
	<cfset obj=createObject("component","database")>
	<cfset obj.init(form.text)>
	<cfset obj.truncate()>
	<cfset obj.insert()>
	
	<cfset obj1=createObject("component","tagCloud")>
	<cfset obj1.init()>
	<cfset s=obj1.get()>
	<cfset d=obj1.process(s)>
	<cfset obj1.output(d)>
	<script src="./js/script.js"></script>
</cfif>
