

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


function helpSelect(type)
{

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

window.onload = function()
{
	var table = new Tabulator("#id_table", {});
	
	//trigger download of data.csv file
	$("#download-csv").click(function(){
		table.download("csv", "data.csv");
	});

	//trigger download of data.json file
	$("#download-json").click(function(){
		table.download("json", "data.json");
	});

	//trigger download of data.xlsx file
	$("#download-xlsx").click(function(){
		table.download("xlsx", "data.xlsx", {sheetName:"My Data"});
	});

	//trigger download of data.pdf file
	$("#download-pdf").click(function(){
		table.download("pdf", "data.pdf", {
			orientation:"portrait", 
			title:"Executarl SQL", 
		});
	});
};
