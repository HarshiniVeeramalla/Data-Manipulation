setwd("D:\\jigsaw\\R\\28.2")
getwd()

# 1 Read the csv file audit.csv.

var <- read.csv("audit.csv")  # double quotes is must

str(var)
View(var)

# 2 Displaying Row numbers 1,2,8,456.

var[c(1,2,8,456),]

# 3 Displaying first 5 rows of column "Education".

var$Education[1:5]    #here we are taking the education as vector so there are no rows and columns

var[c(1:5),"Education"]

head(var[5,"Education"])

head(var$Education,5) # here education is taken as vector

head(var[,"Education"],5)

# 4 Get rows for male private employed employees

Y <- var[var$Employment == "Private" & var$Gender == "Male",]  # doesnt need two braces since we have only one comma and this diferentiates rows and cols
View(Y)

#try using sql

# 6 Get only the columns Age and Marital status of male private employed employees

X <- var[var$Employment == "Private" & var$Gender == "Male", c("Age","Marital")]
View(X)

# 7 Get all the columns except Age and Marital status of male private employees

Z <- var[var$Employment == "Private" & var$Gender == "Male", -c(2,5)]   # c doesnt work for characters it only works for numeric
View(Z)

select(var,var$Employment == "private", var$Gender == "Male")


# 8 Create a new column LogIncome

var$logIncome <- log(var$Income)
View(var)

# 9 Convert the column 'hours' into days and create another column out of it.

install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)
install.packages("sqldf")
library(sqldf)

days <- var$Hours/24    # round(var$hours/24)
View(days)
days1 <- round(days)
var$days <- days1
View(var)


# 10 Sort the data in ascending order of income

asc <- arrange(var,Income)
View(asc)

#11 Sort the data in descending order of Age.

dsc <- arrange(var,-Income)
View(dsc)
#or
dscnd <- arrange(var,desc(Income))
View(dscnd)

# 12 What is the average income by Gender and Marital Status?

grp <- group_by(var,Gender,Marital)   # dplyr
avgInc <- summarize(grp,mean(Income))
View(avgInc)

#13 What are the minimum, maximum of the average income by Gender and Marital Status?

grp <- group_by(var,Gender,Marital)
avgInc <- summarize(grp,mean(Income))
#summary(avgInc)     # gives all min,max,mean, etc.,
avgInc2 <- summarize(avgInc,min(avgInc),max(avgInc))
View(avgInc2)

# 14 Create a contingency table for Gender vs. Marital Status.

cntngnc <- table(var$Gender,var$Marital)
View(cntngnc)

# 15 Find the number of people born on a Wednesday.

# Sys.Date() - 2

Sys.Date()
var$Birthday <- Sys.Date() - var$Age*365.25
View(var)
var%>%filter(weekdays(Birthday) == "Wednesday")%>% nrow()


tod<-Sys.Date()
tod
var$Dob<-tod - var$Age*365.25
View(var)

# 16 Create a column that concatenates Education and Employment.

concat <- paste(var$Education,var$Employment)
View(concat)

#17 Replace all 'Yr" values to "School.

is.character(var$Education)
var$Education = as.character(var$Education)

substr(var$Education, 1,2)

index <- which(substr(var$Education, 1,2) == "Yr")
var$Education[index] <- "School"

View(var)
