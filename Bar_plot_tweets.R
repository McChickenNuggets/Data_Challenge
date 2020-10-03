library(tidyverse)
library(jsonlite)
library(lubridate)
library(ggplot2)
library(ggforce)
library(scales)
library(ggpie)

#install.packages("twitteR")
library(twitteR)

consumer_key<-"VJbodovqculNFbYgxZWLeaics"
consumer_secret<-"bRXsaKg6jfpRk50vNShJGVlTpfPrdl926lFQa5rXuyXuT0dRur"


access_token <-"1263254721264930816-YP2dsdT5AjGafvPRMJ2GJP5pqEOVmg"

access_secret <- "sm3uZYXL4KfWSOiftvfDqqt3tBYonTLYKeH4b1kDJfi3Q"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tw15= length(twitteR::searchTwitter('#Prop15', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw16= length(twitteR::searchTwitter('#Prop16', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw17= length(twitteR::searchTwitter('#Prop17', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw18= length(twitteR::searchTwitter('#Prop18', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw19= length(twitteR::searchTwitter('#Prop19', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw20= length(twitteR::searchTwitter('#Prop20', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw21= length(twitteR::searchTwitter('#Prop21', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw22= length(twitteR::searchTwitter('#Prop22', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw23= length(twitteR::searchTwitter('#Prop23', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))

tw24= length(twitteR::searchTwitter('#Prop24', n=1e4, since = '2020-09-01', retryOnRateLimit = 1e3))


data_pie<-data.frame(num=c(tw15,tw16,tw17,tw18,tw19,tw20,tw21,tw22,tw23,tw24), Proposition=c("Prop15","Prop16","Prop17","Prop18","Prop19","Prop20","Prop21","Prop22","Prop23","Prop24") )

data_pie1 <-data_pie %>% mutate(per=num/sum(num))

###########
# Create a basic bar
#pie = ggplot(data_pie1, aes(x="", y=per, fill=Proposition)) + geom_bar(stat="identity", width=1)

# Convert to pie (polar coordinates) and add labels
#pie = pie + coord_polar("y", start=0) + geom_text(aes(label = paste0(round(per*100),"%")), position = position_stack(vjust = 0.5))


# Remove labels and add title
#pie = pie + labs(x = NULL, y = NULL, fill = NULL, title = "Proposition Popularity Share")

# Tidy up the theme
#pie = pie + theme_classic() + theme(axis.line = element_blank(),
#                                    axis.text = element_blank(),
#                                    axis.ticks = element_blank(),
#                                    plot.title = element_text(hjust = 0.5, color = "#666666"))

#data_new<- data.frame(Proposition = rep(data_pie1$Proposition, data_pie1$num))
#ggpie(data_new, Proposition,offset=0.75)



###bar
#ggpie(data_new, Proposition, offset = 0.95, label.size = 3.5,
#      label.color = "black", facet.label.size = 11,
#     border.color = "black", border.width = 0.5, legend = TRUE,
#      percent = TRUE, title="Proposition Popularity Share", digits = 0, nrow = 1)
############

q<-ggplot(data_pie1, aes(x=Proposition, y=num, fill=Proposition)) +
  geom_bar(stat="identity")+theme_minimal()+ 
  ggtitle("Proposition Popularity Share") + 
  ylab("Number of Tweets")
q