<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class Perfil extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('Perfil_Model','bd');
	}

	public function index()
	{
		if (verify_logged() <> true){
			redirect('login','refresh');
		}
		else{

			/* Informações que devem ser passadas para view.
			 * Nome, Usuário, Biografia, Numero do Prefixo concatenado com Telefone, E-Mail e Profissão.
			 * 
			 */ 
			$user_id = getSession('user_id');
			
			if($user_id)
			{
				$result_sql = $this->bd->getPerfil($user_id);
				$data['user_first_name'] = $result_sql[0]->user_first_name ? $result_sql[0]->user_first_name : '';
				$data['user_login'] = $result_sql[0]->user_login ? $result_sql[0]->user_login : '';
				$data['user_email'] = $result_sql[0]->user_email ? $result_sql[0]->user_email : '';
				$data['user_phone'] = $result_sql[0]->user_phone ? $result_sql[0]->user_phone : '';
				$data['user_job_role'] = $result_sql[0]->user_job_role ? $result_sql[0]->user_job_role : ''; 
				$data['user_bio'] = $result_sql[0]->user_bio ? $result_sql[0]->user_bio : ''; 
				$data['user_url_img'] = $result_sql[0]->user_url_img ? $result_sql[0]->user_url_img : ''; 

				$this->load->view('perfil',$data);
			}
			
		}
	}

}