$(document).ready(() => {
	
	$("#add").click(() => {
		window.location.href= 'add.cfm';
	});
	
	$.ajax({
		url: './database.cfc?method=selectdata',
		type: 'GET',
		success: function(data) 
			{
				let obj= JSON.parse(data);
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
						row += "<td>"+obj.DATA[i][0]+"</td>\n";
						row += "<td>"+obj.DATA[i][1]+"</td>\n";
						tabContent+= "<tr>\n"+row+"<tr>\n";
						row="";
					}
					console.log(tabContent);		
				}
				tab="<table border=\"1px solid black\">"+tabContent+"</table>";
				$("#pageDisplay").html(tab);
			}
		});

});
