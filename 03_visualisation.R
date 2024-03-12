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
