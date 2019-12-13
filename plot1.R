library(readr)
library(tidyverse)

power_consumption <- read_delim("household_power_consumption.txt", 
				";",
				escape_double = FALSE,
				na = c("?"),
				col_types = cols(Date = col_date(format = "%d/%m/%Y"),
						 Time = col_time(format = "%H:%M:%S")), 
				trim_ws = TRUE)

filtered_data <- power_consumption %>%
	filter(Date >= "2007-02-01" & Date <="2007-02-02")

png(filename="plot1.png")

hist(filtered_data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
