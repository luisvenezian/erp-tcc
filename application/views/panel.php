<?php 
$data['controller'] = "panel";
$this->load->view('header',$data) ?>
        <!-- Aqui vai o conteúdo -->
        <h2>Bem vindo ao sistema, <?php  echo strtoupper(getUserName());?>!</h2>
        
<?php $this->load->view('footer') ?>