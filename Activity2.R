#In-Class Prompts
install.packages(c("dplyr", "lubridate", "tidyverse"))
library(dplyr)
library(lubridate)
library(tidyverse)
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

example <- floods_fj %>%

  filter(gheight.ft >= 10)

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

#Homework Part 2
#Question 1

#Create separate data frames for each river
FloodsFish <- filter(floods_fj, siteID == 2256500)
FloodsPeace <- filter(floods_fj, siteID == 2295637)
FloodsSantaFe <- filter(floods_fj, siteID == 2322500)
FloodsWithlacoochee <- filter(floods_fj, siteID == 2312000)

#Plot separate stream stage data for each river
ggplot(FloodsFish, aes(x = dateF, y = gheight.ft)) + 
  geom_line() +
  labs(x = "Date", y = "Fisheating Creek Stream Height (ft)")

ggplot(FloodsPeace, aes(x = dateF, y = gheight.ft)) + 
  geom_line() +
  labs(x = "Date", y = "Peace River Stream Height (ft)")

ggplot(FloodsSantaFe, aes(x = dateF, y = gheight.ft)) + 
  geom_line() +
  labs(x = "Date", y = "Santa Fe River Stream Height (ft)")

ggplot(FloodsWithlacoochee, aes(x = dateF, y = gheight.ft)) + 
  geom_line() +
  labs(x = "Date", y = "Withlacoochee River Stream Height (ft)")

#Question 2

# What was the earliest date of occurrence for each flood category in each river?
ActionDate <- floods_fj %>%
  filter(gheight.ft >= action.ft) %>%
  group_by(names) %>%
  summarise(ActionDate = min(dateF, na.rm = T))

ModerateDate <- floods_fj %>%
  filter(gheight.ft >=moderate.ft) %>%
  group_by(names) %>%
  summarise(ModerateDate = min(dateF, na.rm = T))

MajorDate <- floods_fj %>%
  filter(gheight.ft >=major.ft) %>%
  group_by(names) %>%
  summarise(MajorDate = min(dateF, na.rm = T))

#Question 3

# Which river had the highest stream stage above its listed height in the major flood category?

MaxHeightDiff <- floods_fj %>%
  group_by(names) %>%
  summarise(MaxHeightDiff = max(gheight.ft - major.ft, na.rm = T))