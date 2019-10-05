<?php 
$data['controller'] = "lote";
$this->load->view('header',$data);
if(isset($editar))
{
        ?> <script type='text/javascript' src=<?=base_url('application\views\assets\js\produto.js')?>></script> <?php 

        if ($editar == 2)
        {
                ?>
                <script>
                SwalSqlGravar('sucesso');
                </script>

                <?php 
        }

        else if ($editar == 3)
        {	
                ?>
                <script>
                SwalSqlGravar('erro');
                </script>

                <?php 
        }
}
?>
<!-- Aqui vai o conteúdo -->
<h2>Tela de Cadastro para Lotes</h2>
<?php echo form_open_multipart('lote/loteGravar'); ?>
        <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" class="form-control" name="nome" id="nome" style="min-width:300px;" aria-describedby="nameHelp" placeholder="Digite nome do lote">
        </div>
        <div class="form-group">
                <label for="idTipoLote">Escolha o tipo de Lote</label>
                <select class="browser-default custom-select" id="idTipoLote" name="idTipoLote">
                        <?php
                        foreach ($tipoLote as $r) {
                                $id = $r['idTipoLote'];
                                echo ("<option value='$id'>" . $r['descTipoLote'] . "</option>");
                        } ?>
                </select>
        </div>
        <div class="form-group">
                <label for="vencimentoLote">Tempo no Lote</label>
                <input type="date" class="form-control" id="vencimentoLote" name="vencimentoLote" aria-describedby="tempoUsoHelp" placeholder="Digite a Data Prevista">
        </div>
        <div class="form-group">
                <label for="idDieta">Escolha a dieta</label>
                <select class="browser-default custom-select" id="idDieta" name="idDieta">
                        <?php
                        foreach ($dieta as $r) {
                                $id = $r['idProduto'];
                                echo ("<option value='$id'>" . $r['nomeProduto'] . "</option>");
                        } ?>
                </select>
        </div>
        <div class="form-group">
                <label for="idVacina">Escolhe a Vacina</label>
                <select class="browser-default custom-select" id="idVacina" name="idVacina">
                        <?php
                        foreach ($vacina as $r) {
                                $id = $r['idProduto'];
                                echo ("<option value='$id'>" . $r['nomeProduto'] . "</option>");
                        } ?>
                </select>
        </div>
        <div class="form-group">
                
                <label for="qtdSuinoMacho">Quantidade de Suinos Machos Disponíveis <?php echo($suinoMacho[0]['']);?> </label>
                <input type="number" class="form-control" id="qtdSuinoMacho" min="0" max="<?php echo($suinoMacho[0]['']);?>" name="qtdSuinoMacho" aria-describedby="qtdSuinoMacho" placeholder="Digite a quantidade de Suinos Machos">
        </div>
        <div class="form-group">
                
                <label for="qtdSuinoFemea">Quantidade de Suinos Femeas Disponíveis <?php echo($suinoFemea[0]['']);?> </label>
                <input type="number" class="form-control" id="qtdSuinoFemea" min="0" max="<?php echo($suinoFemea[0]['']);?>" name="qtdSuinoFemea" aria-describedby="qtdSuinoFemea" placeholder="Digite a quantidade de Suinos Femeas">
        </div>

        <div class="form-group">
                <label for="pesoLote">Peso Total do Lote</label>
                <input type="number" class="form-control" id="pesoLote" name="pesoLote" value="0" aria-describedby="tempoUsoHelp" placeholder="Digite o Peso do Lote">
        </div>

        <div class="form-group">
                <label for="descricao">Descrição</label>
                <textarea class="form-control" id="descricao" name="descricao" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Cadastrar</button>
<?php echo form_close(); ?>

<?php $this->load->view('footer') ?>
