#Since the dataset is quite big, I would rather read the data from just between 2007-02-01 and 2007-02-02
#Firstly, read the header.
hpname <- read.table("household_power_consumption.txt",sep=";",nrows=1)

#Secondly, read the lines between 66637 to 69516, which are the data between 2007-02-01 and 2007-02-02.
#I know the line numbers because I used to read the whole dataset into R and check the row numbers.
hp <- read.table("household_power_consumption.txt",sep=";",na.strings="?",skip=66637,nrows=2880)

#Coerce each element into character type and give names to hp
names(hp) <- sapply(hpname,as.character)
hp$DT <- paste(hp$Date,hp$Time)

#Convert DT into Date/Time class
hp$DT <- strptime(hp$DT,format="%d/%m/%Y %H:%M:%S")

#Making the plot
png("plot4.png")
par(mfcol=c(2,2))

#Draws the upper left plot
with(hp,plot(DT,Global_active_power,pch=".",xlab="",ylab="Global Active Power"))
with(hp,lines(DT,Global_active_power))

#Draws the lower left plot
with(hp,plot(DT,Sub_metering_1,pch=".",xlab="",ylab="Energy sub metering"))
with(hp,lines(DT,Sub_metering_1))
with(hp,points(DT,Sub_metering_2,pch=".",col="red"))
with(hp,lines(DT,Sub_metering_2,col="red"))
with(hp,points(DT,Sub_metering_3,pch=".",col="blue"))
with(hp,lines(DT,Sub_metering_3,col="blue"))
legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Draws the upper right plot
with(hp,plot(DT,Voltage,pch=".",xlab="datetime",ylab="Voltage"))
with(hp,lines(DT,Voltage))

#Draws the lower right plot
with(hp,plot(DT,Global_reactive_power,pch=".",xlab="datetime"))
with(hp,lines(DT,Global_reactive_power))

dev.off()