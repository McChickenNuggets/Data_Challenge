library(rtweet)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(maps)

# Retrieve System Time A week ago
toDate <- format(Sys.time() - 60 * 60 * 24 * 7, "%Y%m%d%H%M")

# Search information for #Prop 16 for past 30days
rt <- search_30day("#Prop16", n = 15000,
                   env_name = "research", toDate = toDate)

# Temp data in case other failure in modification
temp <-rt

# Time_plot to display the frequencies of post on twitter about #Prop16
rt %>%
  ts_plot("3 hours") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold")) +
  labs(
    x = NULL, y = NULL,
    title = "Frequency of #Prop16 Twitter statuses from past 30 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# Get geographical location
geo <- lat_lng(rt)

## plot california boundaries
par(mar = c(0, 0, 0, 0))
map('state', region = "california",lwd=.25)

## plot lat and lng points onto state map
with(geo, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))

# Filter important attributes
rt<- rt %>% select(user_id,screen_name:source,is_quote:hashtags,lang,name:verified,-url,-account_created_at)

# Check whether each attribute is convertible
sapply(rt,class)

# Transform the attribute
rt$hashtags<-as.character(rt$hashtags)

# Write to CSV file
write.csv(rt,"C:\\Users\\Jaune\\Desktop\\rt.csv")
