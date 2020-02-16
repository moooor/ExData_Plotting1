#PLOT 3: All Sub Metering on Y Axis against time


# Downloading and extracting the data from source

print("Please be patient! this might take a while")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip", quiet=TRUE)

unzip("exdata-data-household_power_consumption.zip")

rm(list=ls())

print("The following solution uses 'sqldf' & 'dplyr' package. If it is not installed, please install. Attempting to read the data.")

suppressMessages(library(sqldf)) ;suppressMessages(library(dplyr))

input <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = TRUE, sep = ";")

suppressWarnings(closeAllConnections())

print("Data reading is complete!")

input$Global_active_power <- as.numeric(as.character(input$Global_active_power))

input$Date <- as.Date(input$Date, format = "%d/%m/%Y")

input <- mutate(input, DateTime = paste(input$Date,input$Time))
input$DateTime <- strptime(input$DateTime, format = "%Y-%m-%d %H:%M:%S")

print("Data formatting is complete. Creating graph.")

png("plot3.png")
plot(input$DateTime,input$Sub_metering_1, xlab = " ", ylab = "Energy sub metering", type = "n")

lines(input$DateTime,input$Sub_metering_1)
lines(input$DateTime,input$Sub_metering_2, col="red")
lines(input$DateTime,input$Sub_metering_3, col="blue")

legend("topright",col = c("black", "red", "blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

dev.off()

print("Graph exported & Saved in the WD")