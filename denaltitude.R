## Only a function script right now. Still testing the parsing of a METAR. Eventually will be a package.

library(pmetar)
library(tidyverse)
library(airportr)
denaltitude=function(airportCode){
airportDF=as.data.frame(airport_detail(airportCode))
reMetar=metar_get(airportCode)
reMetar=unlist(str_split(reMetar," "))
for (j in 1:length(reMetar)) {
  ifelse(substr(reMetar[j],1,1)=="A",ifelse(nchar(reMetar[j])==5,presLoc<-j,""),"")
}
presVec=unlist(str_split(reMetar[presLoc],"A"))
presHg=strtoi(presVec[2])/100
for (i in 1:length(reMetar)) {
  ifelse(grepl("/",reMetar[i])==TRUE,ifelse(nchar(reMetar[i])<=7,tempLoc<-i,""),"")
}
tempVec=unlist(str_split(reMetar[tempLoc],"/"))
tempC=strtoi(tempVec[1])
presAlt=(29.92-presHg)*1000+airportDF$Altitude
denAlt=presAlt+118.8*(tempC-13.39)
cat("Density Altitude =",denAlt)
}