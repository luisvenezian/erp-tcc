<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Relatorio extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Lote_Model', 'bd');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $this->load->view('relatorio');
        }
    }

    public function peso()
    { 
        $dados = array("lote" => $this->bd->consultaLote());
        $this->load->view('relatorio', $dados);

    }
}
