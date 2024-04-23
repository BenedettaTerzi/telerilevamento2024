# Importing data from external sources
# uso una funzione setwd ovvero set working directory per spiegare qual'è la cartella in cui salviamo tutto (la directory)
setwd("/Users/benedettaterzi/Documents")
eclissi<-rast("eclissi.png")
# Warning message: unknown extent perchè non ha georeferenziazione 
#rast funzione per importare il dato
# plotting the data 
im.plotRGB(eclissi,1,2,3)
# potrei usare anche la funzione plot del pacchetto terra
dif = eclissi[[1]]-eclissi[[2]]
plot(dif)

# import another image 
ocean<-rast("ocean.jpg")
im.plotRGB(ocean,1,2,3)

# copernicus ha 4 blocchi di dati (vegetazione, energia, acqua, criosfera) e altri due (hot spots e groundbased, dati presi a terra di diversa natura) e contengono tante variabili

# importing data from Copernicus 
soil<-rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")
plot(soil)
plot(soil[[1]])

#crop data (uso coordinate per tagliare una immagine)
ext <- c(25,30,55,58) # mi rappresentano x minima x massima y minima y massima in un array per definire l'estensione 
soilcrop<-crop(soil,ext)
