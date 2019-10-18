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
		
		$table  = "<table id='id_table' class ='table  table-striped table-bordered'>\n";
		$table .= "<thead class='thead-light'>\n";
		$table .= "<tr>\n";
			
		if ($num_rows > 0) 
		{

		foreach ($query->list_fields() as $field)
		{
			$table .= "<th scope='col'><b>".$field."</b></th>";
		}

		$table .= "</tr>\n"; 
		$table .= "</tread>\n"; 
		$table .= "<tbody>\n";
		
		$result = $query->result_array();

		for ($line = 0 ; $line < $num_rows; $line++) 
		{	
			$table .= "<tr>";
			foreach ($query->list_fields() as $field)
			{
				$table .= "<td>".$result[$line][$field]."</td>";
			}
			$table .= "</tr>";
		}
		
		$table .= "</tbody>\n";
		$table .= "</table>\n";
		}
		else 
		{
			$table .= "<th scope='col'><b> ;( Nenhum registro encontrado no banco de dados.</b></th>";
			$table .= "</tr>\n"; 
			$table .= "</table>\n";
		
		}
		return $table;
	}



	/*
	 * Função valida se a instrução SQL solicitada pelo usuário
	 * é permitida. 
	 */

	function validarSQL($command_sql){

		$command_sql = strtoupper($command_sql);

		if ( strstr( $command_sql, 'ALTER' ))
		{
			return false;
		} 
		else if ( strstr( $command_sql, 'DROP' ))
		{
			return false;
		} 
		else if ( strstr( $command_sql, 'DELETE' ))
		{
			return false;
		} 
		else if ( strstr( $command_sql, 'UPDATE' ))
		{
			return false;
		} 
		else if ( strstr( $command_sql, 'INSERT' ))
		{
			return false;
		} 
		else
		{
			return true;
		}
	}


} #EOC
