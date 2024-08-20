<cfinclude template="result20.cfm">
<!DOCTYPE html>
<html lang="en">
 	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task20</title>
    		<link rel="stylesheet" href="./css/styles.css">
  	</head>
  	<body>
		<form action="" method="post">
			<div>
				<label for="mail">Enter email:</label>
				<input  type="email" name="mail" id="mail" required>
			</div>

			<div>
				<label for="email">Enter Captcha:</label>
				<input  type="text" name="captcha" id="captcha">
				<cfset key=mid(generateSecretKey("DES",56),1,5)>
				<cfimage action="captcha" height="35" width="180" difficulty="low" text="#key#">
				<cfoutput><input type="hidden" name="pass" value="#key#"></cfoutput>
			</div>
			<input type="submit" name="submit">
		</form>
     	</body>
</html>



