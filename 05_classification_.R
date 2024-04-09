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
