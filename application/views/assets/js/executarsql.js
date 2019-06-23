

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


function helpSelect(type){

	if (type == 'qualificacoes')
	{
		document.getElementById("txtarea").value = "SELECT * FROM [dbo].[qualificacoes]";
	}
	else if (type == 'ocorrencias')
	{
		document.getElementById("txtarea").value = "SELECT * FROM [dbo].[fat_ocorrencia]";
	}
	else if (type == 'operacoes')
	{
		document.getElementById("txtarea").value = "SELECT * FROM [dbo].[ext_operacao]";
	}
	else if (type == 'bi')
	{
		document.getElementById("txtarea").value = "SELECT * FROM [dbo].[dados_bi]";
	}
	else if (type == 'usuarios')
	{
		document.getElementById("txtarea").value = "SELECT * FROM [dbo].[sys_usuario] WHERE [usuario] = 'INSERIR_USUARIO'";
	}
	else if (type == 'clear')
	{
		document.getElementById("txtarea").value = "";
	}
}