# Data_Challenge

![N|Solid](https://i.pinimg.com/originals/76/47/9d/76479dd91dc55c2768ddccfc30a4fbf5.png)
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


This is a project focusing on the impacts of Proposition 16. We retrieve data from Twitter using rtweet, and use text mining through the combining results of 3 differnt sentiment-analysis to analyze the opposition and support implied by the contexts of each tweet on Proposition 16. Using the result generated by sentiment-analysis, we construct a logistic model using the filtered-dataset and investigate the effectiveness, sensitivity, specificity of our model. Besides, combining the past admission summaries based on ethnicity from University of Califonia, we generalize ideas from social medias to make assumptions about the following conseuences of the Proposition 16 on college admission based on ethnicity.

## Key Components!
  - Web Scraping
  - Text Mining
  - Logistic Regression
  - Data Visualization
  - Conclusion

#  How controversial is the topic?
- Collect the number of pp16 relevant tweets from twitter
- Collect the number of relevant tweets for each pp (15~24)
- Compare 16 with the other 9 pp with bar graph 

![image](https://github.com/McChickenNuggets/Data_Challenge/blob/master/img/Proposition%20popularity%20share.png)

## Web Scraping
#### Search tweets
Search for up to 15,000 (non-retweeted) tweets containing the #Prop16 hashtag.
```r
# Retrieve System Time A week ago
toDate <- format(Sys.time() - 60 * 60 * 24 * 7, "%Y%m%d%H%M")

# Search information for #Prop 16 for past 30days in USA
rt <- search_30day("#Prop16", n = 15000,
                   env_name = "research", toDate = toDate,
                   geocode = lookup_coords("usa"))
```
Quickly visualize frequency of tweets over time using `ts_plot()`
```r
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
```
Visualize the geographical location of these tweets
```r
# Get geographical location
geo <- lat_lng(rt)

## plot california boundaries
par(mar = c(0, 0, 0, 0))
map('state', region = "california",lwd=.25)

## plot lat and lng points onto state map
with(geo, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))
```
## Text Mining

## Logistic Regression

## Data Visualization

## Conclusion

