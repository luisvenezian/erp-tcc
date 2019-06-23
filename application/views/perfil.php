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
				<div class="bio-content">
				
					<h2><?php echo $user_first_name; ?></h2>
					<h6><?php echo $user_bio; ?></h6>
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
					<button type="button" class="btn btn-outline-dark">Editar Informações</button>
				</div>
			</div>
		</div>	
	</div>
</div>
<?php $this->load->view('footer') ?>
