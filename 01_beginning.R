# First R script 
> a<-6*7
> b<-5*8

> a+b

#Arrays
# arrays è un vettore quindi una serie di dati concatenati insieme quindi i dati sono gli elementi o argomento del vettore

flowers<-c(3,6,8,10,15,18)
# quindi oggetto flowers a cui assegno questi elementi e c è la funzione di concatenazione  

insects<-c(10,16,25,42,61,73)

#funzione plot per fare un generico plot con assi x e y 
plot(flowers,insects)

# changing plot parameters 

#symbols 
plot(flowers,insects,pch=19)

#symbol dimension 
plot(flowers,insects,pch=19,cex=2)
plot(flowers,insects,pch=19,cex=0.5)

#symbol color 
plot(flowers,insects,pch=19,cex=0.5,col="chocolate1")
