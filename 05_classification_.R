# quantifying land cover variability
# installo il pacchetto "ggplot2" con la funzione install.packages("ggplot2")
install.packages("ggplot2")
library(ggplot2)
# listing images
im.list()

# importo immagine
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# funzione im.classify() chiede l'immagine originale ed il numero di cluster/classi)
sunc<-im.classify(sun,num_clusters=3)

# Mato Grosso images 
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

# classify images 
m1992c<-im.classify(m1992,num_clusters=2)
# classe 1 = suolo nudo 
# classe 2 = foresta 

m2006c<-im.classify(m2006,num_clusters=2)
# classe 1 = suolo nudo 
# classe 2 = foresta 

plot(m1992c)
plot(m2006c)

# calcolare numero dei pixel (frequenza)
# si usa la funzione freq()
f1992<-freq(m1992c)
f1992
  layer value   count
1     1     1  304437
2     1     2 1495563
# calcolo la proporizone facendo valore 1/totale e valore2/totale
# il totale lo calcolo con la funzione ncell 

tot1992<-ncell(m1992c)
tot1992
[1] 1800000
prop1992 = f1992/tot1992
prop1992
         layer        value     count
1 5.555556e-07 5.555556e-07 0.1691317
2 5.555556e-07 1.111111e-06 0.8308683
perc1992 = prop1992 * 100 
perc1992
         layer        value    count
1 5.555556e-05 5.555556e-05 16.91317
2 5.555556e-05 1.111111e-04 83.08683

f2006<-freq(m2006c)
f2006
  layer value   count
1     1     1 3937996
2     1     2 3262004

tot2006<-ncell(m2006c)
tot2006
[1] 7200000
prop2006 = f2006/tot2006
prop2006
         layer        value     count
1 1.388889e-07 1.388889e-07 0.5469439
2 1.388889e-07 2.777778e-07 0.4530561

perc2006 = prop2006 * 100
perc2006
         layer        value    count
1 1.388889e-05 1.388889e-05 54.69439
2 1.388889e-05 2.777778e-05 45.30561

# ora metto tutti i dati in una tabella
# costruisco il dataframe

class<-c("forest","human")
# uso c perchè sono elementi di un array quindi ci vuole concatenate 
# uso le virgolette perchè sono nomi 

y2006<-c(55,45)
y1992<-c(83,17)
tabout<-data.frame(class,y2006,y1992)
tabout
   class y2006 y1992
1 forest    55    83
2  human    45    17

# voglio passare da un dataframe al grafico e lo faccio con la funzione ggplot
p1<-ggplot(tabout, aes(x=class,y=y1992,color=class))+geom_bar(stat="identity",fill="white")
# con geom_bar cambio la geometria,scrivo le statistiche da estarrre (in questo caso mettiamo identity), scelgo il colore

# installo patchwork
install.packages("patchwork")
library(patchwork)

p1<-ggplot(tabout, aes(x=class,y=y1992,color=class))+geom_bar(stat="identity",fill="white")
p2<-ggplot(tabout, aes(x=class,y=y2006,color=class))+geom_bar(stat="identity",fill="white")

library(patchwork)
# visualizzo i due grafici insieme
p1 + p2

# correggo il grafico 
# la scala è diversa, devo mettere gli assi uguali 

# aggiungo + ylim(c(0,100))

p1<-ggplot(tabout, aes(x=class,y=y1992,color=class))+geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p2<-ggplot(tabout, aes(x=class,y=y2006,color=class))+geom_bar(stat="identity",fill="white") + ylim(c(0,100))
