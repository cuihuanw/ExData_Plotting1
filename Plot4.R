## We will only use data from the dates 2007-02-01 and 2007-02-02. 
## Therefore here only read the data from 01/02/2007 and 02/02/2007.

data <- file("household_power_consumption.txt")
my_data <- read.table(text = grep("^[1,2]/2/2007", readLines(data), 
                      value = TRUE), col.names = c("Date", "Time", "Global_active_power", 
                                                    "Global_reactive_power", "Voltage", 
                                                    "Global_intensity", "Sub_metering_1", 
                                                    "Sub_metering_2", "Sub_metering_3"), 
                      sep = ";", header = TRUE)
close(data)

## converting the date from the format of"d/m/y" in original data 
## to the format of "%Y-%m-%d"

my_data$Time<-paste(as.Date(my_data$Date, "%d/%m/%Y"), my_data$Time, sep=" ")
my_data$Time<-strptime(my_data$Time, "%Y-%m-%d %H:%M:%S")


## generate the plot4.png

png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,2))
with(my_data, {
     plot(my_data$Time, my_data$Global_active_power, xlab = "", 
          ylab = "Global Active Power", 
          type = "l")
     plot(my_data$Time, my_data$Voltage, xlab = "datetime", 
       ylab = "Voltage", 
       type = "l")

     plot(my_data$Time, my_data$Sub_metering_1, xlab = "", ylab = "Energy Sub metering", 
          ylim=ylimits, type = "l", col="black")
     par(new=TRUE)
     plot(my_data$Time, my_data$Sub_metering_2, xlab = "", ylab = " ", ylim=ylimits,  
     type = "l", col="red")
     par(new=TRUE)
     plot(my_data$Time, my_data$Sub_metering_3, xlab = "", ylab = " ", ylim=ylimits,
     type = "l", col="blue")
     legend("topright",
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty = c(1,1,1),
            col = c("black", "red", "blue")
           )

     plot(my_data$Time, my_data$Global_reactive_power, xlab = "datetime", 
          ylab = "Global reactive power", 
          type = "l")
     })
dev.off()
