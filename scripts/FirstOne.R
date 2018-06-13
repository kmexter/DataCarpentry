#library(tidyverse)

download.file("https://ndownloader.figshare.com/files/2292169",             
              "data/portal_data_joined.csv")

surveys <- read.csv("data/portal_data_joined.csv")
## Getting info on the data in the file
View(surveys)
head(surveys)
str(surveys)
dim(surveys) 
nrow(surveys) 
ncol(surveys) 
tail(surveys) 
names(surveys) 
rownames(surveys)
summary(surveys)

## Factor class is categorical data. Will see when type str(surveys). These are not treated 
#  as strings even tho they are, rather e.g. "AH" is treated as a category in the factor
#  R treats factors as integers so it treats data as such, not as string or other
#  Note that cvs read command will set to int, real, bool...some order, but strings are 
#  always read in as factor, unless you specify otherwise
#  PS categorical class should be kept for things that are categories, but if are notes or 
#  e.g. y/n or a string value, better no (see below)
#  To create a factor with string values:
sex1 <- factor(c("m","f","f"))
sex1 
sex1 <- factor(sex1,levels=c("f","f","m")) 
# or similar (syntax error here somewhere) to set the level order, or
sex1 <- factor(c("m","f","f"),levels=c("f","f","m"))
as.character(sex1) # to turn into a String1d
# but
year <- factor(c(1990,1983,77))
as.numeric(year) 
#
# So can have int or another data type in there also but be careful because data is converted 
# from the integer value to an index. Are various ways to get around this - check it out!

plot(surveys$sex)
# want to change the blanks, but not in original object, a copy
sex = surveys$sex
levels(sex)[1] <- "undet"
levels(sex)
plot(sex)

levels(sex)[2] <-"female"
levels(sex)[3] <- "male"
# levels(sex)[2:3] <- c("female","male")
plot(sex)
levels(sex)
# change order
sex <- factor(sex, levels=c("female","male","undet"))
plot(sex)


## different behaviours for reading csv file
surveys <- read.csv("data/portal_data_joined.csv",stringsAsFactors = FALSE)
str(surveys) # read in as chr (string)
# change to a factor
surveys$genus <- factor(surveys$genus)
str(surveys)

## Dates can be treated as dates 
#install.packages("lubridate") # don't do this right now !!!! loads 100000000 things!!!!!!
library(lubridate)
myDate <- ymd("2015-01-31")
str(myDate)
myDate <- ymd(paste("2015","1","31",sep="-"))
str(myDate)

#paste(surveys$year, surveys$month, surveys$day, sep="-")
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep="-"))
# add a new column and put in the new format date there
str(surveys)

idx <- is.na(surveys$date)
dateCols = c("year","month","day")
missingDate <- surveys[idx,dateCols]
head(missingDate) # dates are wrong (31 09 does not exist)

## Note:
# d<-0/0 -> NaN
# d<-1/0 -> Inf
# Note: NaN, NA, and Inf are not treated exactly the same. NA is often just ignored, but 
# NaN and Inf will often throw an error

