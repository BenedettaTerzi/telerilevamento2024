# EN = european nitrogen 
# importing data
EN01<-im.import("EN_01.png")
EN13<-im.import("EN_13.png")
par(mfrow=c(2,1)) #due righe una colonna 
im.plotRGB.auto(EN01) # auto mi prende in automatico le prime tre bande
im.plotRGB.auto(EN13)

# Ho importato le tre bande. Voglio ad esempio fare la differenza tra la stessa banda delle due immagini
difEN = EN01[[1]] - EN13[[1]] # uso uguale perchè è un'operazione matematica
# ho preso i pixel del primo livello di una immagine (EN01) e  sotraggo i pixel del primo livello dell'altra immagine (EN13)
cl <- colorRampPalette(c("blue","white","red"))(100)
plot(difEN, col=cl)
# partiamo da immagini ad 8 bit (valori da -225 a +255) quindi abbiamo fatto una quantificazione
