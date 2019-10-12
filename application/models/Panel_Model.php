<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Panel_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}


	function getDadosAlocacaoSuino()
	{
		$query = $this->db->query("SELECT * FROM dbo.viewResumoDaAlocacaoDosPorcosPivotada");
		return $query->Result();
	}



	function getDadosSuinoDisponiveis()
	{
		$query = $this->db->query("SELECT * FROM dbo.viewEstoqueSuinosPivotada");
		return $query->Result();
	}
	

}
