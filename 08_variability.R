#Variability 
# useremo pacchetto per creare mappe visibili a tutti, anche daltonici 
# Misuriamo la variabilità dello spazio, l’eterogeneità
# Usiamo la deviazione standard
# Intervallo [media - deviazione standard; media + deviazione standard] ottengo intervallo in cui ho il  68% dei dati 

#sentinel è un satellite dell'ESA, sentinel2 è usato nel progetto copernicus, risoluzione a terra 10 m
sent<-im.import("sentinel.png")
im.plotRGB(sent, r=1, g=2, b=3)
# rosso = vegetazione 
# suolo nudo = celeste 
# acqua = nera ,assorbe tutto infrarosso 

im.plotRGB(sent, r=1, g=2, b=3) # nir=band 1, red=band 2, green=band 37

# ovviamente la variabilità la calcolo su una banda (nir) , si calcola su una variabile 
# variability 
nir<-sent[[1]]  # ho assegnato la banda 1 (nir) ad un oggetto 

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(nir, col=cl)

# NUOVO COMANDO: focal
# focal: tira fuori delle statistiche all’interno di un gruppo di valori; in questo caso usiamo la deviazione standard.
# NB: la matrice è un vettore bidimensionale, è formata da numeri disposti sia orizzontalmente che verticalmente a formare un blocco bidimensionale. 
# Dobbiamo definire la dimensione della finestra tramite la matrice (matrix) e poi definiamo come è composta, se 3x3, 7x7 ecc… >>  Quindi 1/9 dice che è grande 9 quadretti disposti 3x3 . fun è funzione e sd è la deviazione standard. Non dobbiamo però chiamare la funzione sd ovviamente.

# uso la funzione focal per fare il calcolo della variabilità, mi definisce la matrice di 3x3 pixel ovvero la mia finestra mobile e la statistica che uso 

sd3 <- focal (nir, matrix(1/9, 3, 3), fun=sd)  # fun significa function e sd è la standard deviation 
plot(sd3)

# pacchetto "viridis" per usare palette per i daltonici 

viridisc<-colorRampPalette(viridis(7))(100)
plot(sd3, col=viridisc)

# calcolo la sd su 7 pixel 
sd7<- focal (nir, matrix(1/49, 7, 7), fun = sd)

sd13<- focal (nir, matrix(1/169, 13, 13), fun = sd)
sdstack<-c(sd3,sd7,sd13)
plot(sdstack,col=viridisc)
