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
		$query = "SELECT P.[idProduto],P.[nomeProduto],P.[validade],VP.[qtdDisponivel] FROM [base].[produtos] as P,[viewSaldoAtualProduto] as VP
		WHERE P.[ganhoPeso] IS NOT NULL AND VP.idProduto = P.idProduto AND VP.qtdDisponivel > 0";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaVacina()
	{
		$query = "SELECT P.[idProduto],P.[nomeProduto],P.[validade],VP.[qtdDisponivel] FROM [base].[produtos] as P,[viewSaldoAtualProduto] as VP
		where P.[localAplicacao] IS NOT NULL AND VP.idProduto = P.idProduto AND VP.qtdDisponivel > 0";
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
		$qtdDieta = $dados['qtdDieta'];
		$qtdVacina = $dados['qtdVacina'];
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
					@desc = '$descricao',
					@idUsuario = $idUsuario,
					@peso = $pesoLote,
					@qtdVacina = $qtdDieta,
					@qtdDieta = $qtdVacina
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
		WHERE IL.idLote = L.idLote AND L.idTipoLote != 5";
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
		$query = "SELECT DISTINCT idLote, nome FROM [controle].lotes AS L
					WHERE not idLote =   $id";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	public function consultaLoteAlterarLote($id)
	{
		$query = "SELECT DISTINCT idLote, nome FROM [controle].lotes AS L
					WHERE not idLote =   $id";
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
		$qtd = $dados['qtdDieta'];
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
		$query = $this->db->query("EXEC sp_lancarSaidaNoEstoque 
									@idProduto = $idProduto, 
									@Qtd = $qtd, 
									@idUsuario = $idUsuario");
		return True;
	}

	public function alterarVacina($dados)
	{
		$idUsuario = $dados['idUsuario'];
		$idLote = $dados['idLote'];
		$idTipoTratamento = $dados['idTipoTratamento'];
		$idProduto = $dados['idProduto'];
		$validade = $dados['validade'];
		$qtd = $dados['qtdVacina'];
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
		$query = $this->db->query("EXEC sp_lancarSaidaNoEstoque 
									@idProduto = $idProduto, 
									@Qtd = $qtd, 
									@idUsuario = $idUsuario");
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

	function finalizarLote($dados)
	{
		$idLote = $dados['idLote'];
		$valor = $dados['valorVenda'];
		$cliente = $dados['clienteVenda'];
		$query = "EXEC sp_finalizarLoteCompleto 
					@idLote = '$idLote', 
					@valor = '$valor', 
					@cliente = '$cliente'";
		$query = $this->db->query($query);
		return True;
	}

	public function movimentacaoLote($dados){
		$idLote = $dados['idLote'];
		$idLoteDestino = $dados['idLoteDestino'];
		$query = "exec sp_transferirLote
					@idLoteOrigem = $idLote,
					@idLoteDestino = $idLoteDestino";
		$query = $this->db->query($query);
		return True;
	}
}
