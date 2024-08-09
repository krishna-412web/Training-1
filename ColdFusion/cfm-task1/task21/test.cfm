<!DOCTYPE html>
<html>
	<head>
		<title>Mypage</title>
	</head>
	<body>
	<style>
		.hide{
			visibility : hidden;
		}
		.colour{
			color: red;
		}
		.show {
			visibility: visible;
		}
	</style>
	<form action="" method="post" id="form1" enctype="multipart/form-data">
		<div>
			<label for="name">Birthday Baby Name:</label>
			<input type="text" id="name" name="name">
			<span id="name-error" class="hide colour">*name field is required</span>
		</div>
	
		<div>
			<label for="email">His email id:</label>
			<input type="email" id="email" name="email">
			<span id="mail-error" class="hide colour">*email field is required</span>
		</div>

		<div>	
			<label for="wish">Birthday Wishes:</label>
			<textarea id="wish" name="wish"></textarea>
			<span id="wish-error" class="hide colour">*this field is required</span>
		</div>
	
		<div>
			<label for="image">Greeting Image:</label>
			<input type="file" id="image" name="image" accept="image/*">
			<span id="img-error" class="hide colour">*image field is required</span>
		</div>
		<input type="submit" name="submit">
	</form>
	<script src="script.js"></script>
	<cfinclude template="mail.cfm">
</body>
</html>





