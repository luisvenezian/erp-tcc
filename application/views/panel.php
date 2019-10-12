<?php 
$data['controller'] = "panel";
$this->load->view('header',$data);

/*Recebendo os dados pro gráfico:*/

$qtdEngorda =  $alocacoes[0]->qtdEngorda;
$qtdRecria =  $alocacoes[0]->qtdRecria;
$qtdPosDesmama =  $alocacoes[0]->qtdPosDesmama;
$qtdPreAbate =  $alocacoes[0]->qtdPreAbate;

$qtdFemeasDisponiveis = $qtd[0]->qtdFemea;
$qtdMachosDisponiveis = $qtd[0]->qtdMacho;


?>
        <!-- Aqui vai o conteúdo -->
        <h2>
        <?php 
        
        date_default_timezone_set('America/Sao_Paulo');

        $user = strtoupper(getUserName());
        $date = new DateTime();
        $hour = $date->format('H');

        if(($hour >= 6) && ($hour<=12))
        {
                $saudacao = "Bom dia, ";
        }
        else if (($hour > 12) && ($hour <= 18))
        {
                $saudacao = "Boa tarde, ";
        }
        else 
        {
                $saudacao = "Boa noite, ";
        }

        echo $saudacao . $user . ". <br>Bem vindo ao sistema!";
        ?>
        
        </h2>
        <hr>
        <div class="row">

                <div class="col-sm">
                        <!--<canvas id="myChart" width="400" height="400"></canvas>-->
                        <div id="container"></div>
                </div>

                <div class="col-sm">
                        <div id="container2"></div>
                </div>
        </div>
        
        <script>
        /*
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
        type: 'pie',
        data: {
                labels: ['Pós-Desmama', 'Recria', 'Engorda', 'Pré-abate'],
                datasets: [{
                label: '# of Votes',
                data: [<?php echo $qtdPosDesmama. ','. $qtdRecria .','. $qtdEngorda . ',' . $qtdPreAbate ?>],
                //data: [12, 19, 3, 5],
                backgroundColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                ],
                borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
                }]
        }
        });
        */


        Highcharts.chart('container', {
        chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
        },
        title: {
                text: 'Visão de porcos em cada estágio'
        },
        tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
                pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.y:.1f} '
                }
                }
        },
        series: [{
                name: 'Suinos',
                colorByPoint: true,
                data: [{
                name: 'Qtd Pós Desmama',
                y: <?php echo $qtdPosDesmama ?>,
                }, 
                {
                name: 'Qtd Recria',
                y: <?php echo $qtdRecria ?>,
                }, 
                {
                name: 'Qtd Engorda',
                y: <?php echo $qtdEngorda ?>
                }, 
                {
                name: 'Qtd Pré Abate',
                y: <?php echo $qtdPreAbate ?>
                }
                ]
        }]
        });


        Highcharts.chart('container2', {
        chart: {
                type: 'column'
        },
        title: {
                text: 'Suinos por Sexo'
        },
        subtitle: {
                text: 'Considera todos suinos vivos que não estão em lotes'
        },
        xAxis: {
                categories: [
                'Criações'
                ],
                crosshair: true
        },
        yAxis: {
                min: 0,
                title: {
                text: 'Quantidade'
                }
        },
        tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.0f} </b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
        },
        plotOptions: {
                column: {
                pointPadding: 0.2,
                borderWidth: 0
                }
        },
        series: [{
                name: 'Machos',
                data: [<?php echo $qtdMachosDisponiveis ?>]

        }, {
                name: 'Fêmeas',
                data: [<?php echo $qtdFemeasDisponiveis ?>]

        }]
        });
        </script>
<?php $this->load->view('footer') ?>
