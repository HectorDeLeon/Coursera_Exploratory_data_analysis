###Import Data
data <- read.table("C:/Users/MyLady17/Desktop/household_power_consumption.txt", sep = ";", header = TRUE,
                   stringsAsFactors = FALSE)

### Check Strcture (many chr Variables)
str(data)

###Subset the data to 2 days
data<- subset(data, data$Date %in% c("1/2/2007","2/2/2007"))

###Preprocess the data: chr to numeric, chr to date
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)


### combine date and time to an accurate date variable
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

### Open device and generate plot
png("Plot3.png", width = 480, height = 480)
with(data,{
    plot(datetime,data$Sub_metering_1, type="l",
    ylab="Energy sub metering")
    lines(datetime,data$Sub_metering_2,col='Red')
    lines(datetime,data$Sub_metering_3,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), 
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, lwd = 2)
dev.off()
