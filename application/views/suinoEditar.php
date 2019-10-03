<!-- Aqui vai o conteúdo -->
<h2>Tela de Suino</h2>
<div class="form-group">
ID:<input type="text" name="idSuino" style="background-color:transparent; border: none" disabled value="<?php echo $suino[0]['idSuino'] ?>">
</div>
Sexo: <input type="text" style="background-color:transparent; border: none" disabled value="<?php echo $sexo = $suino[0]['sexo'] == '1' ? 'Macho' : 'Femea'; ?>">
ID Mae: <input type="text" style="background-color:transparent; border: none" disabled value="<?php echo $suino[0]['idMae'] ?>">
Lote Atual: <input type="text" name="idLoteAtual" style="background-color:transparent; border: none" disabled value="<?php echo $suino[0]['nomeLote'] ?>"><a class="btn btn-primary btn-sm" onclick="movLocalidade()" id="movLocalidade">Movimentar Suino</a>

<div id="alterar" style="display:none;">
        <div class="form-group">
                <label for="idLoteFull">Escolha o Lote</label>
                <select class="browser-default custom-select" id="idLoteFullDestino" name="idLoteFullDestino">
                        <option value="null" selected>Escolha um Lote</option>
                        <?php
                        foreach ($lote as $r) {
                                $id = $r['idLoteFull'];
                                echo ("<option value='$id'>" . $r['nomeLote'] . "</option>");
                        } ?>
                </select>
        </div>
</div>
<label for="nome">Data de Cadastro: <input type="date" style="background-color:transparent; border: none" disabled value="<?php $date = new Datetime($suino[0]['dtCadastroInfo']);
                                                                                                                                echo ($date->format('Y-m-d')); ?>"></label>


<script>
        function movLocalidade() {
                estado_atual = $("#alterar").css("display");
                if (estado_atual == "none") {
                        novo_estado = "block";
                } else {
                        novo_estado = "none";
                }
                $("#alterar").css("display", novo_estado);
        }
</script>