# Ma se non riusciamo a scegliere soggettivamente la banda?
# L’analisi multivariata
# Prendiamo come esempio due bande la banda 1 e la banda 2 e prendendo il riferimento dei pixel plottiamo una banda rispetto all'altra. Il primo asse spiega gran parte della varianza, poiché spiega il 90% di questa. Invece di scegliere il nir scegliamo il primo asse chiamato pc1 perché è più rappresentativo in caso di multivariata
# Con pairs(oggetto) vediamo le correlazioni tra le bande. Scegliamo come componente principale quelle bande che hanno una alta correlazione, quindi un grafico decente.
 
# Quando ho tante bande (centinaia) è impossibile scegliere di persona la banda si cui lavorare allora si usa l’analisi multivariata. Riduco le due dimensioni ad una sola dimensione >> analisi delle componenti principali. Prendo due variabili (bande) correlate tra loro e passo due componenti (una componente e la sua perpendicolare). Componenti principali 1 e componente principale 2 ( PC 1 e PC 2) (pc = principal component). Prendo quella con la % maggiore. Se non sono correlate linearmente ad esempio usando i logaritmi le rendo più correlate linearmente 
# Quindi ci sono dei metodi per renderle più correlate linearmente 

# Componenti = numero uguale alle bande ovviamente 

# Quindi ho due bande originarie, correlate tra loro 
# Ognuna ha in questo caso 50% della variabilità (hanno una pendenza di 45°)
# Il primo nuovo asse PC1 ha un range ampio del dato originario per definizione (circa 90%), mentre il secondo PC2 ha un range molto più ridotto (10%)

Banda2 >> blue
Banda3 >> green
Banda4 >> red
Banda8 >> nir 

> b2<-im.import("sentinel.dolomites.b2.tif")
> b3<-im.import("sentinel.dolomites.b3.tif")
> b4<-im.import("sentinel.dolomites.b4.tif")
> b8<-im.import(“sentinel.dolomites.b8.tif")

# Ora faccio uno stack e metto insieme le bande per fare l’immagine satellitare 

> sentdo<-c(b2,b3,b4,b8)
> sentdo

>im.plotRGB(sentdo, r=4, g=3, b=2) ## Qui ho messo il nir (che ha valore 4) sul rosso 
>im.plotRGB(sentdo, r=3, g=4, b=2) ## Qui ho messo il nir (che ha valore 4) sul verde
 
# Vediamo quanto sono correlate tra loro le bande
# Uso la funzione pairs 
>pairs(sentdo)
# va bene per bande ma anche tabelle in generale dati (misure la correlazione tra variabili e va da -1 a 1, è la correlazione di Pearson) 
# correlazione ovviamente non è rapporto causa-effetto 

pcimage <- im.pca(sentdo)
tot <- sum(1579.94128, 537.46580,  74.22210,   33.41315)
# Sommo le componenti principali delle bande ( 1 componente principale per ogni banda, ho 4 band quindi 4 componenti principali).Poi faccio così per vedere la % di variabilità spiegata dall’asse
1579.94128 * 100 / tot  
# Ovviamente questa ha la maggiore % di variabilità spiegata da questa PC
