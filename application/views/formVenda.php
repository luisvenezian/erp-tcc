<h2>Tela de Venda</h2>
<div class="form-group">
        <label for="idLote">ID: <input type="text" name="idLote" style="background-color:transparent; border: none" disabled value="<?php echo $lote[0]['idLote'] ?>"></label>
</div>
<div class="form-group">
        <label for="idLoteAtual"> Lote Atual: <input type="text" name="idLoteAtual" style="background-color:transparent; border: none" disabled value="<?php echo $lote[0]['nomeLote'] ?>"></label>
</div>
<div class="form-group">
        <label for="nome">Data de Cadastro: <input type="date" style="background-color:transparent; border: none" disabled value="<?php $date = new Datetime($lote[0]['dtCadastroInfo']);
                                                                                                                                        echo ($date->format('Y-m-d')); ?>"></label>
</div>
<div class="form-group">
        <label for="valorVenda">Valor de Venda: <input type="number" name="valorVenda" required class="form-control"></label>
</div>
<div class="form-group">
        <label for="clienteVenda">Cliente: <input type="text" name="clienteVenda" required class="form-control"></label>
</div>