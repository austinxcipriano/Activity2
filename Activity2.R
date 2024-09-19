#

install.packages(c("dplyr", "lubridate"))
library(dplyr)
library(lubridate)
streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")

exampleDate <- c("2021-01-10 05:23:30")
#parse date with year, month, day hour:minute:second
ymd_hms(exampleDate)

streamH$dateF <- ymd_hm(streamH$datetime, tz = "America/New_York")

floods_fj <- full_join(streamH, #left data frame
                       siteInfo, #right data frame
                       by="siteID") #shared data

peace <- floods_fj %>%
  filter(siteID == 2295637)

filter(gheight.ft >= 10) %>%
  
  plot(peace$dateF, peace$gheight.ft, type="l")

maxH <- floods %>%
  group_by(names) %>% 
  summarise(meaxH = max(gheight.ft)) 

# Prompt 3 What was the earliest date that each river reached the flood stage?
floods$dateF <- ymd_hm(floods$datetime,
                       tz = "America/New_York")
earlyD <- floods_fj %>%
filter(gheight.ft >= flood.ft) %>%
  group_by(names) %>%
summarise(earlyD = min(dateF, na.rm = T))

# Test