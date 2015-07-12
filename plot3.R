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
png(filename = "plot3.png")
plot(power$Timestamp, power$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
points(power$Timestamp, power$Sub_metering_2, type = "l", col = "red")
points(power$Timestamp, power$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 1)
dev.off()
