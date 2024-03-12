# Installing packages in R
# installo dal Cran
# Cran è dove ci sono tutti i pacchetti. Ci sono anche dei pacchetti su GitHub
# Cerco su internet il pacchetto esempio pacchetto terra

# Cerco su internet terra package 
# Vedo che c’è il reference manual (un manuale con le funzioni ecc…) in oltre ci possono essere delle vignette ovvero dei piccoli manuali 

# per installare un pacchetto uso la funzione install.packages()
# Il nome del package va tra virgolette

install.packages("terra")
# per richiamarlo uso la funzione library()
library(terra)

# ora installo pacchetti da GitHub
# Come faccio 
# Uso la funzione install.github ma per questa funzione devo scaricare un pacchetto (devtools)
# Poi con install.github prendo il pacchetto imagery 
# Quindi scarico il pacchetto devtools dal CRAN, poi uso la funzione install.github e poi scarico imageRy 

install.packages("devtools")
library(devtools)  # or require 

#installo il pacchetto imageRy da GitHub
devtools::install_github("ducciorocchini/imageRy")
# prima dei :: mi dice che è una funzione di devtools
library(imageRy)

# library() non metto le virgolette, perché sono già dentro R 
