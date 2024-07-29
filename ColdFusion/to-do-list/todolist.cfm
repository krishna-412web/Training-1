<!DOCTYPE html>
<html lang="en">
  	<head>
    		<meta charset="UTF-8" />
		<meta name="viewport" content="width-device-width", initial scale=1.0">
    		<title>To-do-list</title>
		<link href="./css/bootstrap.min.css" rel="stylesheet" >
    		<script src="./js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="./css/styles.css" />
  	</head>
  	<body class="container-fluid bg-info ">
		<div class="d-flex flex-column justify-content-center align-items-center mb-3">
			<p class="display-1">Work-To-Dos</p>
			<p class="h2 text-warning">Enter text to input field to add items to your list</p>
			<p class="h2 text-success">Click the items to mark it as complete</p>
			<p class="h2 text-dark">Click the "x" to remove the items from your list</p>
		</div>
		
		
		<form id="todo-input" action="" method="get">
			<div class="d-flex flex-row justify-content-center rounded bg-light p-2 mb-3">
				<input class="col-11 bg-light border-0 " type="text" name="add-new" id="add-new" placeholder="Add new..."/>
				<button class="col-1 btn btn-primary" type="submit" value="submit" class="col-1 btn btn-primary" id="add" name="submit">Add</button>
			</div>
		</form>
	
		<div class="p-2">
			<ul id="anand">
				
			</ul>
		</div>
		<script src="./js/Script.js"></script>
  	</body>
</html>