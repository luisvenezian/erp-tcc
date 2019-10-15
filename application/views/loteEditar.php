<?php
$data['controller'] = "lote";
$this->load->view('header', $data);
if (isset($editar)) {
        ?> <script type='text/javascript' src=<?= base_url('application\views\assets\js\produto.js') ?>></script> <?php

                                                                                                                                if ($editar == 2) {
                                                                                                                                        ?>
                <script>
                        SwalSqlEditado('sucesso');
                </script>

        <?php
                        redirect('/produto/dieta');
                } else if ($editar == 3) {
                        ?>
                <script>
                        SwalSqlEditado('erro');
                </script>

<?php
        }
}

$idLote = $lote[0]['idLote'];
$dateCad = new DateTime($lote[0]['dtCadastroInfo']);
$dateVenc = new DateTime($lote[0]['dtVencimentoLote']);
$tempoLote = date_diff($dateCad, $dateVenc);

$dateCadDieta = new DateTime($lote[0]['dtInicioAplicacao']);
$dateVencDieta = new DateTime($lote[0]['dtFimAplicacao']);
$tempoDieta = date_diff($dateCadDieta, $dateVencDieta);

$dateCadVacina = new DateTime($lote[1]['dtInicioAplicacao']);
$dateVencVacina = new DateTime($lote[1]['dtFimAplicacao']);
$tempoVacina = date_diff($dateCadVacina, $dateVencVacina);
?>

<h2>Tela de Controle<br>Lote: <?php echo ($lote[0]['nomeLote']); ?></h2>
<div class="form-group">
        <hr>
        <label for="nome">Fase Atual: <?php echo ($lote[0]['nome']); ?></label><br>
        <label for="nome">Início <input type="date" style="background-color:transparent; border: none" value="<?php echo ($dateCad->format('Y-m-d')); ?>"></label>
        <div>
                <label>Dias Restante: </label>
                <?php echo ($tempoLote->d); ?>
        </div>
        <label for="nome">Mortes: <?php echo ($lote[0]['qtdMortos']); ?></label><br>
        <hr>

        <?php echo form_open_multipart('Lote/atualizarDieta'); ?>
        <div class="form-group">
                <input type="hidden" name="idLote" value="<?php echo ($lote[0]['idLote']); ?>">
                <input type="hidden" name="idTipoTratamento" value="<?php echo ($lote[0]['idTipoTratamento']); ?>">
                <label for="qtdDieta">Dieta Atual</label>
                <select class="browser-default custom-select" id="dieta" name="idProduto">
                        <option selected><?php echo ($lote[0]['nomeProduto']); ?></option>
                        <?php
                        foreach ($dietas as $r) {
                                $id = $r['idProduto'];
                                echo ("<option value='$id'>" . $r['nomeProduto'] . " - " . $r['qtdDisponivel'] . "</option>");
                        } ?>
                </select>
                <label for="qtdDieta">Quantidade</label>
                <input type="number" id="qtdDieta" name="qtdDieta" class="form-control"><br>
                <label for="nome">Início <input type="date" style="background-color:transparent; border: none" disabled value="<?php echo ($dateCadDieta->format('Y-m-d')); ?>"> </label><br>
                <label>Dias Restante: </label>
                <?php echo ($tempoDieta->d); ?><br>
                <button type="submit" class="btn btn-outline-info">Atualizar</button><br>
        </div>
        <?php echo form_close(); ?>
        <hr>
        <?php echo form_open_multipart('Lote/atualizarVacina
        '); ?>
        <div class="form-group">
                <input type="hidden" name="idLote" value="<?php echo ($lote[0]['idLote']); ?>">
                <input type="hidden" name="idTipoTratamento" value="<?php echo ($lote[1]['idTipoTratamento']); ?>">
                <div class="form-group">
                        <label for="nome">Vacina Atual</label>
                        <select class="browser-default custom-select" id="vacina" name="idProduto">
                                <option selected><?php echo ($lote[1]['nomeProduto']); ?></option>
                                <?php
                                foreach ($vacinas as $r) {
                                        $id = $r['idProduto'];
                                        echo ("<option value='$id'>" . $r['nomeProduto'] . " - " . $r['qtdDisponivel'] . "</option>");
                                } ?>
                        </select>
                </div>
                <label for="nome">Quantidade</label>
                <input type="number" id="qtdVacina" name="qtdVacina" class="form-control"><br>
                <label for="nome">Início <input type="date" style="background-color:transparent; border: none" disabled value="<?php echo ($dateCadVacina->format('Y-m-d')); ?>"></label><br>
                <label>Dias Restante: </label>
                <?php echo ($tempoVacina->d); ?><br>
                <button type="submit" class="btn btn-outline-info">Atualizar</button><br>
        </div>
        <?php echo form_close(); ?>

        <hr>

        <?php echo form_open_multipart('Lote/atualizarPeso'); ?>
        <div class="form-group">
                <input type="hidden" name='idLote' value="<?php echo ($lote[0]['idLote']); ?>">
                <label for="nome">Peso Atual: <input type="text" name="pesoLote" style="background-color:transparent; border: none" value="<?php echo ($lote[0]['pesoLote']); ?>"></label><br>
                <button type="submit" class="btn btn-outline-info">Atualizar</button>
        </div>
        <?php echo form_close(); ?>
        <div class="container">
                <table class="table">
                        <thead>
                                <tr>
                                        <th scope="col">Suinos</th>
                                        <th scope="col">Sexo</th>
                                        <th scope="col">Alterações</th>
                                </tr>
                        </thead>
                        <tbody>
                                <?php
                                foreach ($suino as $r) {
                                        $sexo = $r['sexo'] == '1' ? 'Macho' : 'Femea';
                                        $id = $r['idSuino'];
                                        printf("<tr>
                                        <td>" . $r['idSuino'] . "  </td>
                                        <td>" . $sexo . " </td> 
                                        <td>
                                                <button onclick='exibir($id,$idLote)'>
                                                        <span data-feather='edit'></span>
                                                </button>
                                        </td>
                                </tr>
                                ");
                                }
                                ?>
                        </tbody>
                </table>
                <div class="form-group">
                        <input type="hidden" name="idLote" value="<?php $idLote = ($lote[0]['idLote']);
                                                                        echo $idLote ?>">
                        <button class="btn btn-outline-info" onclick='movimentarLote(<?php echo $idLote ?>)'>Movimentar em Grupo</button>
                </div>
                <?php

                if ($lote[0]['nome'] == 'Pré-abate') { ?>
                        <div class="form-group">
                                <input type="hidden" name="idLote" value="<?php $idLote = ($lote[0]['idLote']);
                                                                                        echo $idLote ?>">
                                <button class="btn btn-outline-info" onclick='exibirVenda(<?php echo $idLote ?>)'> Finalizar Venda</button>
                        </div>
                <?php } ?>
        </div>

        <?php echo form_open_multipart('suino/suinosAlterar'); ?>
        <div id="visulUsuarioModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">

                        <div class="modal-content">

                                <div class="modal-header">
                                        <h5 class="modal-title" id="visulUsuarioModalLabel">Detalhes do Suino</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>

                                </div>
                                <div class="modal-body">

                                        <span id="visul_usuario"></span>

                                </div>
                                <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-info" data-dismiss="modal">Fechar</button>
                                        <button type="submit" class="btn btn-outline-info">Atualizar</button>
                                </div>

                        </div>

                </div>
        </div>
        <?php
        echo form_close();

        echo form_open_multipart('lote/finalizarLote'); ?>
        
        <input type="hidden" name="idLote" value='<?php echo $idLote ?>'>
        <div id="visulUsuarioModalVenda" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">

                        <div class="modal-content">

                                <div class="modal-header">
                                        <h5 class="modal-title" id="visulUsuarioModalLabel">Detalhes da Venda</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>

                                </div>
                                <div class="modal-body">

                                        <span id="visul_usuarioVenda"></span>

                                </div>
                                <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-info" data-dismiss="modal">Fechar</button>
                                        <button type="submit" class="btn btn-outline-info">Finalizar</button>
                                </div>

                        </div>

                </div>
        </div>
        <?php echo form_close();

        echo form_open_multipart('lote/movimentacaoLote'); ?>
        <input type="hidden" name="idLote" value='<?php echo $idLote ?>'>
        <div id="visulUsuarioModalMovimenta" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">

                        <div class="modal-content">

                                <div class="modal-header">
                                        <h5 class="modal-title" id="visulUsuarioModalLabel">Detalhes da Venda</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>

                                </div>
                                <div class="modal-body">

                                        <span id="visul_usuarioMovimenta"></span>

                                </div>
                                <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-info" data-dismiss="modal">Fechar</button>
                                        <button type="submit" class="btn btn-outline-info">Atualizar</button>
                                </div>

                        </div>

                </div>
        </div>
        <?php echo form_close(); ?>
        <script>
                function exibir(id, idLote) {
                        $.ajax({
                                        url: '<?php echo base_url('lote/consultaSuino'); ?>',
                                        crossDomain: true,
                                        type: 'POST',
                                        data: {
                                                idSuino: id,
                                                idLote: idLote
                                        }
                                })
                                .done(function(msg) {
                                        $("#visul_usuario").html(msg);
                                        $('#visulUsuarioModal').modal('show');
                                });
                }
        </script>

        <script>
                function exibirVenda(idLote) {
                        $.ajax({
                                        url: '<?php echo base_url('lote/formVenda'); ?>',
                                        crossDomain: true,
                                        type: 'POST',
                                        data: {
                                                idLote: idLote
                                        }
                                })
                                .done(function(msg) {
                                        $("#visul_usuarioVenda").html(msg);
                                        $('#visulUsuarioModalVenda').modal('show');
                                });
                }
        </script>

        <script>
                function movimentarLote(idLote) {
                        $.ajax({
                                        url: '<?php echo base_url('lote/movimentarLote'); ?>',
                                        crossDomain: true,
                                        type: 'POST',
                                        data: {
                                                idLote: idLote
                                        }
                                })
                                .done(function(msg) {
                                        $("#visul_usuarioMovimenta").html(msg);
                                        $('#visulUsuarioModalMovimenta').modal('show');
                                });
                }
        </script>

        <script>
                $(document).ready(function() {
                        $("#movLocalidade").click(function() {

                        });
                })
        </script>

        <script>
                $(document).ready(function() {
                        $("#vacina").click(function() {
                                var teste = $("#vacina :selected").text().split('-');
                                $("#qtdVacina").attr(parseInt(teste[1]));
                        });
                })
        </script>

        <script>
                $(document).ready(function() {
                        $("#dieta").click(function() {
                                var teste = $("#dieta :selected").text().split('-');
                                $("#qtdDieta").attr("max", parseInt(teste[1]));
                        });
                })
        </script>

        <?php $this->load->view('footer') ?>