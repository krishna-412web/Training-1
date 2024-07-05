const firstName = document.getElementById("first-name");
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
const terms = document.getElementsByName("terms-and-condition");

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

let email_check = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z])$/;
let pass_check = /^([A-Za-z0-9*#_])$/

let b1=0;
let b2=0;
let b3=0;
form.addEventListener('submit',(e) =>
{
	let valid = true; 

	if(firstName.value == '' || firstName.value == null)
	{
		e.preventDefault();
		fnameError.innerText = "*first name field is required";
		valid = false;
	}
	else
	{
		fnameError.innerText = "";
	}

	if(lastName.value == '' || lastName.value == null)
	{
		e.preventDefault();
		lnameError.innerText = "*last name field is required";
		valid = false;
	}
	else
	{
		lnameError.innerText = "";
	}

	if(!email.value.match(email_check))
	{
		e.preventDefault();
		mailError.innerText = "*Email format not correct/empty field";
		valid = false;
	}
	else
	{
		mailError.innerText = "";
	}

	if(!(phone.value.length == 10))
	{
		e.preventDefault();
		phError.innerText = "*Phone no should be 10 characters";
		valid = false;
	}
	else
	{
		phError.innerText = "";
	}
	
	if(!password.value.match(pass_check))
	{
		e.preventDefault();
		passError.innerText = "*Password should only contain A-Z,a-z,0-9,*,#,_";
		valid = false;
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
		e.preventDefault();
		sError.innerText = "*Atleast one button should be checked";
		valid = false;
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
		e.preventDefault();
		msError.innerText = "*Atleast one button should be checked";
		valid = false;
	}
	else
	{
		msError.innerText = "";
	}

	if(pic.value == '' || pic.value == null)
	{
		e.preventDefault();
		picError.innerText = "*file is not uploaded";
		valid = false;
	}
	else
	{
		picError.innerText = "";
	}

	if(date.value == '' || date.value == null)
	{
		e.preventDefault();
		dateError.innerText = "*date field is required";
		valid = false;
	}
	else
	{
		dateError.innerText = "";
	}

	if(occup.value == '')
	{
		e.preventDefault();
		occupError.innerText = "*Atleast select one option";
		valid = false;
	}
	else
	{
		occupError.innerText = "";
	}
	
	if(bio.value == '' || bio.value == null)
	{
		e.preventDefault();
		bioError.innerText = "*Bio is required";
		valid = false;
	}
	else
	{
		bioError.innerText = "";
	}
	
	for (let i = 0; i < terms.length; i++) {
		if (terms[i].checked) {
    			b3+=1;
  		}
	}
	if(b3 == 0)
	{
		e.preventDefault();
		termsError.innerText = "*Atleast one button should be checked";
		valid = false;
	}
	else
	{
		termsError.innerText = "";
	}
		

	window.scrollTo(0,0);
	if(!valid)
	{
		e.preventDefault();		
	}
	

});