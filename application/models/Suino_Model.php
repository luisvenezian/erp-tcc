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
		$command_sql = "EXEC sp_cadastrarSuino
							@qtd = $qtd,
							@peso = $peso,
							@idUsuario = $idUsuario,
							@sexo = $sexo,
							@dtNascimento = '$dt',
							@idMae = $idMae,
							@idLote = $idLoteFull";
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
		$query = "SELECT DISTINCT idLote, nome as  nomeLote FROM [controle].lotes";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaLoteFemea()
	{
		$query = "SELECT L.idSuino
		FROM rlc.loteSuinos L
			INNER JOIN [base].suinos AS S ON(S.idSuino = L.idSuino)
			INNER JOIN controle.lotes AS cl on cl.idLote = L.idLote
		WHERE cl.idTipoLote = 2";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function alterarSuinoLocalidade($dados)
	{
		$idSuino = $dados['idSuino'];
		$idLoteDestino = $dados['idLoteDestino'];
		$query = "		EXEC sp_transferirLoteSuino_sp 
		 	@idSuino = $idSuino, 
		 	@idLoteDestino = $idLoteDestino ";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function alterarSuinoMorte($dados)
	{
		$idSuino = $dados['idSuino'];
		$descMorte = $dados['descMorte'];
		$dataAtual = new DateTime();
		$dataAtual = $dataAtual->format('Y-m-d');
		$query = "EXEC sp_informarMorteSuino 
					@idSuino = '$idSuino', 
					@dataObito = '$dataAtual', 
					@msg = '$descMorte'";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaInformacoesLote($id)
	{
		$query = "EXEC sp_resumoDoLote @idLote = $id";
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
}
