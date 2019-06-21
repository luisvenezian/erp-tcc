<?php $data['controller'] = "perfil";
$this->load->view('header',$data) ?>
<!------ Include the above in your HEAD tag ---------->

<style>
body{
		background: linear-gradient(90deg, #e8e8e8 50%, #F7DC6F 50%);
	}
	.portfolio{
		padding:6%;
		text-align:center;
	}
	.heading{
		background: #fff;
		padding: 1%;
		text-align: left;
		box-shadow: 0px 0px 1px 0px #545b62;
	}
	.heading img{
		width: 7%;
	}
	.bio-info{
		padding: 5%;
		background:#fff;
		box-shadow: 0px 0px 1px 0px #545b62;
	}
	.name{
		font-family: 'Charmonman', cursive;
		font-weight:600;
	}
	.bio-image{
		text-align:center;
	}
	.bio-image img{
		border-radius:0%;
	}
	.bio-content{
		text-align:left;
	}
	.bio-content p{
		font-weight:600;
		font-size:30px;
	}
</style>

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
							<img src="application\archives\luis.jpg" class="img-fluid img-thumbnail" alt="image" height="200" width="300"/>
						</div>			
					</div>
				</div>	
			</div>
			<div class="col-md-6">
				<div class="bio-content">
				
					<h2>Luis Felipe</h2>
					<h6>I have no special talent, I'm just passionately curious ;)</h6>
					<hr>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="user"></span> KPL.LUIS
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="phone"></span> (14) 99824-5302
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="mail"></span> luis.venezian@kplay.com.br
							</a>
						</li>
					</ul>

					<ul class="nav flex-column">
						<li class="nav-item">
							<a class='nav-link'>
							<span data-feather="code"></span> Banco de Dados
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
