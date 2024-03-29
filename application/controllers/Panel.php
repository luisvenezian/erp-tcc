<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class Panel extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('Panel_Model','bd');
		$this->load->model('Executarsql_model','bde');
	}

	public function index()
	{
		if (verify_logged() <> true){
			redirect('login','refresh');
		}
		else{	

			$dados = array("alocacoes" => $this->bd->getDadosAlocacaoSuino(),
						   "qtd" => $this->bd->getDadosSuinoDisponiveis(),
						   "suinos" => $this->bde->getHTMLTableBySQL("SELECT * FROM dbo.viewQtdRecriasPorMae"));
			$this->load->view('panel', $dados);
			
		}
	}
}
