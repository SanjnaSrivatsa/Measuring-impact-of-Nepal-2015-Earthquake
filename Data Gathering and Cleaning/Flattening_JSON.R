library(jsonlite) #manipulating json files
library(magrittr)
library(leaflet)
file1 <- stream_in(file("file1.json"))

file2 <- flatten(file1,recursive = T)

#round geo-coordinates
for (i in 1:nrow(file2)){
   if(is.null(file2$geo.coordinates[[i]])){
      file2$geo.lat[i]<- NA
      file2$geo.lon[i]<- NA
   }
   else{
      file2$geo.lat[i]<- round(file2$geo.coordinates[[i]][1],2)
      file2$geo.lon[i]<- round(file2$geo.coordinates[[i]][2],2)
      
      #leaflet(file2) %>% addTiles() %>% addMarkers(file2$geo.lat[i],file2$geo.lon[i])
   }
}

#remove null hashtags
for(i in 1:nrow(file2)){
   if(is.null(file2$entities.hashtags[i])){
      file2$hashtags[i]<- NA
   }
   else{
      file2$hashtags[i]<-unlist(file2$entities.hashtags[[i]][2])
   }
}



for(i in 1:nrow(file2)){
   file2$hashtags[i]<- unlist(file2$hashtags[[i]])
}

geo <- data.frame(file2$geo.lat,file2$geo.lon)
names(geo)<- c("lat","long")

geo<- geo[complete.cases(geo),]

#plot in leaflet
leaflet(geo) %>% addTiles() %>% addMarkers(
   clusterOptions = markerClusterOptions()
)

#unlist hashtags
for(i in 1:nrow(file2)){
hashtags[i] <- unlist(file2$entities.hashtags[[i]][2])
}

setwd("E:/Fall 2016/INFM 750 - Data to Insights/Project/Twitter_Data")
data_list <- list.files(path = ".",pattern="*.json")

#extracting required variables for analysis
for(i in 1:length(data_list)){
      d <- stream_in(file(data_list[i])) %>% flatten(recursive = T)
      data_set<- data.frame(d$favorited,d$id_str,d$favorite_count,d$in_reply_to_status_id_str,d$retweeted,d$retweet_count,d$source,d$lang,d$possibly_sensitive,d$user.id_str,d$user.verified,d$in_reply_to_user_id_str,d$created_at,d$user.created_at,d$user.followers_count,d$user.statuses_count,d$user.location,d$user.utc_offset,d$user.friends_count,d$user.favourites_count,d$user.listed_count,d$user.geo_enabled,d$quoted_status_id_str,d$place.country,d$place.place_type,d$place.full_name,d$place.id)
      
      for (i in 1:nrow(d)){
         if(is.null(d$coordinates.coordinates[[i]])){
            data_set$geo.lat[i]<- NA
            data_set$geo.lon[i]<- NA
         }
         else{
            data_set$geo.lat[i]<- round(d$geo.coordinates[[i]][1],4)
            data_set$geo.lon[i]<- round(d$geo.coordinates[[i]][2],4)
            #leaflet(file2) %>% addTiles() %>% addMarkers(file2$geo.lat[i],file2$geo.lon[i])
         }
      }
      
      for (i in 1:nrow(d)){
         if(dim(d$entities.hashtags[[i]]) == 00 ){
            data_set$hashtag_list[i] <- NA
         }
         else{
            data_set$hashtag_list[i] <- unlist(as.list(d$entities.hashtags[[i]][2]))
         }
      }
      
      if (i == 1){
         merged_data <- data_set
      }
      else{
         merged_data <- rbind(merged_data, data_set)
      }
      merged_data <- merged_data[!duplicated(merged_data),]
}
write.csv(merged_data,file="nepal_twitter_data.csv",row.names = F)