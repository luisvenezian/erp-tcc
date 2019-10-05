<?php
$data['controller'] = "lote";
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
                redirect('/produto/dieta');
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
<h2>Tela de Controle de Lotes</h2>
<?php echo form_open_multipart('lote/consultaLote'); ?>
        <div class="form-group">
                <label for="idLoteFull">Escolha o Lote</label>
                <select class="browser-default custom-select" id="idLote" name="idLote">
                        <?php
                        foreach ($lote as $r) {
                                $id = $r['idLote'];
                                echo ("<option value='$id'>" . $r['nomeLote'] . "</option>");
                        } ?>
                </select>
        </div>
        <button type="submit" class="btn btn-primary">Consultar</button>
        <?php echo form_close(); ?>

<?php $this->load->view('footer') ?>