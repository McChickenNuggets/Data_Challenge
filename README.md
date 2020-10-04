![image](https://github.com/McChickenNuggets/Data_Challenge/blob/master/img/Team_Outlier_Logo.png)

# README: 2020 Data Challenge by Team Outliers

This is the main directory for data and support files related to the Team Outliers. 

This project focuses on 2020 California Proposition 16 as our topic.

### Background Information 
Proposition 16 allows diversity as a factor in public employment, education, and contracting decisions. 

A YES vote on this measure means: State and local entities could consider race, sex, color,
ethnicity, and national origin in public education, public employment, and public contracting to the extent allowed under federal and state law.

A NO vote on this measure means: The current ban on the consideration of race, sex, color,
ethnicity, and national origin in public education, public employment, and public contracting would remain in effect. 

Historical Timeline: 
 - mid-1960s: CA embraced Affirmative Action.
 - 1996: CA banned Affirmative Action as Prop 209 passed.
 - 2020: Prop 16 tries to restore Affirmative Action in CA. 
 
### Motivation
The adoption of Affirmative Action in CA twists and turns along with the history. One of the most heavily influenced fields by Affirmative Action is college admission. We, as a group of Asians, are concerned with issues sensitive to race, ethnicity or national origin that could also determine our future. We, as UC Davis students, are curious to know how amendment in the legislative constitution will possibly affect admission here in UC Davis. Hence, we put our attention on proposition 16 that debates on ethnicity as a factor in education decisions. We would like to gain a well-rounded view on this hotly debated issue from both the current circumstances and possible implications.

### Research Questions
With our topics of interest, we developed three research questions relevant to Prop 16.
- Q1:  How controversial is Proposition 16? 
- Q2: Who is supporting and who is opposing Proposition 16?
- Q3: What would be the impact on UC Davis admission if Proposition 16 passes?

### Methodology
Data for Prop 16 is collected from Twitter through api and web scraping. To approach Q1, we use a bar graph to visualize the popularity of Prop 16 by comparing its number of tweets within 30 days with the other nine. To approach Q2, we clean the data and classify tweets by yes and no coalitions for Prop 16 in two ways. For those with tendentious keywords in hashtags, we classify based on hashtags. For those without, we apply text-mining on each tweet content, and classify the coalitions based on 3 methods of sentiment analysis. We then use the resultant dataset to figure out users who are most engaged in the topic, and the most frequent words in the biography of each coalition. Meanwhile, we also try to construct a logistic model that predicts coalitions using the user location and account influence with the model's effectiveness evaluated. To approach Q3, we obtain official data from University of California admission. Assuming admission decisions before Prop 209 would somehow reference the trend after Prop 16, we visualize UCD admission by ethnicity from year 1994 to year 2013 as well as the more recent admission from year 2010 to year 2019. We analyze and generalize the trend in graphs and make further conclusions on possible variations in UCD admission if Prop 16 passes and under assumption that everything else is constant (ideal situation with no demographic change, etc).  

### Flow Chart
![image](https://github.com/McChickenNuggets/Data_Challenge/blob/master/img/Flow_Chart.png)

### Directory Manifest
- Folders:
    - “Datasets” - contains UCD admission data by ethnicity and Prop 16 relevant data from Twitter
        - “Freshmen_Eth_data_1994_2003.csv”: UCD admission data within year 1994 ~ 2003 from University of California Admissions
        -  “Freshmen_Eth_data_2010_2019.csv”: UCD admission data within year 2010 ~ 2019 from University of California Admissions
        - “pp16df.csv”: processed dataset with coalitions classified for Prop16 from Twitter
        - “pp16df.csv”: raw data from Twitter 
    - “Img” - contains visualization plots

- Files: 
    - “Admission_data_visualization.R” - contains graphs for UCD admission by ethnicity in two 10 years periods
    - “barplot.R” - contains a bar graph shows number of tweets for Prop 15~24
    -  “logistic_regression_with_sensitivity.R” - contains a logistic model of coalitions by user location and account influence and model evaluation 
    - “rtweet.R” - contains code retrieving Prop16 tweets for thirty days
    - “text_mining.R” - contains three method of sentiment analysis for coalition classification
    - “wordcloud.R” - contains visuals that display the most frequent words in users bio by coalitions and the most active twitter users discussing Prop 16 

### Contributors
- Annie Tang*, UC Davis Statistics Undergraduate, yntang@ucdavis.edu
- Xuanbin Chen, UC Davis Statistics Undergraduate, cxbchen@ucdavis.edu
- Chao Cheng, UC Davis Statistics Graduate, kckcheng@ucdavis.edu

### Project URL
- UCD admission dataset: https://www.universityofcalifornia.edu/infocenter/admissions-residency-and-ethnicity
- rtweet: https://github.com/ropensci/rtweet/ 
