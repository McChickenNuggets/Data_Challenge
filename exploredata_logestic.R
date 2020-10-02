library(tidyverse)
library(stringr)

pp16twitter <- read_csv("pp16twitter.csv", col_types = cols())
pp16twi <- pp16twitter %>% 
  drop_na(c(hashtags, location)) %>%
  transmute(
    support = case_when(
    str_detect(str_flatten(hashtags), regex("(yes)|(Opportunity4All)", ignore_case=TRUE)) ~ "yes",
    str_detect(str_flatten(hashtags), regex("(no)|(stop)|(unitynotdivision)", ignore_case=TRUE)) ~ "no",
    TRUE ~ "unidentified"
  ), 
  text, 
  inCA = ifelse(str_detect(location, regex("(CA)|(California)", ignore_case=TRUE)), "yes", "no"), 
  influential = case_when(
    followers_count > 1000 ~ "yes",
    followers_count < 1000 ~ "no"
  ),
  bio = description
  )

