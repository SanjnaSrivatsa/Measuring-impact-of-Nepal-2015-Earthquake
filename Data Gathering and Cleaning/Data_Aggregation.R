
###
###Update path to directory where output files are created
setwd("E:\\Fall 2016/INFM 750 - Data to Insights\\Project\\Twitter_Data")
###
###

data_list <- list.files(path = ".",pattern="*.json")
for(k in 1:length(data_list)){
   d <- stream_in(file(data_list[k])) %>% flatten(recursive = T)
   data_set<- data.frame(d$favorited,d$id_str,d$favorite_count,d$in_reply_to_status_id_str,d$retweeted,d$retweet_count,d$source,d$lang,d$possibly_sensitive,d$user.id_str,d$user.verified,d$in_reply_to_user_id_str,d$created_at,d$user.created_at,d$user.followers_count,d$user.statuses_count,d$user.location,d$user.utc_offset,d$user.friends_count,d$user.favourites_count,d$user.listed_count,d$user.geo_enabled,d$quoted_status_id_str,d$place.country,d$place.place_type,d$place.full_name,d$place.id)
   
   for (i in 1:nrow(d)){
      if(is.null(d$coordinates.coordinates[[i]])){
         data_set$geo.lat[i]<- NA
         data_set$geo.lon[i]<- NA
      }
      else{
         data_set$geo.lat[i]<- round(d$geo.coordinates[[i]][1],4)
         data_set$geo.lon[i]<- round(d$geo.coordinates[[i]][2],4)
        
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
   
   if (k == 1){
      merged_data <- data_set
   }
   else{
      merged_data <- rbind(merged_data, data_set)
   }
   merged_data <- merged_data[!duplicated(merged_data),]
}
write.csv(merged_data,file="nepal_twitter_data.csv",row.names = F)
