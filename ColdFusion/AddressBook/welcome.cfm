<cfinclude template="logic.cfm">
<!DOCTYPE html>
<html lang="en">
<head>
  	<title>Bootstrap Example</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
 	<link href="./css/bootstrap.min.css" rel="stylesheet">
  	<script src="./js/bootstrap.bundle.min.js"></script>
  	<script src="./js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/print.css" media="print">
</head>
<body>
	<div class="container-fluid p-0">
		<div class="container-fluid p-0 no-print">
			<nav class="navbar navbar-expand-sm bg-primary navbar-dark container-fluid ">
  				<div class="container-fluid row">
  						<h1 class="navbar-brand text-center col-11 m-0">AddressBook</h1>
						<form class="col-1" action="" method="POST">
							<button type="submit" name="submit" class="btn btn-info btn-block">Logout</button>
						</form>
  				</div>
			</nav>
		</div>
		<div class="container">
				
		</div>
		<div class="container no-print">
			<div class="row">
				<div class="card mt-2 row">
					<div class="card-body row d-flex flex-row justify-content-end">
						<button type="button" id="pdfFeature" class="btn btn-info col-1 mx-1">pdf</button>
						<button type="button" id="excelFeature" class="btn btn-info col-1 mx-1">excel</button>
						<button type="button" id="printFeature" class="btn btn-info col-1 mx-1">print</button>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="card mt-2 col-2 no-print">
					<div class="d-flex flex-column justify-content-center card-body">
						<p class="text-center">Krishna Renjith</p>
						<button type="button" class="btn btn-info add" id="btnAdd" data-bs-toggle="modal" data-bs-target="#myModal">Add Contact</button>
					</div>
				</div>
				<div class="col-10">
					<!---<div class="card mt-2">
						<div class="card-body p-1">
							<h2 class="text-center text-secondary m-0">Contacts</h2>
						</div>
					</div>--->
					<table class="table table-bordered table-sm" id="contactList">	
						<thead>
							<th>#</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th class="no-print">View</th>
							<th class="no-print">Edit</th>
							<th class="no-print">Delete</th>
						</thead>
						<tbody  id="pageDisplay">
							<tr>
								<td>1</td>
								<td>Anand Vishnu</td>
								<td>anandvishnu0804@gmail.com</td>
								<td><button type="button" class="btn btn-sm btn-success" id="btnView" data-bs-toggle="modal" data-bs-target="#myModal">View</button></td>
								<td><button type="button" class="btn btn-sm btn-success" id="btnEdit" data-bs-toggle="modal" data-bs-target="#myModal">Edit</button></td>
								<td><button type="button" class="btn btn-sm btn-success">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		<div>
	</div>

	<div class="modal" id="myModal">
  		<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      				</div>
           			<div class="modal-body">
					<div id="viewDiv" class="content-div">
                        			<h3 class="text-center border-bottom text-primary border-dark">VIEW CONTACT</h3>
                        			<div class="row">
							<h4 class="text-primary col-4">Name:</h4>
							<h5 class="text-dark col-auto" id="nameView">Krishna Renjith</h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Gender:</h4>
							<h5 class="text-dark col-auto" id="genderView"></h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Date of Birth:</h4>
							<h5 class="text-dark col-auto" id="dobView"></h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Address:</h4>
							<h5 class="text-dark col-auto" id="AddressView"></h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Pincode:</h4>
							<h5 class="text-dark col-auto" id="pincodeView"></h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Email:</h4>
							<h5 class="text-dark col-auto" id="mailView"></h5>
						</div>
						<div class="row">
							<h4 class="text-primary col-4">Phone:</h4>
							<h5 class="text-dark col-auto" id="phoneView"></h5>
						</div>		
                    			</div>
        				<div id="addDiv" class="content-div">
                        			<div class="container-fluid">
							<form id="myForm1" action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary">CREATE CONTACT</h3>
									<h5 class="text-decoration-underline text-primary text-start">Personal Contact</h5>
									<div class="row">
										<div class="col-2">
											<div class="form-floating">
												<select id="title" name="title" class="form-select">
      													<option value="" selected></option>
      													<option value="1">Mr.</option>
      													<option value="2">Mrs.</option>
      													<option value="3">Ms.</option>
   											 	</select>
												<label class="text-dark fw-bold form-label">Title*</label>
											</div>
										</div>
										<div class="col-5">
											<div class="form-floating">
												<input class="form-control" type="text" id="firstName" name="firstName" placeholder="">														<label for="firstName" class="text-dark fw-bold form-label">Firstname*</label>
											</div>
										</div>
										<div class="col-5"><p class="text-dark fw-bold">Secondname*</p></div>
									</div>
									<div class="row">
										<div class="col-2">
											 
										</div>
										<div class="col-5"></div>
										<div class="col-5"><input type="text" id="lastName" name="lastName"></div>
									</div>
									<div class="row">
										<div class="col-6"><p class="text-dark fw-bold">Gender*</p></div>
										<div class="col-6"><p class="text-dark fw-bold">Date Of Birth*</p></div>
									</div>
									<div class="row">
										<div class="col-6">
											 <select id="gender" name="gender">
      												<option value="" selected></option>
      												<option value="1">Male</option>
      												<option value="2">Female</option>
   											 </select>
										</div>
										<div class="col-6"><input type="date" id="dob" name="dob"></div>
									</div>
									<h5 class="text-decoration-underline text-primary text-start">Upload Photo</h5>
									<input type="file" name="profile" id ="profile">
									<h5 class="text-decoration-underline text-primary text-start">Address</h5>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">House name</p></div>
										<div class="col-5"><p class="text-dark fw-bold">Street</p></div>
										<div class="col-3"><p class="text-dark fw-bold">City</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="text" id="houseName" name="houseName"></div>				
										<div class="col-5"><input type="text" id="street" name="street"></div>
										<div class="col-3"><input type="text" id="city" name="city"></div>
									</div>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">State</p></div>
										<div class="col-4"><p class="text-dark fw-bold">Pincode</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="text" id="state" name="state"></div>				
										<div class="col-4"><input type="text" id="pincode" name="pincode"></div>
									</div>
									<h5 class="text-decoration-underline text-primary text-start">Contact Details</h5>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">Email</p></div>
										<div class="col-4"><p class="text-dark fw-bold">phone</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="email" id="email" name="email"></div>				
										<div class="col-4"><input type="number" id="phone" name="phone"></div>
									</div>
									<!---<span class="text-danger">#session.errorMessage#<br></span>--->
									<button class="btn btn-primary" type="submit" name="submit1">Add Contact</button>
							</div>
							</form>
						</div>
                    			</div>
                    			<div id="editDiv" class="content-div" style="display:none;">
                        			<div class="container-fluid">
							<form action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary">EDIT CONTACT</h3>
									<h5 class="text-decoration-underline text-primary text-start">Personal Contact</h5>
									<div class="row">
										<div class="col-2"><p class="text-dark fw-bold">Title*</p></div>
										<div class="col-5"><p class="text-dark fw-bold">Firstname*</p></div>
										<div class="col-5"><p class="text-dark fw-bold">Secondname*</p></div>
									</div>
									<div class="row">
										<div class="col-2">
											 <select id="title1" name="title">
      												<option value="" selected></option>
      												<option value="1">Mr.</option>
      												<option value="2">Mrs.</option>
      												<option value="3">Ms.</option>
   											 </select>
										</div>
										<div class="col-5"><input type="text" id="firstName1" name="firstName"></div>
										<div class="col-5"><input type="text" id="secondName1" name="secondName"></div>
									</div>
									<div class="row">
										<div class="col-6"><p class="text-dark fw-bold">Gender*</p></div>
										<div class="col-6"><p class="text-dark fw-bold">Date Of Birth*</p></div>
									</div>
									<div class="row">
										<div class="col-6">
											 <select id="gender1" name="gender">
      												<option value="" selected></option>
      												<option value="1">Male</option>
      												<option value="2">Female</option>
   											 </select>
										</div>
										<div class="col-6"><input type="date" id="dob1" name="dob"></div>
									</div>
									<h5 class="text-decoration-underline text-primary text-start">Upload Photo</h5>
									<input type="file" name="profile" id ="profile1">
									<h5 class="text-decoration-underline text-primary text-start">Address</h5>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">House name</p></div>
										<div class="col-5"><p class="text-dark fw-bold">Street</p></div>
										<div class="col-3"><p class="text-dark fw-bold">City</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="text" id="houseName1" name="houseName"></div>				
										<div class="col-5"><input type="text" id="street1" name="street"></div>
										<div class="col-3"><input type="text" id="city1" name="city"></div>
									</div>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">State</p></div>
										<div class="col-4"><p class="text-dark fw-bold">Pincode</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="text" id="state1" name="state"></div>				
										<div class="col-4"><input type="text" id="pincode1" name="pincode"></div>
									</div>
									<h5 class="text-decoration-underline text-primary text-start">Contact Details</h5>
									<div class="row">
										<div class="col-4"><p class="text-dark fw-bold">Email</p></div>
										<div class="col-4"><p class="text-dark fw-bold">phone</p></div>
									</div>
									<div class="row">
										<div class="col-4"><input type="email" id="email1" name="email"></div>				
										<div class="col-4"><input type="number" id="phone1" name="phone"></div>
									</div>
									<button class="btn btn-primary" type="submit" name="submit2">Edit Contact</button>
							</div>
						</div>
						</form>
                    			</div>
                   			
      				</div>

      				<!---<div class="modal-footer">
        				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      				</div>--->

    			</div>
  		</div>
	</div>
	<script src="./js/jQuery.js"></script>
	<script src="./js/modal-script.js"></script>
</body>
</html>
<cfdump var="#form#">


