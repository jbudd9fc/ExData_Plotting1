url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
Unzipdir <- unzip(temp)

pcon <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Format date and power and subset to the selected range 
pcon$Date <- as.Date(pcon$Date, format = "%d/%m/%Y")
pcon$Global_active_power <- as.numeric(pcon$Global_active_power)
pcon <- subset(pcon, pcon$Date >= "2007-02-01" & pcon$Date <= "2007-02-02")

## Create single date and time column and set to POSIXct
pcon$DateTime <- strptime(paste(pcon$Date, pcon$Time),"%Y-%m-%d %H:%M:%S")
pcon$DateTime <- as.POSIXct(pcon$DateTime)

## Make line graph
plot(y = pcon$Global_active_power, x = pcon$DateTime, type = "l", ylab = "
     Global Active Power (kilowatts)", xlab = "")
dev.copy(png,"plot2.png",width = 480, height = 480)
dev.off()