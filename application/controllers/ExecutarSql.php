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
 
			$dados_do_formulario = $this->input->post('instrucaosql'); 
			
			if (isset($dados_do_formulario)) 
			{
				$this->load->view('executarsql',$dados_do_formulario);
			}
			else 
			{
				$this->load->view('executarsql');
			}
		}
	}

}
