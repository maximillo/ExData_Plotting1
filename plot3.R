
library(tidyverse)

#Download file
filename <- "power_consumption.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("power_consumption")) { 
  unzip(filename)
}

#Read the file into a df
powerconsum <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings="?") %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(datetime=strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

#Plot3

png("plot3.png", width=480, height=480)
with(powerconsum, plot(datetime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab=""))
with(powerconsum, lines(datetime, Sub_metering_2, type="l", col="red"))
with(powerconsum, lines(datetime, Sub_metering_3, type="l", col="blue"))
with(powerconsum, legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue")))
dev.off()