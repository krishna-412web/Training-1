const firstName = document.getElementById("first-name");
const lastName = document.getElementById("last-name");
const email = document.getElementById("email");
const phone = document.getElementById("phone-number");
const password= document.getElementById("new-password");
const s = document.getElementById("male");
const s1 = document.getElementById("female");
const ms = document.getElementByName("unmarried");
const ms1 = document.getElementByName("married")


const fnameError = document.getElementById("fname-error");
const lnameError = document.getElementById("lname-error");
const mailError = document.getElementById("mail-error");
const phError = document.getElementById("num-error");
const passError = document.getElementById("pass-error");
const sError = document.getElementById("s-error");
const msError = document.getElementById("ms-error");

const form = document.getElementById("form");

let email_check = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
let pass_check = /^([A-Za-z0-9*#_])$/

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

	if(s.value == "" || s.value == null)
	{
		e.preventDefault();
		sError.innerText = "*Atleast one button should be checked";
		valid = false;
	}
	else
	{
		sError.innerText = "";
	}	

	if(ms.value == "" || ms.value == null)
	{
		e.preventDefault();
		msError.innerText = "*Atleast one button should be checked";
		valid = false;
	}
	else
	{
		msError.innerText = "";
	}

	window.scrollTo(0,0);
	if(!valid)
	{
		e.preventDefault();		
	}
	

});