#--------PLOT 2: Global Active Power against time------------------
# *****************************************************************

# Downloading and extracting the data from source

print("Please be patient! this might take a while")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip", quiet=TRUE)

unzip("exdata-data-household_power_consumption.zip")

print("Data successfuly downloaded and unzipped!")

rm(list=ls())

print("The following solution uses 'sqldf' & 'dplyr' package. If it is not installed, please install. Attempting to read the data.")

suppressWarnings(library(sqldf)) ;suppressWarnings(library(dplyr))

input <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = TRUE, sep = ";")

closeAllConnections()

print("Data reading is complete!")

input$Global_active_power <- as.numeric(as.character(input$Global_active_power))

input$Date <- as.Date(input$Date, format = "%d/%m/%Y")

input <- mutate(input, DateTime = paste(input$Date,input$Time))
input$DateTime <- strptime(input$DateTime, format = "%Y-%m-%d %H:%M:%S")

print("Data formatting is complete. Creating graph.")

plot(input$DateTime,input$Global_active_power, xlab = " ", ylab = "Global Active Power (kilowatts)", type = "n")
lines(input$DateTime,input$Global_active_power)

print("Saving graph with device as png")
dev.copy(png, file="plot2.png")
dev.off()