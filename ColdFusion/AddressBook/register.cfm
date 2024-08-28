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
		<div class="container-fluid d-flex flex-column flex-start justify-content-center col-lg-4 col-sm-5 col-xs-5 mt-5">
			<div>
				<form class="login d-flex flex-column justify-content-start bg-primary border-primary rounded p-3 m-5 gap-3" action="" method="post">
					<div class="form-floating">
						<input class="form-control" type="text" id="name" name="name" placeholder="Username"/>
						<label for="userName" class="form-label">Enter name:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="email" id="email" name="email" placeholder="Username"/>
						<label for="userName" class="form-label">Enter email:</label>
					</div>
					<div class="form-floating">
						<input class="form-control" type="text" id="userName" name="userName" placeholder="Username"/>
						<label for="userName" class="form-label">Enter New Username:</label>
					</div>
					<button type="button" class="btn btn-outline-info">Check</button>
					<div class="form-floating">
						<input class="form-control" type="password" id="passWord" name="passWord" placeholder="Jk*#@12354"/>
						<label class="form-label" for="passWord">Enter New Password:</label>
					</div>
					<input class="form-control btn btn-success " type="submit" name="submit" value="Register" disabled/>
				</form>
			</div>
		</div>
  	</body>
</html>