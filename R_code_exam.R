
##questo codice è stato scritto utilizzando i seguenti pacchetti prima installati.

library(terra)   ##pacchetto R specializzato in metodi per l'analisi di dati spaziali
library(imageRy)  ##pacchetto R specializzato nella manipolazione e condivisione di immagini raster 
library(ggplot2)   ##pacchetto R specializzato nella creazione di grafici
library(patchwork)  ##pacchetto R specializzato nella composizioni di più grafici
library(viridis) ##pacchetto R per l’utilizzo di palette di colori Colorblind-Friendly

##dopo aver installato i pacchetti questi si richiamano con la funzione library() oppure con la funzione require()
##non vanno messe le virgolette con la funzione library perché sono già dentro ad R dato che il pacchetto è stato installato

setwd("/Users/benedettaterzi/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/Documents/R") ##uso questa funzione set working directory per impostare la directory 

##ora importo immagini dall'esterno ovvero dalla directory usando la funzione rast() del pacchetto terra

v15<-rast("v15.jpg") ##colori naturali, bande R G e B
v15f<-rast("v15f.jpg") ##colori falsi, bande nir R e G
v23<-rast("v23.jpg")
v23f<-rast("v23f.jpg")

##le importo e le assegno ad un oggetto 
##il warning è dovuto alla mancata georeferenziazione

##dopo aver importato l'immagine per visualizzarla uso la funzione plot() del pacchetto terra mettendo tra  parentesi tonde il nome dell'oggetto a cui ho assegnato l’immagine

##posso creare un multiframe e visualizzarle insieme
par(mfrow=c(2,2)) ##i numeri nelle parentesi tonde mi indicano rispettivamente il numero di righe e di colonne
##uso la funzione c ovvero concatenate siccome 2 e 2 sono elementi di un vettore 
##uso la funzione plot per visualizzare l’immagine
plot(v15)
plot(v15f)
plot(v23)
plot(v23f)

dev.off()

##utilizzo due immagini per lo stesso anno siccome l’immagine «true colors» ha le bande R,G e B e in quella «false colors» nir, R e G.
##assegno le tre bande R G e B dalla prima immagine e la banda nir dalla seconda immagine a degli oggetti poi unisco le quattro bande

br15<-v15[[1]]  ##banda del rosso
bg15<-v15[[2]] ##banda del verde
bb15<-v15[[3]] ##banda del blu 
bi15<-v15f[[1]] ##banda nir 
band15<-c(br15,bg15,bb15,bi15)

br23<-v23[[1]] 
bg23<-v23[[2]]
bb23<-v23[[3]]
bi23<-v23f[[1]]
band23<-c(br23,bg23,bb23,bi23)

##posso spostare il nir sulle tre bande 
##uso la funzione, del pacchetto imageRy, im.plotRGB() e devo dichiarare il nome dell'immagine e le tre componenti RGB quindi associo ad ogni componente la relativa banda 

par(mfrow=c(3,2))

im.plotRGB(band15, 4,2,3) ##infrarosso sul rosso
im.plotRGB((band23, 4,2,3)

im.plotRGB(band15, 1,4,3) ##infrarosso sul verde
im.plotRGB(band23, 1,4,3)

im.plotRGB(band15, 1,2,4) ##infrarosso sul blu
im.plotRGB(band23, 1,2,4)

dev.off()

##se uso la funzione im.plotRGB.auto() devo dichiarare il nome dell'immagine e mi prende in automatico le prime tre bande
par(mfrow=c(1,2))
im.plotRGB.auto(band15)
im.plotRGB.auto(band23)

dev.off()

##classificazione di un'immagine e calcolo frequenza di ciascuna classe, numero totale di
celle (pixel), proporzione e percentuale dei cluster
##si utilizza la funzione im.classify(), funzione del pacchetto imageRy, dichiarando l'immagine e il numero di clusters, in questo caso sono 2 ovvero (uomo, vegetazione)

band15c<-im.classify(band15,num_clusters=2)
band23c<-im.classify(band23,num_clusters=2)  ##classificazione delle immagini 
par(mfrow=c(1,2))
plot(band15c)
plot(band23c)

dev.off()

f15<-freq(band15c) ##calcolo della frequenza di ciascun cluster (classe) ottenuto dalla classificazione
tot15<-ncell(band15c) ##calcolo del numero totale di celle (pixel)
prop15=f15/tot15 ##calcolo della proporzione delle classi
perc15=prop15*100 ##calcolo della percentuale delle classi 

f23<-freq(band23c) 
tot23<-ncell(band23c)
prop23=f23/tot23
perc23=prop23*100

tot15
tot23 ##numero di pixel totale è lo stesso 

##creazione del data frame con i dati
datav <- data.frame(
     anno = c(2015, 2015, 2023, 2023),
     classe = c("uomo", "foresta", "uomo", "foresta"),
     valori = c(35.5, 64.5, 38.1, 61.9))
 
##creazione del grafico a barre con ggplot2
ggplot(datav, aes(x = as.factor(anno), y = valori, fill = classe)) +
     geom_bar(stat = "identity", position = "dodge") +
     labs(title = "Distribuzione classi per anno",
          x = "Anno",
          y = "Valori percentuali",
          fill = "Classe") +
     theme_minimal()

##aes(x = as.factor(anno), y = valori, fill = classe) specifica che anno è sull'asse x, valori sull'asse y, e le barre sono riempite in base alla classe
##geom_bar(stat = "identity", position = "dodge") uso geom_bar per creare grafico a barre e position = "dodge" per affiancare le barre
##labs(): Aggiunge i titoli e le etichette agli assi
##theme_minimal(): uso tema grafico minimalista

##in questo modo abbiamo analizzato cambiamenti nello spazio tramite classificazione

##calcolo DVI (Difference Vegetation Index) e NDVI (normalized difference vegetation index)
##indice usato per calcolare salute e densità della vegetazione, si usano due bande nir e rosso (o nir e blu)

cl<- colorRampPalette(c("black","white","red"))(100) ## crea una scala di colori che va dal nero al bianco al rosso con 100 gradazioni

par(mfrow=c(1,2))

dvi15 = band15[[4]]-band15[[1]]
plot(dvi15, col=cl) 
##la risoluzione radiometrica in questo caso è 8 bit (256 valori, 8^2) ed il valore va da -255 (0-255 se minimo NIR e massimo Red) a +255 (255-0 se massimo NIR e minimo Red) ovvero faccio NIR - Red
dvi23 = band23[[4]]-band23[[1]]
plot(dvi23, col=cl)

dev.off()

##per fare delle comparazioni uso il NDVI (Normalized Difference Vegetation Index) quindi faccio (NIR - Red) / (NIR + Red) e questo varia tra -1 e 1 
##posso confrontare quindi immagini con bit diversi 

par(mfrow=c(2,2))

ndvi15 = dvi15/(band15[[4]]+band15[[1]]) 
plot(ndvi15, col=cl)
plot(ndvi15, col=viridis(100)) ##lo plotto con una palette colorblind-friendly

ndvi23 = dvi23/(band23[[4]]+band23[[1]]) 
plot(ndvi23, col=cl)
plot(ndvi23, col=viridis(100))

dev.off()

##per meglio visualizzare possiamo creare un istogramma con la percentuale di pixel e i valori di NDVI 

par(mfrow=c(1,2))
         
hist(ndvi15, main="ndvi2015", nclass = 20, xlab="ndvi")
hist(ndvi23, main="ndvi2023", nclass = 20, xlab=“ndvi")

##main è il nome del grafico, class il numero di classi, xlab il nome della variabile di x, ylab non l’ho messa perché di default mette frequenza (il numero di pixel appartenente a quella classe)
##con freq=F ci restituisce la density non su 100 ma su 10
##lo vogliamo in percentuale 

dev.off()

ist15<-hist(ndvi15)
ist23<-hist(ndvi23)

dev.off()

ist15
ist23

perc_nvdi15 = 100/sum(ist15$counts)
ist15$counts = ist15$counts * perc_nvdi15

perc_nvdi23 = 100/sum(ist23$counts)
ist23$counts = ist23$counts * perc_nvdi23

par(mfrow=c(1,2))
plot(ist15,main="ndvi2015",xlab="ndvi",ylab="perc.",nclass=20)
plot(ist23,main=“ndvi2023",xlab="ndvi",ylab="perc.",nclass=20)

dev.off()
           

