<cfset session.errorMessage="">
<cfset result = 0>
<cfif structKeyExists(form,"submit")>
	<cfset obj= createObject('component','components.database')>
	<cfset variables.message = obj.registerValidate(form)>
	<cfif variables.message.flag EQ 1>
		<cfset createResult = obj.createUser(form.name,form.email,form.userName,form.passWord)>
		<cfif createResult.value EQ 1>
			<script>alert("User Created Successfully");</script>
			<cflocation url="index.cfm" addToken="no" statusCode="302">
		</cfif>
	</cfif>
</cfif>

<cfoutput>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>Address Book-Register</title>
		<link href="./css/bootstrap.min.css" rel="stylesheet" >
    		<script src="./js/bootstrap.min.js"></script>
		<link href="./css/styles.css" rel="stylesheet">
  	</head>
  	<body>
		<nav class="navbar navbar-expand-sm bg-primary navbar-dark fixed-top">
  			<div class="container-fluid row">
  				<h1 class="navbar-brand text-center">AddressBook-Register</h1>
  			</div>
		</nav>
		<div class="container-fluid d-flex flex-column flex-start justify-content-center col-xl-4 col-lg-5 col-md-6 col-sm-4 col-xs-4 mt-4">
			<div>
				<form id="register" class="login d-flex flex-column justify-content-start bg-primary border-primary was-validated rounded p-3 m-5 gap-3" action="" method="post">
					<div class="form-floating">
						<input class="form-control" type="text" id="name" name="name" placeholder="Username" required/>
						<label for="userName" class="form-label">Full Name:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="email" id="email" name="email" placeholder="mail@gmail.com" required/>
						<label for="userName" class="form-label">Email:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="text" id="userName" name="userName" pattern="^\w{5,}$" placeholder="Username" required/>
						<label for="userName" class="form-label">Username:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="password" id="passWord" name="passWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" required/>
						<label class="form-label" for="passWord">New Password:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="password" id="confirmPassWord" name="confirmPassWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" required/>
						<label class="form-label" for="passWord">Confirm Password:</label>
					</div>
					<div>
						<span style="color:red;">#session.errorMessage#</span>
						<cfif structKeyExists(variables,'message') AND structKeyExists(variables.message,'errors') AND variables.message.flag EQ 0>
							<cfloop array="#variables.message.errors#" index="local.i">
								<span class="text-danger">#local.i#</span>
								<br>
							</cfloop>
						</cfif>
					</div>
					<input class="form-control btn btn-success disabled" id="submit" type="submit" name="submit" value="Register"/>
					<div>
						<label class="form-label text-warning">Go to login</label>
						<a class="form-control btn btn-outline-info" href="index.cfm">Login</a>
					</div>
				</form>
			</div>
		</div>
		<script src="./js/jQuery.js"></script>
		<script src="./js/register-script.js"></script>
  	</body>
</html>
</cfoutput>