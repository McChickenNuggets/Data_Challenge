library(rtweet)
library(ggplot2)
toDate <- format(Sys.time() - 60 * 60 * 24 * 7, "%Y%m%d%H%M")

rt <- search_30day("#Prop18", n = 300,
                   env_name = "research", toDate = toDate)
rt %>%
  ts_plot("3 hours") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold")) +
  labs(
    x = NULL, y = NULL,
    title = "Frequency of #rstats Twitter statuses from past 30 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

geo <- lat_lng(rt)

## plot state boundaries
par(mar = c(0, 0, 0, 0))
map('state', region = "california")
## plot lat and lng points onto state map
with(geo, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))

vignette("intro", package = "rtweet")

## preview users data
usage<-users_data(rt)
