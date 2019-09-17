<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Suino extends CI_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Suino_Model', 'bd');
    }

    public function index()
    {
        if (verify_logged() <> true) {
            redirect('login', 'refresh');
        } else {
            $this->load->view('suino');
        }
    }
    public function suino()
    {
        $this->load->view('suino');
    }
}
