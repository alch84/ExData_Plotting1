#Read the data into R.  Assume the data has already been downloaded and copied into the working directory

data<-read.table("household_power_consumption.txt",sep = ";",header=TRUE)

#Convert date field into date format and filter on data between 01/02/07 and 02/02/07
data$Date<-as.Date(data$Date,"%d/%m/%Y")
newdata<-data[which(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]

#Convert fields into numeric and create new time field
newdata$Global_intensity<-as.numeric(as.character(newdata$Global_intensity))
newdata$Global_active_power<-as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power<-as.numeric(as.character(newdata$Global_reactive_power))
newdata$Voltage<-as.numeric(as.character(newdata$Voltage))
newdata$Sub_metering_1<-as.numeric(as.character(newdata$Sub_metering_1))
newdata$Sub_metering_2<-as.numeric(as.character(newdata$Sub_metering_2))
newdata$Sub_metering_3<-as.numeric(as.character(newdata$Sub_metering_3))
newdata <- transform(newdata, NewTime=as.POSIXct(paste(Date, Time)))

#Define number of plots
par(mfrow=c(2,2))

#Create plot1
plot(newdata$Global_active_power~newdata$NewTime,type="l",ylab="Global active power",xlab="")

#Create plot2
plot(newdata$Voltage~newdata$NewTime,type="l",ylab="Voltage",xlab="datetime")

#Create plot3
plot(newdata$Sub_metering_1~newdata$NewTime,type="l",ylab="Energy sub metering",xlab="")
lines(newdata$Sub_metering_2~newdata$NewTime,col="red")
lines(newdata$Sub_metering_3~newdata$NewTime,col="blue")
legend("topright",col=c("black","red","blue"),c("Sub_metering_1   ","Sub_metering_2   ","Sub_metering_3   "),lty=c(1,1),bty="n",cex=0.5)

#Create plot4
plot(newdata$Global_reactive_power~newdata$NewTime,type="l",xlab="datetime",ylab="Global_reactive_power")

#Copy into png file
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
