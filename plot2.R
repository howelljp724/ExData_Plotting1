setwd("~/Documents/My Documents/Data Courses/Exploratory Data")
pwrcon<-read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")) 
#read.table recognizes the separator as ";" and sets any entries that are "?" or "" to NA

#the below converts the "Date" column to a Date format in the d/m/y sequence
pwrcon$Date <- as.Date(pwrcon$Date, format = "%d/%m/%Y")

#the below 2 steps convert the time column into POSIXlt format
pwrcon$timetemp <- paste(pwrcon$Date, pwrcon$Time)
#first, paste the Date and Time together in a temp variable
pwrcon$Time <- strptime(pwrcon$timetemp, format = "%Y-%m-%d %H:%M:%S")
#next, redefine the Time variable using strptime and define the format

#now, subset the data to all those entries between 2007-02-01 and 2007-02-02
pwrdata <- subset(pwrcon, Date>="2007-02-01" & Date<="2007-02-02")

library(datasets)
library(graphics)
#below sequence creates the file "plot2.png" and plots a scatter diagram with lines
#connecting dots (type "l") showing Global Active Power vs the time from midnight on
#Thursday, 2007-01-31 to midnight on Friday, 2007-02-02
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
with(pwrdata, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

