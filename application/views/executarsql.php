<?php $data['controller'] = "executarsql";
$this->load->view('header',$data) 

        /* 
         * Formulário: 
         */ 
         
?>
        <script type='text/javascript' src="application\views\assets\js\executarsql.js">js/jquery.min.js"></script>
        <!-- Aqui vai o conteúdo -->
        <h5>Use esta <code>&lt;section&gt;</code> para executar comandos T-SQL.</h5>
        <div class="alert alert-info" role="alert">
                Antes de executar qualquer instrução, certifique-se de que o mesmo
                está correto e que não acarretará em danos nos dados de produção.
                A aplicação restringe uso de comandos arriscados, procure
                um profissional de banco de dados para que os faça. 
        </div>

        <?php echo form_open("executarsql");?> 
        <div class="input-group">
                <div class="input-group-prepend">
                        <span class="input-group-text">Entre com seu código SQL</span>
                </div>
                <textarea name="instrucaosql" class="form-control" aria-label="With textarea" placeholder="SELEC..." required></textarea>
        </div>
        <hr>
        <button type="submit" class="btn btn-warning btn-lg btn-block"><i class="fas fa-bolt"></i> Executar</button>
        <?php echo form_close(); ?>


        <?php
        
        /* 
         * Tratamento de Erros e Resultados: 
         */ 
        
         if (isset($error))
        {
                if ($error == "permissao")
                {
                ?> 
                        <script>
                        SwalSqlError('permissao');
                        </script>
        <?php   }
                else
                {
                ?> 
                        <script>
                        SwalSqlError('sintaxe');
                        </script>
        <?php 
                }
        }

        else if (isset($table)) 
        {
                echo "<hr class='my-4'>\n";
                echo $table;
        }
        ?>
<?php $this->load->view('footer') ?>
