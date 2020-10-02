 library(tidyverse)
library(stringr)
library(MASS)

# Read the data
pp16twitter <- read_csv("pp16df.csv", col_types = cols())

# Drop out the observations that are ambiguious
temp<-pp16twitter %>% filter(support!="neutral")

# Select Required Varaible
temp<-temp %>% select(support,inCA,influential)

# Replace yes with 1, no with 0
temp$support<-str_replace(temp$support,"no",'0')
temp$support<-str_replace(temp$support,"yes","1")
temp$support<-as.numeric(temp$support)

# visualize the variable
# correlation between numeric variables
library(corrgram)
corrgram(temp, order = TRUE,
         lower.panel = panel.shade, upper.panel = panel.pie,
         text.panel = panel.txt,
         main = "Correlogram of Variables")
# No numeric Variable in our dataset, and we cannot use corrgram to display the correlation between variables

# Conduct logistic regression to dataset
initial<-glm(formula = support~inCA+influential+inCA*influential,data=temp,family = 'binomial')
summary(initial)

# Run stepAIC to get the best fit model
stepAIC(initial,scope = list(lower=~1), direction = "backward",k=2)

# Based on the result and determine the best model is the initial model

# Test the percentage of correctness given our model
log_predprob = predict(initial, temp,type='response')
log_pred = (log_predprob > 0.5)
log_cm = table(true = temp$support, predicted = log_pred)
log_cm
sum(diag(log_cm))/sum(log_cm)

