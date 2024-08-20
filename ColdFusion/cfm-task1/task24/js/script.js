 $(document).ready(function() {
	$('#check').click(function() {
		var email = $('#email').val();
		$.ajax({
			url: './logic24.cfc?method=checkmail',
			type: 'POST',
			data: { email: email },
			success: function(response) {
				if (response.trim() == '\"exists\"') {
					alert('Mail ID is already there');
					$('#submit').prop('disabled', true);
				} else {
					$('#submit').prop('disabled', false);
				}
			}
		});
	});
});