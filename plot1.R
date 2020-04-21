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
png("plot1.png")
hist(
    ds$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red"
)
dev.off()
