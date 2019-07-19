#install.packages('timeSeries')
#install.packages('tseries')
#install.packages('forecast')
library(tseries)
library(forecast)
library(timeSeries)
data(AirPassengers)
class(AirPassengers)
names(AirPassengers)
str(AirPassengers)
#This tells you that the data series is in a time series format

 start(AirPassengers)
#This is the start of the time series

 end(AirPassengers)
#This is the end of the time series

frequency(AirPassengers)
#The cycle of this time series is 12months in a year

summary(AirPassengers)

## Lets dive into more details ##

plot(AirPassengers)
#This will plot the time series

abline(reg=lm(AirPassengers~time(AirPassengers)))
# This will fit in a genearl linear regression line

## Lets expolore more options ##

cycle(AirPassengers)
#This will print the cycle across years.

plot(aggregate(AirPassengers,FUN=mean))
#This will aggregate the cycles and display a year on year trend

boxplot(AirPassengers~cycle(AirPassengers))
#Box plot across months will give us a sense on seasonal effect

# time series decomposition
plot(decompose(AirPassengers))


#The above figure shows the time series decomposition into trend,
#seasonal and random (noise) .
#It is clear that the time series is non-stationary (has random walks) 
# because of seasonal effects and a trend (linear trend).



##Important Inferences
#The year on year trend clearly shows that the #passengers have been increasing without fail.
#The variance and the mean value in July and August is much higher than rest of the months.
#Even though the mean value of each month is quite different their variance is small.
##Hence, we have strong seasonal effect with a cycle of 12 months or less.




apts <- ts(AirPassengers, frequency=12)
f<- decompose(apts)
adf.test(apts, alternative ="stationary", k=12)

# We see that the series is not stationary enough
# to do any kind of time series modelling we need to do differencing.

acf(log(AirPassengers))

#Clearly, the decay of ACF chart is very slow,
#which means that the population is not stationary.
#We have already discussed above that we now intend
#to regress on the difference of logs rather than log directly.
#Let’s see how ACF and PACF curve come out after regressing on the difference.#

acf(diff(log(AirPassengers)))
pacf(diff(log(AirPassengers)))



## Model Identification and Estimation

#We need to find the appropriate values of p,d,q representing the AR order,
# the degress of differencing, and the MA order respectively. 
# We will use auto.arima to find the best ARIMA model to univariate time series
# (i.e. a time series that consists of single (scalar) observations recorded
# sequentially over equal time increments.)

findbest <- auto.arima(AirPassengers)
findbest #Check the arma values: [1]  0  1  0  0 12  1  1


plot(forecast(findbest,h=20))

fit <- arima(AirPassengers, order=c(0, 1, 1), list(order=c(0, 1, 0), period = 12))
fit

#Compute prediction intervals of 95% confidence level for each prediction

fore <- predict(fit, n.ahead=24)
# calculate upper (U) and lower (L) prediction intervals
U <- fore$pred + 2*fore$se # se: standard error (quantile is 2 as mean=0)
L <- fore$pred - 2*fore$se
# plot observed and predicted values
library(graphics)
ts.plot(AirPassengers, fore$pred, U, L, col=c(1, 2, 4, 4), lty=c(1, 1, 2, 2))

legend("topleft", c("Actual", "Forecast", "Error Bounds (95% prediction interval)"), 
       col=c(1, 2, 4), lty=c(1, 1, 2))

# Residual Analysis
# Check normality using Q-Q plot

# qqnorm is a generic function the default method of which produces a
# normal QQ plot of the values in y. 
   qqnorm(residuals(fit))
   qqline(residuals(fit))

##Test for stationarity using ADF test
adf.test(fit$residuals, alternative ="stationary")


#From the above p-value, we can conclude that the residuals of our ARIMA prediction
# model is stationary.

















