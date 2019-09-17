<?php
$data['controller'] = "produto";
$this->load->view('header', $data);

?>
<!-- Aqui vai o conteúdo -->
<h2>Tela de Alteração para Vacinas</h2>
<?php echo form_open_multipart('produto/vacinaAtualizar'); ?>
<input type="hidden" name="id" value="<?php echo ($produto->idProduto) ?>">
<div class="form-group">
        <label for="nome">Nome</label>
        <input type="text" class="form-control" value="<?php echo ($produto->nomeProduto) ?>" name="nome" id="nome" style="min-width:300px;" aria-describedby="nameHelp" placeholder="Digite nome da vacina">
</div>
<div class="form-group">
        <label for="nome">Unidade de Uso</label>
        <select class="browser-default custom-select" name="unidade" id='unidade'>
                <option value="ml" <?= ($produto->unidade == 'ml') ? 'selected' : '' ?>>ML</option>
                <option value="ds" <?= ($produto->unidade == 'ds') ? 'selected' : '' ?>>DOSE</option>
        </select>
</div>
<div class="form-group">
        <label for="local">Local de Aplicação</label>
        <input type="text" class="form-control" id="local" value="<?php echo ($produto->localAplicacao) ?>" name="local" aria-describedby="localHelp" placeholder="Digite o local da aplicação">
</div>
<div class="form-group">
        <label for="local">Fabricante</label>
        <input type="text" class="form-control" id="fabricante" value="<?php echo ($produto->fabricante) ?>" name="fabricante" aria-describedby="fabriHelp" placeholder="Digite o fabricante">
</div>
<div class="form-group">
        <label for="data_validade">Data de Validade</label>
        <input type="date" class="form-control" id="data_validade" value="<?php echo ($produto->validade) ?>" name="validade" aria-describedby="data_validadeHelp" placeholder="Selecione a Data de Validade">
</div>
<div class="form-group">
        <label for="descricao">Descrição</label>
        <textarea class="form-control" id="descricao" name="descricao" rows="3"><?php echo ($produto->descricao) ?></textarea>
</div>

<div class="btn-group">

        <button type="submit" class="btn btn-primary">Atualizar</button>
        <?php echo form_close(); ?>

        <?php echo form_open_multipart('produto/vacinaExcluir'); ?>
        <input type="hidden" name="id" value="<?php echo ($produto->idProduto) ?>">
        <button type="submit" style="margin-left:10px;" class="btn btn-primary">Excluir</button>
        <?php echo form_close(); ?>

</div>

<?php $this->load->view('footer') ?>