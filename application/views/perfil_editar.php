<?php 

	$data['controller'] = "perfil";
	$this->load->view('header',$data) 	
?>

<link rel = "stylesheet" type = "text/css" href = "application\views\assets\css\perfil.css"/>
<div class="container portfolio">
<br>
	<div class="row">
		<div class="col-md-12">
			<div class="heading">				
				<img src="application\img\perfil-img-logo.png" />
			</div>
		</div>	
	</div>
	<div class="bio-info">
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-12">
						<div class="bio-image">
							<img src= "<?php echo $user_url_img; ?>"class="img-fluid img-thumbnail" alt="image" height="200" width="300"/>
						</div>			
					</div>
				</div>	
			</div>
			<div class="col-md-6">
			<?php echo form_open("perfil_editar/gravar");?> 
				<div class="bio-content">
					Primeiro Nome:
					<input class="form-control form-control-lg" type="text" placeholder="Primeiro Nome" value="<?php echo $user_first_name; ?>">

					<div class="form-group">
						<label for="bio">Biografia:</label>
						<textarea class="form-control" id="bio" value="<?php echo $user_bio; ?>" rows="3"></textarea>
					</div>

					<hr>
					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="user"></span> <?php echo $user_login; ?>
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="phone"></span>  <?php echo $user_phone; ?>
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="mail"></span>  <?php echo $user_email; ?>
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="code"></span>  <?php echo $user_job_role; ?>
							</a>
						</li>
					</ul>
					<hr>
					<a href="perfil?editar=1"><button type="button" class="btn btn btn-success">Gravar</button></a>
				</div>

			<?php echo form_close(); ?>
			</div>
		</div>	
	</div>
</div>
<?php $this->load->view('footer') ?>
