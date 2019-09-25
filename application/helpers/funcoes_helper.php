<?php
defined('BASEPATH') OR exit('No direct access allowed');

if (!function_exists('set_msg')){

	function set_msg($msg=null){
		$ci = & get_instance();
		$ci->session->set_userdata('aviso',$msg);
	}

}

if (!function_exists('get_msg')){

	function get_msg($destroy=TRUE){
		$ci = & get_instance();
		$result = $ci->session->userdata('aviso');
		if($destroy) $ci->session->unset_userdata('aviso');
		return $result;
	}
}

if (!function_exists('verifica_login')){
	function verifica_login($redirect='login'){
		$ci = & get_instance();
		if($ci->session->userdata('logged') <> TRUE)
		{
			set_msg('<strong> ;( </strong> O acesso ao painel falhou. Tente Novamente. ');
			redirect($redirect,'refresh');
		}
	}
}

if (!function_exists('verify_logged')){
	function verify_logged($redirect='login'){
		$ci = & get_instance();
		return ($ci->session->userdata('logged') == TRUE) ? TRUE : FALSE;
	}
}

if (!function_exists('getUserName')){

	function getUserName()
	{
		$ci = & get_instance();
		return $ci->session->userdata('user_login'); 
	}
}


 /* 
  * Retorna o parâmetro passado na sessão;
  *
  */

if (!function_exists('getSession')){

	function getSession($param)
	{
		$ci = & get_instance();
		return $ci->session->userdata($param); 
	}
}

/* 
 * Aplicaçoes do Usuário,
 * Todas as aplicações que o usuário pode acessar, influencia as pesquisas.
 */ 

if (!function_exists('setApplicationsUser')){
	
	function setApplicationsUser($data=null){
		$ci = & get_instance();
		$ci->session->set_userdata('applications',$data);
	}

}

if (!function_exists('getApplicationsUser')){
	function getApplicationsUser(){
		$ci = & get_instance();
		return $ci->session->userdata('applications');
	}
}

/* 
 * Carrega uma option list com id histórico de buscas.
 */

if (!function_exists('getHistoryList')){
	function getHistoryList(){
		$data = getApplicationsUser(); 
		$option = ""; 
		$i = 0;
	
		foreach($data as $row){
			$option .= "\n\t<option value = '". $data[$i]->APP_NAME ."'></option>";
			$i++;
		}
		return $option;
	}
}


/* 
 * Carregar um item class nav link ou nav link active
 * para iluminar icone no sidebar do sistema.
 */ 

if (!function_exists('getNavLinkType')){
	
	function getNavLinkType($controller, $param){

		if ($controller == $param)
			$result = " class='nav-link active' ";	
		else 
			$result = " class='nav-link' ";

		return $result;
	}
}