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

#Create histogram and copy into PNG file
hist(newdata$Global_active_power,col=2,main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
