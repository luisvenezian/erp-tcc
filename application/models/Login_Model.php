<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_Model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	public function validarUsuario($user)
	{
		$command_sql = "SELECT TOP 1 * FROM base.usuarios WHERE usuario = '".$user."'";
		$query = $this->db->query($command_sql);
		return ($query->num_rows() == 1) ? true : false;
	}

	public function validarSenhaUsuario($passworduser)
	{
		$command_sql = "SELECT TOP 1 * FROM base.usuarios WHERE senha = '".$passworduser."'";
		$query = $this->db->query($command_sql);
		return ($query->num_rows() == 1) ? true : false;
	}

	public function getUserIdByUserName($user_name){
		$command_sql = "SELECT TOP 1 idUsuario FROM base.usuarios WHERE usuario = '".$user_name."'";
		$query = $this->db->query($command_sql);

		foreach ($query->result() as $row)
		{
				$result = $row->idUsuario;
		}
		return $result;
	}


	public function atualizarSenhaUsuario($dados)
	{
		$senha = $dados['senha'];
		$senhaNova = $dados['senhaNova'];
		$usuario = $dados['usuario'];


		$command_sql = "UPDATE base.usuarios 
						SET senha = '".$senhaNova."'   
						WHERE senha = '".$senha."' AND usuario = '".$usuario."'";

		return ($this->db->query($command_sql)) ? true : false;
	}


	public function cadastrarSenhaUsuario($dados)
	{
		$senha = $dados['senha'];
		$usuario = $dados['usuario'];


		$command_sql = "INSERT base.usuarios (usuario, senha, dtCadastro)
						VALUES ('".$usuario."','".$senha."', GETDATE())";

		return ($this->db->query($command_sql)) ? true : false;
	}
}
