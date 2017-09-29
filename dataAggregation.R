#load needed libraries
library(reshape)
# Set working directory, place this script file in the same folder
# where you have stored data in separate csv files
setwd(".")

# load data from precipitation file
inputData <- read.csv(file="data/ACCESS1_day_RCP4.5_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_1 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")
#change the column name from "value" to "pr" for precipitation data
colnames(molten_1)[3] <- "pr"


# load data from  file
inputData <- read.csv(file="data/tasmax_day_RCP45_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_2 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")

#change the column name from "value" to "tmax" for precipitation data
colnames(molten_2)[3] <- "tmax"
#conver tmax from Celsius to Kelvin
molten_2$tmax <- molten_2$tmax + 273.15

# load data from  file
inputData <- read.csv(file="data/tasmin_day_RCP45_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_3 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")

#change the column name from "value" to "tmin" for precipitation data
colnames(molten_3)[3] <- "tmin"
molten_3$tmin <- molten_3$tmin + 273.15
dataAggr <- cbind(molten_1, molten_2$tmax, molten_3$tmin)

save(dataAggr, file = "dataAggr")

library(tidyr)
# separate data column to YEAR Month Date
result <- separate(dataAggr, "Date", c("Month", "Date", "Year"), sep = "/")

#re-arrange columns
result <- result[c(3,1,2, 4,5,6,7)]
#store final data as finalResult
save("result", file = "finalResult")
dir.create("./output")  
writecsv <- function(){
  for(i in 1:155){
    temp <- subset(result, stations == i, select = -stations)
    write.table(temp, sep = "  ", file = paste0("output/" , i, ".txt"), quote=FALSE,
                row.names=FALSE, col.names = FALSE)
    
  }
}
writecsv()

  
  