$(document).ready(() => {
	
	var obj;
	$.ajax({
		url: './components/database.cfc?method=selectdata',
		type: 'GET',
		success: function(data) 
		{	
			obj= JSON.parse(data);
			console.log(obj);
			let tab="";
			let tabContent="";
			if (obj.DATA == '') 
			{
				alert('Add pages');
			} 
			else 
			{
				tabContent="";
				let row = ""
				let j = 0;
				for(let i=0;i< obj.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu no-print"><img style="height:40px;width:40px;padding:0;margin:0 auto;" src="${obj[i].profile}" class="img-fluid" alt="pic"/></td>\n`+
						`<td class="menu">${obj[i].firstname+" "+obj[i].lastname}</td>\n`+
						`<td class="menu">${obj[i].email}</td>\n`+
						`<td class="menu">${obj[i].phone}</td>\n`;
					row +=  `<td>\n<button type="button" class=" btn btn-sm btn-success view no-print" data-bs-toggle="modal" data-bs-target="#myModal">View</button></td>\n`+
						`<td><button type="button" class=" btn btn-sm btn-success edit no-print" data-bs-toggle="modal" data-bs-target="#myModal">Edit</button></td>`+
						`<td>
							<form action="" method="post" id="form${i+1}">
								<input type="hidden" name="logId" id="inp${i+1}"/>
								<button type="submit" class=" btn btn-sm btn-success delete no-print" name="delete">Delete</button>
							</form>
						</td>`;
					tabContent+= `<tr id="${obj[i].log_id}">`+row+`</tr>\n`;
					row="";							
				}
				$("#pageDisplay").html(tabContent);
			}
		}
		
	});

	$("#pdfFeature").click(function(){
		window.location.href="pdfFeature.cfm";
	});
	
	$("#excelFeature").click(function(){
		window.location.href="excelFeature.cfm";
	});
	
	$("#printFeature").click(function(){
        	window.print();
	});

	$(document).on('click', '[data-bs-toggle="modal"]', function() {
		console.log(obj);
		var button = $(this);
		var buttonClass = button.attr('class'); 
		if (buttonClass.includes('add')) {
			$('.content-div').hide();
            		$('#addDiv').show();

       		} 
		if (buttonClass.includes('edit')) {
                       	$('.content-div').hide();
			let i = $(this).parent().parent().children().first().html();
			let j = $(this).parent().parent().attr('id');
			let rowSelected = obj[i-1];
			$("#logId1").val(j);
			$("#title1").val(rowSelected.title);
			$("#firstName1").val(rowSelected.firstname);
			$("#lastName1").val(rowSelected.lastname);
			$("#gender1").val(rowSelected.gender);
			let date = new Date(rowSelected.dob);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			$("#dob1").val(formatdate);
			$("#houseName1").val(rowSelected.house_flat);
			$("#street1").val(rowSelected.street);
			$("#city1").val(rowSelected.city);
			$("#state1").val(rowSelected.state);
			$("#pincode1").val(rowSelected.pincode);
			$("#email1").val(rowSelected.email);
			$("#phone1").val(rowSelected.phone);
			
            		$('#editDiv').show();
        	} 	
		if (buttonClass.includes('view')) {
            		$('.content-div').hide();
			let i = $(this).parent().parent().children().first().html();
			let rowSelected = obj[i-1];

			$("#title1").val(rowSelected.title);
			let title = $('#title1 option:selected').text();
			$("#gender1").val(rowSelected.gender);
			let gender = $('#gender1 option:selected').text();
			let date = new Date(rowSelected.dob);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			let address = `${rowSelected.house_flat},${rowSelected.street},<br>${rowSelected.city},${rowSelected.state}`;
			
			$("#profilePic").attr('src',`${rowSelected.profile}`);

			let name = `${title} ${rowSelected.firstname} ${rowSelected.lastname}`;
			$("#nameView").text(name);
			$("#genderView").text(gender);
			$("#dobView").text(formatdate);
			$("#AddressView").html(address);
			$("#pincodeView").text(rowSelected.pincode);
			$("#mailView").text(rowSelected.email);
			$("#phoneView").text(rowSelected.phone);
			
			
			$('#viewDiv').show();
       	 	}
		
	});
		
	$(document).on('click','.delete', function(event) {
		let row = $(this).parent().parent().parent().attr('id');
		let i = $(this).parent();
		let inp = i.children().first();
		inp.attr('value',row);
		alert(inp.attr('value'))
		$(i).submit();

	});
	

});
