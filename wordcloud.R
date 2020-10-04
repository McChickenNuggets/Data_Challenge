library(tidyverse)
library(ggplot2)
library(tidytext)
library(wordcloud)
data(stop_words)

# Import datasets
pp16df<- read_csv("pp16df.csv", col_types = cols())
pp16twitter<- read_csv("pp16twitter.csv", col_types = cols())

#divide users according to their attitude toward proposition 16
pp16_no<-pp16df %>% filter(support=="no") %>% transmute(bio) %>% unique()

pp16_yes<-pp16df %>% filter(support=="yes") %>%  transmute(bio) %>% unique()

#wordcloud of bio for no
word_pat <- "[\\D]+"
word_pat1 <- "\\w{3,}"

words_collec_no_pre <- str_extract_all(pp16_no$bio, word_pat) %>%  unlist()
words_collec_no <- str_extract_all(words_collec_no_pre , word_pat1)%>% unlist() 

words_collec_no <- tolower(words_collec_no)


words_lc_no<-sapply(words_collec_no, tolower)

df_words_lc_no <- tibble(line = 1:length(words_lc_no), text = words_lc_no)

df_words_lc_no <- df_words_lc_no %>% 
  unnest_tokens(word, text)%>% 
  anti_join(stop_words)

df_words_lc_no_count<-df_words_lc_no%>%
  group_by(word) %>%
  summarize(n = n()) %>% 
  arrange(desc(n)) %>% 
  na.omit()

df_words_lc_no_count%>% with(wordcloud(
  word, n, min.freq = 1, max.words = 15, random.order = FALSE,
  colors = brewer.pal(8, "Dark2")))

#wordcloud of bio for yes
word_pat <- "[\\D]+"
word_pat1 <- "\\w{3,}"

words_collec_yes_pre <- str_extract_all(pp16_yes$bio, word_pat) %>%  unlist()
words_collec_yes <- str_extract_all(words_collec_yes_pre , word_pat1)%>% unlist() 

words_collec_yes <- tolower(words_collec_yes)


words_lc_yes<-sapply(words_collec_yes, tolower)

df_words_lc_yes <- tibble(line = 1:length(words_lc_yes), text = words_lc_yes)

df_words_lc_yes <- df_words_lc_yes %>% 
  unnest_tokens(word, text)%>% 
  anti_join(stop_words)

df_words_lc_yes_count<-df_words_lc_yes%>%
  group_by(word) %>%
  summarize(n = n()) %>% 
  arrange(desc(n)) %>% 
  na.omit()

df_words_lc_yes_count%>% with(wordcloud(
  word, n, min.freq = 1, max.words = 15, random.order = FALSE,
  colors = brewer.pal(8, "Dark2")))

#wordcloud of username for active user
name_count<-pp16twitter %>% group_by(screen_name) %>%
  summarize(n = n()) %>% 
  arrange(desc(n)) %>% 
  na.omit()

name_count %>% with(wordcloud(
  screen_name, n, min.freq = 1, max.words = 20, random.order = FALSE,
  colors = brewer.pal(8, "Dark2")))

