#Basic Let's begin with basics. To get familiar with R coding environment, 
# start with some basic calculations. 
#1. R console can be used as an interactive calculator too. 

  
2 + 3
6 / 3

(3*8)/(2*3)
log(12)
sqrt (121)

#In R, you can create a variable usinComputations in R
#g <- or = sign. 
#Let's say I want to create a variable x to compute the sum of 7 and 8. I'll write it as:
  
x <- 8 + 7
x


# 2. Essentials of R Programming

# Everything you see or create in R is an object. A vector, matrix, data frame, 
# even a variable is an object. R treats it that way. So, R has 5 basic classes of objects.
#
#This includes:
#   
# Character
# Numeric (Real Numbers)
# Integer (Whole Numbers)
# Complex
# Logical (True / False)
# Since these classes are self-explanatory by names,
# These classes have attributes. 
# Think of attributes as their 'identifier', a name or number which aptly 
# identifies them. An object can have following attributes:
#   
# names, dimension names
# dimensions
# class
# length
# Attributes of an object can be accessed using attributes() function. 
# More on this coming in following classes
# 
# Let's understand the concept of object and attributes practically. 
# The most basic object in R is known as vector. You can create an empty vector using vector().
# Remember, a vector contains object of same class.
# 
# For example: Let's create vectors of different classes.
# We can create vector using c() or concatenate command also.
# 
a <- c(1.8, 4.5)   #numeric
b <- c(1 + 2i, 3 - 6i) #complex
d <- c(23, 44)   #integer
e <- vector("logical", length = 5)
 
# Similarly, you can create vector of various classes.

# Data Types in R
# R has various type of 'data types' which includes vector (numeric, integer etc), 
# matrices, data frames and list. Let's understand them one by one.
# Vector: As mentioned above, a vector contains object of same class.
# But, you can mix objects of different classes too. 
# When objects of different classes are mixed in a list, 
# coercion occurs. This effect causes the objects of different types to 'convert' 
# into one class. For example:

qt <- c("Time", 24, "October", TRUE, 3.33)  #character
ab <- c(TRUE, 24) #numeric
cd <- c(2.5, "May") #character
 
# To check the class of any object, use class("vector name") function.

class(qt)

# To convert the class of a vector, you can use as. command.

bar <- 0:5
class(bar)

as.numeric(bar)
class(bar)
as.character(bar)
class(bar)

# 
# Similarly, you can change the class of any vector.
#But, you should pay attention here. If you try to convert a "character" vector to 
#"numeric" , NAs will be introduced. Hence, you should be careful to use this command.
# 
# 
# 
# List: A list is a special type of vector which contain elements of different data types.
# For example:
#   
my_list <- list(22, "ab", TRUE, 1 + 2i)
my_list
 
# As you can see, the output of a list is different from a vector.
# This is because, all the objects are of different types. 
# The double bracket [[1]] shows the index of first element and so on. 
# Hence, you can easily extract the element of lists depending on their index. Like this:
#   
my_list[[3]]

 
# You can use [] single bracket too.
# But, that would return the list element with its index number, 
# instead of the result above. Like this:
#   
my_list[3]

# Matrices: When a vector is introduced with row and column i.e. a dimension attribute, 
# it becomes a matrix. A matrix is represented by set of rows and columns. 
# It is a 2 dimensional data structure. It consist of elements of same class.
# Let's create a matrix of 3 rows and 2 columns:
#   
my_matrix <- matrix(1:6, nrow=3, ncol=2)
my_matrix
dim(my_matrix)
attributes(my_matrix)
 
# As you can see, the dimensions of a matrix can be obtained using either dim() or attributes() command. 
#To extract a particular element from a matrix, simply use the index shown above. 
#For example(try this at your end):
#   
my_matrix[,2]   #extracts second column
my_matrix[,1]   #extracts first column
my_matrix[2,]   #extracts second row
my_matrix[1,]   #extracts first row
# 
# As an interesting fact, you can also create a matrix from a vector. 
#All you need to do is, assign dimension dim() later. Like this:
#   
age <- c(23, 44, 15, 12, 31, 16)
age

dim(age) <- c(2,3)
age
class(age)

# You can also join two vectors using cbind() and rbind() functions. 
# But, make sure that both vectors have same number of elements. 
# If not, it will return NA values.

x <- c(1, 2, 3, 4, 5, 6)
y <- c(20, 30, 40, 50, 60)
cbind(x, y)
cbind(x, y)

class(cbind(x, y))


# Data Frame: This is the most commonly used member of data types family.
# It is used to store tabular data. It is different from matrix. 
# In a matrix, every element must have same class. 
# But, in a data frame, you can put list of vectors containing different classes.
# This means, every column of a data frame acts like a list. 
# Every time you will read data in R, it will be stored in the form of a data frame. 
# Hence, it is important to understand the majorly used commands on data frame:
#   
df <- data.frame(name = c("ash","jane","paul","mark"), score = c(67,56,87,91))
df
dim(df)

str(df)
nrow(df)
ncol(df)

# Let's understand the code above. df is the name of data frame.
# dim() returns the dimension of data frame as 4 rows and 2 columns. 
# str() returns the structure of a data frame i.e. the list of variables 
# stored in the data frame. nrow() and ncol() return the number of rows and number of 
# columns in a data set respectively.
# 
# Here you see "name" is a factor variable and "score" is numeric.
# In data science, a variable can be categorized into two types: Continuous and Categorical.
# 
# Continuous variables are those which can take any form such as 1, 2, 3.5, 4.66 etc.
# Categorical variables are those which takes only discrete values such as 2, 5, 11, 15 etc.
# In R, categorical values are represented by factors. 
# In df, name is a factor variable having 4 unique levels.
# Factor or categorical variable are specially treated in a data set.

# Let's now understand the concept of missing values in R. 
# This is one of the most painful yet crucial part of predictive modeling. 
# You must be aware of all techniques to deal with them. 
# The complete explanation on such techniques is provided here.
# 
# Missing values in R are represented by NA and NaN. 
# Now we'll check if a data set has missing values (using the same data frame df).
# 
df[1:2,2] <- NA #injecting NA at 1st, 2nd row and 2nd column of df 
df
is.na(df) #checks the entire data set for NAs and return logical output
table(is.na(df)) #returns a table of logical output
df[!complete.cases(df),] #returns the list of rows having missing values

# Missing values hinder normal calculations in a data set.
# For example, let's say, we want to compute the mean of score. 
# Since there are two missing values, it can't be done directly. Let's see:
#   
mean(df$score)

mean(df$score, na.rm = TRUE)


# The use of na.rm = TRUE parameter tells R to ignore the NAs and compute the mean 
# of remaining values in the selected column (score). 
# To remove rows with NA values in a data frame, you can use na.omit:
#   
new_df <- na.omit(df)
new_df


# Control Structures in R
# As the name suggest, a control structure 'controls' the flow of code / commands 
# written inside a function. A function is a set of multiple commands written 
# to automate a repetitive coding task.
# 
# For example: You have 10 data sets. You want to find the mean of 'Age' column 
# present in every data set. This can be done in 2 ways: either you write the code 
# to compute mean 10 times or you simply create a function and pass the data set to it.
# 
# Let's understand the control structures in R with simple examples:
#   
#   if, else - This structure is used to test a condition. Below is the syntax:
#   
#   if (<condition>){
#     ##do something
#   } else {
#     ##do something
#   }
# 
# Example
# 
# #initialize a variable
N <- 10

# #check if this variable * 5 is > 40
if (N * 5 > 40){
   print("This is easy!")
 } else {
   print ("It's not easy!")
 }

 
# for - This structure is used when a loop is to be executed fixed number of times. It is commonly used for iterating over the elements of an object (list, vector). Below is the syntax:
#   
#   for (<search condition>){
#     #do something
#   }
# 
# Example
# 
# #initialize a vector
y <- c(99,45,34,65,76,23)
 
#print the first 4 numbers of this vector
 for(i in 1:4){
   print (y[i])
 }
# while - It begins by testing a condition, and executes only if the condition is found to be true.
#Once the loop is executed, the condition is tested again. 
#Hence, it's necessary to alter the condition such that the loop doesn't go infinity.
# Below is the syntax:
#   
#   #initialize a condition
Age <- 12

# #check if age is less than 17
while(Age < 17){
   print(Age)
   Age <- Age + 1 #Once the loop is executed, this code breaks the loop
 }
# There are other control structures as well but are less frequently used than 
# explained above. Those structures are:
#   
# repeat - It executes an infinite loop
# break - It breaks the execution of a loop
# next - It allows to skip an iteration in a loop
# return - It help to exit a function
# Note: If you find the section 'control structures' difficult to understand, 
#not to worry. R is supported by various packages to compliment the work done
#by control structures.


## Descriptive statistics is next....



typos = c(2,3,0,3,1,0,0,1)

typos.draft1 = c(2,3,0,3,1,0,0,1)
typos.draft2 = c(0,3,0,3,1,0,0,1)

typos.draft2 = typos.draft1 # make a copy
typos.draft2[1] = 9 # assign the first page 0 typos


typos.draft2 # print out the value

typos.draft2[4] # all but the 4th page

typos.draft2[c(1,2,3)] # fancy, print 1st, 2nd and 3rd

max(typos.draft2) # what are worst pages?

typos.draft2 == 3 # Where are they?

which(typos.draft2 == 3)

?which()

sum(typos.draft2) # How many typos?

sum(typos.draft2>0)


typos.draft1 - typos.draft2 # difference between the two


whale = c(74, 122, 235, 111, 292, 111, 211, 133, 156, 79)

mean(whale)
var(whale)
std(whale)
sqrt(var(whale))
sqrt( sum( (whale - mean(whale))^2 /(length(whale)-1)))
std = function(x) sqrt(var(x))
std(whale)
summary(whale)

miles = c(65311, 65624, 65908, 66219, 66499, 66821, 67145, 67447)
x = diff(miles)

#Categorical data 

x=c("Yes","No","No","Yes","Yes")

x

factor(x)

#Bar Plots

beer = c(3,4,1,1,3,4,3,3,1,3,2,1,2,1,2,3,2,3,1,1,1,1,4,3,1)

barplot(beer) # this isn't correct
barplot(table(beer)) # Yes, call with summarized data

barplot(table(beer)/length(beer)) # divide by n for proportion
table(beer)/length(beer)

#Pie charts

beer.counts = table(beer) # store the table result
pie(beer.counts) # first pie -- kind of dull
names(beer.counts) = c("domestic\n Can","Domestic\n bottle","Microbrew","Imported\n Liq") # give names                         "Microbrew","Import") # give names
pie(beer.counts) # prints out names
pie(beer.counts,col=c("purple","green2","cyan","white")) # now with colors

#Frequency Polygon
x = c(.314,.289,.282,.279,.275,.267,.266,.265,.256,.250,.249,.211,.161)
tmp = hist(x) # store the results
lines(c(min(tmp$breaks),tmp$mids,max(tmp$breaks)),c(0,tmp$counts,0),type="l")


data=c(10, 17, 18, 25, 28, 28)
summary(data)
quantile(data,.25)
quantile(data,c(.25,.75)) # two values of p at once

sals= c(12,0.4,5,2,50,8,3,1,4,0.25)
mean(sals) # the average

mean(sals,trim=1/10) # trim 1/10 off top and bottom
mean(sals,trim=2/10)
var(sals) # the variance
sd(sals) # the standard deviation
median(sals) # the median
summary(sals)
sort(sals)
Trimed_ten_Percent_mean = mean(sals,trim=1/10)
mean(sals,trim=2/10)
IQR(sals)
mad(sals)

#And to see that we could do this ourself, we would do

median(abs(sals - median(sals))) # without normalizing constant
median(abs(sals - median(sals))) * 1.4826


sals = c(12, .4, 5, 2, 50, 8, 3, 1, 4, .25) # enter data
cats = cut(sals,breaks=c(0,1,5,max(sals))) # specify the breaks
?cut


cats # view the values
table(cats) # organize
cats
levels(cats) = c("poor","rich","Surviving") # change labels
table(cats)

#Histograms

x = c(29.6,28.2,19.6,13.7,13.0,7.8,3.4,2.0,1.9,1.0,0.7,0.4,0.4,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0.1)
hist(x) # frequencies
hist(x,probability=TRUE) # proportions (or probabilities)
rug(jitter(x))
hist(x,breaks=10) # 10 breaks, or just hist(x,10)
hist(x,breaks=c(0,1,2,3,4,5,10,20,max(x))) # specify break points

#Boxplots
install.packages("UsingR")
install.packages("ggplot2movies")
library(UsingR)
library(ggplot2movies)
?data

data(movies)
names(movies)
attach(movies) # to access the names above
head(movies)
boxplot(current,main="current receipts",horizontal=TRUE)
boxplot(gross,main="gross receipts",horizontal=TRUE)

MyData <- MBA.Starting.Salaries.Data
str(MyData)



