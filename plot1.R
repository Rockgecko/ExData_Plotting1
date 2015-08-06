#load data from relevant dates into R
# nb: read.csv2.sql requires sqldf package
# script requires household_power_consumption.txt to be in working directoryre
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
png(file="plot1.png", width = 480, height = 480)
with(hpc, {
    hist(Global_active_power,
         col="RED",
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)")
})
dev.off()

