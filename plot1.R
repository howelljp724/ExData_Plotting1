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
#below sequence creates the file "plot1.png" and plots the histogram to it
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
hist(pwrdata$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()#close the png sequence
