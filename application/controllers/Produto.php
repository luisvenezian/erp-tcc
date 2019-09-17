<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Produto extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Produto_Model','bd');
        $this->load->helper('form');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $this->load->view('produto');
        }
    }

    public function vacina(){
        $dados = array("produtos" => $this->bd->consultaVacina());
        $this->load->view('vacina', $dados);
    }

    
    public function vacinaConsultar(){
        $id = $this->input->post();
        $dados = array("produto" => $this->bd->consultaVacinaId($id));
        $this->load->view('vacinaEditar', $dados);

    }

    public function vacinaAtualizar(){
        $dados = $this->input->post();
        if($this->bd->vacinaAtualizar($dados)){
            $data['editar'] = 2;
            $this->load->view('vacina', $data);
        }
    }

    public function vacinaExcluir(){
        $dados = $this->input->post();
        if($this->bd->vacinaExcluir($dados)){
            $data['editar'] = 2;
            $this->load->view('vacina', $data);
        }
    }

    public function dietaConsultar(){
        $id = $this->input->post();
        $dados = array("produto" => $this->bd->consultaDietaId($id));
        $this->load->view('dietaEditar', $dados);

    }
    
    public function dieta(){
        $dados = array("produtos" => $this->bd->consultaDieta());
        $this->load->view('dieta', $dados);
    }

    public function dietaExcluir(){
        $dados = $this->input->post();
        if($this->bd->dietaExcluir($dados)){
            $data['editar'] = 2;
            $this->load->view('dieta', $data);
        }
    }

    public function dietaAtualizar(){
        $dados = $this->input->post();
        if($this->bd->dietaAtualizar($dados)){
            $data['editar'] = 2;
            $this->load->view('dieta', $data);
        }
    }

    public function cadastroVacinas()
    {
        $this->load->view('cadastroVacinas');
    }

    public function cadastroDietas(){
        $this->load->view('cadastroDietas');
    }

    public function dietasGravar()
    {
        $dados_do_formulario = $this->input->post(); 
        if($this->bd->gravarDieta($dados_do_formulario)){
            $data['editar'] = 2;
            $this->load->view('cadastroDietas', $data);
        }  
    }
    
    public function vacinasGravar()
    {
        $dados_do_formulario = $this->input->post(); 
        if($this->bd->gravarVacina($dados_do_formulario)){
            $data['editar'] = 2;
            $this->load->view('cadastroVacinas', $data);
        }  
    }


}
