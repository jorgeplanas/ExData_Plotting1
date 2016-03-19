
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


#make and save plot 3 to a png file

png(file = "plot3.png")
plot(electric$Datetime,electric$Sub_metering_1, type = "l", ylab="Energy sub metering",xlab="")
lines(electric$Datetime,electric$Sub_metering_2,col="red")
lines(electric$Datetime,electric$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"))
dev.off()
