#Outlier detection and management-R Code
cars1 <- cars[1:30, ] # original data
#Inject outliers into data.
cars_outliers <- data.frame(speed=c(19,19,20,20,20), dist=c(190, 186, 210, 220, 218)) # introduce outliers.
cars2 <- rbind(cars1, cars_outliers) # data with outliers.
# Plot of data with outliers.
par(mfrow=c(1, 2))
plot(cars2$speed, cars2$dist, xlim=c(0, 28), ylim=c(0, 230), main="With Outliers", xlab="speed", ylab="dist", pch="*", col="red", cex=2)
abline(lm(dist ~ speed, data=cars2), col="blue", lwd=3, lty=2)
# Plot of original data without outliers. Note the change in slope (angle) of best fit line.
plot(cars1$speed, cars1$dist, xlim=c(0, 28), ylim=c(0, 230), main="Outliers removed \n A much better fit!", xlab="speed", ylab="dist", pch="*", col="red", cex=2)
abline(lm(dist ~ speed, data=cars1), col="blue", lwd=3, lty=2)

#Detect outliers - Univariate approach
#For a given continuous variable, outliers are those observations
#that lie outside 1.5 * IQR, where IQR, the 'Inter Quartile Range'
#is the difference between 75th and 25th quartiles.
#Look at the points outside the whiskers in below box plot.

url <- "https://raw.githubusercontent.com/selva86/datasets/master/ozone.csv"
inputData <- read.csv(url) # import data
head(inputData)
names(inputData)
outlier_values <- boxplot.stats(inputData$pressure_height)$out # outlier values.
boxplot(inputData$pressure_height, main="Pressure Height", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

#Bivariate approach

#url <- "http://rstatistics.net/wp-content/uploads/2015/09/ozone.csv"
ozone <- read.csv(url)
# For categorical variable
boxplot(ozone_reading ~ Month, data=ozone, main="Ozone reading across months")
# clear pattern is noticeable

boxplot(ozone_reading ~ Day_of_week, data=ozone, main="Ozone reading for days of week")
# this may not be significant, as day of week variable is a subset of the month var.

#What is the inference? 
#The change in the level of boxes suggests that Month seem to have an impact
#in ozone_reading while Day_of_week does not.
#Any outliers in respective categorical level show up as dots outside
#the whiskers of the boxplot.

# For continuous variable (convert to categorical if needed.) 
boxplot(ozone_reading ~ pressure_height, data=ozone, main="Boxplot for Pressure height (continuos var) vs Ozone")
boxplot(ozone_reading ~ cut(pressure_height, pretty(inputData$pressure_height)), data=ozone,main="Boxplot for Pressure height (categorial) vs Ozone", cex.axis=0.5)
#You can see few outliers in the box plot and how the ozone_reading increases
#with pressure_height. Thats clear. Multivariate Model

#Multivariate Model Approach - Cooks Distance

mod <- lm(ozone_reading ~ ., data=ozone)
cooksd <- cooks.distance(mod)

#Influence measures In general use, those observations that have a cook's distance
#greater than 4 times the mean may be classified as influential.
#This is not a hard boundary.
# plot cook's distance
plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance") 
abline(h = 4*mean(cooksd, na.rm=T), col="red") # add cutoff line
# add labels
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")

#Now lets find out the influential rows from the original data.
#If you extract and examine each influential row 1-by-1 (from below output),
#you will be able to reason out why that row turned out influential.
#It is likely that one of the X variables included in the model had extreme values.

# influential row numbers
influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))]) 
head(ozone[influential, ]) # influential observations.

#Lets examine the first 6 rows from above output to find out why these rows could be tagged as influential observations.
# TAke a look at the header(rows)

#Outliers Test
#The function outlierTest from car package gives the most extreme observation
#based on the given model.
#Here's an example based on the mod linear model object we'd just created.

car::outlierTest(mod)
# This output suggests that observation in row 243 is most extreme.

#outliers package The outliers
#install.packages('outliers')
library(outliers)
set.seed(1234)
y=rnorm(100)
outlier(y)
outlier(y,opposite=TRUE)
dim(y) <- c(20,5) # convert it to a matrix outlier(y)
outlier(y)
outlier(y,opposite=TRUE)

#Treating the outliers

#Once the outliers are identified and you have decided to make amends as per
#the nature of the problem, you may consider one of the following approaches.
#1. Imputation Imputation with mean / median / mode. This method has been dealt
#with in detail in the discussion about treating missing values.
#2. Capping For missing values that lie outside the 1.5 * IQR limits,
#we could cap it by replacing those observations outside the lower limit
#with the value of 5th %ile and those that lie above the upper limit, 
#with the value of 95th %ile. Below is a sample code that achieves this.

x <- ozone$pressure_height
qnt <- quantile(x, probs=c(.25, .75), na.rm = T)
caps <- quantile(x, probs=c(.05, .95), na.rm = T)
H <- 1.5 * IQR(x, na.rm = T)
x[x < (qnt[1] - H)] <- caps[1] 
x[x > (qnt[2] + H)] <- caps[2]
