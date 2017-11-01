# Generalized.Linear.Models

## Objective (Find "Best" Model)
Question 1: Use the data set crabs to fit a Poisson regression model with canonical link for the count variable Satellites using predictor variables Width, Dark, GoodSpine

Question 2: Use the data set heart to fit a logistic regression with canonical link to Death using covariates AgeGroup, Severity, Delay, Region.Note here that the data is in matrix form: death and Total, you want to input the data to the model as death and non-death.

Question 3: Use the data set heart to fit a logistic regression using a probit link to the variable Death using covariates AgeGroup, Severity, Delay and Region.

## Summary
Question 1:Did an EDA of variables by checking their structure. Then created a glm using family equals poisson, since this was for a poisson regression model. The default is the canonical link so I didn’t need to set it. I got that the deviance residuals were centered around zero, which is good. The width and Darkyes as significant. Then I got that the residual deviance was 560.96 on 169 degrees of freedom, and a chisquare test to get the pvalue was 0. This means this model is not a good model for the data and that there might be overdisperion.  I made several other glms like including the interaction effects of variables and changing the family to quasipoisson.  I still kept getting very low pvalues for the chisquare test. Since I am supposed to use Poisson model only, the analysis stops. My results are that poission regression with the canonical link of log is not a good fit for the data


Question 2: Did an EDA of variables by checking their structure. Had to create a nondeath column in order to create a glm with the data. I created a glm with family binomial. The deviance residuals were centered around zero, which is good. All the variables were significant and the residual deviance was 121.69 on 69. When I checked the chisquare test the pvalue was below .05, which means my model was not adequate. Then I tried several combinations and landed on glm with AgeGroup * Severity + Delay + Region, family = binomial as the best model. It is a model that incudes AgeGroup, Severity, Delay, Region, and AgeGroup with Severity interaction effect as predictors. 

Question 3: The only difference between question 2 and question 3 was changing the link function. This means the EDA was the same. The new link function caused the model to be totally different from before. The “best” model was the AgeGroup * Severity + Delay + Region, family = binomial (link = probit). The results were the same as question 2 for this model, except that this time the chisquare p value was below .05. This means it’s not a good model for that data. All the other combinations of variables I fitted into a glm had much worse pvalues. 

## Conclusion
Question 1: I got low p values for many different glm models. Since I am supposed to use Poisson model only, the analysis stops. My results are that poission regression with the canoical link of log is not a good fit for the data

Question 2: The "best" model was glm with AgeGroup * Severity + Delay + Region, family = binomial as the best model. It had the lowest AIC and its residual deviance was 84.163 on 69 degrees of freedom. The chisquare test pvalue was above .05 so this meant it was a good model. 

Question 3: Since there were no combinations of predictor values in glm that resulted in chisquare test p value above .05, I had to conclude that the probit function was not a good link funciton for the data. 
