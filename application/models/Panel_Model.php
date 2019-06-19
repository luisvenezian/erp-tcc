<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Panel_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	public function getApplicacoes($user)
	{
		$command_sql = "SELECT A.APP_NAME, A.APP_ID 
						FROM [users].[permission] AS P
						JOIN [si].[application] AS A ON A.APP_ID = P.APP_ID
						WHERE P.[user_name] = '".$user."'";
		$query = $this->db->query($command_sql);
		
		return $query->result();
	}

}
