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
plot2 <- function() {
    dat <- readData()
    Sys.setlocale("LC_TIME","C")
    png("plot2.png", width = 480, height = 480, units = "px")
    
    plot(dat$Time, dat$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    
    dev.off()
}