<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Lote extends CI_Controller {

function __construct(){
    parent::__construct();
    $this->load->model('Lote_Model','bd');
}

public function index()
{
    if (verify_logged() <> true){
        redirect('login','refresh');
    }
    else{
        $this->load->view('lote');
    }
}
}
