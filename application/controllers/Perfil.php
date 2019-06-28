<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class Perfil extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('Perfil_Model','bd');
		$this->load->helper('form','url');
	}

	public function index()
	{
		if (verify_logged() <> true){
			redirect('login','refresh');
		}
		else
		{
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
				$data['user_phone_number'] = $result_sql[0]->user_phone_number ? $result_sql[0]->user_phone_number : '';
				$data['user_phone_prefix'] = $result_sql[0]->user_phone_prefix ? $result_sql[0]->user_phone_prefix : '';
				$data['user_job_role'] = $result_sql[0]->user_job_role ? $result_sql[0]->user_job_role : ''; 
				$data['user_bio'] = $result_sql[0]->user_bio ? $result_sql[0]->user_bio : ''; 
				$data['user_url_img'] = $result_sql[0]->user_url_img ? $result_sql[0]->user_url_img : ''; 

				// Para editar troca a view
				$data_request['editar'] = $this->input->get('editar') ? $this->input->get('editar') : 0;

				if ( $data_request['editar'] == 1 )  // 0 Mostrar Perfil, 1 Editar, 2 Sucesso ao Editar, 3 Erro ao editar.
				{
					$this->load->view('perfil_editar',$data);
				}
				else 
				{
					$this->load->view('perfil',$data);
				}
			}
		}

	}

	public function gravar()
	{
		
		$user_id = getSession('user_id');
		
		$config['upload_path']          = 'application\archives';
		$config['allowed_types']        = 'jpg|png';
		$config['max_size']             = 2048; // 2MB
		$config['max_width']            = 0; // No limit size 
		$config['max_height']           = 0; // No limit size 
		$config['file_name']		    = $user_id. "_" . mt_rand(1, 99999);

		$dados_do_formulario = $this->input->post(); 

		$this->load->library('upload', $config);

		if ($this->upload->do_upload('user_file'))
		{
				$file_extension = $this->upload->data('file_ext'); 
				$file_size = $this->upload->data('file_size');
				$dados_do_formulario['user_url_img'] = $config['upload_path'] . "\\". $config['file_name'] . $file_extension;
		}
		else 
		{
			$dados_do_formulario['user_url_img'] = NULL;
		}


		if ($this->bd->atualizarPerfil($dados_do_formulario, $user_id))
		{
			$result_sql = $this->bd->getPerfil($user_id);
			$data['user_first_name'] = $result_sql[0]->user_first_name ? $result_sql[0]->user_first_name : '';
			$data['user_login'] = $result_sql[0]->user_login ? $result_sql[0]->user_login : '';
			$data['user_email'] = $result_sql[0]->user_email ? $result_sql[0]->user_email : '';
			$data['user_phone_number'] = $result_sql[0]->user_phone_number ? $result_sql[0]->user_phone_number : '';
			$data['user_phone_prefix'] = $result_sql[0]->user_phone_prefix ? $result_sql[0]->user_phone_prefix : '';
			$data['user_job_role'] = $result_sql[0]->user_job_role ? $result_sql[0]->user_job_role : ''; 
			$data['user_bio'] = $result_sql[0]->user_bio ? $result_sql[0]->user_bio : ''; 
			$data['user_url_img'] = $result_sql[0]->user_url_img ? $result_sql[0]->user_url_img : ''; 
			$data['editar'] = 2;


			// validando envio da imagem
			if (isset($file_extension))
			{

				if (($file_extension <> 'jpg') || ($file_extension <> 'png'))
				{
				$data['editar'] = 3;
				$this->load->view('perfil',$data);
				}

				else if ( $file_size > 2048)
				{
					$data['editar'] = 3;
					$this->load->view('perfil',$data);
				}
			}
			else 
			{
			$this->load->view('perfil',$data);
			}
		}
	}
}