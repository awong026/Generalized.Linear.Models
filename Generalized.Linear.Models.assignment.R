#Assignment; Generalized Linear Models

########################################################################################################

#Question1.	Use the data set crabs to fit a Poisson regression model with 
#canonical link for the count variable Satellites using predictor variables Width, Dark, GoodSpine

########################################################################################################

library(glm2)
data(crabs)
attach(crabs)

#y = Satellites
#x = width, dark, goodspine
head(crabs)
str(crabs) 

glm <- glm(Satellites ~ Width + Dark + GoodSpine,family = poisson, data = crabs) #Default link is canonical
summary(glm)

#Deviance Residuals center around zero, which is good
#Significant are  Width, Darkyes
#Resid deviance: 560.96 on 169 df, which is not good. Looks like there could be overdispersion/ need more terms
##to test H0: the model is  adequate vs Ha: the model is not adequate. We compare the deviance to a chi-square with 169 df. 
1-pchisq(560.96,169) #P value is 0, so Ha: model is not adequate

#Lets try to  create a model with interactions effect. Width * Dark
glm2 <- glm(Satellites ~ Width * Dark + GoodSpine, family = poisson,  data = crabs) #Default link is canonical
summary(glm2)

#Deviance Residuals center around zero, which is good
#Significant are Width, Darkyes, and Width: Darkyes interaction
#Resid deviance: 555.41 on 168 df, which is not good. Looks like there could be overdispersion/ need more terms
##to test H0: the model is  adequate vs Ha: the model is not adequate. 
1-pchisq(555.41,168) #P value is 0, so Ha: model is not adequate

#Lets try another interaction effect: Width * Dark * GoodSpine
glm3 <- glm(Satellites ~ Width*Dark+GoodSpine,family = poisson, data = crabs) #Default link is canonical
summary(glm3)

#Deviance Residuals center around zero, which is good
#Significant are width, Darkyes:GoodSpineyes, With:Darkyes:GoodSpineyes
#Resid deviance: 549.49 on 165 df, which is not good. Looks like there could be overdispersion/ need more terms
##to test H0: the model is  adequate vs Ha: the model is not adequate. 
1-pchisq(549.49,165) #P value is 0, so Ha: model is not adequate

#Let's try quasipoisson 
glm4 <- glm(Satellites ~ Width*Dark*GoodSpine,family = quasipoisson, data = crabs) #Default link is canonical
summary(glm4)
#Only sig for width
#Residual deviance: 549.49  on 165  degrees of freedom
1-pchisq(549.49,165) #P value is 0, so Ha: model is not adequate

##to see the effect of adding the new terms
anova(glm, glm4) ##By adding the interaction effect in our final model the deviance was reduced by 11.468 and only 4 df loss

##Look at residuals
plot(glm4$residuals) #Looks good except maybe some outliers

#To get probablity of how many satelites for each combination
glm$fitted.values

##Since I am suppose to use Poisson model only the analysis stops. Would need to check with person asking question if
## I can use other families or tests. My results are that poission regression with the canoical link of log is not 
#a good fit for the data

###############################################################################

#Question 2: Use the data set heart to fit a logistic regression with canonical link to Death using covariates
#AgeGroup, Severity, Delay, Region.  Note here that the data is in matrix form: death and Total, 
#you want to input the data to the model as death and non-death.

###############################################################################

attach(heart)
str(heart)
head(heart)

#Need to create death and non-death columns to run GLM correctly
NDeath <- heart$Patients-heart$Death
heart2 <- data.frame(cbind(Deaths = heart$Deaths, NDeath = NDeath, AgeGroup = heart$AgeGroup, Severity = heart$Severity, Delay = heart$Delay, Region = heart$Region))
head(heart2)
attach(heart2)
logreg <- glm(cbind(Deaths, NDeath) ~ factor(AgeGroup) + factor(Severity) + factor(Delay) + factor(Region), family = binomial, data = heart2)
summary(logreg)

#Deivance resids centered around zero
#All are sig, except delay 2 and region 2
#AIC = 341.6
#Residual deviance:  113.11  on 65  degrees of freedom
##to test H0: the model is  adequate vs Ha: the model is not adequate. 
1-pchisq(113.11,65) #pvalue below .05 so Ha. Model is not adequate

#Let's try with interaction effect: AgeGroup * Severity * Delay * Region
logreg2 <- glm(cbind(Deaths, NDeath) ~ factor(AgeGroup) * factor(Severity) * factor(Delay) * factor(Region), family = binomial, data = heart2)
summary(logreg2)

#Several things are sig, but there is a really low res deviance and 0 degrees of freedom. Not good
#AIC = 358.5
#Residual deviance: 2.7148e-10  on  0  degrees of freedom
1-pchisq(.00000000027,0) #p value is 0 which means Ha is true

#Let's try interaction effect: AgeGroup * Severity
logreg3 <- glm(cbind(Deaths, NDeath) ~ factor(AgeGroup) * factor(Severity) + factor(Delay) + factor(Region), family = binomial, data = heart2)
summary(logreg3) #AIC 312.8
#Sig: All Sig, except region 2 and delay 2
#Residual deviance:   76.31  on 61  degrees of freedom
1-pchisq(76.31,61) #p value is .0895 which means H0 is true

##to see the effect of adding the new terms
anova(logreg, logreg3) ##By adding the interaction effect in our final model the deviance was reduced by 36.8 and only 4 df loss

##Look at residuals
plot(logreg3$residuals) #Looks good

#To get probablity of how many deaths for each combination
logreg3$fitted.values

#############################################################3

#Question 3:3.	Use the data set heart to fit a logistic regression 
#using a probit link to the variable Death using covariates AgeGroup, Severity, Delay and Region.

###############################################################

probit <- glm(cbind(Deaths, NDeath) ~ AgeGroup + Severity + Delay + Region, family = binomial(link = probit), data = heart2)
summary(probit)

#Deviance Resid center around zero
#Sig are all
#Residual deviance:  109.02  on 69  degrees of freedom
1-pchisq(109.02, 69) #pvalue below .05 so Ha

#Try interaciton effect: AgeGroup * Severity
probit2 <- glm(cbind(Deaths, NDeath) ~ factor(AgeGroup) * factor(Severity) + factor(Delay) + factor(Region), family = binomial(link = probit), data = heart2)
summary(probit2) #AIC is 313

#Sig are all
#Residual deviance:   77.232  on 61  degrees of freedom
1-pchisq(77.232, 61) #pvalue above .05 so H0


#Try qusi
probit3 <- glm(cbind(Deaths, NDeath) ~ AgeGroup + Severity + Delay + Region, family = binomial(link = probit), data = heart2)
summary(probit3)


probit4 <- glm(cbind(Deaths, NDeath) ~ Severity + Delay  + AgeGroup + Region, family = quasibinomial(link = probit), data = heart2)
summary(probit4)

##model probit 2 was better than these. 

##to see the effect of adding the new terms
anova(probit, probit2) ##By adding the interaction effect in our final model the deviance was reduced by 31.7 and only 8 df loss

##Look at residuals
plot(probit2$residuals) #Looks good

#To get probablity of how many deaths for each combination
probit2$fitted.values
