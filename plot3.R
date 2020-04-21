# Define
URL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
HPC_ZIP = "household_power_consumption.zip"
HPC_TXT = "household_power_consumption.txt"

# File check
if(!file.exists(HPC_ZIP)) {
    download.file(URL, HPC_ZIP)
}

# Read zip file and select data set between 2007/2/1 ~ 2007/2/2
ds <- read.table(
    unz(HPC_ZIP, HPC_TXT),
    header = TRUE,
    sep = ";",
    colClasses = c(rep("character", 2), rep("numeric", 7)),
    na.strings = "?"
)
ds <- ds[ds$Date == "1/2/2007" | ds$Date == "2/2/2007",]

# Plot
Sys.setlocale(category = "LC_ALL", locale = "C")
png("plot3.png")
dt <- strptime(paste(ds$Date, ds$Time), format = "%d/%m/%Y %T", tz = "CET")
plot(
    dt,
    ds$Sub_metering_1,
    type = "l",
    col = "black",
    xlab = "",
    ylab = "Energy sub metering"
)
lines(dt, ds$Sub_metering_2, col = "red")
lines(dt, ds$Sub_metering_3, col = "blue")
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = c(1, 1, 1),
    col = c("black", "red", "blue")
)
dev.off()
