<cfoutput>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
  	<head>
    		<meta charset="UTF-8" />
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>Registration Form</title>
		<link rel="stylesheet" href="./css/register.css" />
		<link href="./css/bootstrap.min.css" rel="stylesheet" >
    		<script src="./js/bootstrap.min.js"></script>
  	</head>
  	<body>
	<div class="container-fluid bg-dark  d-flex flex-column align-items-center">
    		<h1 class="text-white">Employment Application</h1>
    		<div><p class="text-white">Please fill out this form with the required information</p></div>
    		<form class="d-flex flex-column bg-primary bg-gradient rounded p-5 my-5 gap-3 " id="form" action="result.cfm" method="post">
	      			<fieldset>
					<div class="d-flex flex-column mb-2">
        					<label for="referrer">Which position are you applying for?<span style="color=red;">*</span>
          						<select class="form-select" id="position" name="position">
            							<option value=""></option>
            							<option value="Interface Designer">Interface Designer</option>
            							<option value="System Engineer">System Engineer</option>
            							<option value="System Administrator">System Administrator</option>
            							<option value="Office Manager">Office Manager</option>
          						</select>
        					</label>	
						<span id="pos-error"></span>
					</div>
					<div class="form-control mb-2">
						<div class="form-check d-flex flex-wrap flex-column">
							<label>Are you willing to relocate? <span style="color=red;">*</span></label>
							<div class="d-flex flex-row"><input class="form-check-input" id="yes" type="radio" name="choice" value="yes" />
							<label class="form-check-label" for="yes"> Yes</label></div>
							<div class="d-flex flex-row"><input class="form-check-input" id="no" type="radio" name="choice" value="no" />
							<label class="form-check-label" for="no">No</label></div>
							<span id="choice-error"></span>
						</div>
					</div>
					<div class="d-flex flex-column mb-2">
						<label for="dob">When can you start?<span style="color=red;">*</span></label>
						<input class="form-input" id="doj" type="date" name="doj"/>
						<span id="doj-error"></span>
					</div>
					<div class="form-floating mb-2 ">
						<input class="form-control " id="web-site" name="webSite"  type="text"  placeholder=""/> 
        					<label class="form-label"  for="web-site">Portfolio Web Site: </label>
 						<span id="site-error"></span>
					</div>
					
					<div class="d-flex flex-column mb-2">
        					<label for="resume">Attach a copy of your resume? </label>
						<input class="form-input" id="resume" type="file" name="resume" />
						<span id="res-error"></span>
					</div>
					<div class="form-floating mb-2">
						<input class="form-control check" id="salary" name="salary" type="number"  placeholder=""/>
						<label  class="form-label" for="salary"> Salary Requirements: </label>
						<span id="sal-error"></span>
					</div>
					
     	 			</fieldset>
						
				<fieldset>
					<label>Your Contact Information</label>
					<div class="form-floating mb-2">
						<input class="form-control " id="name" name="name" type="text"  placeholder=""/>
        					<label class="form-label" for="name">Name: <span style="color=red;">*</span></label>
						<span id="name-error"></span>
					</div>
					<div class="form-floating mb-2">
						<input class="form-control check" id="email" name="email" type="text" placeholder=""/>
        					<label class="form-label"  for="email">Enter Your Email: <span style="color=red;">*</span></label>
						<span id="mail-error"></span>
					</div>
					<div class="form-floating mb-2">
						<input class="form-control check" id="phone-number" name="phoneNumber" type="number"  placeholder=""/>
						<label  class="form-label" for="phone-number">Enter Your Phone number: <span style="color=red;">*</span></label>
						<span id="num-error"></span>
					</div>
				</fieldset>
				<button class="btn btn-outline-success" type="submit" name="submit">Submit</button>
			</div>
			
    		</form>
		</div>
		<script src="./js/JQuery.js"></script>
		<script src="./js/Script.js"></script>
  	</body>
</html>
</cfoutput>
