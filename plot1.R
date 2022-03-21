
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


#Plot1 to png device
png("plot1.png", width = 480, height = 480)
with(powerconsum, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()