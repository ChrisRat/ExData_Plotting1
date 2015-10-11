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
plot1 <- function() {
    dat <- readData()
    
    png("plot1.png", width = 480, height = 480, units = "px")
    
    hist(dat$Global_active_power, main = "Global Active Power", xlim = range(0,6),
         ylim = range(0,1200), col = "red", xlab = "Global Active Power (kilowatts)")
    
    dev.off()
}