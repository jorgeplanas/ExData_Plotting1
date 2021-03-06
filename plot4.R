
###create a directory in your working directory and set it as working

if (!file.exists("electric")) {
        dir.create("electric")}

setwd(".//electric")

###download and unzip the files

url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url,"electric.zip")

unzip("electric.zip")

###read the needed data into R and convert the date and time to datetime

electric<-read.csv('household_power_consumption.txt',header=FALSE,sep=";",na.strings = "?", skip=66637,nrows=2880)
electricnames<-read.csv('household_power_consumption.txt',header=FALSE,stringsAsFactors = FALSE,sep=";",nrows=1)

colnames(electric)<-electricnames[1,]

electric$Date<-as.Date(electric$Date,"%d/%m/%Y")

electric$Datetime<-strptime(paste(electric$Date,electric$Time, sep=" "),format="%Y-%m-%d %H:%M:%S")


#make and save plot 4 to a png file

png(file = "plot4.png")
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1), oma = c(0, 0, 0, 0))
with(electric, {
        plot(Datetime,Global_active_power, type = "l", ylab="Global Active Power",xlab="")
        plot(Datetime,Voltage, type = "l", ylab="Voltage",xlab="datetime")
        
        plot(Datetime,Sub_metering_1, type = "l", ylab="Energy sub metering",xlab="")
        lines(Datetime,Sub_metering_2,col="red")
        lines(Datetime,Sub_metering_3,col="blue")
        legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty = "n")
        
        plot(Datetime,Global_reactive_power, type = "l", ylab="Global_reactive_power",xlab="datetime")
})
dev.off()
