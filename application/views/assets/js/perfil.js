

/* 
 * Exibe alerta de erro em permssões instrução SQL.
 */ 
function SwalSqlEditado(type)
{
	if (type == 'sucesso'){
		Swal.fire({
		type: 'success',
		title: 'Seu perfil foi editado com sucesso!',
	})
	}
	else if (type == 'erro')
	{
		Swal.fire({
			type: 'error',
			title: 'Erro ao atualizar a imagem...',
		})
	}
}