library (lubridate)
#Read in Data,
df <- data.frame(read.table("household_power_consumption.txt", 
                            header = TRUE, sep = ";", stringsAsFactors = FALSE))

#Create cocatanted date and time column and bind to table. 
date_time <- dmy_hms(paste(df$Date, df$Time)) 
df <- cbind(date_time, df)
df$Date <- NULL 
df$Time <- NULL

#coerce to numeric columns
df[,2:8] <- sapply(df[,2:8], as.numeric)


#subset the data to 1st and 2nd Feb 2007 
Feb <- subset(df, df$date_time >= "2007-02-01" & df$date_time < "2007-02-03")

#Plot4 
png(file = "plot4.png", width =480, height = 480)
par(mfrow = c(2,2))
#topleft
plot(Feb$date_time,Feb$Global_active_power, type = "l", 
     xlab = "",
     ylab = "Global Active Power")
#topright
plot(Feb$date_time, Feb$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage")
#bottomleft
plot(Feb$date_time, Feb$Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab= "")
points (Feb$date_time, Feb$Sub_metering_2, type = "l", col ="red")
points (Feb$date_time, Feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
#bottomright
plot(Feb$date_time, Feb$Global_reactive_power, type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()