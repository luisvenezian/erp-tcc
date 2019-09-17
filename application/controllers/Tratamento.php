<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tratamento extends CI_Controller {

function __construct(){
    parent::__construct();
    $this->load->model('Tratamento_Model','bd');
}

public function index()
{
    if (verify_logged() <> true){
        redirect('login','refresh');
    }
    else{
        $this->load->view('tratamento');
    }
}
public function tratamento(){
    $this->load->view('tratamento');
}

}
