library(tidyverse)

ucdavis2010_2019<-read.csv('Freshmen_Eth_data_2010_2019.csv')
ucdavis1994_2003<-read.csv('Freshmen_Eth_data_1994_2003.csv')

colnames(ucdavis2010_2019)<-c('Category','Ethnicity','Academic_year','Count','Percentage')
colnames(ucdavis1994_2003)<-c('Category','Ethnicity','Academic_year','Count','Percentage')

temp_Admits<-ucdavis2010_2019 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

temp_Admits2<-ucdavis1994_2003 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

# Line Plot ofr Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(x=Academic_year, y=Count, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="Admits Change For All Ethnicities Over 1994 to 2003",y='Student_Numbers')

# Bar Plot ofr Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(fill=Ethnicity, y=Count, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="Proportion in Admits For All Ethnicities Over 1994 to 2003",y='Student_Numbers')

# Line Plot for Admits by Ethnicity
ggplot(data=temp_Admits, aes(x=Academic_year, y=Count, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Admits Change For All Ethnicities Over 2010 to 2019",y='Student_Numbers')


# Bar Plot for Admits by Ethnicity
ggplot(data=temp_Admits, aes(fill=Ethnicity, y=Count, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Proportion in Admits For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

