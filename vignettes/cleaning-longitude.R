## ----setup, echo = FALSE, message = FALSE--------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      message = FALSE, 
                      fig.width = 7, 
                      fig.height = 5)
library(data.table)
library(dplyr)
library(ggplot2)
library(Hurricanes)
library(knitr)
library(maps)
library(readr)

## ------------------------------------------------------------------------
raw_hurdat()

## ------------------------------------------------------------------------
df <- bind_rows(nencpac, atlantic)

## ------------------------------------------------------------------------
df$Latitude <- clean_lat(df$Latitude)
df$Longitude <- clean_lon(df$Longitude)

## ------------------------------------------------------------------------
summary(df$Longitude)

## ------------------------------------------------------------------------
world_map <- map_data("world")

bp <- list(geom_polygon(data = world_map, aes(x = long, y = lat, group = group), 
                 colour = "grey10", fill = "white"), 
           geom_point(size = 0.5, colour = "red"))

ggplot(df, aes(x = Longitude, y = Latitude)) + 
    bp

## ------------------------------------------------------------------------
tmp <- df %>% 
 filter(Longitude < -180)

## ------------------------------------------------------------------------
unique(tmp$Key)

## ------------------------------------------------------------------------
tmp_atlantic <- filter(atlantic, Key == "AL051952")
print(tmp_atlantic$Longitude)

## ------------------------------------------------------------------------
raw_atlantic <- read_csv(
    "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2015-021716.txt", 
    skip = 23823L, n_max = 2, col_names = FALSE)
raw_atlantic

## ------------------------------------------------------------------------
print(tmp_atlantic$Longitude)

## ------------------------------------------------------------------------
df$Longitude <- sapply(df$Longitude, function(x) { ifelse(x < -180, 360 + x, x)})

## ------------------------------------------------------------------------
ggplot(df, aes(x = Longitude, y = Latitude)) + 
    bp

