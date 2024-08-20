<cfif structKeyExists(session,"result") AND session.result EQ 1>
	<cfif structKeyExists(form,"submit")>
		session.result=0;
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Welcome page</title>
  </head>
  <body>
	<cfoutput>Welcome</cfoutput>
    	<form action="" method="post">
		<input type="submit" name="submit" value="Logout">
	</form>
	
  </body>
</html>