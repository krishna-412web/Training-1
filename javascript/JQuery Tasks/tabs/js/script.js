$(document).ready(function (){

	$("button").click(function(){
		$(".tabcontent").hide();
		$("button").not(this).removeClass("active");
		$(this).addClass("active");
		$("#"+$(this).attr("name")).show("slow");	
	});


});
