/*const firstName = document.getElementById("first-name");
const lastName = document.getElementById("last-name");
const email = document.getElementById("email");
const phone = document.getElementById("phone-number");
const password= document.getElementById("new-password");
const s = document.getElementsByName("gender");
const ms = document.getElementsByName("m-status");
const pic = document.getElementById("profile-picture");
const date = document.getElementById("dob");
const occup = document.getElementById("referrer");
const bio = document.getElementById("bio");
const terms = document.getElementsByName("terms-and-conditions");


const fnameError = document.getElementById("fname-error");
const lnameError = document.getElementById("lname-error");
const mailError = document.getElementById("mail-error");
const phError = document.getElementById("num-error");
const passError = document.getElementById("pass-error");
const sError = document.getElementById("s-error");
const msError = document.getElementById("ms-error");
const picError = document.getElementById("pic-error");
const dateError = document.getElementById("dob-error");
const occupError = document.getElementById("ref-error");
const bioError = document.getElementById("bio-error");
const termsError = document.getElementById("terms-error");

const form = document.getElementById("form");

let email_check = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]){2,4}$/;
let pass_check = /^([A-Za-z0-9!@#$%^&*()_+-]{8,})$/;
let phone_check = /^([0-9]{10})$/;

let b1=0;
let b2=0;
let b3=0;


function Email(){
	if(!email.value.match(email_check))
	{
		mailError.innerText = "*Email format not correct/empty field";
		mailError.style.color = "red";
	}
	else
	{
		mailError.innerText = "*Valid Form Identified";
		mailError.style.color = "white";
	}
}

function Phone(){
	if(!phone.value.match(phone_check))
	{
		phError.innerText = "*Email format not correct/empty field";
		phError.style.color = "red";
	}
	else
	{
		phError.innerText = "*Valid Form Identified";
		phError.style.color = "white";
	}
}
function Password(){
	if(!password.value.match(pass_check))
	{
		passError.innerHTML = "*Password should have atleast 8 characters<br>[alphabets, numbers and !@#$%^&*()_+-";
		passError.style.color = "red";
	}
	else
	{
		passError.innerText = "*Valid Form Identified";
		passError.style.color = "white";
	}
}

form.addEventListener('submit',function(e)
{
	let valid = true; 

	if(firstName.value == '' || firstName.value == null)
	{
		valid = false;
		fnameError.innerText = "*first name field is required";
	}
	else
	{
		fnameError.innerText = "";
	}

	if(lastName.value == '' || lastName.value == null)
	{
		valid = false;
		lnameError.innerText = "*last name field is required";
	}
	else
	{
		lnameError.innerText = "";
	}

	if(!email.value.match(email_check))
	{
		valid = false;
		mailError.innerText = "*Email format not correct/empty field";
	}
	else
	{
		mailError.innerText = "";
	}

	if(!(phone.value.match(phone_check)))
	{
		valid = false;
		phError.innerText = "*Phone no should be 10 characters";
	}
	else
	{
		phError.innerText = "";
	}
	
	if(!password.value.match(pass_check))
	{
		valid = false;
		passError.innerText = "*Password should only contain A-Z,a-z,0-9,*,#,_";
	}
	else
	{
		passError.innerText = "";
	}		
	
	for (let i = 0; i < s.length; i++) {
		if (s[i].checked) {
    			b1+=1;
  		}
	}
	if(b1 == 0)
	{
		valid = false;
		sError.innerText = "*Atleast one button should be checked";
	}
	else
	{
		sError.innerText = "";
	}	

	for (let i = 0; i < ms.length; i++) {
		if (ms[i].checked) {
    			b2+=1;
  		}
	}
	if(b1 == 0)
	{
		valid = false;
		msError.innerText = "*Atleast one button should be checked";
	}
	else
	{
		msError.innerText = "";
	}

	if(pic.value == '' || pic.value == null)
	{
		valid = false;
		picError.innerText = "*file is not uploaded";
	}
	else
	{
		picError.innerText = "";
	}

	if(date.value == '' || date.value == null)
	{
		valid = false;
		dateError.innerText = "*date field is required";
	}
	else
	{
		dateError.innerText = "";
	}

	if(occup.value == '')
	{
		valid = false;
		occupError.innerText = "*Atleast select one option";
	}
	else
	{
		occupError.innerText = "";
	}
	
	if(bio.value == '' || bio.value == null)
	{
		valid = false;
		bioError.innerText = "*Bio is required";
	}
	else
	{
		bioError.innerText = "";
	}
	
	
	if(terms[0].checked == false)
	{
		valid = false;
		termsError.innerText = "*This field is required";
	}
	else
	{
		termsError.innerText = "";
	}
		

	window.scrollTo(0,0);
	if(!valid)
	{
		alert("All the fields are required");
		e.preventDefault();		
	}
	else
	{
		alert("Form is valid");	
	}
	

});*/


$(document).ready(function() {
	$("#form").submit(function(e) {
			var valid = false;
			
			let fname = $("#first-name").val();
			if(fname == '' || fname == null)
			{
				valid = false;
				$("#fname-error").text("*first name field is required");
			}
			else
			{
				$("#fname-error").text("");
			}


			let lname = $("#last-name").val();			
			if(lname == '' || lname == null)
			{
				valid = false;
				$("#lname-error").text("*first name field is required");
			}
			else
			{
				$("#lname-error").text("");
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
