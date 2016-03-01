#' Download, parse, clean and seperate HURDAT into multiple data frames
#'
hurdat_separate <- function() {

    raw_hurdat()

    df <- bind_rows(atlantic, nepac)

    df$Latitude <- clean_lat(df$Latitude)
    df$Longitude <- clean_lon(df$Longitude)

    df$Longitude <- sapply(df$Longitude, function(x) {
        ifelse(x < -180, 360 + x, x)
    })

    df$Key <- as.factor(df$Key)
    df$YearNum <- as.integer(df$YearNum)
    df$Year <- as.factor(df$Year)
    df$Record <- as.factor(df$Record)
    df$Status <- as.factor(df$Status)

    basins <- unique(df$Basin)

    invisible(sapply(basins, function(x){
        tmp <- filter(df, Basin == x)

        tmp_summary <- tmp %>%
            group_by(Key) %>%
            summarise(Observations = n(),
                      StartDate = min(Datetime),
                      EndDate = max(Datetime),
                      YearNum = first(YearNum),
                      Year = first(Year),
                      Name = first(Name),
                      MaxWind = max(Wind, na.rm = TRUE),
                      MinPressure = min(Pressure, na.rm = TRUE))

        tmp_details <- tmp %>%
            select(Key, Datetime, Record, Status, Latitude, Longitude, Wind,
                   Pressure)

        tmp_wind <- tmp %>%
            filter(rowSums(tmp[13:24], na.rm = TRUE) > 0) %>%
            select(Key, Datetime, WindRadii34NE:WindRadii64NW)

        assign(paste(x, "summary", sep = "_"), tmp_summary, envir = .GlobalEnv)
        assign(paste(x, "details", sep = "_"), tmp_details, envir = .GlobalEnv)
        assign(paste(x, "wind_radius", sep = "_"), tmp_wind, envir = .GlobalEnv)

        save(list=c(paste(x, "summary", sep = "_")),
             file=paste(paste("data",
                              paste(x, "summary", sep = "_"),
                              sep = "/"), "rda",
                        sep = "."))

        save(list=c(paste(x, "details", sep = "_")),
             file=paste(paste("data",
                              paste(x, "details", sep = "_"),
                              sep = "/"), "rda",
                        sep = "."))

        save(list=c(paste(x, "wind_radius", sep = "_")),
             file=paste(paste("data",
                              paste(x, "wind_radius", sep = "_"),
                              sep = "/"), "rda",
                        sep = "."))

    }))

}
