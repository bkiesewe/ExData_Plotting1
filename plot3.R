#sessionInfo()

# for Plot3, https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1

# checking whether directory exists otherwise create the directory
if (!file.exists("Data")) { dir.create("Data")}

# checking whether the file has already been downloaded otherwise download the same
if (!file.exists("Data/household_power_consumption.txt")) {
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zfile <- "./Data/exdata_data_household_power_consumption.zip"
  
  message("***** downloading file, this can take up to a few minutes *****")
  download.file(fileURL, destfile=zfile, method="curl")
  unzip(zfile, exdir="./Data")}

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

# ploting the 3 variables

png(filename = "plot3.png",
    width = 480, height = 480)

par( mar = c(5, 6.5, 4, 2))

plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")
lines(data$datetime, data$Sub_metering_2, col='red')
lines(data$datetime, data$Sub_metering_3, col='blue')
legend("topright",c("Sub_Metering_1","Sub_Metering_2", "Sub_Metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))

dev.off()



