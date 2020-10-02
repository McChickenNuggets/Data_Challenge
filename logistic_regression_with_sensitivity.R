library(tidyverse)

# Read the data
pp16twitter <- read_csv("pp16df.csv", col_types = cols())

# Drop out the observations that are ambiguious
temp<-pp16twitter %>% filter(support!="neutral")

# Select Required Varaible
temp<-temp %>% select(support,inCA,influential)

# Replace variable
temp$support=ifelse(temp$support=='yes',1,0)
temp$inCA=ifelse(temp$inCA=='yes', 1,0)
temp$influential=ifelse(temp$influential=='yes', 1,0)

# visualize the variable
# correlation between numeric variables
library(corrgram)
corrgram(temp, order = TRUE,
         lower.panel = panel.shade, upper.panel = panel.pie,
         text.panel = panel.txt,
         main = "Correlogram of Variables")

# Conduct logistic regression to dataset
initial<-glm(formula = support~inCA+influential+inCA*influential,data=temp,family = 'binomial')
summary(initial)

library(MASS)
# Run stepAIC to get the best fit model
stepAIC(initial,scope = list(lower=~1), direction = "backward",k=2)

# Based on the result and determine the best model is the initial model

# Test the percentage of correctness given our model
log_predprob = predict(initial, temp,type='response')

# Change standard to 0.5, then there is error in prediction given our model since all of the 
# predicted response is less than 0.5. Based on the givern result, we manage to do a good job
# in conducting text-mining for Not support.
standard<-0.4
log_pred = log_predprob > standard
log_cm = table(true = temp$support, predicted = log_pred)
log_cm
sum(diag(log_cm))/sum(log_cm)

#Sensitivity: proportion of predictions for Yes on prop16 out of the number of samples which actually support prop16.
sens=54/(54+246)

#Specificity  proportion of predictions for No on prop16 out of the number of samples which actually object prop16.
spec=779/(779+64)
