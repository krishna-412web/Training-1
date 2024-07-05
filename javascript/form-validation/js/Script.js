const firstName = document.getElementById("first-name");
const lastName = document.getElementById("last-name");
const email = document.getElementById("email");
const phone = document.getElementById("phone-number");
const password= document.getElementById("new-password");


const fnameError = document.getElementById("fname-error");
const lNameError = document.getElementById("lname-error");
const mailError = document.getElementById("mail-error");
const phError = document.getElementById("num-error");
const passError = document.getElementById("pass-error");

const form = document.getElementById("form");

form.addEventListener('submit',(e) =>
{
	let valid = true; 
	if(firstName.value == '' || firstName.value == null)
	{
		e.preventDefault();
		fnameError.innerText = "*Name field is required";
		valid = false;
	}
	else
	{
		fnameError.innerText = "";
	}
	window.scrollTo(0,0);
	if(!valid)
	{
		e.preventDefault();		
	}
	

});