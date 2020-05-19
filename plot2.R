
library(data.table)

#reading the text file 

##dataset link : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

mydataa = read.table('household_power_consumption.txt',sep=";",
                     header = TRUE,check.names = TRUE,na.strings = '?')

#converting the type of all column data from factor type to various types

mydataa$Date <- as.Date(mydataa$Date, format="%d/%m/%Y")
mydataa$Time <- format(mydataa$Time, format="%H:%M:%S")
mydataa$Global_active_power <- as.numeric(mydataa$Global_active_power)
mydataa$Global_reactive_power <- as.numeric(mydataa$Global_reactive_power)
mydataa$Voltage <- as.numeric(mydataa$Voltage)
mydataa$Global_intensity <- as.numeric(mydataa$Global_intensity)
mydataa$Sub_metering_1 <- as.numeric(mydataa$Sub_metering_1)
mydataa$Sub_metering_2 <- as.numeric(mydataa$Sub_metering_2)
mydataa$Sub_metering_3 <- as.numeric(mydataa$Sub_metering_3)

#subsetting the rows from the given dates

sub_data <- subset(mydataa, Date=="2007-02-01" | Date=="2007-02-02")

sub_data$DateTime <- as.POSIXct(as.character(paste(sub_data$Date, sub_data$Time)))

#creating the plot

with(sub_data, plot(DateTime,Global_active_power,xlab = '',ylab = 'Global Active Power (kilowatts)',type ='l'))

#copy the histogram from device screen to graphics file device : png (Bitmap format)
#by default 480x480

dev.copy(png,file="plot2.png")

#closing the png device , it's important !
dev.off()