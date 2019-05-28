# Multiple regression is an extension of linear regression into relationship
# between more than two variables. In simple linear relation we have one predictor
# and one response variable, but in multiple regression we have more than one
# predictor variable and one response variable.
# The general mathematical equation for multiple regression is ???
# 
# y = a + b1x1 + b2x2 +...bnxn 
# 
# Following is the description of the parameters used ??? y is the response variable.
# a, b1, b2...bn are the coefficients. x1, x2, ...xn are the predictor variables.
# We create the regression model using the lm function in R. The model determines the
# value of the coefficients using the input data. Next we can predict the value of the
# response variable for a given set of predictor variables using these coefficients.
# 
# lm Function
# This function creates the relationship model between the predictor and the response 
# variable. 
# 
# Syntax
# The basic syntax for lm function in multiple regression is ???
# lm(y ~ x1+x2+x3...,data) 
# 
# Following is the description of the parameters used ??? formula is a symbol 
# presenting the relation between the response variable and predictor variables.
# data is the vector on which the formula will be applied. Example Input Data
# Consider the data set "mtcars" available in the R environment.
# It gives a comparison between different car models in terms of mileage per gallon , 
# cylinder displacement , horse power , weight of the car and some more parameters.
# The goal of the model is to establish the relationship between "mpg" as a response 
# variable with "disp","hp" and "wt" as predictor variables. We create a subset of
# these variables from the mtcars data set for this purpose.

install.packages('dplyr')
library(dplyr)
df <- mtcars % > %
  select(-c(am, vs, cyl, gear, carb))
glimpse(df)

input <- mtcars[,c("mpg","disp","hp","wt")]
print(head(input))


# Create Relationship Model & get the Coefficients
input <- mtcars[,c("mpg","disp","hp","wt")] 

# Create the relationship model. 

model <- lm(mpg~disp+hp+wt, data = input) 

# Show the model. 

print(model) 
summary(model)

# Get the Intercept and coefficients as vector elements.
cat("# # # # The Coefficient Values # # # ","\n") 

a <- coef(model)[1]

print(a) 

Xdisp <- coef(model)[2]
Xhp <- coef(model)[3]
Xwt <- coef(model)[4] 

print(Xdisp)
print(Xhp)
print(Xwt)

# Create Equation for Regression Model
# Based on the above intercept and coefficient values, we create the mathematical equation.
# R Multiple Regression

# Y = a+Xdisp.x1+Xhp.x2+Xwt.x3 
# 
# or
# 
# Y = 37.15+(-0.000937)*x1+(-0.0311)*x2+(-3.8008)*x3 
# Apply Equation for predicting New Values
# We can use the regression equation created above to predict the mileage when 
# a new set of values for displacement, horse power and weight is provided.

# For a car with disp = 221, hp = 102 and wt = 2.91 the predicted mileage is ???

Y = 37.15+(-0.000937)*221+(-0.0311)*102+(-3.8008)*2.91

print(Y)




