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

