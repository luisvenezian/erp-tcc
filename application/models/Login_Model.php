<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	public function validarUsuario($user)
	{
		$command_sql = "SELECT TOP 1 * FROM users.profiles WHERE user_login = '".$user."'";
		$query = $this->db->query($command_sql);
		return ($query->num_rows() == 1) ? true : false;
	}

	public function validarSenhaUsuario($passworduser)
	{
		$command_sql = "SELECT TOP 1 * FROM users.profiles WHERE user_password = '".$passworduser."'";
		$query = $this->db->query($command_sql);
		return ($query->num_rows() == 1) ? true : false;
	}

	public function getUserIdByUserName($user_name){
		$command_sql = "SELECT TOP 1 ID_USER FROM users.profiles WHERE user_login = '".$user_name."'";
		$query = $this->db->query($command_sql);

		foreach ($query->result() as $row)
		{
				$result = $row->ID_USER;
		}
		return $result;
	}
}
