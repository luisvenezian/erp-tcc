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



/* 
 * Carregar o resultado de uma instrução de banco de dados
 * em tabela HTML.
 */ 
function mostrarTabela($sql, $conexao){
    if (!$tabela=mysqli_query($conexao,$sql))
    echo "<script>swal('Erro ao criar conectar tabela!');</script>";
    
    $qtd_registro=mysqli_num_rows($tabela);
    
    if ($qtd_registro > 0) {
    $fields_num = mysqli_num_fields($tabela);
    
    echo "<div class='container'>\n";
    echo "<table class ='table  table-striped'><tr>\n";
    echo "<thead class='thead-light'>\n";
    echo "<tr>\n";
    #Header da Tabela é construido no for.
    for($i=0; $i<$fields_num; $i++){
        $field = mysqli_fetch_field($tabela);
        echo "<th scope='col'><b>".$field->name."</b></th>";
    }
    echo "</tr>\n"; #Fim do cabeçalho
    echo "</tread>\n"; #Primeira linha
    echo "<tbody>\n";
    #Dados tabela.
    while($linha = mysqli_fetch_row($tabela)){
        #Pega a linha como um array e as imprime dentro do for each.
        echo "<tr>";
        foreach($linha as $colunas) 
            echo "<td>$colunas</td>";
        
        echo "</tr>\n";
    }
    echo "</tbody>\n";
    echo "</table>\n";
    echo "</div>\n";
	}
}