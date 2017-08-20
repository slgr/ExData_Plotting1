#download data and list zip contents
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              "Dataset.zip")
ziplist <- unzip("Dataset.zip")

#load data.table package and read the consumption data
library(data.table)
consumption <- fread(ziplist[1], na.strings = "?")

#load lubridate package, convert date, and subset to the period 2007-02-01 to 2007-02-02, create datetime
library(lubridate)
consumption$DateConv <- dmy(consumption$Date)
consumptionrelevant <- consumption[consumption$DateConv >= ymd("2007-02-01") & 
                                     consumption$DateConv <= ymd("2007-02-02"),]
consumptionrelevant$DateTime <- dmy_hms(paste(consumptionrelevant$Date, consumptionrelevant$Time))

#create png device and first plot
png("plot3.png", width = 480, height = 480)
plot(consumptionrelevant$DateTime, consumptionrelevant$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", type = "n")
points(consumptionrelevant$DateTime, consumptionrelevant$Sub_metering_1, col = "black", type = "l")
points(consumptionrelevant$DateTime, consumptionrelevant$Sub_metering_2, col = "red", type = "l")
points(consumptionrelevant$DateTime, consumptionrelevant$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, 
                     col = c("black","red","blue")) 
dev.off()