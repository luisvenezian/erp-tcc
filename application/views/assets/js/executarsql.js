

/* 
 * Exibe alerta de erro em permssões instrução SQL.
 */ 
function SwalSqlError(type)
{
	if (type == 'permissao'){
		Swal.fire({
		type: 'error',
		title: 'Algo de errado aconteceu...',
		text: ' O aplicação não  permite que você faça comandos de ALTER/DROP/DELETE/UPDATE/INSERT!',
	})
	}
	else 
	{
		Swal.fire({
			type: 'error',
			title: 'Síntaxe incorreta...',
		})
	}
}