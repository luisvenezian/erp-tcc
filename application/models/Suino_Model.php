<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Suino_Model extends CI_Model
{

	function __construct()
	{
		parent::__construct();
	}

	function consultaOperacoes()
	{
		$query = "SELECT * FROM [base].[operacoesEstoque]";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaProdutos()
	{
		$query = "SELECT * FROM [base].[produtos]";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function inserir($dados)
	{
		$idProduto = $dados['nome'];
		$idOperacao = $dados['idOperacao'];
		$quantidade = $dados['quantidade'];
		$idUsuario = 1;
		$unidade = $dados['unidade'];
		$custo = $dados['custo'];
		$command_sql = "INSERT INTO [base].[estoques]
		([idProduto]
		,[idOperacao]
		,[quantidade]
		,[dtLancamento]
		,[idUsuario]
		,[unidade]
		,[custo])
  VALUES
		($idProduto
		,$idOperacao
		,$quantidade
		,GETDATE()
		,$idUsuario 
		,'$unidade'
		,$custo
		)";

		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	function gravarSuinos($dados)
	{
		$sexo = $dados['sexo'];
		$qtd = $dados['qtd'];
		$peso = $dados['peso'];
		$dt = $dados['dataNascimento'];
		$idUsuario = $dados['idUsuario'];
		$idMae = $dados['idMae'];
		$idLoteFull = $dados['idLoteFull'];

		$command_sql = "EXEC sp_cadastrarSuino '" . $qtd . "','" . $peso . "','" . $idUsuario . "','" . $sexo . "','" . $dt . "'";

		try {
			$this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	public function consultaLote()
	{
		$query = "SELECT DISTINCT L.idLoteFull, nomeLote FROM [controle].lotes as L,[controle].informacoesLote AS IL
					WHERE IL.idLoteFull = L.idLoteFull";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaLoteFemea()
	{
		$query = "SELECT L.idSuino FROM controle.lotes  AS L
					INNER JOIN [base].suinos AS S ON (S.idSuino = L.idSuino)
						WHERE L.idTipoLote = 2 ";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function alterarSuino($dados)
	{
		$idSuino = $dados['idSuino'];
		$idLoteFullDestino = $dados['idLoteFullDestino'];

		$query = "		EXEC sp_transferirLoteSuino_sp 
			@idSuino = $idSuino, 
			@idLoteFullDestino = $idLoteFullDestino ";
		$query = $this->db->query($query);
		return $query->result_array();
	}
}
