<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Suino extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Suino_Model', 'bd');
        $this->load->model('Login_Model', 'usuario');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $this->load->view('suino');
        }
    }
    public function suino()
    {
        $this->load->view('suino');
    }

    public function cadastroSuinos()
    {
        $this->load->view('cadastroSuinos');
    }

    public function suinosGravar()
    {

        $dados_do_formulario = $this->input->post(); 
        $dados_do_formulario['idUsuario'] =  $this->usuario->getUserIdByUserName(getUserName());

        if($this->bd->gravarSuinos($dados_do_formulario)){
            $data['editar'] = 2;
            $this->load->view('cadastroDietas', $data);
        }  
    }
}
