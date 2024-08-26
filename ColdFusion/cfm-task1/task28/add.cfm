<cfoutput>
	<!DOCTYPE html>
	<html lang="en">
 		 <head>
  			<meta charset="UTF-8">
    			<meta name="viewport" content="width=device-width, initial-scale=1.0">
    			<meta http-equiv="X-UA-Compatible" content="ie=edge">
    			<title>Add Page</title>
    			<link rel="stylesheet" href="style.css">
  		</head>
 		<body>
			<form action="" method="POST">
				<div>
					<label for="pagename">Enter pagename:</label>
					<input type="text" name="pagename" id="pagename" placeholder="myPage" required>
				</div>
				<div>
					<label for="pagedesc">Enter page description:</label>
					<textarea name="pagedesc" id="pagedesc" placeholder="One in a million" required></textarea>
				</div>
				<input type="submit" name="submit"/>
			</form>
    			<script src="index.js"></script>
  		</body>
		</html>
</cfoutput>

<cfif structKeyExists(form,"submit")>
	<cfset obj= createObject('component','database')>
	<cfset local.out = obj.addPage(form.pagename,form.pagedesc)>
	<cfset session.result = 1>
	<cflocation url="welcome.cfm" addToken="no" statusCode="302">
</cfif>