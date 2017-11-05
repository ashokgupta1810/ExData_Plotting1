library(lubridate)


if(!file.exists("./powerdata")){dir.create("./powerdata")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./powerdata/consumption.zip")

# unzip data to data directory
unzip(zipfile="./powerdata/consumption.zip", exdir = "./powerdata")

# listing content of zip files 
list.files("./powerdata")

# reading data
houseDfr <- read.table("./powerdata/household_power_consumption.txt", sep = ";", header = TRUE)

# converting into date class head(filterhouseDfr)
houseDfr$Date<- dmy(houseDfr$Date)

# filtering data on date
filterhouseDfr <-  houseDfr[ houseDfr$Date>= "2007-02-01" & houseDfr$Date<= "2007-02-02", ]


#str(subSetData) head(datetime)
datetime <- strptime(paste(filterhouseDfr$Date, filterhouseDfr$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 


globalActivePower <- as.numeric(filterhouseDfr$Global_active_power)
globalReactivePower <- as.numeric(filterhouseDfr$Global_reactive_power)
voltage <- as.numeric(filterhouseDfr$Voltage)
subMetering1 <- as.numeric(filterhouseDfr$Sub_metering_1)
subMetering2 <- as.numeric(filterhouseDfr$Sub_metering_2)
subMetering3 <- as.numeric(filterhouseDfr$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
