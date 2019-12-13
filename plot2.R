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

png(filename="plot2.png")

plot(x=filtered_data$DateTime, y=filtered_data$Global_active_power,
     type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
