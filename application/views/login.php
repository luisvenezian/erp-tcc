<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title> ERP ICORP </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                    <input type="checkbox">Lembrar-me</label>
                <a href="#" class="pull-right">Esqueceu a senha?</a>
            </div>

        <?php echo form_close(); ?>

    </div>
</body>

</html>

