
/* 
 * Exibe alerta de erro em permssões instrução SQL.
 */ 
function SwalSqlGravar(type)
{
	if (type == 'sucesso'){
		Swal.fire({
		type: 'success',
		title: 'Suino foi cadastrado com sucesso!',
	})
	}
	else if (type == 'erro')
	{
		Swal.fire({
			type: 'error',
			title: 'Erro ao cadastrar o suino...',
		})
	}
}