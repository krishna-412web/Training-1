$(document).ready(function (){

	$("button").click(function(){
		//$(".tabcontent").hide("slow");
		$("button").not(this).removeClass("active");
		$(this).addClass("active");
		$("#"+$(this).attr("name")).toggle("slow");	
	});


});
