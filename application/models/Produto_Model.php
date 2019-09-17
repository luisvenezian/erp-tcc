<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Produto_Model extends CI_Model
{

	function __construct()
	{
		parent::__construct();
	}

	function consultaVacina()
	{
		$query = "SELECT [idProduto],[nomeProduto] FROM [base].[produtos] where [localAPlicacao] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaVacinaId($id)
	{
		$id = $id['nome'];
		$query = "SELECT * FROM [base].[produtos] where [idProduto] = $id";
		$query = $this->db->query($query);
		return $query->row(1);
	}

	public function vacinaExcluir($id)
	{
		$id = $id['id'];
		$command_sql = "DELETE FROM [base].[produtos] WHERE [idProduto] = $id";
		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	public function vacinaAtualizar($dados)
	{
		$nome = $dados['nome'];
		$local = $dados['local'];
		$fabricante = $dados['fabricante'];
		$validade = $dados['validade'];
		$descricao = $dados['descricao'];
		$unidade = $dados['unidade'];
		$id = $dados['id'];
		$command_sql = " UPDATE [base].[produtos]
		SET [dtCadastro] = GETDATE()
		   ,[nomeProduto] = '$nome'
		   ,[localAplicacao] = '$local'
		   ,[fabricante] = '$fabricante'
		   ,[validade] = '$validade'
		   ,[descricao] = '$descricao'
		   ,[unidade] = '$unidade'
		   ,[ganhoPeso] = null
	  WHERE [idProduto] = '$id'
	  ";
		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	function consultaDieta()
	{
		$query = "SELECT [idProduto],[nomeProduto] FROM [base].[produtos] where [ganhoPeso] IS NOT NULL";
		$query = $this->db->query($query);
		return $query->result_array();
	}

	function consultaDietaId($id)
	{
		$id = $id['nome'];
		$query = "SELECT * FROM [base].[produtos] where [idProduto] = $id";
		$query = $this->db->query($query);
		return $query->row(1);
	}

	public function dietaExcluir($id)
	{
		$id = $id['id'];
		$command_sql = "DELETE FROM [base].[produtos] WHERE [idProduto] = $id";
		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	public function dietaAtualizar($dados)
	{
		$nome = $dados['nome'];
		$fabricante = $dados['fabricante'];
		$validade = $dados['validade'];
		$descricao = $dados['descricao'];
		$unidade = $dados['unidade'];
		$ganhoPeso = $dados['ganhoPeso'];
		$id = $dados['id'];
		$command_sql = " UPDATE [base].[produtos]
		SET [dtCadastro] = GETDATE()
		   ,[nomeProduto] = '$nome'
		   ,[localAplicacao] = null
		   ,[fabricante] = '$fabricante'
		   ,[validade] = '$validade'
		   ,[descricao] = '$descricao'
		   ,[unidade] = '$unidade'
		   ,[ganhoPeso] = $ganhoPeso
	  WHERE [idProduto] = '$id'
	  ";
		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}
	
	function gravarVacina($dados)
	{
		$nome = $dados['nome'];
		$local = $dados['local'];
		$fabricante = $dados['fabricante'];
		$validade = $dados['validade'];
		$descricao = $dados['descricao'];
		$unidade = $dados['unidade'];

		$command_sql = "INSERT INTO [base].[produtos](
		 [dtCadastro]
		,[nomeProduto]
		,[localAplicacao]
		,[fabricante]
		,[validade]
		,[descricao]
		,[unidade]
		,[ganhoPeso])
  VALUES
		(
		GETDATE(),
		'$nome',
		'$local',
		'$fabricante',
		'$validade',
		'$descricao',
		'$unidade',
		null
		)
";


		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}

	function gravarDieta($dados)
	{
		$nome = $dados['nome'];
		$fabricante = $dados['fabricante'];
		$validade = $dados['validade'];
		$descricao = $dados['descricao'];
		$unidade = $dados['unidade'];
		$ganhoPeso = $dados['ganhoPeso'];

		$command_sql = "INSERT INTO [base].[produtos](
		 [dtCadastro]
		,[nomeProduto]
		,[localAplicacao]
		,[fabricante]
		,[validade]
		,[descricao]
		,[unidade]
		,[ganhoPeso])
  VALUES
		(
		GETDATE(),
		'$nome',
		null,
		'$fabricante',
		'$validade',
		'$descricao',
		'$unidade',
		'$ganhoPeso'
		)
";


		try {
			$query = $this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;
	}
}
