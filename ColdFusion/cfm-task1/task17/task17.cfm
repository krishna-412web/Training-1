<!DOCTYPE html>
<html lang="en">
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task17</title>
  	</head>
  	<body>
		<form action="" method="post" id="form1">
			<div>
				<label for="num">Enter Number:</label>
				<input type="text" id="num" name="num" required>
			</div>
			<input type="submit" name="submit" value="submit">
		</form>
		<script src="./js/script.js"></script>
		<cfinclude template="result17.cfm">
 	 </body>
</html>
	


<cfparam name="form.submit" default="">
<cfparam name="form.num" default="0">

<cfif NOT isNull(form.submit)>

	<cfoutput>
		<style>
			.odd { color:blue; }
			.even { color:green; }
		</style>
		<cfset n= form.num>

		<cfloop from="1" to="#n#" index="i">
			<cfif i mod 2 EQ 0>
				<cfoutput><span class="even">#i#</span><br></cfoutput>
			<cfelse>
				<cfoutput><span class="odd">#i#</span><br></cfoutput>
			</cfif>
		</cfloop>
 
	</cfoutput>
	
</cfif>