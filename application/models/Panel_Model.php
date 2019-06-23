<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Panel_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	public function getApplicacoes($user)
	{
		$command_sql = "SELECT A.APP_NAME, A.ID_APP 
						FROM [users].[concessions] AS P
						JOIN [si].[applications] AS A ON A.ID_APP = P.APP_ID 
						JOIN [users].[profiles] AS UP ON UP.ID_USER = P.USER_ID
						WHERE UP.[user_login] = '".$user."'";

		$query = $this->db->query($command_sql);
		return $query->result();
	}

}
