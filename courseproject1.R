
#Preparation - Create directories for input data and output (plots/graphs)
rm(list = ls())
library(lubridate)
setwd("~/Coursera/Johns_Hopkins_R/4_exploratory_data_analysis/week1")           #change this to whatever directory you want
if(file.exists("./week1project")){file.remove("./week1project")}
if(!file.exists("./week1project")){dir.create("./week1project")}
if(!file.exists("./week1project/output")){dir.create("./week1project/output")}
unzip("./exdata_data_household_power_consumption.zip", exdir = "./week1project/data")
setwd("./week1project/data")
file.rename("household_power_consumption.txt", "data.txt")


#Download data
data <- read.delim("./data.txt", header = TRUE, sep = ";", na.strings = "?")

#Combine date and time
data$DateTime <- dmy_hms(paste(data$Date, data$Time))
data <- subset(data, select = -c(Date, Time))

#Subset to 02-01 and 02-02
data <- data[66637:69516, ]

#Set wd to output
setwd("../output")

#Plot 1
png(filename = "myplot1.png", width = 480, height = 480)
str(data)
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()

#Plot 2
png(filename = "myplot2.png", width = 480, height = 480) 
with(data, {
        plot(DateTime, Global_active_power,
             type = "l",
             ylab = "Global Active Power (kilowatts)",
             xlab = NA)
})
dev.off()

#Plot 3
png(filename = "myplot3.png", width = 480, height = 480)
with(data, {
        plot(DateTime, Sub_metering_1,
             type = "l",
             ylab = "Energy sub metering",
             xlab = NA)
        lines(DateTime, Sub_metering_2,
              col = "red")
        lines(DateTime, Sub_metering_3,
              col = "blue")
        legend("topright", pch = 1,col = c("black", "blue", "red"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()

#Plot 4 - combine 2 previous plots with 2 new plots
png(filename = "myplot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(data, {
        plot(DateTime, Global_active_power,
             type = "l",
             ylab = "Global Active Power (kilowatts)",
             xlab = NA)
        plot(DateTime, Voltage,
             type = "l")
        plot(DateTime, Sub_metering_1,
             type = "l",
             ylab = "Energy sub metering",
             xlab = NA)
        lines(DateTime, Sub_metering_2,
              col = "red")
        lines(DateTime, Sub_metering_3,
              col = "blue")
        legend("topright", pch = 1,col = c("black", "blue", "red"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power,
             type = "l")
})
dev.off()
