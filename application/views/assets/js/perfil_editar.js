
// Limita input operadora de telefone para receber apenas 3 números.
	$(document).ready(function() {
	$("#user_prefix_id").keyup(function() {
		$("#user_prefix_id").val(this.value.match(/[0-9]*/));
	});
	});

// Limita input telefone para receber apenas 9 números.
	$(document).ready(function() {
	$("#user_phone_id").keyup(function() {
		$("#user_phone_id").val(this.value.match(/[0-9]*/));
	});
	});