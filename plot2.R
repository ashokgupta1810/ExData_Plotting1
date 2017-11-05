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
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()