library('rvest')

DFEmol<-data.frame()

#Se asigna de economia de Emol
Emol<-'https://www.emol.com/economia/'

#Leyendo pagina de Emol
PaginaEmol <- read_html(Emol)

ContEmol <- html_nodes(PaginaEmol,'[id="col_center_420px"]')
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

for(i in Links){
  print(i)
LinkEmol<-paste('https://www.emol.com',i, sep="")
print(LinkEmol)
}

for(link in LinkEmol){
  print(link)
  InfoDeLinks <- link
  
   NoticiasEmol <-read_html(InfoDeLinks)
  
  # Extracción de Titutlos de las noticias de Emol 
  TituloEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTitular_tituloNoticia')
  TituloNoticia <- html_text(TituloEmol)
  
  # Extracción de Bajadas de las noticias de Emol 
  BajadaEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTitular_bajadaNoticia')
  BajadaNoticia <- html_text(BajadaEmol)
  
  # Extracción de fecha y autor de la noticia de Emol 
  FechaEmol <- html_nodes(NoticiasEmol, ".info-notaemol-porfecha")
  FechaNoticia <- html_text(FechaEmol)  
  
  # Extracción de fecha y autor de la noticia de Emol 
  TextoEmol <- html_nodes(NoticiasEmol, '#cuDetalle_cuTexto_textoNoticia')
  CuerpoNoticia <- html_text(TextoEmol)
  
  df <- data.frame(TituloNoticia = TituloNoticia, BajadaNoticia = BajadaNoticia, FechaNoticia=FechaNoticia, CuerpoNoticia=CuerpoNoticia)

  DFEmol<-rbind(DFEmol,df)
}






# No se logró hacer el for, se analiza una noticia.


library('rvest')

DFWeb<-data.frame()

#Se asigna de economia de Emol
WebPageEmol<-'https://www.emol.com/noticias/Economia/2019/01/25/935583/Operadores-financieros-proyectan-que-el-Banco-Central-subira-la-tasa-de-interes-hasta-3.html'

#Leyendo noticia de Emol
WebEmol <- read_html(WebPageEmol)
print(WebEmol)

# Extracción de Titutlos de las noticias de Emol 
Titulo <- html_nodes(WebEmol, '[id="cuDetalle_cuTitular_tituloNoticia"]')
TituloWeb <- html_text(Titulo)
print(TituloWeb)

TituloWeb <- gsub("\n","",TituloWeb)
TituloWeb <- gsub("\"","",TituloWeb)
TituloWeb <- gsub("[.]","",TituloWeb)
TituloWeb <- gsub(",","",TituloWeb)

# Separando las palabras por espacio
SplitTitulo <- strsplit(TituloWeb," ")[[1]]

# Pasando todas las palabras a minusculas
SplitTitulo <- tolower(SplitTitulo)

# Contando palabras
UnlistTitulo<-unlist(SplitTitulo)
TablaTitulo<-table(UnlistTitulo)

print(TituloWeb)
print(TablaTitulo)

# Pasando la informacion a un data frame
DFTitulo<- as.data.frame(TablaTitulo)

# Extracción de Bajadas de las noticias de Emol 
Bajada <- html_nodes(WebEmol, '[id="cuDetalle_cuTitular_bajadaNoticia"]')
BajadaWeb <- html_text(Bajada)
print(BajadaWeb)

BajadaWeb <- gsub("\n","",BajadaWeb)
BajadaWeb <- gsub("\"","",BajadaWeb)
BajadaWeb <- gsub("[.]","",BajadaWeb)
BajadaWeb <- gsub(",","",BajadaWeb)

SplitBajada <- strsplit(BajadaWeb," ")[[1]]
SplitBajada <- tolower(SplitBajada)
UnlistBajada<-unlist(SplitBajada)
TablaBajada<-table(UnlistBajada)

print(BajadaWeb)
print(TablaBajada)

DFBajada<- as.data.frame(TablaBajada)

# Extracción de fecha y autor de la noticia de Emol 
Fecha <- html_nodes(WebEmol, ".info-notaemol-porfecha")
FechaWeb <- html_text(Fecha)
print(FechaWeb)

FechaWeb <- gsub("\n","",FechaWeb)
FechaWeb <- gsub("\r","",FechaWeb)
FechaWeb <- gsub("\"","",FechaWeb)
FechaWeb <- gsub("[.]","",FechaWeb)
FechaWeb <- gsub(",","",FechaWeb)

DFFecha<- as.data.frame(FechaWeb)

# Extracción de fecha y autor de la noticia de Emol 
Texto <- html_nodes(WebEmol, '#cuDetalle_cuTexto_textoNoticia')
CuerpoWeb <- html_text(Texto)
print(CuerpoWeb)

CuerpoWeb <- gsub("\n","",CuerpoWeb)
CuerpoWeb <- gsub("\"","",CuerpoWeb)
CuerpoWeb <- gsub("[.]","",CuerpoWeb)
CuerpoWeb <- gsub(",","",CuerpoWeb)
CuerpoWeb <- gsub("[()]","",CuerpoWeb)

SplitCuerpo <- strsplit(CuerpoWeb," ")[[1]]
SplitCuerpo <- tolower(SplitCuerpo)
UnlistCuerpo<-unlist(SplitCuerpo)
TablaCuerpo<-table(UnlistCuerpo)

print(CuerpoWeb)
print(TablaCuerpo)

DFCuerpo<- as.data.frame(TablaCuerpo)

#Almacenando la informacion en CSV
write.csv(DFTitulo, file="PalabrasTitulo.csv")
write.csv(DFBajada, file="PalabrasBajada.csv")
write.csv(DFFecha, file="PalabrasFecha.csv")
write.csv(DFCuerpo, file="PalabrasCuerpo.csv")

# o en un txt
write.table(DFTitulo, file="PalabrasTitulo.txt")
write.table(DFBajada, file="PalabrasBajada.txt")
write.table(DFFecha, file="PalabrasFecha.txt")
write.table(DFCuerpo, file="PalabrasCuerpo.txt")

#Graficando las palabras del cuerpo
library('ggplot2')
# Grafico Barra por frecuencia de palabras,
# respecto al costo
DFBajada %>%
  ggplot() +
  aes(x = UnlistBajada, y = Freq) +
  geom_bar(stat="identity")

  # GrÃ¡fico boxplot diferenciado por producto
DFBajada %>%
  ggplot() +
  geom_boxplot(aes(x = UnlistBajada, y = Freq)) +
  theme_bw()
