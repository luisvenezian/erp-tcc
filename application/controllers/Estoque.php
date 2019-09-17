<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Estoque extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Estoque_Model', 'bd');
        $this->load->helper('form');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $dados = array(
                "produtos" => $this->bd->consultaProdutos(),
                "operacoes" => $this->bd->consultaOperacoes()
            );
            $this->load->view('estoque', $dados);
        }
    }

    public function controle()
    {
        $dados = $this->input->post();
        if ($this->bd->inserir($dados)) {
            $data['editar'] = 2;
            $this->load->view('estoque', $data);
        }
    }
}
