let form=document.getElementById("form1");
		let number=document.getElementById("num");
		form.addEventListener("submit", (event) => {
			let valid = true;
			if( isNaN(num.value))
			{
				valid = false;
				alert("*only numbers are allowed");
				number.value="";
			}
			
			if(!valid)
				event.preventDefault();
			else
				alert("!!FORM SUBMITTED!!")
			
		});