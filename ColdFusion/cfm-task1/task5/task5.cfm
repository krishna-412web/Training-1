<!DOCTYPE html>
<html lang="en">
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>HTML 5 Boilerplate</title>
    		<link rel="stylesheet" href="style.css">
  	</head>
  	<body>
    		<form action="result5.cfm" method="post">
			<div>
				<label for="mother">Enter Mother's dob:</label>
				<input type="date" name="mother" id="mother" placeholder="1to5" required>
			</div>
			<div>
				<label for="son">Enter Son's dob:</label>
				<input type="date" name="son" id="son" placeholder="1to5" required>
			</div>
			<input type="submit" name="submit" value="Submit" required>
		</form>
  	</body>
</html>