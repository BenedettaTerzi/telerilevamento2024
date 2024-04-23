# Importing data from external sources
# uso una funzione per spiegare qual'è la cartella in cui salviamo tutto (la directoty)
setwd("/Users/benedettaterzi/Documents")
eclissi<-rast("eclissi.png")
# Warning message: unknown extent perchè non ha georeferenziazione 
#rast funzione che ...
# plotting the data 
im.plotRGB(eclissi,1,2,3)
# potrei usare anche la funzione plot del pacchetto terra 
