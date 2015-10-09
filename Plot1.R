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


## generate the Global Active Power histogram plot1.png

png(filename = "Plot1.png", width = 480, height = 480)

hist(my_data$Global_active_power, main=("Global Active Power"), 
     xlab="Global Active Power (kilowatts)", col="red")

dev.off()
