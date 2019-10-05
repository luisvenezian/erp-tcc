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
            $dados = array(
                "lote" => $this->bd->consultaLote(),
                "suino" => $this->bd->consultaLoteFemea()
            );
            $this->load->view('cadastroSuinos', $dados);
        }
    }
    public function suino()
    {
        $this->load->view('suino');
    }

    public function cadastroSuinos()
    {
        $dados = array("lote" => $this->bd->consultaLote());
        $this->load->view('cadastroSuinos', $dados);
    }

    public function suinosGravar()
    {
        $dados_do_formulario = $this->input->post();
        $dados_do_formulario['idUsuario'] =  $this->usuario->getUserIdByUserName(getUserName());

        if ($this->bd->gravarSuinos($dados_do_formulario)) {
            $data['editar'] = 2;
            $this->load->view('cadastroDietas', $data);
        }
    }

    public function suinosAlterar()
    {
        $dados_do_formulario = $this->input->post();
        $id = $this->input->post('idLoteDestino');
        var_dump($this->input->post());
        $this->bd->alterarSuino($dados_do_formulario);
        $data['editar'] = 2;
        $dados = array("suino" => $this->bd->consultaLoteId($id),
                       "lote" => $this->bd->consultaInformacoesLote($id)); 
        $this->load->view('loteEditar', $dados);
    }
}
