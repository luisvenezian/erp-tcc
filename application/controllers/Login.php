<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->library('form_validation');
		$this->load->model('Login_Model','bd');
		$this->load->helper('form');
	}


	public function index()
	{	
		if (verify_logged() == true){
			redirect('panel','refresh');
		}
		else
		$this->load->view('login');
	}


	/* 
	 * Valida se o usuário existe, se sim, valida a senha e autentica o usuário
	 * a acessar o sistema.
	 * 
	 */ 
	public function autenticar()
	{

		$dados_do_formulario = $this->input->post(); 
		
		if($this->bd->validarUsuario($dados_do_formulario['usuario']))
		{
			if($this->bd->validarSenhaUsuario($dados_do_formulario['senha']))
			{
				$user_id = $this->bd->getUserIdByUserName($dados_do_formulario['usuario']);
				$this->session->set_userdata('logged', TRUE);
				$this->session->set_userdata('user_login',$dados_do_formulario['usuario']);
				$this->session->set_userdata('user_id',$user_id);
				redirect('panel','refresh');
			}
			else 
			{
				set_msg(' <strong>;(</strong> Ocorreu algum problema ao antenticar a senha!');
				redirect('login','refresh');
			}
		}
		else 
		{	
			set_msg(' <strong>;(</strong> Ocorreu algum problema ao autenticar o usuário!');
			redirect('login','refresh');
		}
	}


	public function sair()
	{
		$this->session->unset_userdata('logged');
		$this->session->unset_userdata('user_login');
		redirect('login','refresh');
	}
	
}
