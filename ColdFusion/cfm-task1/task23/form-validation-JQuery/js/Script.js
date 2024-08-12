$(document).ready(function() {

	$(".check").on("input",function(e) {
		var check_list= [/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]){2,4}$/,/^([0-9]{10})$/];
		var error_id=["mail-error","num-error"];
		var id = $(this).attr("id");
		var value = $("#"+id).val();
		var c1;
		var text;

		if(id=="email") { c1=0; }
		else if(id=="phone-number") {c1=1;}

		if(!value.match(check_list[c1]))
		{	
			if(c1 == 0){ 
					text = "*email field is required"; 
			}
			else if(c1 == 1){
					text = "*phone number field is required"; 
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
			var phone_check = /^([0-9]{10})$/;
			let b1=0;
			let b2=0;
			let b3=0;
			
			let name = $("#name").val();
			let s= $("input[name='choice']");
			let res= $("#resume").val();
			let date= $("#doj").val();
			let position= $("#position").val();
			let salary= $("#salary").val();
			let webSite= $("#web-site").val();
			
			if(name == '' || name == null)
			{
				valid = false;
				$("#name-error").text("* name field is required");
			}
			else
				$("#name-error").text("");


			if(!$("#email").val().match(email_check))
			{
				valid = false;
				$("#mail-error").text("*Email format not correct/empty field");
			}
			else
				$("#mail-error").text("");


			if(!$("#phone-number").val().match(phone_check))
			{
				valid = false;
				$("#num-error").text("*Phone no should be 10 characters");
			}
			else
				$("#num-error").text("");


			
			for (let i = 0; i < s.length; i++) {
				if (s[i].checked) {
    					b1+=1;
  				}
			}
			if(b1 == 0)
			{
				valid = false;
				$("#choice-error").text("*Atleast one button should be checked");
			}
			else
				$("#choice-error").text("");
	

			
			if(date == '' || date == null)
			{
				valid = false;
				$("#doj-error").text("*date field is required");
			}
			else
				$("#doj-error").text("");
	

			
			if(position== '')
			{
				valid = false;
				$("#pos-error").text("*Atleast select one option");
			}
			else
				$("#pos-error").text("");
		
	
			let file=event.targets.files[0];

			/*if(!file)
			{
				valid="false";
				$("#res-error").value("*must attach resume");
			}
			else
			{
				if(!(file.type==='application/pdf'||file.type==='application/jpg'))
			}*/
			
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
