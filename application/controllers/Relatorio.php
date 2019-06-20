<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Relatorio extends CI_Controller {

function __construct(){
    parent::__construct();
}

public function index()
{
    if (verify_logged() <> true){
        redirect('login','refresh');
    }
    else{
        $this->load->view('relatorio');
    }
}
}
