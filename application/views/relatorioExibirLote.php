<br>
<br>
<h1>Lote</h1>
<?php echo $result;
if (isset($result)) 
{
                echo "<hr class='my-4'>\n";
                ?>
                <button id="download-csv" onclick="csv()" type="button" class="btn btn-outline-info btn-sm">Download CSV</button>
                <button id="download-json" onclick="json()" type="button" class="btn btn-outline-info btn-sm">Download JSON</button>
                <button id="download-xlsx" onclick="xlsx()" type="button" class="btn btn-outline-info btn-sm">Download XLSX</button>
                <button id="download-pdf" onclick="pdf()" type="button" class="btn btn-outline-info btn-sm">Download PDF</button>
                <hr class='my-4'>
<?php
            }
?>

<br>
<h1>Tratamentos</h1>
<?php echo $result2;
if (isset($result)) 
{                   
                echo " <hr class='my-4'>\n";
                ?>
                <button id="download-csv" onclick="csv()" type="button" class="btn btn-outline-info btn-sm">Download CSV</button>
                <button id="download-json" onclick="json()" type="button" class="btn btn-outline-info btn-sm">Download JSON</button>
                <button id="download-xlsx" onclick="xlsx()" type="button" class="btn btn-outline-info btn-sm">Download XLSX</button>
                <button id="download-pdf" onclick="pdf()" type="button" class="btn btn-outline-info btn-sm">Download PDF</button>
                <hr class='my-4'>
<?php
            }
?>