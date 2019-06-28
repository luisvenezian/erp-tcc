<?php 

	$data['controller'] = "perfil";
	$this->load->view('header',$data);

	if(isset($editar))
	{
		?> <script type='text/javascript' src=<?=base_url('application\views\assets\js\perfil.js')?>></script> <?php 

		if ($editar == 2)
		{
			?>
			<script>
                        SwalSqlEditado('sucesso');
			</script>

			<?php 
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
<link rel = "stylesheet" type = "text/css" href = <?=base_url('application\views\assets\css\perfil.css')?>/>
<div class="container portfolio">
<br>
	<div class="row">
		<div class="col-md-12">
			<div class="heading">				
				<img src=<?=base_url('application\img\perfil-img-logo.png')?>/><strong>Visualizar Perfil</strong>
			</div>
		</div>	
	</div>
	<div class="bio-info">
	<?php echo form_open("perfil_editar/gravar");?> 
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-12">
						<div class="bio-image">
							<img src= <?=base_url($user_url_img) ?> class="img-fluid img-thumbnail" alt="image" height="200" width="300"/>
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
							<span data-feather="phone"></span>  <?php echo "(". $user_phone_prefix .") - ". $user_phone_number ; ?>
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
					<a href=<?= base_url('perfil?editar=1') ?>><button type="button" class="btn btn-outline-dark">Editar Informações</button></a>
				</div>
			</div>
		</div>	
	</div>
</div>
<?php $this->load->view('footer') ?>
