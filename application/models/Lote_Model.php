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
		$query = "SELECT [idProduto],[nomeProduto],[validade] FROM [base].[produtos] where [ganhoPeso] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaVacina()
	{
		$query = "SELECT [idProduto],[nomeProduto],[validade] FROM [base].[produtos] where [localAPlicacao] IS NOT NULL";
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
		$validadeVacina = $dados['validadeVacina'];
		$validadeDieta = $dados['validadeDieta'];
		$vencimentoLote = new DateTime($dados['vencimentoLote']);
		$idVacina = $dados['idVacina'];
		$idUsuario = $dados['idUsuario'];
		$qtdMacho = $dados['qtdSuinoMacho'];
		$qtdFemea = $dados['qtdSuinoFemea'];
		$descricao = $dados['descricao'];
		$pesoLote = $dados['pesoLote'];
		$vencimentoLote = ($vencimentoLote->format('Y-m-d h:m:s'));
		$dataAtual = new DateTime();
		$dataAtual = $dataAtual->format('Y-m-d');
		$query = "
					exec sp_cadastrarLote 
					@Nome = '$nome',
					@idTipoLote = $idTipoLote,
					@dtVencimentoLote = '$vencimentoLote',
					@idProdutoDieta = $idDieta,
					@idProdutoVacina = $idVacina,
					@dtInicioAplicacaoDieta = '$dataAtual',
					@dtFimAplicacaoDieta = '$validadeDieta',
					@dtInicioAplicacaoVacina = '$dataAtual',
					@dtFimAplicacaoVacina = '$validadeVacina',
					@qtdMacho = $qtdMacho,
					@qtdFemea = $qtdFemea,
					@desc = $descricao,
					@idUsuario = $idUsuario,
					@peso = $pesoLote
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
		$query = "SELECT DISTINCT L.idLote, L.nome as nomeLote FROM [controle].lotes as L,[rlc].loteSuinos AS IL
		WHERE IL.idLote = L.idLote";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaLoteId($id)
	{
		$query = " SELECT L.idSuino AS idSuino, 
						S.sexo AS sexo, 
						L.idLote AS idLote
				FROM [rlc].loteSuinos AS L, 
					[base].suinos AS S
				WHERE S.idSuino = L.idSuino
					AND L.idLote = $id
					AND L.dtSaidaSuino IS NULL
				ORDER BY L.idSuino";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaInformacoesLote($id)
	{
		$query = "EXEC sp_resumoDoLote @idLote = $id";
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
		$query = "SELECT L.dtCriacaoLote as dtEntradaSuino ,S.sexo ,S.idSuino,S.idMae, L.idLote, L.nome as nomeLote FROM base.suinos AS S
							INNER JOIN [rlc].loteSuinos AS LS ON (LS.idSuino = S.idSuino)
							INNER JOIN [controle].lotes AS L ON (L.idLote = LS.idLote)
								WHERE S.idSuino = $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaLoteAlterarSuino($id)
	{
		$query = "SELECT DISTINCT idLote, nomeLote FROM [controle].informacoesLote AS IL
					WHERE not idLote =  $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function alterarPeso($dados)
	{
		$idUsuario = $dados['idUsuario'];
		$idLote = $dados['idLote'];
		$peso = $dados['pesoLote'];
		$query = "INSERT INTO [controle].[pesosLote]
		([idLote]
		,[idUsuario]
		,[dtPesagem]
		,[pesoG])
  VALUES
		('$idLote'
		,'$idUsuario'
		,GETDATE()
		,$peso)";
		$query = $this->db->query($query);
		return True;
	}

	public function alterarDieta($dados)
	{
		$idUsuario = $dados['idUsuario'];
		$idLote = $dados['idLote'];
		$idTipoTratamento = $dados['idTipoTratamento'];
		$idProduto = $dados['idProduto'];
		$validade = $dados['validade'];
		$query = "INSERT INTO [controle].[tratamentosLote]
		([idLote]
		,[idProduto]
		,[idTipoTratamento]
		,[dtInicioAplicacao]
		,[dtFimAplicacao])
  VALUES
		('$idLote'
		,'$idProduto'
		,'$idTipoTratamento'
		,GETDATE()
		,'$validade')";
		$query = $this->db->query($query);
		return True;
	}

	public function alterarVacina($dados)
	{
		$idUsuario = $dados['idUsuario'];
		$idLote = $dados['idLote'];
		$idTipoTratamento = $dados['idTipoTratamento'];
		$idProduto = $dados['idProduto'];
		$validade = $dados['validade'];
		$query = "INSERT INTO [controle].[tratamentosLote]
		([idLote]
		,[idProduto]
		,[idTipoTratamento]
		,[dtInicioAplicacao]
		,[dtFimAplicacao])
  VALUES
		('$idLote'
		,'$idProduto'
		,'$idTipoTratamento'
		,GETDATE()
		,'$validade')";
		$query = $this->db->query($query);
		return True;
	}

	function consultaDietaId($id)
	{
		$query = "SELECT validade FROM [base].[produtos] where [idProduto] = $id";
		$query = $this->db->query($query);
		return $query->row(1);
	}

	function consultaVacinaId($id)
	{
		
		$query = "SELECT validade FROM [base].[produtos] where [idProduto] = $id";
		$query = $this->db->query($query);
		return $query->row(1);
	}


}
