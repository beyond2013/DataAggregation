#load needed libraries
library(reshape)
# Set working directory, place this script file in the same folder
# where you have stored data in separate csv files
setwd("stackoverflow")

# load data from precipitation file
inputData <- read.csv(file="data/ACCESS1_day_RCP4.5_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_1 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")

# load data from  file
inputData <- read.csv(file="data/tasmax_day_RCP45_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_2 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")


# load data from  file
inputData <- read.csv(file="data/tasmin_day_RCP45_2006_2099.csv",
                      header = TRUE, check.names = FALSE)
# change data from wide to long format
molten_3 <- melt(inputData, id.vars = "Date",
                             variable_name = "stations")


dataAggr <- cbind(molten_1, molten_2$value, molten_3$value)

save(dataAggr, file = "dataAggr")

library(tidyr)
# separate data column to YEAR Month Date
result <- separate(dataAggr, "Date", c("Month", "Date", "Year"), sep = "/")

#re-arrange columns
result <- result[c(3,1,2, 4,5,6,7)]
#store final data as finalResult
save("result", file = "finalResult")
  
writecsv <- function(){
  for(i in 1:155){
    temp <- subset(result, stations == i, select = -stations)
    write.table(temp, sep = "  ", file = paste0(i, ".txt"), quote=FALSE,
                row.names=FALSE, col.names = FALSE)
    
  }
    
}
  
  