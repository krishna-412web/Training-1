$(document).ready(function() {

	$(".check").on("input",function(e) {
		var check_list=[/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]){2,4}$/,/^([0-9]{10})$/,/^([A-Za-z0-9!@#$%^&*()_+-]{8,})$/];
		var error_id=["mail-error","num-error","pass-error"];
		var id = $(this).attr("id");
		var value = $("#"+id).val();
		var c1;
		var text;

		if(id=="email") { c1=0; }
		else if(id=="phone-number") {c1=1;}
		else { c1=2;}
		console.log();

		if(!value.match(check_list[c1]))
		{	
			if(c1 == 0){ 
					text = "*Email format not correct/empty field"; 
			}
			else if(c1 == 1){
					text = "*Phone no should be 10 characters"; 
			}
			else{
					text = "*Password should have atleast 8 characters<br>alphabets, numbers and !@#$%^&*()_+-"; 		
			}
			$("#"+error_id[c1]).html(text);
			$("#"+error_id[c1]).css("color","red");
		}
		else 
		{
			$("#"+error_id[c1]).html("This field is valid");
			$("#"+error_id[c1]).css("color","white");
		}
		
				
	});
	$("form").on('submit',function(e) {

			var valid = true;
			var email_check = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]){2,4}$/;
			var pass_check = /^([A-Za-z0-9!@#$%^&*()_+-]{8,})$/;
			var phone_check = /^([0-9]{10})$/;
			let b1=0;
			let b2=0;
			let b3=0;
			
			let fname = $("#first-name").val();
			let lname = $("#last-name").val();
			let s= $("input[name='gender']");
			let ms= $("input[name='m-status']");
			let pic= $("#profile-picture").val();
			let date= $("#dob").val();
			let occup= $("#referrer").val();
			let bio= $("#bio").val();
			let terms= $("input[name='terms-and-conditions']");
			

			if(fname == '' || fname == null)
			{
				valid = false;
				$("#fname-error").text("*first name field is required");
			}
			else
			{
				$("#fname-error").text("") ;
			}

			
			if(lname == '' || lname == null)
			{
				valid = false;
				$("#lname-error").text("*last name field is required");
			}
			else
			{
				$("#lname-error").text("");
			}


			if(!$("#email").val().match(email_check))
			{
				valid = false;
				$("#mail-error").text("*Email format not correct/empty field");
			}
			else
			{
				$("#mail-error").text("");
			}


			if(!$("#phone-number").val().match(phone_check))
			{
				valid = false;
				$("#num-error").text("*Phone no should be 10 characters");
			}
			else
			{
				$("#num-error").text("");
			}

	
			if(!$("#new-password").val().match(pass_check))
			{
				valid = false;
				$("#pass-error").html("*Password should have atleast 8 characters<br>alphabets, numbers and !@#$%^&*()_+-");
			}
			else
			{
				$("#pass-error").html("");
			}
			
			for (let i = 0; i < s.length; i++) {
				if (s[i].checked) {
    					b1+=1;
  				}
			}
			if(b1 == 0)
			{
				valid = false;
				$("#s-error").text("*Atleast one button should be checked");
			}
			else
			{
				$("#s-error").text("");
			}	

			for (let i = 0; i < ms.length; i++) {
				if (ms[i].checked) {
    					b2+=1;
  				}
			}
			if(b2 == 0)
			{
				valid = false;
				$("#ms-error").text("*Atleast one button should be checked");
			}
			else
			{
				$("#ms-error").text("");
			}
			

			if(pic == '' || pic == null)
			{
				valid = false;
				$("#pic-error").text("*file is not uploaded");
			}
			else
			{
				$("#pic-error").text("");
			}

			if(date == '' || date == null)
			{
				valid = false;
				$("#dob-error").text("*date field is required");
			}
			else
			{
				$("#dob-error").text("");
			}

			
			if(occup== '')
			{
				valid = false;
				$("#ref-error").text("*Atleast select one option");
			}
			else
			{
				$("#ref-error").text("");
			}
	
			if(bio == '' || bio == null)
			{
				valid = false;
				$("#bio-error").text("*bio is required");
			}
			else
			{
				$("#bio-error").text("");
			}
	
	
			if(terms[0].checked == false)
			{
				valid = false;
				$("#terms-error").text("*this field is required");
			}
			else
			{
				$("#terms-error").text("");
			}
			window.scrollTo(0,0);
			if(!valid)
			{	
				e.preventDefault();
			}
			else
			{
				alert("Form is valid");	
			}
	});
});
