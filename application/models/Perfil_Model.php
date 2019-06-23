<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Perfil_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}

	function getPerfil($user_id){

		$command_sql = "SELECT user_first_name,
		user_login,
		user_email, 
		concat('(',user_phone_prefix,') - ',user_phone_number) as user_phone,
		user_job_role,
		user_bio,
		user_url_img
 		FROM users.profiles WHERE id_user = '".$user_id."'";

		$query = $this->db->query($command_sql);

		return $query->Result();

	}

}