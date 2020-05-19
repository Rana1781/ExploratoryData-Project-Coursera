
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

#creating the plot in png device

png("plot3.png", width=480, height=480)

with(sub_data, plot(DateTime,Sub_metering_1,xlab = '',
                    ylab = 'Energy sub metering',type ='l'))
with(sub_data,points(DateTime,Sub_metering_2,type = 'l',col='red'))
with(sub_data,points(DateTime,Sub_metering_3,type = 'l',col='blue'))

legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#closing the png device , it's important !
dev.off()