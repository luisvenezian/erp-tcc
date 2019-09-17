<?php $data['controller'] = "estoque";
$this->load->view('header', $data);

if(isset($editar))
{
        ?> <script type='text/javascript' src=<?=base_url('application\views\assets\js\produto.js')?>></script> <?php 

        if ($editar == 2)
        {
                ?>
                <script>
                SwalSqlEditado('sucesso');
                </script>

                <?php 
        }

        else if ($editar == 3)
        {	
                ?>
                <script>
                SwalSqlEditado('erro');
                </script>

                <?php 
        }
}
?>
<!-- Aqui vai o conteúdo -->
<h2>Tela de Estoque</h2>
<?php echo form_open_multipart('estoque/controle'); ?>
<div class="form-group">
    <label for="nome">Escolha o Produto</label>
    <select class="browser-default custom-select" id="nome" name="nome">
        <?php
        foreach ($produtos as $r) {
            $id = $r['idProduto'];
            echo ("<option value='$id'>" . $r['nomeProduto'] . "</option>");
        } ?>
    </select>
</div>

<div class="form-group">
    <label for="nome">Escolha a Operação</label>
    <select class="browser-default custom-select" id="idOperacao" name="idOperacao">
        <?php
        foreach ($operacoes as $r) {
            $id = $r['idOperacao'];
            echo ("<option value='$id'>". $r['descOperacao'] . "</option>");
        } ?>
    </select>
</div>

<div class="form-group">
    <label for="quantidade">Quantidade</label>
    <input type="number" class="form-control" id="quantidade" name="quantidade" aria-describedby="quantidadeHelp" placeholder="Digite a quantidade">
</div>

<div class="form-group">
    <label for="nome">Unidade</label>
    <select class="browser-default custom-select" name="unidade" id='unidade'>
        <option selected>Selecione uma Unidade</option>
        <option value="ml">ML</option>
        <option value="ds">DOSE</option>
        <option value="kg">KG</option>
        <option value="tonelada">TONELADA</option>
    </select>
</div>
<div class="form-group">
    <label for="custo">Custo</label>
    <input type="number" class="form-control" id="custo" name="custo" aria-describedby="custo" placeholder="Digite o valor">
</div>
<button type="submit" class="btn btn-primary">Cadastrar</button>
<?php echo form_close(); ?>
<?php $this->load->view('footer') ?>