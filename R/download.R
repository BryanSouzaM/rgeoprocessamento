#' Donwload de estações da ANA
#'
#' Função para download de estações da ANA
#' 
#' 
#' 
#'
#' @param lista Lista de códigos
#' @param tipo 1 para .mdb, 2 para .txt e 3 para .csv
#' @return .zip das estações
#' @export

download_estacoes <- function(lista, tipo = 3, destino = getwd()){
  
  
  
  baseurl = "http://www.snirh.gov.br/hidroweb/rest/api/documento/convencionais?tipo=&documentos="
  
  ListaEstacaoes = lista
  
  # tipo=1 arquivo access *.mdb
  # tipo=2 arquivo texto  *.txt
  # tipo=3 arquivo excel  *.csv
  
  #substituindo o tipo
  baseurl = gsub("tipo=",paste0("tipo=",tipo),baseurl)
  
  for(i in 1:length(ListaEstacaoes)){
    baseurl_est = paste0(baseurl,ListaEstacaoes[i])
    
    #Conexao
    r = POST(url = baseurl_est, body = list(cboTipoReg = "10"), encode = "form")
    if (r$status_code == 405) {
      cont = content(r, as = "text", encoding="ISO-8859-1")
      download.file(baseurl_est, paste0(ListaEstacaoes[i], ".zip"), mode = "wb")
    }
  }
  
  
}
