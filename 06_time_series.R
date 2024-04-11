# EN = european nitrogen 
# importing data
EN01<-im.import("EN_01.png")
EN13<-im.import("EN_13.png")
par(mfrow=c(2,1)) #due righe una colonna 
im.plotRGB.auto(EN01) # "auto" mi prende in automatico le prime tre bande
im.plotRGB.auto(EN13)

# Ho importato le tre bande. Voglio ad esempio fare la differenza tra la stessa banda delle due immagini
difEN = EN01[[1]] - EN13[[1]] # uso uguale perchè è un'operazione matematica
# ho preso i pixel del primo livello di una immagine (EN01) e  sotraggo i pixel del primo livello dell'altra immagine (EN13)
cl <- colorRampPalette(c("blue","white","red"))(100)
plot(difEN, col=cl)
# partiamo da immagini ad 8 bit (2^8 = 256 quindi i valori vanno da -225 a +255 perchè c'è lo 0) quindi abbiamo fatto una quantificazione

# ice melt in Greenland 
# uso un proxy ovvero una variabile usata al posto di un'altra perchè più facile per fare misure 
# EuropeLST =  dataset per le temperature del suolo
# geom_bar era stato usato per gli istogrammi, geom_line si usa per le linee 
g2000<-im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black","blue","white","red"))(100)
plot(g2000,col=clg) # il nero temperatura più fredda
# è un'immagine a 16 bit quindi 2^16 sarebbero 65'000 valori sarebbero ma qua si ferma a 15'000 valori 
g2005<-im.import("greenland.2005.tif")
g2010<-im.import("greenland.2010.tif")
g2015<-im.import("greenland.2015.tif")

par(mfrow=c(2,2))
plot(g2000,col=clg)
plot(g2005,col=clg)
plot(g2010,col=clg)
plot(g2015,col=clg)

# stack alternativo a par(mfrow)
greenland <- c(g2000,g2005,g2010,g2015)
plot(greenland, col=clg)

# differenza
difg = greenland[[1]]- greenland[[4]] # differenza tra 2000 e 2015
clgreen<-colorRampPalette(c("red","white","blue"))(100) # valori bassi rossi, il primo colore che metto ma se è temperature 2000 - tempertaure 2015 valore negativo signficia aumento delle temperature dal 2000 al 2015
plot (difg, col=clgreen)

