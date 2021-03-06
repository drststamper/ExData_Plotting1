#make sure that the sqldf package is available
require(sqldf)

plot3 <- function(){

#set the filepath, sql statement correctly, then read in using read.table and subset with sqldf
file <- "household_power_consumption.txt"
statement <- "select * from data where Date = '1/2/2007' or Date = '2/2/2007'"
data <- read.table(file, header=T, sep=";", na.strings = "?", stringsAsFactors=FALSE)
filtered_data <- sqldf(statement)

#combine the date and time columns and convert the new column to a POSIXlt object with strptime()
datetime <- paste(filtered_data$Date,filtered_data$Time)
filtered_data$DateTime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#open graphics device (png)
png("plot3.png", width = 480, height = 480)

#This line was taken from a forumpost of the course; it makes sure that the weekdays are
#in English and not in my own language (which is the default behavior)
Sys.setlocale("LC_TIME","English_United States.1252")

#create plot3, making use of addition of data using points() and add accompanying legend
plot(filtered_data$DateTime, filtered_data$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering", col = "black")
points(filtered_data$DateTime,filtered_data$Sub_metering_2, type="l", col="red")
points(filtered_data$DateTime,filtered_data$Sub_metering_3, type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#close graphics device(png)
dev.off()

}