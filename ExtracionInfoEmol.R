library('rvest')

# Abrir csv
if(file.exists("TablaEmol.csv")){
  print("Abre CSV")
  AlmacenarTablasDepa2 <- read.csv(file = "TablaEmol.csv", header = TRUE, sep = " ")
}

#Se asigna de economia de Emol
Emol<-'https://www.emol.com/economia/'

#Leyendo pagina de Emol
PaginaEmol <- read_html(Emol)

ContEmol <- html_nodes(PaginaEmol,'#col_center_420px')
print (ContEmol)

#Se extraen los elementos que contienen links dentro de Emol
ContenidoEmol <- html_nodes(ContEmol,'h3')
print (ContenidoEmol)

#Se extraen los elementos que contienen links dentro de Emol
ContenidoNoticia <- html_nodes(ContenidoEmol,'a')
print (ContenidoNoticia)

# Se extraen todos los links y se almacenan en una lista
Links <- html_attr(ContenidoNoticia,'href')
print (Links)

LinkEmol<-paste('https://www.emol.com',Links, sep="")
print(LinkEmol)


TablaEmol<-data.frame()

for(link in LinkEmol){
  print(link)
  InfoDeLinks <- link
  
   NoticiasEmol <-read_html(InfoDeLinks)
  
  # Extracción de Titutlos de las noticias de Emol 
  TituloEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTitular_tituloNoticia')
  TituloNoticia <- html_text(TituloEmol)
  # Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
  TituloNoticia <- gsub("\n","",TituloNoticia)
  TituloNoticia <- gsub("\"","",TituloNoticia)
  TituloNoticia <- gsub("[.]","",TituloNoticia)
  TituloNoticia <- gsub(",","",TituloNoticia)
  TituloNoticia <- gsub("[()]","",TituloNoticia)
  TituloNoticia <- gsub("-","",TituloNoticia)
  # Separando las palabras por espacio
  SplitTituloNoticia <- strsplit(TituloNoticia," ")[[1]]
  # Pasando todas las palabras a minusculas
  SplitTituloNoticia <- tolower(SplitTituloNoticia)
  # Contando palabras
  UnlistTituloNoticia<-unlist(SplitTituloNoticia)
  #Pasando la informacion a tabla
  Titulo<-table(UnlistTituloNoticia)

  # Extracción de Bajadas de las noticias de Emol 
  BajadaEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTitular_bajadaNoticia')
  BajadaNoticia <- html_text(BajadaEmol)

  BajadaNoticia <- gsub("\n","",BajadaNoticia)
  BajadaNoticia <- gsub("\"","",BajadaNoticia)
  BajadaNoticia <- gsub("[.]","",BajadaNoticia)
  BajadaNoticia <- gsub(",","",BajadaNoticia)
  BajadaNoticia <- gsub("[()]","",BajadaNoticia)
  BajadaNoticia <- gsub("-","",BajadaNoticia)

  SplitBajadaNoticia <- strsplit(BajadaNoticia," ")[[1]]

  SplitBajadaNoticia <- tolower(SplitBajadaNoticia)

  UnlistBajadaNoticia<-unlist(SplitBajadaNoticia)

  Bajada<-table(UnlistBajadaNoticia)

  # Extracción de fecha y autor de la noticia de Emol 
  FechaEmol <- html_nodes(NoticiasEmol, ".info-notaemol-porfecha")
  FechaNoticia <- html_text(FechaEmol)
  #Pasando la informacion a tabla
  Fecha<-table(FechaNoticia)

  # Extracción del cuerpo de la noticia de Emol 
  TextoEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTexto_textoNoticia')
  CuerpoNoticia <- html_text(TextoEmol)
  
  CuerpoNoticia <- gsub("\n","",CuerpoNoticia)
  CuerpoNoticia <- gsub("\"","",CuerpoNoticia)
  CuerpoNoticia <- gsub("[.]","",CuerpoNoticia)
  CuerpoNoticia <- gsub(",","",CuerpoNoticia)
  CuerpoNoticia <- gsub("[()]","",CuerpoNoticia)
  CuerpoNoticia <- gsub("-","",CuerpoNoticia)
  
  SplitCuerpoNoticia <- strsplit(CuerpoNoticia," ")[[1]]
  
  SplitCuerpoNoticia <- tolower(SplitCuerpoNoticia)
  
  UnlistCuerpoNoticia <-unlist(SplitCuerpoNoticia)
  
  Cuerpo<-table(UnlistCuerpoNoticia)

  UnifTablaEmol<-data.frame(Cuerpo)
  
  TablaEmol<-rbind(TablaEmol,UnifTablaEmol)
}

#Cerrar archivo csv con toda la informacion
write.csv(TablaEmol, file = "TablaEmol.csv")


# Graficando la fracuencia de las palabras
library('ggplot2')

# Grafico Barra por frecuencia de palabaras
TablaEmol %>%
  ggplot() +
  aes(x = UnlistCuerpoNoticia, y =  Freq) +
  geom_bar(stat="identity")
