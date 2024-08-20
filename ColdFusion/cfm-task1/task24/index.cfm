<cfif structKeyExists(form,"submit")>
	<cfset obj=createObject('component','logic24')>
	<cfset obj.store()>
	<cfoutput>Data Inserted Succesfully..</cfoutput>
</cfif>

<!DOCTYPE html>
<html lang="en">
  	<head>
		<meta charset="UTF-8">
  	  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	  	<title>Task24</title>
  	</head>
  	<body>
		<form action="" method="post">
			<div>
				Enter First Name:
				<input type="text" name="firstName" required/>
			</div>
			<div>
				Enter email:
				<input type="email" name="email" id="email" required/>
				<input type="button" name="check" id="check" value="check" />
			</div>
			<input type="submit" name="submit" id="submit" disabled/>
		</form>
		<script src="./js/jQuery.js"></script>
		<script src="./js/script.js"></script>
  	</body>
</html