# Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

# tutte le funzioni di imageRy iniziano con im.

lista dei dati nel pacchetto imageRy
im.list()

# funzione per importare 
im.import()
im.import("matogrosso_l5_1992219_lrg.jpg")
mato<-im.import("matogrosso_l5_1992219_lrg.jpg")

# NASA earth observatory = trovo immagini scaricabili 

# Plottiamo i dati 
plot(mato) 

b2<-im.import("sentinel.dolomites.b2.tif")
plot(b2)

# Immagine satellitare è composta da tante bande 
# sentinel è satellite lanciato nel 2015 dall'ESA e ci somo bande a 10 metri e la banda 2 è nel blu 
# possiamo cambiare la scala di colori
# uso la funzione colorRampPalette ad esempio la faccio in bianco e nero 

clg<-colorRampPalette(c("black","grey","light grey"))(3)
# questo è un vettore (array) di elementi concatenati dalla funzione c concatenate
# il 3 è il numero di sfumature di pasaggio da un colore all'altro
plot(b2,col=clg)

clcyan<-colorRampPalette(c("magenta","cyan4","cyan"))(100)
clch<-colorRampPalette(c("magenta","cyan4","cyan","chartreuse"))(100)

# quella blu è roccia che riflette
# quella magenta è vegetazione che assorbe nel blu e nel rosso per la fotosintesi quindi bassa riflettanza 

# importare altre bande 
# banda3 = 560 nm, verde
# banda4 = rosso 
# banda8 = vicino infrarosso 

b3<-im.import("sentinel.dolomites.b3.tif")
plot(b3,col=clch)

b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4,col=clch)

b8<-im.import("sentinel.dolomites.b8.tif")
plot(b8,col=clch)

# voglio creare un multiframe quindi che contiene vari grafici tutti insieme 
# uso la funzione par()
# ho 4 bande e voglio metterle due a due (quindi due righe e due colonne)
par(mfrow=c(2,2))
# uso c siccome 2 e 2 sono elementi di un vettore
par(mfrow=c(2,2))
# per ora vedo tutto bianco perchè è solo l'intelaiatura del multiframe poi piano piano appaiono tutte
plot(b2,col=clch)
plot(b3,col=clch)
plot(b4,col=clch)
plot(b8,col=clch)

# plotto le quattro bande in una riga, una dopo l'altra quindi 1 riga 4 colonne
par(mfrow=c(1,4))
plot(b2,col=clch)
plot(b3,col=clch)
plot(b4,col=clch)
plot(b8,col=clch)

# ora le bande le considero come elementi di un unico array (le concateno insieme) e creo un'immagine satellitare (uno stack di n bande)
# uso la funzione concatenate quindi
stacksent<-c(b2,b3,b4,b8)
plot(stacksent,col=clch)

# se ho un'immagine satellitare con le varie bande e voglio plottare solo la banda b8, quarto elemento
# gli elementi si selezionano con le parentesi quadre 
plot(stacksent[[4]],col=clch)
# usiamo due parentesi quadre nel pacchetto raster e terra perchè siamo in due dimensioni
# uso la funzione dev.off() se voglio eliminare/chiudere qualcosa = close a plotting device

# la funzione im.import() serve ad importare dati 
# ora le bande le considero come elementi di un unico array (le concateno insieme) e creo un'immagine satellitare (uno stack di n bande) mutispettrale 
# uso la funzione concatenate quindi
stacksent<-c(b2,b3,b4,b8)
plot(stacksent)

# vogliamo plottare uno solo di questi 4 elementi
# prima uso dev.off() per chiudere un device
dev.off()
# poi scrivo plot(stacksent[[4]]) 
plot(stacksent[[4]])

#RGB plotting
# stacksent[[1]] =  b2 = blue 
# stacksent[[2]] =  b3 = verde
# stacksent[[3]] =  b4 = rosso
# stacksent[[4]] =  b8 = vicino infrarosso (nir in inglese)

# uso la funzione im.plotRGB() dove dichiaro il nome dell'immagine e le tre componenti RGB
# associo ad ogni componente la relativa banda quindi R=3, G=2 e B=1 
im.plotRGB(stacksent,3,2,1)
im.plotRGB(stacksent,4,2,1)
# tutto quello riflette nell'infrarosso lo vedo rosso 

# sostituisco tutto e scrivo im.plotRGB(stacksent,4,3,2)
im.plotRGB(stacksent,4,3,2)
# è praticamente uguale a prima, ma quella che regola i colori è quella meno collegata alle altre bande (infrarosso in questo caso)
# lo sostituisco al verde
im.plotRGB(stacksent,3,4,2)
# lo sostituisco al blu = se voglio evidenziare il suolo nudo che diventa giallo 
im.plotRGB(stacksent,3,2,4)

# faccio un multiframe
par(mfrow=c(2,2))
plot(im.plotRGB(stacksent,3,2,1)) # natural colors 
plot(im.plotRGB(stacksent,4,2,1)) # nir on red 
plot(im.plotRGB(stacksent,3,4,2)) # nir on green
plot(im.plotRGB(stacksent,3,2,4)) # nir on blue 

# correlazione di informazioni 
# uso la funzione pairs()
pairs(stacksent)

# in ordine in diagonale abbiamo le bande blu, verde, rosso e nir (quelli verdi) poi in nero le mette in correlazione due a due e i numeri sono l'indice di correlazione lineare di pearson (che va da -1 a 1)
