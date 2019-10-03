<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Lote_Model extends CI_Model
{

	function __construct()
	{
		parent::__construct();
	}

	function consultaDieta()
	{
		$query = "SELECT [idProduto],[nomeProduto] FROM [base].[produtos] where [ganhoPeso] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaVacina()
	{
		$query = "SELECT [idProduto],[nomeProduto] FROM [base].[produtos] where [localAPlicacao] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}


	public function consultaSuino()
	{
		$query = "SELECT [idProduto],[nomeProduto] FROM [base].[produtos] where [localAPlicacao] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaTipoLote()
	{
		$query = "SELECT [idTipoLote]
					,[descTipoLote]
					FROM [controle].[tiposLote]";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaSuinoMacho()
	{
		$query = "select count(*) from viewSuinosDisponiveis where sexo = 1";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaSuinoFemea()
	{
		$query = "select count(*) from viewSuinosDisponiveis where sexo = 0";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function loteGravar($dados)
	{
		$nome = $dados['nome'];
		$idTipoLote = $dados['idTipoLote'];
		$idDieta = $dados['idDieta'];
		$tempoUso = $dados['tempoUso'];
		$idVacina = $dados['idVacina'];
		$idUsuario = $dados['idUsuario'];
		$qtdMacho = $dados['qtdSuinoMacho'];
		$qtdFemea = $dados['qtdSuinoFemea'];
		$descricao = $dados['descricao'];

		$query = "
					exec sp_cadastrarLote 
					@Nome = '$nome',
					@idTipoLote = $idTipoLote,
					@idProdutoDieta = $idDieta,
					@idProdutoVacina = $idVacina,
					@tempoUso = $tempoUso,
					@qtdMacho = $qtdMacho,
					@qtdFemea = $qtdFemea,
					@desc = $descricao,
					@idUsuario = $idUsuario
		";
		try {
			$query = $this->db->query($query);
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

	public function consultaLoteId($id)
	{
		$query = "SELECT  L.idSuino as idSuino, S.sexo as sexo, L.idLoteFull as idLote FROM [controle].lotes as L,[base].suinos AS S
						WHERE S.idSuino = L.idSuino and L.idLoteFull =  $id ";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaInformacoesLote($id)
	{
		$query = "SELECT * FROM viewResumoDosLotes WHERE idLoteFull = $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaSuinoId($id)
	{
		$query = "SELECT  L.idSuino as idSuino, S.sexo as sexo FROM [controle].lotes as L,[base].suinos AS S
		WHERE S.idSuino = L.idSuino and L.idLoteFull =  $id ";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaSuinoAlterarId($id)
	{
		$query = "	SELECT IL.dtCadastroInfo,S.sexo ,S.idSuino,S.idMae, IL.idLoteFull, IL.nomeLote FROM base.suinos AS S
						INNER JOIN [controle].lotes AS L ON (L.idSuino = S.idSuino)
						INNER JOIN [controle].informacoesLote AS IL ON (IL.idLoteFull = L.idLoteFull)
							WHERE S.idSuino = $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}
	
	public function consultaLoteAlterarSuino($id)
	{
		$query = "SELECT DISTINCT idLoteFull, nomeLote FROM [controle].informacoesLote AS IL
		WHERE not idLoteFull = $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}
}
