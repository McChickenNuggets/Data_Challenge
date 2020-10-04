library(tidyverse)
install.packages('ggpie')
library(ggpie)

ucdavis2010_2019<-read.csv('Freshmen_Eth_data_2010_2019.csv')
ucdavis1994_2003<-read.csv('Freshmen_Eth_data_1994_2003.csv')
all_campus_94_03<-read.csv('1994_2003_All_Campus.csv')

colnames(ucdavis2010_2019)<-c('Category','Ethnicity','Academic_year','Count','Percentage')
colnames(ucdavis1994_2003)<-c('Category','Ethnicity','Academic_year','Count','Percentage','Difference')
colnames(all_campus_94_03)<-c('Category','Ethnicity','Academic_year','Count','Percentage','Difference')

temp_Admits1<-ucdavis2010_2019 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

temp_Admits2<-ucdavis1994_2003 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

temp_all_campus<-all_campus_94_03 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

ucd19<-ucdavis2010_2019 %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Academic_year==2019, Category=='Admits')

# All Campus Line Plot for Differences in Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_all_campus, aes(x=Academic_year, y=Difference, group=Ethnicity)) +
  geom_line(aes(color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="All Campus Admits Proprtion Change For All Ethnicities Over 1994 to 2003",y='Change in Proportion')

# UC Davis Line Plot for Differences in Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(x=Academic_year, y=Difference, group=Ethnicity)) +
  geom_line(aes(color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="UC Davis Admits Proprtion Change For All Ethnicities Over 1994 to 2003",y='Change in Proportion')

# UC Davis Line Plot ofr Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(x=Academic_year, y=Percentage, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="UC Davis Admits Proprtion Change For All Ethnicities Over 1994 to 2003",y='Percentage Share')

# UC Davis Bar Plot ofr Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(fill=Ethnicity, y=Percentage, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="UC Davis Proportion in Admits For All Ethnicities Over 1994 to 2003",y='Percentage Share')

# UC Davis Line Plot for Admits by Ethnicity from 2010 to 2019
ggplot(data=temp_Admits1, aes(x=Academic_year, y=Percentage, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="UC Davis Admits Proportion For All Ethnicities Over 2010 to 2019",y='Percentage Share')


# UC DAVIS Bar Plot for Admits by Ethnicity from 2010 to 2019
ggplot(data=temp_Admits1, aes(fill=Ethnicity, y=Percentage, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
    labs(title="UC Davis Proportion in Admits For All Ethnicities Over 2010 to 2019",y='Percentage Share')

# All Campus Line Plot by Ethnicity from 1994 to 2003
ggplot(data=temp_all_campus, aes(x=Academic_year, y=Percentage, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="All Campus Admits Proprtion Change For All Ethnicities Over 1994 to 2003",y='Percentage Share')

# All Campus Bar Plot ofr Admits by Ethnicity from 1994 to 2003
ggplot(data=temp_Admits2, aes(fill=Ethnicity, y=Percentage, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(1994,1995,1996,1997,1998,1999,2000,2001,2002,2003))+
  labs(title="All Campus Proportion in Admits For All Ethnicities Over 1994 to 2003",y='Percentage Share')
