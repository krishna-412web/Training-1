<!DOCTYPE html>
<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task26</title>
	</head>
	<body>
		<link rel="stylesheet" href="./css/styles.css">
    		<form action="" method="post" enctype="multipart/form-data">
			<div>
				<label for="text">Enter text file:</label>
				<input type="file" name="textFile" id="textFile" placeholder="Attach text file">
			</div>
			<input type="submit" name="submit"/>
		</form>
	</body>
</html>


<cfoutput>
<cfif structKeyExists(form,"submit") AND structKeyExists(form,"textFile")>
	<cfset uploadDir = expandPath('./uploads/')>
	<cffile action="upload" fileField="textFile" destination="#uploadDir#" nameConflict="makeUnique" result="r">
	<cfif r.SERVERFILEEXT EQ "txt">
		File uploaded successsfully!!<br>
		<cffile action="read" file="#uploadDir#/#r.SERVERFILE#" variable="serverFile">
		<cfset obj=createObject("component","tagCloud")>
		<cfset obj.init(serverFile)>
		<cfset obj.insert()>
		<cfset s = obj.select()>
		<cfset d=obj.process(s)>
		<cfset obj.output(d)>
	<cfelse>
		*text files are only allowed
	</cfif>		
</cfif>
</cfoutput>
