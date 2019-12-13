library(readr)
library(tidyverse)
Sys.setlocale(category = "LC_ALL", locale = "english") # Required for english labeling of days

power_consumption <- read_delim("household_power_consumption.txt", 
				";",
				escape_double = FALSE,
				na = c("?"),
				col_types = cols(Date = col_date(format = "%d/%m/%Y"),
						 Time = col_time(format = "%H:%M:%S")), 
				trim_ws = TRUE)

filtered_data <- power_consumption %>%
	filter(Date >= "2007-02-01" & Date <="2007-02-02") %>%
	mutate(DateTime = as.POSIXct(strptime(paste0(Date, " ", Time), format="%Y-%m-%d %H:%M:%S")))

png(filename="plot4.png")

par(mfrow=c(2,2))

plot(x=filtered_data$DateTime, y=filtered_data$Global_active_power,
     type="l",
     xlab="", ylab="Global Active Power")

plot(x=filtered_data$DateTime, y=filtered_data$Voltage,
     type="l",
     xlab="datetime", ylab="Voltage")

plot(x=filtered_data$DateTime, y=filtered_data$Sub_metering_1,
     type="l",
     col="black",
     xlab="", ylab="")

lines(x=filtered_data$DateTime, y=filtered_data$Sub_metering_2,
     type="l",
     col="red",
     xlab="", ylab="")

lines(x=filtered_data$DateTime, y=filtered_data$Sub_metering_3,
     type="l",
     col="blue",
     xlab="", ylab="")

title(ylab="Energy sub metering")

legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=rep(1,3))

plot(x=filtered_data$DateTime, y=filtered_data$Global_reactive_power,
     type="l",
     xlab="datetime", ylab="Global_reactive_power")


dev.off()
