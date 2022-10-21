
# ID SCRIPT ---------------------------------------------------------------

## LENGUAJES DE PROGRAMACION ESTADISTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO: MIGUEL PRIETO 21981393
## HANDS ON 01

browseURL("https://github.com/ProgramadorMiguel/LPE21981393") 

# INSTALAR LIBRERÍAS ------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman,magrittr,productplots,psych,RColorBrewer)
#pacman es un gestor de paquetes
#magrittr - pipe bidireccional
#productplots - plot variables categóricas
#psych - estadística
#RColorBrewer - colores

# LOAD AND PREPARE DATA ---------------------------------------------------

browseURL("http://j.mp/37Wxvv7") 
tipo_happy<-happy #Es formato dataframe (mejor usar formato tibble siempre)
df<- happy %>% as_tibble()
view(df)
#?happy información del dataset
levels(df$happy)  #check happy levels
df %<>% mutate(happy=fct_rev(happy))#Dar la vuelta a los niveles


# OUTCOME VARIABLES: HAPPINESS --------------------------------------------

df %>% ggplot()+geom_bar(aes(happy,fill=happy))+
                          theme(axis.title.x = element_blank(),legend.position = "none")
#Frecuencias for happiness
df %>% count(happy)
#Se queda solo con las columnas que hay entre happy y health
df %<>% select(happy:health) %>% view()
df %<>% filter(!is.na(happy))

# HAPPINESS AND GENDER ----------------------------------------------------

df %>% ggplot(aes(sex, fill=happy))+geom_bar(position="fill")
# HAPPINESS AND MARITAL STATUS --------------------------------------------

df %>% ggplot(aes(marital, fill=happy))+geom_bar(position="fill")

# HAPPINESS AND EDUCATION LEVEL -------------------------------------------

df %>% ggplot(aes(degree, fill=happy))+geom_bar(position="fill")


# HAPPINESS AND MONEY -----------------------------------------------------

df %>% ggplot(aes(finrela, fill=happy))+geom_bar(position="fill")
view(df)


# NEW COLUMN MARITAL STATUS TO BINARIO ------------------------------------

df %<>%mutate(married = if_else(marital=="married","yes","no")) %>% 
  mutate(married=as_factor(married)) %>% view()

# HAPPINESS AND MARRIED -----------------------------------------------------

df %>% ggplot(aes(married, fill=happy))+geom_bar(position="fill")
