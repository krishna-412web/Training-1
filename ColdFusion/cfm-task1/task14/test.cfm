<!DOCTYPE html>
<html lang="en">
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task8</title>
  	</head>
  	<body>
		<form action="" method="post" enctype="multipart/form-data">
			<div>
				<label for="imgname">Enter Image Name:</label>
				<input type="text" id="imgname" name="imgname" placeholder="Myphoto" required >
			</div>
			<div>
				<label for="file">Attach Image File:</label>
				<input type="file" id="file" name="file" placeholder="Add file" accept="image/*" required>
			</div>
			<div>
				<label for="imgdesc">Enter Image description:</label>
				<textarea type="text" id="imgdesc" name="imgdesc" placeholder="I was sitting on a chair." required>	
				</textarea>
			</div>	
			<input type="submit" name="submit" value="submit"/>
		</form>
		<cfinclude template="logic.cfm">
 	 </body>
</html>






