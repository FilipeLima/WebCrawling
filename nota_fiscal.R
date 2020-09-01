# Função para analisar processar um pdf em formato de nota fiscal.
# Primeiro entrar no site da SEFAZ/PE: http://nfce.sefaz.pe.gov.br/nfce-web/consultarNFCe
# Usar o código de acesso que vem na Nota Fiscal.
# Usar como exemplo: 26200775315333015211655050001092841048579176
# Baixar o pdf e deixar no mesmo diretório do script.
# No caso o arquivo ficou "nota.pdf".


library(pdftools)
library(dplyr)
library(stringr)

dataNota <- function(arquivo) {
  nota <- pdf_text(arquivo) %>% strsplit(split = "\n") %>% unlist()
  nota_fiscal <-
    data.frame(
      produto = c(),
      codigo = c(),
      quantidade = c(),
      unidade = c(),
      valor = c()
    )
  for (i in grep("Código", nota)) {
    linha_produ <- unlist(strsplit(nota[i], split = "  "))
    linha_produ <- grep("Código*", linha_produ, value = T)
    codigo <-sub(")", "", unlist(strsplit(linha_produ, split = " "))
                 [grep("Código",unlist(strsplit(linha_produ, split =" "))) + 1])
    produto <- str_remove_all(linha_produ, "\\(Código: [0-9]+\\)")
    linha_preco <- unlist(strsplit(nota[i + 1], split = " "))
    quantidade <- linha_preco[2]
    quantidade <-  gsub(",", ".", quantidade)
    preco <- linha_preco[grep("Unit.:", linha_preco) + 1]
    preco <- gsub(",", ".", preco)
    unidade <- linha_preco[grep("UN:", linha_preco) + 1]
    nota_fiscal <-
      rbind(nota_fiscal, c(produto, codigo, quantidade, unidade, preco))
  }
  names(nota_fiscal) <-
    c("Produto", "Codigo", "Quantidade", "Unidade", "Valor")
  nota_fiscal$Quantidade <- as.numeric(nota_fiscal$Quantidade)
  nota_fiscal$Valor <- as.numeric(nota_fiscal$Valor)
  nota_fiscal$Subtotal <- nota_fiscal$Quantidade * nota_fiscal$Valor
  return(nota_fiscal)
}

View(dataNota("nota.pdf"))


