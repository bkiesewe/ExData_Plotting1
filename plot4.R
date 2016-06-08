# for Plot4, https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1

# checking whether directory exists otherwise create the directory
if (!file.exists("Data")) { dir.create("Data")}

# checking whether the file has already been downloaded otherwise download the same
if (!file.exists("data/household_power_consumption.txt")) {
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zfile <- "./data/exdata_data_household_power_consumption.zip"
  
  message("***** downloading file, this can take up to a few minutes *****")
  download.file(fileURL, destfile=zfile, method="curl")
  unzip(zfile, exdir="./data")}

# loading entire data
message("***** reading the full file - this can take a while *****")

data <- read.table(file="./Data/household_power_consumption.txt", header = TRUE,  sep=";", na.strings = "?")

# subsetting to 01 and 02 February 2007 data
data <- subset(data, as.character(Date) %in%  c("1/2/2007",  "2/2/2007"))
data$Global_active_power <- as.numeric(data$Global_active_power)

# concatinating date and time
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, "%e/%m/%Y %H:%M:%S")

# changing session setting as mine is German Setting
Sys.setlocale("LC_TIME", "English")


# ploting the 4 types
png(filename = "plot4.png",
    width = 480, height = 480)

par(mfcol=c(2,2), mar=c(5,6.5,4,2) ) 



# first plot
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# second plot below
plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")
lines(data$datetime, data$Sub_metering_2, col='red')
lines(data$datetime, data$Sub_metering_3, col='blue')
legend("topright",cex =0.8,bty = 'n',lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# third plot
with(data, (plot(datetime, Voltage, type="l", xlab="datetime")))

# fourth plot
with(data,(plot(datetime, Global_reactive_power, type="l", xlab="datetime")))

dev.off()



