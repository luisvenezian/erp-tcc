<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class Panel extends CI_Controller {

	public function index()
	{
		if (verify_logged() <> true){
			redirect('login','refresh');
		}
		else
		$this->load->view('panel');
	}
}
