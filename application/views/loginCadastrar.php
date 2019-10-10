<?php
$data['controller'] = "login";
$this->load->view('header', $data);

if(isset($editar))
{
        ?> <script type='text/javascript' src="application\views\assets\js\produto.js"></script> <?php 

        if ($editar == 2)
        {
                ?>
                <script>
                
                SwalSqlEditado('sucesso');
                </script>

                <?php 
                redirect('/panel');
        }

        else if ($editar == 3)
        {	
                ?>
                <script>
                alert('teste');
                SwalSqlEditado('erro');
                </script>

                <?php 
        }
}

?>
<!-- Aqui vai o conteúdo -->
<!--  <script type='text/javascript' src="application\views\assets\js\produto.js"></script>  -->
<h2>Tela para Criar Novo Usuário </h2>
<?php echo form_open_multipart('login/loginCadastrar'); ?>

<div class="form-group">
        <label for="usuario">Nome de Usuário</label>
        <input type="text" required class="form-control" value="" name="usuario" id="usuario" style="min-width:300px;" aria-describedby="nameHelp" placeholder="Digite nome da vacina">
</div>

<div class="form-group">
        <label for="senha">Senha</label>
        <input type="password" required class="form-control" id="senha" value="" name="senha" aria-describedby="localHelp" placeholder="Digite o local da aplicação">
</div>

<div class="btn-group">

        <button type="submit" class="btn btn-primary">Atualizar</button>
        <?php echo form_close(); ?>
</div>

<?php $this->load->view('footer') ?>