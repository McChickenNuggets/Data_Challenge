library(tidyverse)

ucdavis<-read.csv('Freshmen_Eth_data.csv')

colnames(ucdavis)<-c('Category','Ethnicity','Academic_year','Count','Percentage')

temp_Applicants<-ucdavis %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Applicants')
temp_Enrollees<-ucdavis %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Enrollees')
temp_Admits<-ucdavis %>% filter(Ethnicity!='All',Ethnicity!='Unknown',Category=='Admits')

# Line Plot for Applicants by Ethnicity
ggplot(data=temp_Applicants, aes(x=Academic_year, y=Count, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Applicants Change For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

# Line Plot for Enrollees by Ethnicity
ggplot(data=temp_Enrollees, aes(x=Academic_year, y=Count, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Enrollees Change For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

# Line Plot for Admits by Ethnicity
ggplot(data=temp_Admits, aes(x=Academic_year, y=Count, group=Ethnicity)) +
  geom_line(aes(linetype=Ethnicity,color=Ethnicity))+
  geom_point(aes(shape=Ethnicity,color=Ethnicity))+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Admits Change For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

# Bar Plot for Applicants by Ethnicity
ggplot(data=temp_Admits, aes(fill=Ethnicity, y=Count, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Proportion in Applicants For All Ethnicities Over 2010 to 2019",y='Student_Numbers')+
  geom_text(aes(label=Percentage))

# Bar Plot for Enrollees by Ethnicity
ggplot(data=temp_Enrollees, aes(fill=Ethnicity, y=Count, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Proportion in Enrollees For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

# Bar Plot for Admits by Ethnicity
ggplot(data=temp_Admits, aes(fill=Ethnicity, y=Count, x=Academic_year)) + 
  geom_bar(position="fill", stat="identity")+
  scale_x_continuous(name = " ", breaks = c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019))+
  labs(title="Proportion in Admits For All Ethnicities Over 2010 to 2019",y='Student_Numbers')

