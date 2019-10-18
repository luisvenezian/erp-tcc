<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Relatorio extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Lote_Model', 'bd');
        $this->load->model('Executarsql_model', 'bds');
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
        $dados = array("lote" => $this->bd->consultaLote(),
                       "tipo" => "Peso");
        $this->load->view('relatorio', $dados);

    }

    public function venda()
    { 
        $tipo = array("tipo" => "Venda");
        $this->load->view('relatorioVenEst', $tipo);
    }
    public function lote(){
        $tipo = array("lote" => $this->bd->consultaLoteRelatorio(),
                         "tipo" => "lote");
        $this->load->view('relatorioLote', $tipo);
    }
    
    public function estoque()
    { 
        $tipo = array("tipo" => "Estoque");
        $this->load->view('relatorioVenEst',$tipo);
    }

    public function historicoPesagem(){
        $idLote = $this->input->post('idLote');
        $result = array('result' => $this->bds->getHTMLTableBySQL("SELECT pl.idPesagemLote as 'ID Peso', pl.idLote as 'ID Lote', u.usuario as Usuario, pl.dtPesagem as 'Data Pesagem', pl.pesoG as 'Peso Lote' 
                                                                    FROM controle.pesosLote pl
                                                                        INNER JOIN base.usuarios u on u.idUsuario = pl.idUsuario
                                                                            WHERE idLote = $idLote or -1 = $idLote
                                                                                ORDER BY pl.idPesagemLote DESC "));
        $this->load->view('relatorioExibir', $result); 
    }

    public function historicoVenda(){
        $dataInicio = $this->input->post('dataInicio');
        $dataFinal = $this->input->post('dataFinal');
        $query = "SELECT * FROM viewVendas WHERE dtVenda >= '$dataInicio' AND dtVenda <= '$dataFinal'";
        $result = array('result' => $this->bds->getHTMLTableBySQL($query));
        $this->load->view('relatorioExibir', $result); 
    }

    public function historicoEstoque(){
        $dataInicio = $this->input->post('dataInicio');
        $dataFinal = $this->input->post('dataFinal');
        $query = "SELECT * FROM viewLancamentosEstoque WHERE dtLancamento >= '$dataInicio' AND dtLancamento <= '$dataFinal'";
        $result = array('result' => $this->bds->getHTMLTableBySQL($query));
        $this->load->view('relatorioExibir', $result); 
    }

    public function historicoLote(){
        $idLote = $this->input->post('idLote');
        $query = "SELECT * FROM rlc.loteSuinos WHERE idLote = $idLote or -1 = $idLote";
        $query2 = "SELECT * FROM viewTratamentos WHERE idLote = $idLote or -1 = $idLote";
        $result = array('result' => $this->bds->getHTMLTableBySQL($query),
                        'result2' => $this->bds->getHTMLTableBySQL($query2));
        $this->load->view('relatorioExibirLote', $result); 
    }
}

