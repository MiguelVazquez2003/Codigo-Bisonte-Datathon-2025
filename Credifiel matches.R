
library("readr")
library("dplyr")
install.packages("dplyr")
install.packages("readr")

d <- read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/ListaCobroDetalle2025.csv")
names(d)[4] <-"IdBanco"
names(d)[9] <-"IdRespuestaBanco"
View(d)
catban <- read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/CatBanco.csv")
View(catban)
catem <-read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/CatEmisora.csv")
View(catem)
catresp <- read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/CatRespuestaBancos.csv")
View(catresp)
listco <- read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/ListaCobro.csv")
View(listco)
listcoemi <- read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/ListaCobroEmisora.csv")
View(listcoemi)

d <- left_join(d, catban, by="IdBanco")
names(d)[10] <-"NomBanco"
#View(d)
d <- left_join(d, listcoemi, by="idListaCobro")
names(d)[11] <- "idEmisora"
#View(d)
d <- left_join(d,catem , by="idEmisora")
names(d)[12] <- "NomEmisora"
d$IdBanco.y <- NULL
#View(d)
d <- left_join(d,catresp , by="IdRespuestaBanco")
#View(d)
d <- left_join(d,listco , by="idListaCobro")
d$idBanco <- NULL
View(d)

setwd("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/Listascobrodetalleschido")
write.csv(d,"C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/2025.csv",row.names=FALSE )
getwd()


hist(d$IdRespuestaBanco)
summary(d$montoCobrar)
hist(d$montoCobrar)
table(d$IdRespuestaBanco)

d2024 <-read.csv("C:/Users/saund/Desktop/Datathon credifiel/ExtraccionDomiVersionFinal/Listascobrodetalleschidos/2024.csv")
View(d2024)
count_cre <-table(d2024$idCredito)
count_cre <-as.data.frame(count_cre)
names(count_cre)[1] <- "IdCredito"
View(count_cre)

df_des <- df[ order(-count_cre$Freq), ]

coun_emi <- table(d2024$NomEmisora)
coun_emi <-as.data.frame(coun_emi)
View(coun_emi)

sum <- list(sum(coun_emi$Freq[1:4]), sum(coun_emi$Freq[5:10]),sum(coun_emi$Freq[11:20]),sum(coun_emi$Freq[21], coun_emi$Freq[22]) )
nom <- list("BANAMEX", "BANORTE","BBVA", "SANTANDER")

sum <- unlist(sum)
nom <- unlist(nom)
c_e <- data.frame(
  NomEmiso =nom, 
  Freq =sum,
  stringsAsFactors = FALSE)
View(c_e)
sum(coun_emi$Freq)
sum(c_e$Freq)

coun_banc<- table(d2024$NomBanco)
View(coun_banc)

emi_EF <- table(d2024$NomEmisora, d2024$IdRespuestaBanco == 0)
emi_EF
View(emi_EF)
ban_data <- as.data.frame.matrix(emi_EF)
View()
names(ban_EF)[1] <- "Banco"
names(ban_EF)[2] <- "=0"
names(ban_EF)[3] <- "!=0"
View(ban_EF)
