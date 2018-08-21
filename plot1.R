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

## create the histogram of variable Global_active_power
## histogram color is red, there are 20 breaks
## x-axis label is specified, y-axis label is the default ("Frequency")
## main title is specified

hist(household$Global_active_power, 
     col = "red", 
     breaks = 20, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

## setting the parameters of the plot as written to a png file

dev.copy(png, "plot1.png",  width = 480, height = 480, units = "px")
dev.off()

