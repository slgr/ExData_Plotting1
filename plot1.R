#download data and list zip contents
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Dataset.zip")
ziplist <- unzip("Dataset.zip")

#load data.table package and read the consumption data
library(data.table)
consumption <- fread(ziplist[1], na.strings = "?")

#load the lubridate package, convert the date and time columns and subset to the period 2007-02-01 to 2007-02-02
library(lubridate)
consumption$Date <- dmy(consumption$Date)
consumption$Time <- hms(consumption$Time)
consumptionrelevant <- consumption[consumption$Date >= ymd("2007-02-01") & consumption$Date <= ymd("2007-02-02"),]

#create png device and first plot
png("plot1.png", width = 480, height = 480)
hist(consumptionrelevant$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", 
     col = "red")
dev.off()