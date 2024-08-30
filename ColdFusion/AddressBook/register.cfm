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
					<span id="usernameCheck"></span>
					<div class="form-floating">
						<input class="form-control" type="password" id="passWord" name="passWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="Jk*#@12354" required/>
						<label class="form-label" for="passWord">New Password:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="password" id="confirmPassWord" name="confirmPassWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="Jk*#@12354" required/>
						<label class="form-label" for="passWord">Confirm Password:</label>
					</div>
					<input class="form-control btn btn-success disabled" id="submit" type="submit" name="submit" value="Register"/>
				</form>
			</div>
		</div>
		<script src="./js/jQuery.js"></script>
		<script src="./js/register-script.js"></script>
  	</body>
</html>