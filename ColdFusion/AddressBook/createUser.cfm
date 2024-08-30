<!DOCTYPE html>
<html>
<head><title>CreateUser</title></head>
<body>
	<form action="" method="post">
		<div>
			Enter name:
			<input type="text" name="name">
		</div>

		<div>
			Enter email:
			<input type="email" name="email">
		</div>

		<div>
			Enter username:
			<input type="text" name="userName">
		</div>
		
		<div>
			Enter Password:
			<input type="password" name="newPassword">
		</div>
		<input type="submit" name="submit"/>
	</form>
</body>
</html>

<cfif structKeyExists(form,"submit")>
	<cfset obj= createObject('component','components.database')>
	<cfset obj.createUser(form.name,form.email,form.userName,form.newPassWord)>
	<cfoutput>User Created Successfully</cfoutput>
</cfif>