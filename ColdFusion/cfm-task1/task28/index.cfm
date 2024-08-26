<cfset session.result =0>

<cfif structKeyExists(form,"submit")>
	<cfset obj = createObject('component','database')>
	<cfset session.result = obj.getInfo(form.userName,form.passWord)>
	<cfoutput>
		<cfif session.result EQ 1>
			<cfif session.role EQ "admin" OR session.role EQ "editor" >
				<cflocation url="welcome.cfm" addToken="no" statusCode="302">
			<cfelse>
				<cflocation url="welcomeUser.cfm" addToken="no" statusCode="302">
			</cfif>
		<cfelse>
			Unauthorized!!
		</cfif>
	</cfoutput>
</cfif>

<!DOCTYPE html>
<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task28</title>
	</head>
	<body>
    		<form action="" method="post" enctype="multipart/form-data">
			<div>
				<label for="login">Username:</label>
				<input type="text" name="userName" id="userName" placeholder="Username">
			</div>
			<div>
				<label for="passWord">Password:</label>
				<input name="passWord" id="passWord" type="password" placeholder="Atleast 8 characters" pattern="^.{8,}$" required>
			</div>
			<input type="submit" name="submit" value="Login"/>
		</form>
	</body>
</html>