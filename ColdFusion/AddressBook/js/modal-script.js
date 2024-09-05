$(document).ready(() => {
	
	var obj;
    	// Open the modal and show the respective content
    	/*$("#btnAdd").click(function() {
        	$("#myModal").modal('show');
		$(".content-div").hide();
        	$("#addDiv").show();
    	});
	
    	$(".edit").click(function() {
        	$("#myModal").modal('show');
		$(".content-div").hide();
        	$("#editDiv").show();
    	});

   	$("#btnView").click(function() {
        	$("#myModal").modal('show');
		$(".content-div").hide();
       		$("#viewDiv").show();
    	});
	
	$("#myForm1").submit(function(event) {
		
		event.preventDefault();
		let imgPath = $("#profile").val();
		let title = $("#title").val();
		let firstName = $("#firstName").val();
		let secondName = $("#secondName").val();
		alert(imgPath);
	});*/

	
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
						`<td><button type="button" class=" btn btn-sm btn-success">Delete</button></td>`;
					tabContent+= `<tr id="${i+1}">`+row+`</tr>\n`;
					row="";					
					console.log(tabContent);		
				}
				$("#pageDisplay").html(tabContent);
			}
		}
		
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
			let log_id = rowSelected[0];
			$("#title1").val(rowSelected[1]);
			$("#firstName1").val(rowSelected[2]);
			$("#secondName1").val(rowSelected[3]);
			$("#gender1").val(rowSelected[4]);
			let date1 = Date.parse(rowSelected[5]);
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
            		$('#viewDiv').show();
       	 	}
	});
		
	/*$(document).on('click','.menu', function(event) {
		let parentId= $(event.target).parent().attr('id');
		$.ajax({
			url: './database.cfc?method=viewdata',
			type: 'POST',
			data: { id: parentId },
			success: function(response) 
			{
				if(response){
					window.open('output.cfm','_blank');
				}	
			}
		});


	});

		
	$(document).on('click','.editbtn', function(event) {
		let parentId= $(event.target).parent().parent().attr('id');
		$.ajax({
			url: './database.cfc?method=getid',
			type: 'POST',
			data: { id: parentId },
			success: function(response) 
			{
				if(response){
					window.location.href='edit.cfm';
				}	
			}
		});
	});

	$(document).on('click','.deletebtn', function(event) {
		let parentId= $(event.target).parent().parent().attr('id');
		$.ajax({
			url: './database.cfc?method=getid',
			type: 'POST',
			data: { id: parentId },
			success: function(response) 
			{	if(response == 1)
				{	
					$.ajax({
							url: './database.cfc?method=deletePage',
							type: 'GET',
							success: function(data) 
							{
								if(data == 1)
								{
									alert("page deleted successfully");
								}	
			
							}
		
					});
				}
			}
		
		});
		window.location.href= 'welcome.cfm';
	});*/
	

});
