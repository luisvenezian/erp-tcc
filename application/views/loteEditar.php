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
        <div>
                <table>
                        <thead>
                                <td>Suinos</td>
                                <td>Sexo</td>
                        </thead>
                        <tbody>
                                <?php 
                                        foreach($lote as $r){
                                                echo (" <tr>
                                                                <td>". $r['idLoteFull']."  </td>
                                                                <td>". $r['sexo'] == '1') ? 'echo Macho' : 'Femea'."</td>
                                                        </tr>
                                                
                                                
                                                ");
                                        }
                                ?>
                        </tbody>
        </div>

<?php $this->load->view('footer') ?>