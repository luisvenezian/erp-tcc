<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href=<?= base_url('application\img\icon-porco.png') ?>

  <title>ERP - SUINOS</title>

  <!-- Principal CSS do Bootstrap -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  <script src="https://kit.fontawesome.com/aab0d1297c.js"></script>
  <script src=<?= base_url('application/views/assets/js/panel.js') ?>></script>
  <link href=<?= base_url('application/views/assets/css/panel.css') ?> rel="stylesheet">
  <link rel="stylesheet" href=<?= base_url('application\views\assets\css\footer.css') ?>>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/8.11.8/sweetalert2.all.js"></script>
  <link href=<?= base_url('application\views\assets\css\tabulator.min.css') ?> rel="stylesheet">
  <script type="text/javascript" <?= base_url('application/views/assets/js/tabulator.min.js')?>></script>
  <!--<link href="https://unpkg.com/tabulator-tables@4.2.7/dist/css/tabulator.min.css" rel="stylesheet">-->
  <!--<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.2.7/dist/js/tabulator.min.js"></script>-->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>

  <!-- HighCharts -->
  <script src="https://code.highcharts.com/highcharts.js"></script>
  <script src="https://code.highcharts.com/modules/exporting.js"></script>
  <script src="https://code.highcharts.com/modules/export-data.js"></script>
  
</head>

<body>
  <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">

    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="\panel">
      <img id="mainlogo" href="" src=<?= base_url('application\img\icon-porco.png') ?> width="35" height="35" alt=""> Painel Administrador</a>

    <input name="pesquisador" class="form-control form-control-dark" type="text" list="historico" placeholder="Pesquise por alguma ferramenta" aria-label="Search">

    <div class="input-group-btn">
      <a id="disparapesquisa" href="\pesquisa">
        <button onclick="dispararPesquisa()" class="btn btn-outline-secondary" type="">Pesquisar</button>
      </a>
    </div>
    <ul class="navbar-nav px-3">
      <li class="nav-item text-nowrap">
        <a class="nav-link" href="login\sair">
          <i class="fas fa-sign-out-alt">
          </i> Sair
        </a>
      </li>
    </ul>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <nav class="col-md-2 d-none d-md-block bg-light sidebar">
        <div class="sidebar-sticky">
          <ul class="nav flex-column">
            <li class="nav-item">
              <a <?php echo getNavLinkType('panel', $controller); ?> href="\panel">
                <span data-feather="home"></span>
                Página Inicial <span class="sr-only"></span>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" data-toggle="dropdown" <?php echo getNavLinkType('produto', $controller); ?> href="#" role="button" aria-haspopup="true" aria-expanded="false"><span data-feather="file"></span>Cadastro</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('produto/cadastroVacinas') ?>>Vacinas</a>
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('produto/cadastroDietas') ?>>Dietas</a>
                 <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('suino/cadastroSuinos') ?>>Suinos</a>
                <a class="dropdown-item" <?php echo getNavLinkType('Lote', $controller); ?> 
                href=<?php echo base_url('lote/cadastroLotes') ?>>Lotes</a>
              </div>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" data-toggle="dropdown" <?php echo getNavLinkType('produto', $controller); ?> href="#" role="button" aria-haspopup="true" aria-expanded="false"><span data-feather="shopping-cart"></span>Produtos</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('produto/vacina') ?>>Vacinas</a>
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('produto/dieta') ?>>Dietas</a>
              </div>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('estoque', $controller); ?> href="\estoque">
                <span data-feather="package"></span>
                Estoque
              </a>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('tratamento', $controller); ?> href="\Tratamento">
                <span data-feather="activity"></span>
                Tratamentos
              </a>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('suino', $controller); ?> href="\Suino">
                <span data-feather="heart"></span>
                Suinos
              </a>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('lote', $controller); ?> href="\lote">
                <span data-feather="codepen"></span>
                Lotes
              </a>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('relatorio', $controller); ?> href="\relatorio">
                <span data-feather="bar-chart-2"></span>
                Relatórios
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" data-toggle="dropdown" <?php echo getNavLinkType('produto', $controller); ?> href="#" role="button" aria-haspopup="true" aria-expanded="false"><span data-feather="user"></span>Usuário</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('login/cadastrar') ?>>Cadastrar</a>
                <a class="dropdown-item" <?php echo getNavLinkType('Produto', $controller); ?> 
                href=<?php echo base_url('login/editar') ?>>Editar</a>
              </div>
            </li>
            <li class="nav-item">
              <a <?php echo getNavLinkType('executarsql', $controller); ?> href="\executarsql">
                <span data-feather="database"></span>
                Executar SQL
              </a>
            </li>
          </ul>
          <!-- 
          <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Relatórios salvos</span>
            <a class="d-flex align-items-center text-muted" href="#">
              <span data-feather="plus-circle"></span>
            </a>
          </h6>
          <ul class="nav flex-column mb-2">
            <li class="nav-item">
              <a class="nav-link" href="#">
                <span data-feather="file-text"></span>
                Neste mês
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <span data-feather="file-text"></span>
                Último trimestre
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <span data-feather="file-text"></span>
                Engajamento social
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <span data-feather="file-text"></span>
                Vendas do final de ano
              </a>
            </li>
          </ul>
          -->
        </div>
        
      </nav>

      <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4"><br>