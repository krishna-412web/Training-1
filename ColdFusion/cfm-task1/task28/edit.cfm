<cfif structKeyExists(session,"id")>
	<cfset pageId = session.tmpData.DATA[session.id][1]>
	<cfset pageName = session.tmpData.DATA[session.id][2]>
	<cfset pageDesc = session.tmpData.DATA[session.id][3]>
	<cfif structKeyExists(form,"submit")>
		<cfif pageName NEQ form.newPageName OR pageDesc NEQ form.newPageDesc >
			<cfset obj= createObject('component','database')>
			<cfset obj.updateData(pageId,form.newPageName,form.newPageDesc)>
		</cfif>
	</cfif>
</cfif>
<cfoutput>
	<!DOCTYPE html>
	<html lang="en">
		<head>
    			<meta charset="UTF-8">
    			<meta name="viewport" content="width=device-width, initial-scale=1.0">
    			<meta http-equiv="X-UA-Compatible" content="ie=edge">
    			<title>task27</title>
		</head>
		<body>
    			<form action="" method="post" enctype="multipart/form-data">
				
				<div>
					<label for="newPageName">Edit Pagename:</label>
					<input type="text" name="newPageName" id="newPageName" placeholder="Page Name" value="#pageName#">
				</div>
				<div>
					<label for="newPageDesc">Edit PageDesc</label>
					<textarea name="newPageDesc" id="newPageDesc" placeholder="Enter page description...">#pageDesc#</textarea>
				</div>
				<input type="submit" name="submit" value="Edit"/>
			</form>
		</body>
	</html>
</cfoutput>