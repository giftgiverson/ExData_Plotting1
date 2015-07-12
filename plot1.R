##Collect tools
library(data.table)
library(dplyr)
library(lubridate)

##Read data
power <- fread("household_power_consumption.txt", na.strings = '?'
               ,colClasses = list(character = 1:9))
power <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")
power <- mutate(power, Timestamp = dmy(Date) + hms(Time))
power <- mutate_each(power, funs(as.numeric), -c(Date, Time, Timestamp))
power <- select(power, -Date, -Time)

##Print plot to PNG (480px is the default size)
png(filename = "plot1.png")
hist(power$Global_active_power,col = "red",
     xlab = "Globla Active Power (kilowatts)", main = "Global Active Power")
dev.off()
