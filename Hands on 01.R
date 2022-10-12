
# ID SCRIPT ---------------------------------------------------------------

## LENGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO: PABLO DORREGO, EXP 22040682
## HANDS ON 01

# SHORTCUTS ---------------------------------------------------------------

## ctrl + l = clean console
## ctrl + shift + r = new section
## ctrl + enter = run

# LOADING LIBS ------------------------------------------------------------

install.packages("janitor") 
install.packages("pacman")
install.packages("tidyverse") 
install.packages("httr") ##instalador de paquetes
library(tidyverse)
library(httr)
dp

## httr buscar archivos de internet
## janitor formatear y limpiar los datos

# BASIC OPERATORS ---------------------------------------------------------

#inicializar
cristina <- 20
clase_lep <- c("marta", "emilia", "pablo") # la c es de combine y sirve para agrupar y convertir en array

##para coger datos de internet
#df<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
#glimpse(precios)

# GETTING DATA FROM INTERNET ----------------------------------------------

url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
df<- GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

xml2::read_xml(df$content) 

#que hacia esto
f_raw <- jsonlite::fromJSON(url_)

# Glimpse = genera listado en consola  de alta potencia (como view pero mejor )
df_source <- f_raw$ListaEESSPrecio %>%  glimpse()

#para limpiar los nombres de las columnas (quitar los `` de cada variable)
janitor::clean_names(df_source) %>%  glimpse()

#para saber que configuración tenemos (puntos en vez de comas...)
glimpse()
#cambiamos las , por . en longitud y latitud 
type_convert(df_source,locale =  )
#cambiamos las , por . en longitud y latitud y lo imprimimos por pantalla con glimpse
df_source  %>%  clean_names()  %>% type_convert(locale= locale(decimal_mark)= ",") %>%  glimpse()
#Lo guardamos en una variable
df_cambios <-df_source  %>% janitor::clean_names()  %>% type_convert(locale = locale(decimal_mark= ","))


# CREATING A NEW VARIABLE -------------------------------------------------


# Clasificamos por gasolineras baratas y no baratas -----------------------

#buscamos a ver donde están guardados los nobres de las gasolineras con este comando
df_cambios  %>% view()

#metemos en esta variable (expensive) los noombres de las gasolineras caras
#mutate
#df_cambios$rotulo ---> busca en df_cambios, en la variable rotulo todo lo de denro que se llame cepsa repsol bp shell
df_low<-df_cambios %>% mutate(expensive = !rotulo %in% c("CEPSA", "REPSOL", "BP", "SHELL"))


# Cual precio medio del gasoleo en las CCAA -------------------------------
#select para seleccionar las variables del dataset
# $ busca nombre de la variable en el DF
#
df_low   %>% select(precio_gasoleo_a, idccaa, rotulo, expensive)  %>% drop_na()   %>% group_by(idccaa, expensive)  %>% summarise(mean(precio_gasoleo_a))  %>% view()

df_low   %>% view()
#poner a la id el nombre de la comunidad y llamar ds21981393

ccaa<- c("Andalucía",
         "Aragón",
         "Principado de Asturias",
         "Illes Balears",
         "Canarias",
         "Cantabria",
         "Castilla y León",
         "Castilla-La Mancha",
         "Cataluña",
         "Comunitat Valenciana",
         "Extremadura",
         "Galicia",
         "Comunidad de Madrid",
         "Región de Murcia",
         "Comunidad Foral de Navarra",
         "País Vasco",
         "La Rioja",
         "Ciudad Autónoma de Ceuta",
         "Ciudad Autónoma de Melilla")
idcca<- c("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19")
df_ccaa <- data.frame(ccaa, idcca)
ds21981393 <- merge(df_low,df_ccaa)
ds21981393   %>% view()


# READING AND WRITING (FILES) ---------------------------------------------------------

glimpse(preciosEESS_es) #se usa mazo invierte la tabla

# GIT COMMANDS ---------------------------------------------------------

git status 
git init
git add
git commit -m "message"
git push -u origin main
git branch Miguel
git merge
git remote add origin https://github.com/ProgramadorMiguel/LPE21535220.git
git clone https://github.com/ProgramadorMiguel/LPE21535220.git
git pull
git fetch
git log (para saber lo que ha hecho el usuario) --oneline
git diff comparar dos ramas
git reset (commit) volver a un checkpoint
git branch para ver en que rama estas
git clean -n borrar archivos
git remote -v para saber si estas enlazado 
git rename oldname newname
git push -u origin main

# TERMINAL COMMANDS ---------------------------------------------------------

ls
cd 
pwd
cd ..
mkdir
touch
nano
less (te devuelve lo que hay dentro del archivo y deja moverte a través)
cat (te devuelve lo que hey dentro del archivo)
where
which


