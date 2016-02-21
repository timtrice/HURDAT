## ----libraries, echo = FALSE, messages = FALSE---------------------------
library(Hurricanes)
library(tidyr)

## ------------------------------------------------------------------------
raw_hurdat()

## ------------------------------------------------------------------------
ls()

## ------------------------------------------------------------------------
unique(atlantic_problems[, 3:4])
unique(nencpac_problems[, 3:4])

## ------------------------------------------------------------------------
str(atlantic)

## ------------------------------------------------------------------------
atlantic$Latitude <- clean_lat(atlantic$Latitude)
atlantic$Longitude <- clean_lon(atlantic$Longitude)
str(select(atlantic, Latitude, Longitude))

## ------------------------------------------------------------------------
nencpac$Latitude <- clean_lat(nencpac$Latitude)
nencpac$Longitude <- clean_lon(nencpac$Longitude)
str(select(nencpac, Latitude, Longitude))

## ------------------------------------------------------------------------
if(exists("lat_problems")) str(lat_problems)
if(exists("lon_problems")) str(lon_problems)

## ------------------------------------------------------------------------
atlantic$YearNum <- as.integer(atlantic$YearNum)
atlantic$Year <- as.integer(atlantic$Year)
str(select(atlantic, YearNum, Year))

nencpac$YearNum <- as.integer(nencpac$YearNum)
nencpac$Year <- as.integer(nencpac$Year)
str(select(nencpac, YearNum, Year))

