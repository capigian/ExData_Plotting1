#-----------------------------Download file and unzip----------------------------------------
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

#---------------------Preparing the subset of the data-------------------------------------
#Create dataset and name it household
household <- read.table("household_power_consumption.txt",skip=1,sep=";")

#Add labels to each column of dat
names(household) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Create subset of household data 
householdperdate <- subset(household,household$Date=="1/2/2007" | household$Date =="2/2/2007")


#----------------------------- Transforming the Date and Time ----------------------------------------
householdperdate$Date <- as.Date(householdperdate$Date, format="%d/%m/%Y")
householdperdate$Time <- strptime(householdperdate$Time, format="%H:%M:%S")
householdperdate[1:1440,"Time"] <- format(householdperdate[1:1440,"Time"],"2007-02-01 %H:%M:%S")
householdperdate[1441:2880,"Time"] <- format(householdperdate[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# ---------------------------Plot the data--------------------------------------------
plot(householdperdate$Time,as.numeric(as.character(householdperdate$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 


#-------------------Save histogram as a png file-------------------------------------------------------
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()