<?php
$data['controller'] = "lote";
$this->load->view('header', $data);
?>
<h2>Tela de Relatórios</h2>
<?php echo form_open_multipart('lote/consultaLote'); ?>
        <div class="form-group">
                <label for="idLoteFull">Escolha o Lote</label>
                <select class="browser-default custom-select" id="idLote" name="idLote">
                        <?php
                        foreach ($lote as $r) {
                                $id = $r['idLote'];
                                echo ("<option value='$id'>" . $r['nomeLote'] . "</option>");
                        } ?>
                        <option value='todos'>Todos</option>
                </select>
        </div>
        <button type="submit" class="btn btn-primary">Consultar</button>
        <?php echo form_close(); ?>

<?php $this->load->view('footer') ?>