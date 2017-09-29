# DataAggregation.R 

This repo contains DataAggregation.R script written to aggregate data from 3 csv files and convert it to tidy format (from wide to long format)

Source file: "data/ACCESS1_day_RCP4.5_2006_2099.csv", "data/tasmax_day_RCP45_2006_2099.csv", and "data/tasmin_day_RCP45_2006_2099.csv" contain precipation, maximum temperature and minimum temperature data respectively in the following format 156 Columns, Columns 1 through 155 representing stations
and 156 the date on which measurements were taken

| 1 | 2 | 3 | ........|155|Date|  
|---|---|---|---------|---|----|  
|   |   |   |         |   |    |  
|   |   |   |         |   |    |  
|   |   |   |         |   |    |  


