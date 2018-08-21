## read from locally saved data file "Electric power consumption", originally a zipped text file
## select out only those rows with data between Feb 1 and Feb 2, 2007
## identify the specific rows by viewing the data in notepad or similar first
## select using skip and nrows arguments
## since the header row will be lost, assign col.names using the original variable names

household <- read.table("household_power_consumption.txt", 
                        skip = 66637, nrows = 2880, 
                        sep = ";", 
                        col.names = c("Date","Time","Global_active_power",
                                      "Global_reactive_power","Voltage","Global_intensity",
                                      "Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                        na.strings = "?")

## add date info to time variable for correct conversion
## convert date variable to date class using as.date()
## convert time variable to time class using strptime()

household$Time <- paste(household$Date, household$Time, sep = " ")
household$Date <- as.Date(household$Date, "%d/%m/%Y")
household$Time <- strptime(household$Time, "%d/%m/%Y %H:%M:%S")

## setting the parameters of the plot as written to a png file
## create the line plots of Time by variables Sub_metering 1, 2, and 3
## line colors are black (1), red (2), and blue (3)
## y-axis label is specified, no other label or title
## add appropriate legend in upper right corner

png("plot3.png",  width = 480, height = 480, units = "px")
with(household, plot(Time, Sub_metering_1, 
                      type = "l", 
                      xlab = "", 
                      ylab = "Energy sub metering"))
lines(household$Time, household$Sub_metering_2, col = "red")
lines(household$Time, household$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

