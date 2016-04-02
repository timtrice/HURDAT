## ----libraries, echo = FALSE, messages = FALSE---------------------------
library(Hurricanes)
library(tidyr)

## ------------------------------------------------------------------------
raw_hurdat()

## ------------------------------------------------------------------------
ls()

## ------------------------------------------------------------------------
unique(atlantic_problems[, 3:4])
unique(nepac_problems[, 3:4])

## ------------------------------------------------------------------------
str(atlantic)

## ------------------------------------------------------------------------
atlantic$Latitude <- clean_lat(atlantic$Latitude)
atlantic$Longitude <- clean_lon(atlantic$Longitude)
str(select(atlantic, Latitude, Longitude))

## ------------------------------------------------------------------------
nepac$Latitude <- clean_lat(nepac$Latitude)
nepac$Longitude <- clean_lon(nepac$Longitude)
str(select(nepac, Latitude, Longitude))

## ------------------------------------------------------------------------
if(exists("lat_problems")) str(lat_problems)
if(exists("lon_problems")) str(lon_problems)

## ------------------------------------------------------------------------
atlantic$YearNum <- as.integer(atlantic$YearNum)
atlantic$Year <- as.integer(atlantic$Year)
str(select(atlantic, YearNum, Year))

nepac$YearNum <- as.integer(nepac$YearNum)
nepac$Year <- as.integer(nepac$Year)
str(select(nepac, YearNum, Year))

