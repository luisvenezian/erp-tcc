<!-- Aqui vai o conteúdo -->
<h2>Tela de Movimentação</h2>
<div class="form-group">
        <label for="idLote">Escolha o Lote</label>
        <select class="browser-default custom-select" id="idLoteDestino" name="idLoteDestino">
                <option value="null" selected>Escolha um Lote</option>
                <?php
                foreach ($lote as $r) {
                        $id = $r['idLote'];
                        echo ("<option value='$id'>" . $r['nome'] . "</option>");
                } ?>
        </select>
</div>