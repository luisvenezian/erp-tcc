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
