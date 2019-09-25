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
	
	function inserir($dados){
		$idProduto = $dados['nome'];
		$idOperacao = $dados['idOperacao']; 
		$quantidade = $dados['quantidade'];
		$idUsuario = 1;
		$unidade = $dados['unidade'] ;
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

		$command_sql = "EXEC sp_cadastrarSuino '".$qtd."','".$peso."','".$idUsuario."','".$sexo."','".$dt."'";
		
		try {
			$this->db->query($command_sql);
			$valida = true;
		} catch (Exception $e) {
			$valida = false;
		}
		return $valida;

	}
}
