library(maptools) 
library(sp)
library(maps)
library(rgeos)
library(rgdal)
library(plyr)
library(dplyr)
setwd("E:/Nepal")

#loading shapefile
sfmap<- readOGR("./NPL_adm/NPL_adm3.shp", layer = "NPL_adm3")
plot(sfmap)

#create dataframe with lat, long values
geo_lat_long <- data.frame(Longitude = Nepal_Total_Data_Geo$geo.lon,Latitude = Nepal_Total_Data_Geo$geo.lat, stringsAsFactors = F)


plot(sfmap)
dat2 <- data.frame(Longitude = geo_lat_long$Longitude, Latitude = geo_lat_long$Latitude)
points(geo_lat_long$Longitude,geo_lat_long$Latitude, pch=19, col="red",cex=1)
coordinates(dat2)<- ~Longitude+Latitude

#Categorizing lat lonf values based on the shape files 
proj4string(dat2)<- proj4string(sfmap)
sf_data_coordinates <- data.frame(Longitude = Nepal_Total_Data_Geo$geo.lon,Latitude = Nepal_Total_Data_Geo$geo.lat,over(dat2,sfmap), stringsAsFactors = F)

names(Nepal_Total_Data_Geo)[28:29] <- c("Latitude", "Longitude")
