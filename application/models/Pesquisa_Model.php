<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pesquisa_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}

    public function validaPesquisa($user, $search)
	{
        $command_sql = "SELECT TOP 2 *
                        FROM [users].[concessions] AS P
                        JOIN [si].[applications] AS A ON A.ID_APP = P.APP_ID
                        JOIN [users].[profiles] AS UP ON UP.ID_USER = P.USER_ID 
                        WHERE UP.[user_login] = '".$user."' AND A.[APP_NAME] = '".$search."'";

        $query = $this->db->query($command_sql);
        
        return ($query->num_rows() == 1) ? true : false;
    }
    
    public function getControllerByName($search){

        $command_sql = "SELECT TOP 1 APP_NAME_CONTROLLER FROM [si].[applications] WHERE [APP_NAME] = '".$search."'";
        $query = $this->db->query($command_sql);
        $array = $query->result_array(); 

        return $array['0']['APP_NAME_CONTROLLER'];
    }

    
    /*
     * Carrega uma lista de aplicações que possuem parte do nome
     * que o usuário buscou com link.
     */ 
    public function validaPesquisaIncompleta($user, $search)
	{
        $command_sql = "SELECT *
                        FROM [users].[permission] AS P
                        JOIN [si].[application] AS A ON A.APP_ID = P.APP_ID
                        WHERE P.[user_name] = '".$user."' AND A.[APP_NAME] LIKE '%".$search."'%";

        $query = $this->db->query($command_sql);
        
        return ($query->num_rows() == 1) ? true : false;
    }


}
