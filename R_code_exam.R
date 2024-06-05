# codice per l'analisi di cambiamenti ambientali nella zona di Villabassa in Val Pusteria(BZ)
# questo codice è stato scritto utilizzando i seguenti pacchetti prima installati
# installato i seguenti pacchetti, eccetto imageRy, dal CRAN con la funzione install.packages(), il pacchetto va inserito tra virgolette
# imageRy è stato installato da GitHub con la funzione install_github per cui serve il pacchetto devtools installato dal CRAN

# install.packages("terra")
# install.packages("devtools")
# library(devtools)
# devtools::install_github("duccioroccchini/imageRy")
# install.packages("ggplot2")
# install.packages("patchwork")
# install.packages("viridis")

library(terra)   # pacchetto R specializzato in metodi per l'analisi di dati spaziali, manipolazione e analisi di dati geografici
library(imageRy)  # pacchetto R specializzato nella manipolazione , analisi e condivisione di immagini raster 
library(ggplot2)   # pacchetto R specializzato nella creazione di grafici
library(patchwork)  # pacchetto R specializzato nella composizioni di più grafici
library(viridis) # pacchetto R per l’utilizzo di palette di colori Colorblind-Friendly

# dopo aver installato i pacchetti questi si richiamano con la funzione library() oppure con la funzione require()
# non vanno messe le virgolette con la funzione library perché sono già dentro ad R dato che il pacchetto è già stato installato

setwd("/Users/benedettaterzi/Library/CloudStorage/OneDrive-AlmaMaterStudiorumUniversitàdiBologna/Documents/R") # uso questa funzione set working directory per impostare la directory 

# ora importo immagini dall'esterno ovvero dalla directory usando la funzione rast() del pacchetto terra
# quattro immagini scaricate da Copernicus sentinel-2

v15<-rast("v15.jpg") # colori naturali, bande R G e B
v15f<-rast("v15f.jpg") # colori falsi, bande nir R e G
v23<-rast("v23.jpg")
v23f<-rast("v23f.jpg")

# le importo e le assegno ad un oggetto 
# dopo aver importato l'immagine per visualizzarla uso la funzione plot() del pacchetto terra mettendo tra  parentesi tonde il nome dell'oggetto a cui ho assegnato l’immagine

# posso creare un multiframe e visualizzarle insieme
par(mfrow=c(2,2)) # i numeri nelle parentesi tonde mi indicano rispettivamente il numero di righe e di colonne
# uso la funzione c ovvero concatenate siccome 2 e 2 sono elementi di un vettore 
# uso la funzione plot per visualizzare l’immagine
plot(v15)
plot(v15f)
plot(v23)
plot(v23f)

dev.off()

# utilizzo due immagini per lo stesso anno siccome l’immagine «true colors» ha le bande R,G e B e in quella «false colors» nir, R e G.
# assegno le tre bande R G e B dalla prima immagine e la banda nir dalla seconda immagine a degli oggetti poi unisco le quattro bande

br15<-v15[[1]]  # banda del rosso
bg15<-v15[[2]] # banda del verde
bb15<-v15[[3]] # banda del blu 
bi15<-v15f[[1]] # banda nir 
band15<-c(br15,bg15,bb15,bi15)

br23<-v23[[1]] 
bg23<-v23[[2]]
bb23<-v23[[3]]
bi23<-v23f[[1]]
band23<-c(br23,bg23,bb23,bi23)

# posso spostare il nir sulle altre tre bande 
# uso la funzione, del pacchetto imageRy, im.plotRGB() e devo dichiarare il nome dell'immagine e le tre componenti RGB quindi associo ad ogni componente la relativa banda 

par(mfrow=c(3,2))

im.plotRGB(band15, 4,2,3) # infrarosso sul rosso
im.plotRGB(band23, 4,2,3)

im.plotRGB(band15, 1,4,3) # infrarosso sul verde
im.plotRGB(band23, 1,4,3)

im.plotRGB(band15, 1,2,4) # infrarosso sul blu
im.plotRGB(band23, 1,2,4)

dev.off()

# se uso la funzione im.plotRGB.auto() devo dichiarare il nome dell'immagine e mi prende in automatico le prime tre bande
par(mfrow=c(1,2))
im.plotRGB.auto(band15)
im.plotRGB.auto(band23)

dev.off()

# classificazione di un'immagine e calcolo frequenza di ciascuna classe, numero totale di celle (pixel), proporzione e percentuale dei cluster
# si utilizza la funzione im.classify(), funzione del pacchetto imageRy, dichiarando l'immagine e il numero di clusters, in questo caso sono 2 uomo e vegetazione
# vengono create delle classi/clusters in base al comportamento dei pixel (riflettanza), i pixel vengono estratti casualmente quindi quale colore è associato a ciascuna classe è casuale 

           
band15c<-im.classify(band15,num_clusters=2)
band23c<-im.classify(band23,num_clusters=2)  # classificazione delle immagini 
par(mfrow=c(1,2))
plot(band15c)
plot(band23c)

dev.off()

f15<-freq(band15c) # calcolo della frequenza di ciascun cluster (classe) ottenuto dalla classificazione
tot15<-ncell(band15c) # calcolo del numero totale di celle (pixel)
prop15=f15/tot15 # calcolo della proporzione delle classi
perc15=prop15*100 # calcolo della percentuale delle classi 

f23<-freq(band23c) 
tot23<-ncell(band23c)
prop23=f23/tot23
perc23=prop23*100

tot15
tot23 # numero di pixel totale è lo stesso 

# creazione del dataframe con i dati
datav<-data.frame( anno = c(2015, 2015, 2023, 2023), classe = c("uomo", "foresta", "uomo", "foresta"), valori = c(35.5, 64.5, 38.1, 61.9))

# creazione del grafico con la funzione ggplot() del pacchetto ggplot2

ggplot(datav, aes(x = as.factor(anno), y = valori, fill = classe)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Distribuzione classi per anno", x = "Anno", y = "Valori percentuali") + ylim(c(0, 75)) + scale_fill_manual(values = c("foresta" = "forestgreen", "uomo" = "darkslateblue")) + theme_bw()

# aes(x = as.factor(anno), y = valori, fill = classe) specifica che anno è sull'asse x, valori sull'asse y, e le barre sono riempite in base alla classe
# geom_bar(stat = "identity", position = "dodge") uso geom_bar per creare grafico a barre e stat=identity specifica che i dati vengono usati così come sono e position = “dodge" per affiancare le barre 
# labs(): Aggiunge i titoli e le etichette agli assi
# theme mi permette di scegliere il tema 
# scale_fill_manual mi permette di scegliere manualmente i colori

# in questo modo abbiamo analizzato cambiamenti nello spazio tramite classificazione

# calcolo DVI (Difference Vegetation Index) e NDVI (normalized difference vegetation index)
# indice usato per calcolare salute e densità della vegetazione, si usano due bande nir e rosso (o nir e blu)
# lo calcolo facendo (NIR - Red)
# faccio una differenza, un’operazione matematica di sottrazione di pixel di una banda da un’altra banda
# siccome l’immagine ha 8 bit (2^8 = 256) i valori possono andare da -255 a +255 

cl<- colorRampPalette(c("black","white","red"))(100) # crea una scala di colori che va dal nero al bianco al rosso con 100 gradazioni

par(mfrow=c(1,2))

dvi15 = band15[[4]]-band15[[1]]
plot(dvi15, col=cl) 
dvi23 = band23[[4]]-band23[[1]]
plot(dvi23, col=cl)

dev.off()

# per fare delle comparazioni uso il NDVI (Normalized Difference Vegetation Index) quindi faccio (NIR - Red) / (NIR + Red) ovvero ndvi / (NIR + Red)  e varia tra -1 e 1 
# posso confrontare quindi immagini con bit diversi 

par(mfrow=c(2,2))

ndvi15 = dvi15/(band15[[4]]+band15[[1]]) 
plot(ndvi15, col=cl)
plot(ndvi15, col=turbo(100)) # lo plotto con una palette adatta alle persone con daltonismo

ndvi23 = dvi23/(band23[[4]]+band23[[1]]) 
plot(ndvi23, col=cl)
plot(ndvi23, col=turbo(100))

dev.off()

# Differenza di NDVI 
# valori positivi significa NDVI aumentato dal 2015 al 2023
# valori negativi significa NDVI è diminuito
# valori simili a zero: no cambiamenti nella vegetazione

difNDVI = ndvi23 - ndvi15
par(mfrow=c(1,2))
plot(difNDVI, col=cl)
plot(difNDVI,col=turbo(100))

# per meglio visualizzare possiamo creare un istogramma con la percentuale di pixel e i valori di NDVI 

dev.off()

par(mfrow=c(1,2))
ist15<-hist(ndvi15, main="ndvi2015", xlab="ndvi",nclass=20,freq=F,ylim=c(0,5),col=blues9)
ist23<-hist(ndvi23, main="ndvi2023", xlab="ndvi",nclass=20,freq=F,ylim=c(0,5),col=blues9)
# con main scelgo il nome del grafico, con nclass o breaks scelgo il numero di classi, xlab il nome della variabile di x, di default freq=T (restituisce la frequency ovvero il numero di pixel appartenente a quella classe)
# con freq=F ci restituisce density (non è la percentuale ma è su 10)

dev.off()

# copertura forestale calata di valori non elevati (3% circa)
# NDVI nel complesso no variazioni significative

# misura della variabilità/eterogeneità dello spazio con metodo moving window 
# si calcola su una variabile la variabilità, quindi su una banda, in questo caso la calcolo sulla banda nir
nir15<-band15[[4]] # assegno la banda nir, la quarta, ad un oggetto
sd3nir15<-focal(nir15,matrix(1/9,3,3), fun=sd) # uso la funzione focal()

# focal() mi permette di calcolare la variabilità, definisco la matrice (la finestra) in questo caso 9 pixel disposti 3x3 pixel e anche la statistica che uso in questo caso fun=sd (function = standard deviation)
# la dimensione della finestra la scelgo io 

# faccio la stessa cosa con l’immagine del 2023
nir23<-band23[[4]]
sd3nir23<-focal(nir23,matrix(1/9,3,3), fun=sd)

par(mfrow=c(1,2))
plot(sd3nir15, col=turbo(100))
plot(sd3nir23, col=turbo(100))

# non c’è una elevata differenza tra il 2015 e il 2023

dev.off()

# correlazione delle informazioni 
# posso usare la funzione pairs() per visualizzare la correlazione tra le quattro bande, le mette in correlazione due a due calcola indice di correlazione lineare di Pearson che va da -1 a 1 
pairs(band15)
pairs(band23)
# vediamo che le correlazioni sono abbastanza elevate per entrambe le immagini
# si guarda se le bande sono correlate prima di procede all’analisi PCA

dev.off()

# analisi multivariata
# se non riesco a scegliere personalmente la banda posso fare analisi delle componenti principali (PCA)
# uso la funzione im.pca()

pcimage15<-im.pca(band15) # di default come immagini mi da le prime 3 PC

# calcolo della percentuale di variabilità spiegata dall'asse 

tot15<-sum(61.735712, 27.537533, 5.865115, 3.025104)
# sommo le componenti principali delle 4 bande, una componente principale per ogni banda, poi calcolo la percentuale di variabilità spiegata dagli assi 

tot15 # 98.16346 

61.735712*100/tot15 # 62.89072 % di variabilità spiegata dal primo asse
27.537533*100/tot15 # 28.05273 % di variabilità spiegata dal secondo asse
5.865115*100/tot15 # 5.974845 % di variabilità spiegata dal terzo asse 
3.025104*100/tot15 # 3.081701 % di variabilità spiegata dal quarto asse 

# faccio la stessa cosa per l’anno 2023

pcimage23<-im.pca(band23)

tot23<-sum(66.613792, 28.700642, 6.404655, 3.408473)
tot23 # 105.1276
66.613792*100/tot23 # 63.36473 % di variabilità spiegata dal primo asse
28.700642*100/tot23 # 27.30078 % di variabilità spiegata dal secondo asse
6.404655*100/tot23 # 6.09227 % di variabilità spiegata dal terzo asse
3.408473*100/tot23 # 3.242226 % di variabilità spiegata dal quarto asse

dev.off()

# metodo moving window 
pca15<-pcimage15[[1]] # assegno la prima componente della PCA ad un oggetto
sd3pca15<-focal(pca15,matrix(1/9,3,3), fun=sd)
# metodo moving window sulla prima componente della PCA ovvero quella che spiega la maggiore variabilità 

pca23<-pcimage23[[1]]
sd3pca23<-focal(pca23,matrix(1/9,3,3), fun=sd)

par(mfrow=c(1,2))
plot(sd3pca15, col=turbo(100))
plot(sd3pca23, col=turbo(100))
# non ci sono differenze notevoli con la variabilità calcolata sul nir e non ci sono differenze notevoli tra i due anni

