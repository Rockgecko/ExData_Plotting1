#load data from relevant dates into R
# nb: read.csv2.sql requires sqldf package
# script requires household_power_consumption.txt to be in working directory
if(!exists("hpc"))
{
    hpc_classes <- c("Date","character",rep("numeric",7))
    hpc <- read.csv2.sql(file = "household_power_consumption.txt", 
                         sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                         header =TRUE, row.names = NULL,
                         colClasses = hpc_classes)
    closeAllConnections()
    
    #convert date and time columns to Date/Time format
    dates<-hpc$Date
    times<-hpc$Time
    x<-paste(dates, times)
    hpc$datetime<-strptime(x,"%d/%m/%Y %H:%M:%S")
}

#create file for saved plot and then create plot
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#first plot
with(hpc, {
    plot(x=datetime, y=Global_active_power, 
         type="l",
         lty=1,
         xlab="",
         ylab="Global Active Power (kilowatts)")
})
#second plot
with(hpc, {
    plot(x=datetime, y=Voltage, 
         type="l",
         lty=1,
         xlab="datetime",
         ylab="Voltage")
})
#third plot
with(hpc, {
    plot(x=datetime, y=Sub_metering_1, 
         type="l",
         lty=1,
         xlab="",
         ylab="Energy sub metering")
})
with(hpc, {lines(x=datetime, y=Sub_metering_2,col=2)})
with(hpc, {lines(x=datetime, y=Sub_metering_3,col=4)})
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c(1,2,4),lty=1,bty="n")

#fourth plot
with(hpc, {
    plot(x=datetime, y=Global_reactive_power, 
         type="l",
         lty=1,
         xlab="",
         ylab="Global_reactive_power")
})



dev.off()

