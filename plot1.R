#make sure that the sqldf package is available
require(sqldf)

#set the filepath, column classes, sql statement correctly, then read in using read.table and subset with sqldf
file <- "household_power_consumption.txt"
statement <- "select * from data where Date = '1/2/2007' or Date = '2/2/2007'"
data <- read.table(file, header=T, sep=";", na.strings = "?", stringsAsFactors=FALSE)
filtered_data <- sqldf(statement)

#combine the date and time columns and convert the new column to a POSIXlt object with strptime()
datetime <- paste(filtered_data$Date,filtered_data$Time)
filtered_data$DateTime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
