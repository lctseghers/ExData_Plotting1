## download data file "Electric power consumption" which is a zipped text file
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
## four plots in a 2 x 2 organization

png("plot4.png",  width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))

## plot 1 reuses the code from plot2.R with small adjustment to the y-axis label

with(household, plot(Time, Global_active_power, type = "l", 
                      xlab = "", ylab = "Global Active Power"))

## plot 2 reuses the code from plot3.R, resizing the legend to 0.9 and removing the border

with(household, plot(Time, Sub_metering_1, 
                      type = "l", 
                      xlab = "", 
                      ylab = "Energy sub metering"))
lines(household$Time, household$Sub_metering_2, col = "red")
lines(household$Time, household$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        bty = "n", cex = 0.9)

## plot 3 is a line plot of Time by Voltage

with(household, plot(Time, Voltage, type = "l", 
                     xlab = "datetime", 
                     ylab = "Voltage"))

## plot 4 is a line plot of Time by Global_reactive_power

with(household, plot(Time, Global_reactive_power, type = "l", 
                     xlab = "datetime", 
                     ylab = "Global_reactive_power"))

dev.off()

