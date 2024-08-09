let form1=document.getElementById("form1");
let name=document.getElementById("name");
let mail=document.getElementById("email");
let wish=document.getElementById("wish");
let image=document.getElementById("image");

let email_check = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]){2,4}$/;

let m1=document.getElementById("name-error");
let m2=document.getElementById("mail-error");
let m3=document.getElementById("wish-error");
let m4=document.getElementById("img-error");
		
form1.addEventListener("submit", (event) => {
	let valid = true;
	if(name.value == ""||name.value == null)
	{
		valid = false;
		m1.classList.remove("hide");
		m1.classList.add("show");
	}
	if(mail.value ==""||mail.value == null||!mail.value.match(email_check))
	{
		valid = false;
		m2.classList.remove("hide");
		m2.classList.add("show");
	}
	if(wish.value==""||wish.value == null)
	{
		valid = false;
		m3.classList.remove("hide");
		m3.classList.add("show");
	}
	if(image.value==""||image.value == null)
	{
		valid = false;
		m4.classList.remove("hide");
		m4.classList.add("show");
	}
	
	
	if(!valid)
		event.preventDefault();
	else
		alert("!!FORM SUBMITTED!!");
			
});
