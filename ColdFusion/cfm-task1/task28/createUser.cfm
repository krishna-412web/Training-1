<!DOCTYPE html>
<html>
<head><title>CreateUser</title></head>
<body>
	<form action="" method="post">
		<div>
			Enter username:
			<input type="text" name="userName">
		</div>
		<div>
			Enter role:
			<input type="text" name="role">
		</div>

		<div>
			Enter Password:
			<input type="text" name="newPassword">
		</div>
		<input type="submit" name="submit"/>
	</form>
</body>
</html>

<cfif structKeyExists(form,"submit")>
	<cfset obj= createObject('component','database')>
	<cfset obj.createUser(form.userName,form.role,form.newPassWord)>
	<cfoutput>User Created Successfully</cfoutput>
</cfif>