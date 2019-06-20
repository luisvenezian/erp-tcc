<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class ExecutarSql extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('ExecutarSql_Model','bd');
		$this->load->helper('form');
	}

	public function index()
	{
		if (verify_logged() <> true){
			redirect('login','refresh');
		}
		else{
 
			$dados_do_formulario['instrucaosql'] = $this->input->post('instrucaosql'); 

			if (!is_null($dados_do_formulario['instrucaosql'])) 
			{
				$result_sql['table'] = $this->bd->getHTMLTableBySQL($dados_do_formulario['instrucaosql']);
				
				$this->load->view('executarsql',$result_sql);
			}
			else 
			{
				$this->load->view('executarsql');
			}
		}
	}

}
