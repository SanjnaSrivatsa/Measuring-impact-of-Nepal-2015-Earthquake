
setwd("C:/Users/Snigdha/Documents/CourseWork/INFM 750/Nepal_Tweets/n.ids/Aggregated_Data")
p = read.csv("nepal_twitter_data_snigdha.csv",stringsAsFactors=FALSE)
p= rbind(p,read.csv("nepal_twitter_data_aarthi.csv",stringsAsFactors=FALSE))
p= rbind(p,read.csv("nepal_twitter_data_karthik.csv",stringsAsFactors=FALSE))
p= rbind(p,read.csv("nepal_twitter_data_kanishka.csv",stringsAsFactors=FALSE))
p= rbind(p,read.csv("nepal_twitter_data_manuja.csv",stringsAsFactors=FALSE))
p= rbind(p,read.csv("nepal_twitter_data_sanjna.csv",stringsAsFactors=FALSE))

write.csv(p,file="Nepal_Total_Data.csv", row.names = F)

ncol(p)
colnames(p)
sapply(p, class)
p$timezone<- p$d.user.utc_offset/(60*60)
p$timezone
p = read.csv("Nepal_Total_Data.csv",stringsAsFactors=FALSE)
subdata = subset(p, timezone==5.75|d.place.country=="Nepal")
completeVec <- complete.cases(p[, c("geo.lat","geo.lon")])
subdatageo = p[completeVec, ]
write.csv(subdatageo,file="All_Geo_Data.csv", row.names = F)

install.packages("devtools")
install.packages("lubridate")
require(devtools)
library("lubridate")
subdatageo = subset(subdatageo, timezone==5.75|d.place.country=="Nepal")
subdatageo$datetime = as_datetime(strptime(subdatageo$d.created_at,format="%a %b %d %H:%M:%S %z %Y", tz = "GMT"))
write.csv(subdatageo,file="Nepal_GeoData.csv", row.names = F)
format.str <- "%a %b %d %H:%M:%S %z %Y"
equake1 = as_datetime(strptime("Sat Apr 25 05:11:25 +0000 2015",format.str, tz = "GMT"))
end1 = as_datetime(strptime("Fri May 1 05:11:25 +0000 2015",format.str, tz = "GMT"))
equake2 = as_datetime(strptime("Fri May 12 07:05:00 +0000 2015",format.str, tz = "GMT"))
end2 = as_datetime(strptime("Mon May 18 12:07:05 +0000 2015",format.str, tz = "GMT"))


# before baseline
bbefore1 = subset(subdatageo, as.double(subdatageo$datetime-equake1)<0)
#during earthquake 1
bduring1 = subset(subdatageo,(as.double(subdatageo$datetime-equake1)>=0)&(as.double(subdatageo$datetime-end1)<=0))
# after baseline
bafter1 = subset(subdatageo, (as.double(subdatageo$datetime-end1)>0)&(as.double(subdatageo$datetime-equake2)<0))

# during earthquake 2
bduring2 = subset(subdatageo, (as.double(subdatageo$datetime-equake2)>=0)&(as.double(subdatageo$datetime-end2)<=0))
                 
# after earthquake 2
bafter2 = subset(subdatageo, as.double(subdatageo$datetime-end2)>0)


                                  
write.csv(bbefore1,"geo_before_e1.csv",row.names = F)
write.csv(bduring1,"geo_during_e1.csv",row.names = F)
write.csv(bafter1,"geo_bafter_e1.csv",row.names = F)
write.csv(bduring2,"geo_bduring_e2.csv",row.names = F)
write.csv(bafter2,"geo_bafter_e2.csv",row.names = F)

dtaf = read.csv("setonelocdf.csv",stringsAsFactors=FALSE)

