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
$idLoteFull = $lote[0]['idLoteFull'];
$date = new DateTime($lote[0]['dtCadastroInfo']);
$tempoUso = (int) $lote[0]['infoTempoDeUso'];
$dataAtual = strtotime(date('d-m-Y'));
$diasRestanteDieta = abs((strtotime(($lote[0]['dtCadastroInfo']) . '+60 days') - $dataAtual) / 86400);
?>

<h2>Tela de Controle do <?php echo ($lote[0]['nomeLote']); ?></h2>
<div class="form-group">
        <label for="nome">Fase Atual: <?php echo ($lote[0]['nome']); ?></label><br>
        <label for="nome">Início <input type="date" style="background-color:transparent; border: none" disabled value="<?php echo ($date->format('Y-m-d')); ?>"></label>
        <div>
                <label>Dias Restante: </label>
                <?php echo (int) $diasRestanteDieta; ?>
        </div>
        <hr>

        <label for="nome">Vacinas: <input type="text" style="background-color:transparent; border: none" disabled value="<?php echo ($lote[0]['nomeVacina']); ?>"></label><br>
        <label for="nome">Início <input type="date" style="background-color:transparent; border: none" disabled value="<?php echo ($date->format('Y-m-d')); ?>"></label><br>
        <hr>

        <label for="nome">Ração Atual: <input type="text" style="background-color:transparent; border: none" disabled value="<?php echo ($lote[0]['nomeDieta']); ?>"></label>

        <div class="form-group">

        </div>

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
                                                <button onclick='exibir($id,$idLoteFull)'>
                                                        <span data-feather='edit'></span>
                                                </button>
                                        </td>
                                </tr>
                                ");
                                }
                                ?>
                        </tbody>
                </table>
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
        <?php echo form_close(); ?>
        <script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script>
                function exibir(id, idLote) {
                        $.ajax({
                                        url: '<?php echo base_url(); ?>lote/consultaSuino',
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
                <!-- chamada padrão do JQuery pelo document.ready 
                -->
                $(document).ready(function
                ()
                {
        <!-- listener do botão com o ID do pedido, igual ao que está lá na tag BUTTON -->
        $("#movLocalidade").click(function () {
        alert('teste');
        <!-- o evento click tem um function dentro que fará o trabalho de mostrar ou esconder a div -->
        <!-- no estado atual capturo se a div está none ou block no momento do click -->
        estado_atual = $("#alterar").css("display");
        <!-- se estiver none troca pra block e vice versa -->
        if (estado_atual == "none") {
        novo_estado = "block";
        } else {
        novo_estado = "none";
        }
        <!-- atribui o novo display a div -->
        $("#alterar").css("display", novo_estado);
        });
        })
        </script>

        <?php $this->load->view('footer') ?>