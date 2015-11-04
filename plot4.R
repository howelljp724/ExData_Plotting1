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
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
#the below parameter call defines 4 separate graphs in a 2x2 configuration
par(mfrow = c(2, 2), mar=c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
#the below sequence uses the main data frame("pwrdata") to plot all 4 graphs
with(pwrdata, {
        #this plot cmd plots the same depiction as in plot2.R
        plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        #this cmd plots "Time" vs "Voltage" as a scatterplot with line-connect
        plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        #these following commands are pulled from plot3.R
        plot(pwrdata$Time, pwrdata$Sub_metering_1, ann=FALSE,type="n")
        lines(pwrdata$Time, pwrdata$Sub_metering_1, lwd=2)
        lines(pwrdata$Time, pwrdata$Sub_metering_2, lwd=2, col="red")
        lines(pwrdata$Time, pwrdata$Sub_metering_3, lwd=2, col="blue")
        title(" ",xlab="",ylab="Energy sub metering")
        legend("topright", pch="-", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        #this cmd plots "Time" against the variable "Global_reactive power"
        plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()