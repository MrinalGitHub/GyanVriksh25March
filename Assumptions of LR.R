##  Assumptions of linear regression

# 1. The mean of residuals is zero
cars

mod <- lm(dist ~ speed, data=cars)
mean(mod$residuals)

# Assumption 3: Homoscedasticity of residuals or equal variance

par(mfrow=c(2,2))  # set 2 rows and 2 column plot layout
mod_1 <- lm(mpg ~ disp, data=mtcars)  # linear model
plot(mod_1)

#In this case, there is a definite pattern noticed.
#So, there is heteroscedasticity. Lets check this on a different model.

mod <- lm(dist ~ speed, data=cars[1:20, ])  #  linear model
plot(mod)

#Now, the points appear random and the line looks pretty flat, with no increasing or decreasing trend.
#So, the condition of homoscedasticity can be accepted.

# Assumption 4: The X variables and residuals are uncorrelated

 ##Do a correlation test on the X variable and the residuals.

mod.lm <- lm(dist ~ speed, data=cars)
cor.test(cars$speed, mod.lm$residuals)  # do correlation test 


#p-value is high, so null hypothesis that true correlation is 0 can't be rejected.
#So, the assumption holds true for this model.

# Assumption 5: The number of observations must be greater than number of Xs

##This can be directly observed by looking at the data.

# Assumption 6: The variability in X values is positive

##This means the X values in a given sample must not all be the same (or even nearly the same).

var(cars$speed)  

# The variance in the X variable above is much larger than 0. So, this assumption is satisfied.

# Assumption 8: The regression model is correctly specified

##This means that if the Y and X variable has an inverse relationship,
##the model equation should be specified appropriately:
  
  
 ## Y=??1+??2???(1/X)

# Assumption 8: No perfect multicollinearity

## If the VIF of a variable is high, it means the information in that variable is already
##explained by other
## X variables present in the given model, which means, more redundant is that variable.

# VIF=1/(1???Rsq)

## where, Rsq is the Rsq term for the model with given X as
## response against all other Xs that went into the model as predictors.


install.packages("CARS")
install.packages('car')
insatall.packages('vif')
library(car)
mod2 <- lm(mpg ~ ., data=mtcars)
vif(mod2)
car::vif(mod2)


#How to rectify?
#  Two ways:
  
##  Either iteratively remove the X var with the highest VIF or,
## See correlation between all variables and keep only one of all highly correlated pairs.

install.packages('corrplot')
library(corrplot)
corrplot(cor(mtcars[, -1]))
mod <- lm(mpg ~ cyl + gear, data=mtcars)
car::vif(mod)

#The convention is, the VIF should not go more than 4 for any of the X variables.

# Assumption 9: Normality of residuals

par(mfrow=c(2,2))
mod <- lm(dist ~ speed, data=cars)
plot(mod)

# Check Assumptions Automatically: The gvlma() function from gvlma
install.packages('gvlma')
library(gvlma)

par(mfrow=c(2,2))  # draw 4 plots in same window
mod <- lm(dist ~ speed, data=cars)
gvlma::gvlma(mod)


## Making the modifications
mod <- lm(dist ~ speed, data=cars[-c(23, 35, 49), ])
gvlma::gvlma(mod)


## Cooks distance
influence.measures(mod)




















