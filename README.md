# financial-risk

La página de emol.com (“el mercurio on line”). entrega gran cantidad de noticias y de todo ámbito.
Esta página va publicando y actualizando las noticias a cada hora, además, cuenta con blogs. A través 
de las noticias financieras, económicas y de inversiones (quizás se necesiten noticias de otro tipo)
que entrega la página de emol. Se buscará, recolectará y analizará todos los datos posibles
encontrados en esta página con el fin de poder crear una manera de predecir y anticipar los riesgos 
que existen de los diversos instrumentos financieros que son transados en el mercado de capitales.

Lo anterior, se intentó realizar a través del programa R, la extracción de datos financieros según la
información que se han publicado.
Se extrajo los distintos links que se encuentra en la página de Emol, en la sección de económia, con
la intención de lograr la recopilación de datos de cada link.
Se busco la forma de conocer el titutlo, la bajada y el cuerpo de cada noticia, pero este proceso fracasó.
Dada las condicioens anteriores, es que se procedió a realizar una prueba utilizando la noticia
"Operadores financieros proyectan que el Banco Central subirá la tasa de interés hasta 3% en enero
Fuente: Emol.com - https://www.emol.com/noticias/Economia/2019/01/25/935583/Operadores-financieros-proyectan-que-el-Banco-Central-subira-la-tasa-de-interes-hasta-3.html"
Con esta noticia, se logró obtener el titulo, la bajada, fecha y hora, y el cuerpo de la noticia.
Cada parte de la noticia se llevó a una data frame con la intención de conocer cuales son las
palabras más comunes, para poder tener una idea de como la tasa de interés impacta en el mercado.