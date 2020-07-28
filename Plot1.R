url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
Unzipdir <- unzip(temp)

pcon <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Format date and power and subset to the selected range 
pcon$Date <- as.Date(pcon$Date, format = "%d/%m/%Y")
pcon$Global_active_power <- as.numeric(pcon$Global_active_power)
pcon <- subset(pcon, pcon$Date >= "2007-02-01" & pcon$Date <= "2007-02-02")


pcon$DateTime <- strptime(paste(pcon$Date, pcon$Time),"%Y-%m-%d %H:%M:%S")
pcon$Global_active_power <- as.numeric(pcon$Global_active_power)

## Make and print histogram
hist(pcon$Global_active_power, col = "Red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts", ylab = "Frequency")

dev.copy(png,"plot1.png", width=480, height=480)

dev.off()