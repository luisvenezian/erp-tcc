<?php
$data['controller'] = "suino";
$this->load->view('header', $data);

if (isset($editar)) {
        ?> <script type='text/javascript' src=<?= base_url('application\views\assets\js\produto.js') ?>></script> <?php

                                                                                                                        if ($editar == 2) {
                                                                                                                                ?>
                <script>
                        SwalSqlGravar('sucesso');
                </script>

        <?php
                } else if ($editar == 3) {
                        ?>
                <script>
                        SwalSqlGravar('erro');
                </script>

<?php
        }
}
?>
<!-- Aqui vai o conteúdo -->
<h2>Tela de Cadastro para Suinos</h2>
<?php echo form_open_multipart('suino/suinosgravar'); ?>

<div class="form-group">
        <label for="sexo">Sexo</label>
        <select required class="browser-default custom-select" name="sexo" id='sexo'>
                <option selected>Selecione um sexo</option>
                <option value="1">Macho</option>
                <option value="0">Femêa</option>
        </select>
</div>

<div class="form-group">
        <label for="qtd">Quantidade</label>
        <input type="text" class="form-control" required name="qtd" id="qtd" style="min-width:300px;" aria-describedby="nameHelp" placeholder="Digita a quantidade de suinos">
</div>

<div class="form-group">
        <label for="peso">Peso (G)</label>
        <input type="text" class="form-control" required name="peso" id="peso" style="min-width:300px;" aria-describedby="nameHelp" placeholder="Digite o peso individual">
</div>
<div class="form-group">
        <label for="idLoteFull">Escolha o Lote</label>
        <select class="browser-default custom-select" id="idLoteFull" name="idLoteFull">
                <option value='null' selected>Selecione um Lote</option>
                <?php
                foreach ($lote as $r) {
                        $id = $r['idLoteFull'];
                        echo ("<option value='$id'>" . $r['nomeLote'] . "</option>");
                } ?>
        </select>
</div>

<div class="form-group">
        <label for="idLoteFull">Escolha o Mãe</label>
        <select class="browser-default custom-select" id="idMae" name="idMae">
                <option value='null' selected>Selecione uma Mãe</option>
                <?php
                foreach ($suino as $r) {
                        $id = $r['idSuino'];
                        echo ("<option value='$id'>" . $r['idSuino'] . "</option>");
                } ?>
        </select>
</div>

<div class="form-group">
        <label for="dataNascimento">Data de Nascimento *Opcional</label>
        <input type="date" class="form-control" id="dataNascimento" name="dataNascimento" aria-describedby="dataNascimentoHelp" placeholder="Selecione a Data de Validade">
</div>

<button type="submit" class="btn btn-primary">Cadastrar</button>
<?php echo form_close(); ?>

<?php $this->load->view('footer') ?>