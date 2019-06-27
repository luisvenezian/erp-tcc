<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Perfil_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}

	function getPerfil($user_id)
	{

		$command_sql = "SELECT user_first_name,
		user_login,
		user_email, 
		user_phone_number,
		user_phone_prefix,
		user_job_role,
		user_bio,
		user_url_img
 		FROM users.profiles WHERE id_user = '".$user_id."'";

		$query = $this->db->query($command_sql);

		return $query->Result();

	}

	function atualizarPerfil($dados, $user_id)
	{

		$command_sql = " UPDATE users.profiles 
		SET 
		user_first_name = '".$dados['user_first_name']."',
		user_phone_number = '".$dados['user_phone_number']."',
		user_phone_prefix = '".$dados['user_phone_prefix']."',
		user_job_role = '".$dados['user_job_role']."',
		user_bio = '".$dados['user_bio']."',
		user_url_img = iif('".$dados['user_url_img']."' = '', user_url_img, '".$dados['user_url_img']."')
		WHERE id_user = '".$user_id."'";
		
		return ($this->db->query($command_sql)) ? true : false;
	}

}