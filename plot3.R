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
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
#this sequence starts with a basic plot of "Time" against "Sub_metering_1"(or energy
#from the kitchen)
plot(pwrdata$Time, pwrdata$Sub_metering_1, ann=FALSE,type="n")
lines(pwrdata$Time, pwrdata$Sub_metering_1, lwd=2)
#it then adds lines (of different colors) to show "Time" against "Sub_metering_2"(or
#energy from the laundry room)
lines(pwrdata$Time, pwrdata$Sub_metering_2, lwd=2, col="red")
#....and "Time" against "Sub_metering_3"(or energy from water heater/ A/C)
lines(pwrdata$Time, pwrdata$Sub_metering_3, lwd=2, col="blue")
title(" ",xlab="",ylab="Energy sub metering")

#the below code adds a legend in the top-right, using the pch code for "-"
legend("topright", pch="-", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()