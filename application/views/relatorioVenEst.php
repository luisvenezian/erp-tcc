<?php
$data['controller'] = "Relatorio";
$this->load->view('header', $data);
?>
<script type='text/javascript' src="..\application\views\assets\js\executarsql.js"></script>
<link rel="stylesheet" type="text/css" href="..\application\views\assets\css\executarsql.css" />
<script type="text/javascript" src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.0.5/jspdf.plugin.autotable.js"></script>

<h2>Tela de Relatórios <?php ?></h2>
<div class="form-group">
        <label for="dataInicio">Data Inicio</label>
        <input type="date" id="dataInicio" name="dataInicio" class="form-control">
</div>
<div class="form-group">
        <label for="dataFinal">Data Final</label>
        <input type="date" id="dataFinal" name="dataFinal" class="form-control">
</div>

<button type="button" onclick='exibir<?php echo $tipo ?>()' class="btn btn-primary">Consultar</button>

<div id="resultado">

</div>

<script>

        function exibirVenda() {
                dataInicio = $("#dataInicio").val();
                dataFinal = $("#dataFinal").val();
                $.ajax({
                        url: '<?php echo base_url('relatorio/historicoVenda'); ?>',
                                crossDomain: true,
                                type: 'POST',
                                data: {
                                        dataInicio: dataInicio,
                                        dataFinal: dataFinal
                                }
                        })
                        .done(function(msg) {
                                $("#resultado").html(msg);
                        });
        }

        function exibirEstoque() {
                dataInicio = $("#dataInicio").val();
                dataFinal = $("#dataFinal").val();
                $.ajax({
                        url: '<?php echo base_url('relatorio/historicoEstoque'); ?>',
                                crossDomain: true,
                                type: 'POST',
                                data: {
                                        dataInicio: dataInicio,
                                        dataFinal: dataFinal
                                }
                        })
                        .done(function(msg) {
                                $("#resultado").html(msg);
                        });
        }


        function csv() {
                var table = new Tabulator("#id_table", {});
                table.download("csv", "data.csv");

        }

        function pdf() {
                var table = new Tabulator("#id_table", {});
                table.download("pdf", "data.pdf", {
                        orientation: "portrait",
                        title: "Histórico de Pesagem",
                });

        }

        function xlsx() {
                var table = new Tabulator("#id_table", {});
                table.download("xlsx", "data.xlsx", {
                        sheetName: "My Data"
                });

        }

        function json() {
                var table = new Tabulator("#id_table", {});
                table.download("json", "data.json");

        }
</script>

<?php $this->load->view('footer') ?>