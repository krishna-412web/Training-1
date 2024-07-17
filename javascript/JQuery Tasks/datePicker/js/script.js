$(document).ready(function (){

	$("button").click(function(){
		$("button").not(this).removeClass("active");
		$(this).addClass("active");
		$("#"+$(this).attr("name")).toggle("slow");	
	});


});
