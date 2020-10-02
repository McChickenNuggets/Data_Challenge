library(tidyverse)
library(stringr)
library(tidytext)
library(wordcloud)
library(textdata)

# read twitter data collected
pp16twitter <- read_csv("pp16twitter.csv", col_types = cols())

# redefine original data as new df for analysis
pp16twi <- pp16twitter %>% 
  drop_na(c(hashtags, location)) %>%
  transmute(
    support = case_when(
    str_detect(hashtags, regex("(yes)|(Opportunity4All)", ignore_case=TRUE)) ~ "yes",
    str_detect(hashtags, regex("(no)|(stop)|(unitynotdivision)", ignore_case=TRUE)) ~ "no",
    TRUE ~ "undef"
  ), 
  text, 
  inCA = ifelse(str_detect(location, regex("(CA)|(California)", ignore_case=TRUE)), "yes", "no"), 
  influential = case_when(
    followers_count > 1000 ~ "yes",
    followers_count < 1000 ~ "no"
  ),
  username = screen_name,
  bio = description
  )

# twitter dataset split into 2 parts: df1 - yes/no defined in hashtags & df2 - those undefined
df1 <- pp16twi %>% filter(support != "undef")
df2 <- pp16twi %>% filter(support == "undef")

# those undefined (df2) need to be defined based on text sentiment analysis 
textdf <- df2 %>% mutate(id = 1:nrow(df2))

## 1st method: unigram sentiment analysis for tweets with 'bing' lexicon

# each tweet split into single word and take out stop words
tweet_token <- textdf %>% 
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  group_by(id) %>%
  count(word,sort = TRUE) %>%
  arrange(id)

# freq of each word in each tweet
tweet_propotions <- tweet_token %>% 
  group_by(id) %>% 
  mutate(propotion = n / sum(n)) %>% 
  select(-n) %>%
  arrange(id, desc(propotion))

# graph - word cloud for tweet no.1 by word freq
tweet_token %>% 
  filter(id == "1") %>% 
  with(wordcloud(
    word, n, min.freq = 1, max.words = 10, random.order = FALSE,
    colors = brewer.pal(8, "Dark2")))


# define yes/no based on positive/negative sentiment on prop16
sentimentM1 <- tweet_token %>% 
  left_join(get_sentiments("bing")) %>% 
  group_by(id) %>% 
  summarize(  # the frequencies are ignored in this analysis
    positive = sum(sentiment == "positive", na.rm = TRUE), 
    negative = sum(sentiment == "negative", na.rm = TRUE), 
    neutral = n() - positive - negative) %>%
  mutate(
    id,
    sentiment1 = case_when(
      positive > negative ~ "positive",
      positive < negative ~ "negative",
      TRUE ~ "neutral"
    )
  ) %>% 
  left_join(select(textdf, id, username)) %>% 
  select(sentiment1, id, username)

# 2nd method: bigrams sentiment analysis for tweets with 'bing' lexicon
tweet_token2 <- textdf %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>% 
  separate(bigram, c("word1", "word2"), sep = " ")

negate_words <- c("not", "without", "no", "can't", "don't", "won't")

sentimentM2 <- tweet_token2 %>% 
  group_by(id) %>% 
  count(word1, word2) %>% 
  left_join(get_sentiments("bing"), by = c("word2" = "word")) %>%
  mutate(sentiment = case_when(
    word1 %in% negate_words & sentiment == "negative" ~ "positive", 
    word1 %in% negate_words & sentiment == "positive" ~ "negative",
    TRUE ~ sentiment)) %>% 
  summarize(
    positive = sum(sentiment == "positive", na.rm = TRUE), 
    negative = sum(sentiment == "negative", na.rm = TRUE), 
    neutral = n() - positive - negative) %>%
  mutate(
    id,
    sentiment2 = case_when(
      positive > negative ~ "positive",
      positive < negative ~ "negative",
      TRUE ~ "neutral"
    )
  ) %>% 
  left_join(select(textdf, id, username)) %>% 
  select(sentiment2, id, username)

## 3rd method: unigram sentiment analysis for tweets with 'afinn' lexicon
sentimentM3 <- textdf %>% 
  unnest_tokens(word, text) %>% 
  left_join(get_sentiments("afinn")) %>% 
  replace_na(list(value=0L)) %>%
  group_by(id) %>%
  mutate(
    id,
    sentiment3 = case_when(
      sum(value) > 0 ~ "positive",
      sum(value) < 0 ~ "negative",
      TRUE ~ "neutral"
    )
  ) %>% 
  transmute(id, sentiment3) %>%
  unique() %>%
  left_join(select(textdf, id, username)) %>% 
  select(sentiment3, id, username)

# new df contain 3 sentiment result, and pick the mode
dfM123 <- sentimentM1 %>% 
  left_join(sentimentM2, by = c("id"="id")) %>% 
  left_join(sentimentM3, by = c("id"="id"))

dfM123$sentiment1 <- str_replace(dfM123$sentiment1,"positive","1")
dfM123$sentiment1 <- str_replace(dfM123$sentiment1,"negative","-1")
dfM123$sentiment1 <- str_replace(dfM123$sentiment1,"neutral","0")

dfM123$sentiment2 <- str_replace(dfM123$sentiment2,"positive","1")
dfM123$sentiment2 <- str_replace(dfM123$sentiment2,"negative","-1")
dfM123$sentiment2 <- str_replace(dfM123$sentiment2,"neutral","0")

dfM123$sentiment3 <- str_replace(dfM123$sentiment3,"positive","1")
dfM123$sentiment3 <- str_replace(dfM123$sentiment3,"negative","-1")
dfM123$sentiment3 <- str_replace(dfM123$sentiment3,"neutral","0")

dfM123$sentiment1<-as.numeric(dfM123$sentiment1)
dfM123$sentiment2<-as.numeric(dfM123$sentiment2)
dfM123$sentiment3<-as.numeric(dfM123$sentiment3)

df2_new <- dfM123 %>% 
  mutate(s = (sentiment1+sentiment2 +sentiment3)) %>%
  transmute(
    id,
    support = case_when(
      s > 0 ~ "yes",
      s < 0 ~ "no",
      TRUE ~ "neutral"
    )
  ) %>%
  right_join(textdf, by=c("id" = "id")) %>%
  transmute(support = support.x, text, inCA, influential, username = username, bio )

pp16df <- df1 %>% bind_rows(df2_new)


