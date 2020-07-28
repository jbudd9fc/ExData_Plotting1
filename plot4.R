url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
Unzipdir <- unzip(temp)

pcon <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Format date and power and subset to the selected range 
pcon$Date <- as.Date(pcon$Date, format = "%d/%m/%Y")
pcon$Global_active_power <- as.numeric(pcon$Global_active_power)
pcon <- subset(pcon, pcon$Date >= "2007-02-01" & pcon$Date <= "2007-02-02")
pcon$Sub_metering_1 <- as.numeric(pcon$Sub_metering_1)
pcon$Sub_metering_2 <- as.numeric(pcon$Sub_metering_2)
pcon$DateTime <- strptime(paste(pcon$Date, pcon$Time),"%Y-%m-%d %H:%M:%S")
pcon$DateTime <- as.POSIXct(pcon$DateTime)
pcon$Voltage <- as.numeric(pcon$Voltage)

##Create and plot the four plots identified in question 4
## Graph 1
plot(pcon$Global_active_power~pcon$DateTime,type = "l", ylab = "
     Global Active Power", xlab = "")
## Graph2
plot(pcon$Voltage~pcon$DateTime,type = "l", ylab = "Voltage", xlab = "datetime")

## Graph 3
plot(y = pcon$Sub_metering_1, x = pcon$DateTime, type = "l", ylab = "
     Energy sub meetering", xlab = "")
lines(x=pcon$DateTime, y = pcon$Sub_metering_2, col="red" )
lines(x=pcon$DateTime, y = pcon$Sub_metering_3, col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col = c("black","red","blue"), lwd = c(1,1,1))
