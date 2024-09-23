<cfif structKeyExists(url,"id")>
	<cfset obj = createObject("component","components.database")>
	<cfset get = obj.selectdata(URL.id)>	
</cfif>

<cfoutput>
<!DOCTYPE html>
<html lang="en">
	<head>
  		<title>ContactPage</title>
  		<meta charset="utf-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="./css/bootstrap.min.css" rel="stylesheet">
  		<script src="./js/bootstrap.bundle.min.js"></script>
  		<script src="./js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="./css/printContact.css" media="print">
	</head>
	<body>
		<div class="border-bottom border-2 border-dark no-print"></div>
		<div id="viewDiv" class="content-div row">
			<div class="col-9">
                        	<h3 class="text-center border-bottom text-primary border-dark">VIEW CONTACT</h3>
                        	<div class="row">
					<h4 class="text-primary col-4">Name:</h4>
					<h5 class="text-dark col-auto" id="nameView">#get[1].titleName# #get[1].firstname# #get[1].lastname#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Gender:</h4>
					<h5 class="text-dark col-auto" id="genderView">#get[1].genderName#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Date of Birth:</h4>
					<h5 class="text-dark col-auto" id="dobView">#get[1].dob#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Address:</h4>
					<h5 class="text-dark col-auto" id="AddressView">#get[1].house_flat#,#get[1].street#<br>#get[1].city#,#get[1].state#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Pincode:</h4>
					<h5 class="text-dark col-auto" id="pincodeView">#get[1].pincode#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Email:</h4>
					<h5 class="text-dark col-auto" id="mailView">#get[1].email#</h5>
				</div>
				<div class="row">
					<h4 class="text-primary col-4">Phone:</h4>
					<h5 class="text-dark col-auto" id="phoneView">#get[1].phone#</h5>
				</div>
				
				<div class="row">
					<h4 class="text-primary col-4">Hobbies:</h4>
					<h5 class="text-dark col-auto" id="hobbieView">
						<cfloop array="#get[1].hobbies#" index="i">
							#i#<br>
						</cfloop>
					</h5>
				</div>
			</div>
			<div class="col-3 bg-secondary d-flex flex-column justify-content-center align-items-center no-print">
				<img src="#get[1].profile#" class="img-fluid rounded w-50 h-50" id="profilePic" alt="profile-pic">
			</div>
        	</div>
		<div class="border-bottom border-2 border-dark no-print"></div>
	</body>
</html>
</cfoutput>
