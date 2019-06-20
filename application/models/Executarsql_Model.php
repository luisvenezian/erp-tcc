<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ExecutarSql_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}


	/* 
	* Carregar o resultado de uma instrução de banco de dados
	* em tabela HTML.
	*/ 
	function getHTMLTableBySQL($command_sql){
		

		$query = $this->db->query($command_sql);

		$num_rows = $query->num_rows();
		

		if ($qtd_registro > 0) {

		$table  = "<table class ='table  table-striped'><tr>\n";
		$table .= "<thead class='thead-light'>\n";
		$table .= "<tr>\n";
	
		foreach ($query->list_fields() as $field)
		{
			$table .= "<th scope='col'><b>".$field."</b></th>";
		}

		$table  = "</tr>\n"; 
		$table .= "</tread>\n"; 
		$table .= "<tbody>\n";
		
		/*
		while($linha = mysqli_fetch_row($tabela)){
			$table .= "<tr>";
			foreach($linha as $colunas) 
				echo "<td>$colunas</td>";
			
			echo "</tr>\n";
		}
		*/
		$table .= "</tbody>\n";
		$table .= "</table>\n";
		}

		return $table;
	}
}