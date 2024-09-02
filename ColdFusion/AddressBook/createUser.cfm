<cfset session.errorMessage="">
<cfset result = 0>
<cfif structKeyExists(form,"submit")>
	<cfset obj= createObject('component','components.database')>
	<cfset result = obj.createUser(form.name,form.email,form.userName,form.newPassWord)>
	<cfif result EQ 1>
		<cfoutput>User Created Successfully</cfoutput>
	</cfif>
</cfif>


<cfoutput>
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
		<div>
			<span style="color:red;">#session.errorMessage#</span>
		</div>
		<input type="submit" name="submit"/>
	</form>
</body>
</html>
</cfoutput>
