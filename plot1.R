## ------------------
##  Load the data
## ------------------

## Download the provided file to a Data folder (create the folder in case it does not exist)
## Once downloaded unzip it
if(!file.exists('./Data')){
        dir.create('./Data')
}
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', './Data/household_power_consumption.zip')
unzip('./Data/household_power_consumption.zip', exdir='./Data')

## Read the data file
householdElectricPowConsumption <- read.table('./Data/household_power_consumption.txt', header=TRUE, sep=';', na.strings='?')

## Filter the dataset and obtain data from the dates 2007-02-01 and 2007-02-02
householdEPC <- householdElectricPowConsumption[householdElectricPowConsumption$Date=='1/2/2007'|householdElectricPowConsumption$Date=='2/2/2007', ]

## Remove the original one
remove(householdElectricPowConsumption)

## Compose date and time string in order to later create POSIXlt objects
dateAndTimeString <- paste(householdEPC$Date, householdEPC$Time)

## Convert Date column to Date type
householdEPC$Date <- as.Date(householdEPC$Date, '%d/%m/%Y')

## Convert Time column to POSIXlt -time- type
householdEPC$Time <- strptime(dateAndTimeString, format='%d/%m/%Y %H:%M:%S')
remove(dateAndTimeString)

## ------------------
##  Let's plot
## ------------------

## First open the graphic device. In this case a 480x480 png (It is the default!)
png('plot1.png')

## Plot the histogram with the color and texts required
hist(householdEPC$Global_active_power, col='orangered', main='Global Active Power', xlab='Global Active Power (kilowatts)')

## Close the graphic device
dev.off()
