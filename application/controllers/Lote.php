<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Lote extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Lote_Model', 'bd');
        $this->load->model('Login_Model', 'usuario');
        $this->load->helper('form');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $dados = array("lote" => $this->bd->consultaLote());
            $this->load->view('lote', $dados);     
        }
    }

    public function loteGravar()
    {
        $dados_do_formulario = $this->input->post();
        $dados_do_formulario['idUsuario']  = $this->usuario->getUserIdByUserName(getUserName());
        if ($this->bd->loteGravar($dados_do_formulario)) {
            $dados = array(
                "dieta" => $this->bd->consultaDieta(),
                "vacina" => $this->bd->consultaVacina(),
                "tipoLote" => $this->bd->consultaTipoLote(),
                "suinoMacho" => $this->bd->consultaSuinoMacho(),
                "suinoFemea" => $this->bd->consultaSuinoFemea(),
                'editar' => 2
            );
            $this->load->view('cadastroLote',$dados);
        }
    }

    public function cadastroLotes(){
        $dados = array(
            "dieta" => $this->bd->consultaDieta(),
            "vacina" => $this->bd->consultaVacina(),
            "tipoLote" => $this->bd->consultaTipoLote(),
            "suinoMacho" => $this->bd->consultaSuinoMacho(),
            "suinoFemea" => $this->bd->consultaSuinoFemea()
        );
        $this->load->view('cadastroLote', $dados);
    }

    public function consultaLote(){
        $id = $this->input->post('idLoteFull');
        $dados = array("suino" => $this->bd->consultaLoteId($id),
                       "lote" => $this->bd->consultaInformacoesLote($id)); 
        $this->load->view('loteEditar', $dados);
        
    }

    public function consultaSuino(){
        $id = $this->input->post('idSuino');
        $idlote = $this->input->post('idLote');       
        $dados = array("suino" => $this->bd->consultaSuinoAlterarId($id),
                        "lote" => $this->bd->consultaLoteAlterarSuino($idlote));
        $this->load->view('suinoEditar', $dados);
    }
}
