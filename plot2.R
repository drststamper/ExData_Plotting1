#make sure that the sqldf package is available
require(sqldf)

plot2 <- function(){

#set the filepath, sql statement correctly, then read in using read.table and subset with sqldf
file <- "household_power_consumption.txt"
statement <- "select * from data where Date = '1/2/2007' or Date = '2/2/2007'"
data <- read.table(file, header=T, sep=";", na.strings = "?", stringsAsFactors=FALSE)
filtered_data <- sqldf(statement)

#combine the date and time columns and convert the new column to a POSIXlt object with strptime()
datetime <- paste(filtered_data$Date,filtered_data$Time)
filtered_data$DateTime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#open screen device (png)
png("plot2.png", width = 480, height = 480)

#This line was taken from a forumpost of the course; it makes sure that the weekdays are
#in English and not in my own language (which is the default behavior)
Sys.setlocale("LC_TIME","English_United States.1252")

#create plot2, with labels and data
plot(filtered_data$DateTime, filtered_data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

#close screen device(png)
dev.off()

}