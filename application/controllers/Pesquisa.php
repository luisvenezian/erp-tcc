<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pesquisa extends CI_Controller {

function __construct(){
    parent::__construct();
    $this->load->model('Pesquisa_Model','bd');
}

public function index()
{
    if (verify_logged() <> true){
        redirect('login','refresh');
    }
    else{
        $data['pesquisa'] = $this->input->get('value');
        $user_session = getUserName();

        if ($this->bd->validaPesquisa($user_session,$data['pesquisa'])){

            $controller = $this->bd->getControllerByName($data['pesquisa']);
            
            redirect($controller,'refresh');
        }
        else {
            
            $this->load->view('pesquisa');
        }
        
    }
}
}