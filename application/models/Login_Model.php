<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	public function validarUsuario($user)
	{
		$this->db->where('usuario',$user);
		$query = $this->db->get('sys_usuario', 1);

		return ($query->num_rows() == 1) ? true : false;
	}

	public function validarSenhaUsuario($passworduser)
	{
		$this->db->where('senha',$passworduser);
		$query = $this->db->get('sys_usuario', 1);

		return ($query->num_rows() == 1) ? true : false;
	}

}
