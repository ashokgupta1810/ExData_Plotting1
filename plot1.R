library(lubridate)


if(!file.exists("./powerdata")){dir.create("./powerdata")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./powerdata/consumption.zip")

# unzip data to data directory
unzip(zipfile="./powerdata/consumption.zip", exdir = "./powerdata")

# listing content of zip files 
list.files("./powerdata")

houseDfr <- read.table("./powerdata/household_power_consumption.txt", sep = ";", header = TRUE)

# converting into date class head(filterhouseDfr)
houseDfr$Date <- dmy(houseDfr$Date)
# filtering data on date
filterhouseDfr <-  houseDfr[ houseDfr$Date>= "2007-02-01" & houseDfr$Date<= "2007-02-02", ]

head(filterhouseDfr$Global_active_power)
# converting class
filterhouseDfr$Global_active_power <- as.numeric((filterhouseDfr$Global_active_power))

png("plot1.png", width=480, height=480)
hist(filterhouseDfr$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()