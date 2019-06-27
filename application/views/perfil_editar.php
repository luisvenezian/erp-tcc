<?php 

	$data['controller'] = "perfil";
	$this->load->view('header',$data) 	
?>

<link rel = "stylesheet" type = "text/css" href = "application\views\assets\css\perfil.css"/>
<script type='text/javascript' src="application\views\assets\js\perfil_editar.js"></script>

<div class="container portfolio">
<br>
	<div class="row">
		<div class="col-md-12">
			<div class="heading">				
				<img src="application\img\perfil-img-logo.png" /> <strong>Editar Perfil</strong>
			</div>
		</div>	
	</div>
	<div class="bio-info">
	<?php  echo form_open_multipart('perfil/gravar'); ?> 
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-12">
						<div class="bio-image">
							<img src= "<?php echo $user_url_img; ?>"class="img-fluid img-thumbnail" alt="image" 
							height="200" width="300"/>
							<hr>	
							<strong>Alterar Imagem:	</strong><input name ="user_file" type="file" class="form-control-file" id="exampleFormControlFile1">	
						</div>		
						
					</div>
				</div>	
			</div>
			<div class="col-md-6">
					
					<!-- Primeiro Nome -->
					<div class="bio-content">
					Primeiro Nome:
					<input name="user_first_name" class="form-control form-control-lg" type="text" placeholder="Primeiro Nome"  maxlength="50" value="<?php echo $user_first_name; ?> "required>

					<!-- Biografia -->
					<div class="form-group">
						<label for="bio">Biografia:</label>
						<textarea name="user_bio"  class="form-control" id="bio" value="<?php echo $user_bio; ?>" rows="3" required
						placeholder="É mais fácil obter o que se deseja com um sorri.... William Shakespeare" maxlength="130"><?php echo $user_bio; ?></textarea>
					</div>

					<hr>
					<!-- Número de Telefone -->
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroup-sizing-sm">Telefone: </span>
						</div>
						<input  name="user_phone_number"  id="user_phone_id" type="text" maxlength="9" pattern="([0-9]{9})"  value="<?php echo $user_phone_number; ?>" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required> 	
					</div>

					<!-- Número da Operadora -->
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroup-sizing-sm">Operadora: </span>
						</div>
						<input name="user_phone_prefix" id="user_prefix_id" type="text" maxlength="3" pattern="([0-9]{3})" value="<?php echo $user_phone_prefix; ?>" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required> 	
					</div>

					<!-- Descrição da Profissão -->
					<div class="input-group input-group-sm mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroup-sizing-sm">Profissão: </span>
					</div>
					<input name="user_job_role" type="text" maxlength="250" value="<?php echo $user_job_role; ?>" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
					</div>

					<hr>
					<button type="submit" class="btn btn-outline-success btn-sm btn-block">Gravar</button>

				</div>

			<?php echo form_close(); ?>
			</div>
		</div>	
	</div>
</div>
<?php $this->load->view('footer') ?>
