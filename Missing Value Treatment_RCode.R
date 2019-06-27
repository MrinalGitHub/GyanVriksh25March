
install.packages('mlbench')
library(mlbench)
data ("BostonHousing", package="mlbench") # initialize the data # load the data
original <- BostonHousing # backup original data
# Introduce missing values 
set.seed(100) 
BostonHousing[sample(1:nrow(BostonHousing), 40), "rad"] <- NA 
BostonHousing[sample(1:nrow(BostonHousing), 40), "ptratio"] <- NA 
head(BostonHousing)

install.packages('mice')
library(mice)
md.pattern(BostonHousing) # pattern or missing values in data.

#1. Deleting the observations
lm(medv ~ ptratio + rad, data=BostonHousing, na.action=na.omit) 

#2.Deleting the variable
## Look at the variable importance and take a call on deleting the Col.

#3. Imputation with mean / median / mode

install.packages('Hmisc')
library(Hmisc)
impute(BostonHousing$ptratio, mean) # replace with mean
impute(BostonHousing$ptratio, median) # median
impute(BostonHousing$ptratio, 90000) # replace specific number

#Computation of accuracy

install.packages('DMwR')
library(DMwR)
actuals <- original$ptratio[is.na(BostonHousing$ptratio)]
predicteds <- rep(mean(BostonHousing$ptratio, na.rm=T), length(actuals))
regr.eval(actuals, predicteds)
predicteds <- rep(median(BostonHousing$ptratio, na.rm=T), length(actuals))
regr.eval(actuals, predicteds)

#4. Prediction
# 4.1. kNN Imputation
knnOutput <- knnImputation(BostonHousing[, !names(BostonHousing) %in% "medv"])
# perform knn imputation
anyNA(knnOutput)
actuals <- original$ptratio[is.na(BostonHousing$ptratio)]
predicteds <- knnOutput[is.na(BostonHousing$ptratio), "ptratio"]
regr.eval(actuals, predicteds)
library(rpart)
class_mod <- rpart(rad ~ . - medv, data=BostonHousing[!is.na(BostonHousing$rad), ], method="class", na.action=na.omit)
# since rad is a factor

anova_mod <- rpart(ptratio ~ . - medv, data=BostonHousing[!is.na(BostonHousing$ptratio), ], method="anova", na.action=na.omit)
# since ptratio is numeric.
rad_pred <- predict(class_mod, BostonHousing[is.na(BostonHousing$rad), ])
ptratio_pred <- predict(anova_mod, BostonHousing[is.na(BostonHousing$ptratio), ])
actuals <- original$ptratio[is.na(BostonHousing$ptratio)]
predicteds <- ptratio_pred
regr.eval(actuals, predicteds)

actuals <- original$rad[is.na(BostonHousing$rad)]
predicteds <- as.numeric(colnames(rad_pred)[apply(rad_pred, 1, which.max)])
mean(actuals != predicteds) # compute misclass error.
# This yields a mis-classification error of 25%. Not bad for a factor variable!

# 4.3 mice: Multivariate Imputation by Chained Equations
install.packages('mice')
library(mice)
miceMod <- mice(BostonHousing[, !names(BostonHousing) %in% "medv"], method="rf")
# perform mice imputation, based on random forests.
miceOutput <- complete(miceMod) # generate the completed data.
anyNA(miceOutput)
actuals <- original$ptratio[is.na(BostonHousing$ptratio)]
predicteds <- miceOutput[is.na(BostonHousing$ptratio), "ptratio"]
regr.eval(actuals, predicteds)

actuals <- original$rad[is.na(BostonHousing$rad)]
predicteds <- miceOutput[is.na(BostonHousing$rad), "rad"]
mean(actuals != predicteds) # compute misclass error.

