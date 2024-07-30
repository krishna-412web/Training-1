<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>HTML5 Boilerplate</title>
 
  <style>
	
	.box{
		display:flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		height: 5vh;
		margin: 1vh 6vw;
		background-color: #cccccc;
	}
  </style>
</head>

<body>
  <h1>Hands_on2</h1>
  <cfscript>
	personalInfo={name='Krishna Renjith', dob='31/0/2002', address='Athippillil House', email='krenjith567@gmail.com', website='www.krishnarenjith.com', skype='krishnarenjith@techversantinfo.com'};
</cfscript>

<cfoutput>
	<div class="box">
		<div class="input-box">Name: </div><span>#personalInfo.name#</span>
	</div>
	<div class="box">
		<div class="input-box">Date-of-birth:</div><span>#personalInfo.dob#</span>
	</div>
	<div class="box">
		<div class="input-box">Address:</div><span>#personalInfo.address#</span>
	</div>
	<div class="box">
		<div class="input-box">Email:</div><span><a href="##">#personalInfo.email#</a></span>
	</div>
	<div class="box">
		<div class="input-box">Website:</div><span><a href="##">#personalInfo.website#</a></span>
	</div>
	<div class="box">
		<div class="input-box">Skype:</div><span><a href="##">#personalInfo.skype#</a></span>
	</div>
	
</cfoutput>

</body>

</html>