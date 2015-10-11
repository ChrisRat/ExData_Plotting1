# reads the data from file
readData <- function() {
    dstfile <- "./household_power_consumption.txt"
    
    library(data.table)
    
    DT <- fread(dstfile,na.strings = c("?",""))
    
    DT[,Date := as.Date(Date, format = "%d/%m/%Y")]
    
    DT <- DT[Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")]
    
    DT$Time <- as.POSIXct(paste(DT$Date, DT$Time), format = "%Y-%m-%d %H:%M:%S")
    DT
}

# creates the plot
plot3 <- function() {
    dat <- readData()
    Sys.setlocale("LC_TIME","C")
    
    colNames <- names(dat)
    png("plot3.png", width = 480, height = 480, units = "px")
    
    plot(dat$Time, dat$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(dat$Time, dat$Sub_metering_2, type = "l", col="red")
    lines(dat$Time, dat$Sub_metering_3, type = "l", col="blue")
    legend('topright', colNames[7:9], lty = 1, col = c('black','red','blue'))
    
    dev.off()
}