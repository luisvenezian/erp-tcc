<?php 
$data['controller'] = "panel";
$this->load->view('header',$data) ?>
        <!-- Aqui vai o conteúdo -->
        <h2>
        <?php 
        
        date_default_timezone_set('America/Sao_Paulo');

        $user = strtoupper(getUserName());
        $date = new DateTime();
        $hour = $date->format('H');

        if(($hour >= 6) && ($hour<=12))
        {
                $saudacao = "Bom dia, ";
        }
        else if (($hour > 12) && ($hour <= 18))
        {
                $saudacao = "Boa tarde, ";
        }
        else 
        {
                $saudacao = "Boa noite, ";
        }

        echo $saudacao . $user . ". Bem vindo ao sistema!"
        ?>
        
        </h2>
        
<?php $this->load->view('footer') ?>
