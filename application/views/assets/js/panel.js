
/* Carrega href da tela inicial para mandar a pesquisa
 * para controller de pesquisa.
 * 
 */ 
function dispararPesquisa() {
  var href = "\\pesquisa?value=";
  var pesquisa = $("input[name=pesquisador]").val();
  var enviar = href.concat(pesquisa);
  $('#disparapesquisa').attr('href',enviar);
}