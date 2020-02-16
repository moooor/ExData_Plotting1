# PLOT 1: Global Active Power

# Downloading and extracting the data from source

print("Please be patient! this might take a while")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip", quiet=TRUE)

unzip("exdata-data-household_power_consumption.zip")

print("Data successfuly downloaded and unzipped!")

print("Clearing any other objects in memory to avoid data integrity issues...")

rm(list=ls())

print("This is a huge data set, however needs only data for two days. To avoid straining the memory, R will attempt to read only relevant data. This may take time!")
filter <- c("1/2/2007","2/2/2007")

input <- subset(read.table("./household_power_consumption.txt",sep = ";", header = TRUE),read.table("./household_power_consumption.txt",sep = ";", header = TRUE)$Date %in% c("1/2/2007","2/2/2007"))

print("Data reading is complete!")

input$Global_active_power <- as.numeric(as.character(input$Global_active_power))

input$Date <- as.Date(input$Date, format = "%d/%m/%Y")

cat(rep("\n",2))
print("Creating histogram with device as screen as per the project objctives")
Sys.sleep(2)

hist(input$Global_active_power, xlab="Global Active Power (kilowatts)",col="red", main = "Global Active Power")

print("Saving histogram with device as png as per the project objctives")
dev.copy(png, file="plot1.png")
dev.off()