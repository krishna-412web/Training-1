<!DOCTYPE html>
<html lang="en" >
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>Address Book-Login</title>
		<link href="./css/bootstrap.min.css" rel="stylesheet" >
    		<script src="./js/bootstrap.min.js"></script>
		<link href="./css/styles.css" rel="stylesheet">
  	</head>
  	<body>
		<nav class="navbar navbar-expand-sm bg-success navbar-dark fixed-top">
  			<div class="container-fluid row">
  				<h1 class="navbar-brand text-center">AddressBook-Login</h1>
  			</div>
		</nav>
		<div class="container-fluid d-flex flex-column flex-start justify-content-center col-xl-4 col-lg-5 col-md-6 col-sm-4 col-xs-4 mt-5">
			<div>
				<form class="login d-flex flex-column justify-content-start bg-success was-validated order-primary rounded p-3 m-5 gap-3" action="" method="post">
					<div class="form-floating">
						<input class="form-control" type="text" id="userName" name="userName" pattern="^\w{5,}$" placeholder="Username" required/>
						<label for="userName" class="form-label">Enter Username:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="password" id="passWord" name="passWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="Jk*#@12354" required/>
						<label class="form-label" for="passWord">Enter Password:</label>
					</div>
					<input class="btn btn-primary" type="submit" name="submit" value="Login"/>
					<div>
						<label class="form-label text-warning">Not Signed in Yet?</label>
						<a class="form-control btn btn-outline-info" href="register.cfm">Register</a>
					</div>
				</form>
			</div>
		</div>
  	</body>
</html>