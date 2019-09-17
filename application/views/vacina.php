<?php
$data['controller'] = "produto";
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
                redirect('/produto/vacina');
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
<h2>Tela de Controle de Vacinas</h2>
<?php echo form_open_multipart('produto/vacinaConsultar'); ?>
        <div class="form-group">
                <label for="nome">Escolha a vacina</label>
                <select class="browser-default custom-select" id="nome" name="nome">
                        <?php
                        foreach ($produtos as $r) {
                                $id = $r['idProduto'];
                                echo ("<option value='$id'>" . $r['nomeProduto'] . "</option>");
                        } ?>
                </select>
        </div>
        <button type="submit" class="btn btn-primary">Consultar</button>
        <?php echo form_close(); ?>

<?php $this->load->view('footer') ?>