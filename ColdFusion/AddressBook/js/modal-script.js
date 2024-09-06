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
				for(let i=0;i< obj.DATA.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu">${obj.DATA[i][2]+" "+obj.DATA[i][3]}</td>\n`+
						`<td class="menu">${obj.DATA[i][12]}</td>\n`+
						`<td class="menu">${obj.DATA[i][13]}</td>\n`;
					row +=  `<td>\n<button type="button" class=" btn btn-sm btn-success view" data-bs-toggle="modal" data-bs-target="#myModal">View</button></td>\n`+
						`<td><button type="button" class=" btn btn-sm btn-success edit" data-bs-toggle="modal" data-bs-target="#myModal">Edit</button></td>`+
						`<td><button type="button" class=" btn btn-sm btn-success delete">Delete</button></td>`;
					tabContent+= `<tr id="${i+1}">`+row+`</tr>\n`;
					row="";					
					console.log(tabContent);		
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
			let rowSelected = obj.DATA[i-1];
			$("#logId").val(rowSelected[0]);
			$("#title1").val(rowSelected[1]);
			$("#firstName1").val(rowSelected[2]);
			$("#secondName1").val(rowSelected[3]);
			$("#gender1").val(rowSelected[4]);
			let date = new Date(rowSelected[5]);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			$("#dob1").val(formatdate);
			$("#houseName1").val(rowSelected[7]);
			$("#street1").val(rowSelected[8]);
			$("#city1").val(rowSelected[9]);
			$("#state1").val(rowSelected[10]);
			$("#pincode1").val(rowSelected[11]);
			$("#email1").val(rowSelected[12]);
			$("#phone1").val(rowSelected[13]);
			
            		$('#editDiv').show();
        	} 	
		if (buttonClass.includes('view')) {
            		$('.content-div').hide();
			let i = $(this).parent().parent().children().first().html();
			let rowSelected = obj.DATA[i-1];
			$("#title1").val(rowSelected[1]);
			let title = $('#title1 option:selected').text();
			$("#gender1").val(rowSelected[4]);
			let gender = $('#gender1 option:selected').text();
			let date = new Date(rowSelected[5]);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			let address = `${rowSelected[7]},${rowSelected[8]},<br>${rowSelected[9]},${rowSelected[10]}`;
			
			let name = `${title} ${rowSelected[2]} ${rowSelected[3]}`;
			$("#nameView").text(name);
			$("#genderView").text(gender);
			$("#dobView").text(formatdate);
			$("#AddressView").html(address);
			$("#pincodeView").text(rowSelected[11]);
			$("#mailView").text(rowSelected[12]);
			$("#phoneView").text(rowSelected[13]);
			
			
			$('#viewDiv').show();
       	 	}
		/*if(buttonClass.includes('delete')) {
			$('.content-div').hide();
			let i = $(this).parent().parent().children().first().html();
			let rowSelected = obj.DATA[i-1];
			$.ajax({
				url: './database.cfc?method=deletePage',
				type: 'POST',
				data: { logId: rowSelected[0] },
				success: function(response) 
				{
					if(response == 1)
					{
						alert("page deleted successfully");
					}	
			
				}
		
				});		
			window.location.href= 'welcome.cfm';
		}*/
	});
		
		$(document).on('click','.delete', function(event) {

		let i = $(this).parent().parent().children().first().html();
		let rowSelected = obj.DATA[i-1];
		alert(rowSelected[0]);
		$.ajax({
				url: './components/database.cfc?method=deleteContact',
				type: 'POST',
				data: { logId: rowSelected[0] },
				success: function(response) 
				{
					if(response == 1)
					{
						alert("page deleted successfully");
					}	
			
				}
				
			});
		window.location.href= 'welcome.cfm';
	});
	

});
