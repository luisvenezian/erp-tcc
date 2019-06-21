<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> ERP ICORP </title>
    
    <!-- Principal CSS do Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/application/views/assets/css/login.css">
</head>
<body>
    <div class="login-form">
        <?php echo form_open("login/autenticar"); 
        
        if($msg = get_msg())
        echo "<div class='alert alert-danger'>\n<strong>Atenção!</strong>". $msg ."</div>";
        ?>
            <div class="text-center">
                <img src="application\img\hnd-login-logo.png" class="img avatar" alt="Avatar">
            </div>
            <div class="form-group">
                <input name="usuario" type="text" class="form-control" placeholder="Usuário ou E-mail" required="required">
                <input name="senha" type="password" class="form-control" placeholder="Senha" required="required">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block">Entrar</button>
            </div>
            <div class="clearfix">
                <label id="rem" class="pull-left checkbox-inline">
                    <input type="checkbox" >Lembrar-me</label>
                <a href="#" class="float-right">Esqueceu a senha?</a>
            </div>

        <?php echo form_close(); ?>

    </div>
</body>

</html>

