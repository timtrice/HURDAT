#' Retrieve Raw HURDAT files for Atlantic or the  Northeast Pacific and North
#'      central Pacific basins
#'
#' Raw text files \emph{should} be found at
#'      \url{http://www.nhc.noaa.gov/data/hurdat/} as of this writing. The
#'      codebook for Atlantic HURDAT can be found at
#'      \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf};
#'      East and Central Pacific at
#'      \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-nencpac.pdf}.
#'
#' HURDAT files are updated typically over the winter or early spring. As of
#'      this writing, only the Atlantic HURDAT file has been updated.
#'
#' By default, calling \code{raw_hurdat()} will retrieve two HURDAT datasets;
#'      one for the Atlantic basin and one for both the north central and
#'      north east Pacific basin. See Examples.
#'
#' You can choose to load only Atlantic or the north east Pacific and north
#'      central \emph{and} north east Pacific basin datasets. You can subset
#'      the combined Pacific dataset by \code{Basin == CP}, discarding the
#'      rest.
#'
#' Problem warnings are to be expected. In the raw text files, the header
#'      only contain four comma-delimited values where otherwise there are
#'      21. \code{readr} will generate a warning of n parsing failures and
#'      state that it expected 21 colums but only received four. \emph{This
#'      warning is the only acceptable warning}. When any \code{problems()}
#'      are generated for a dataset, a data frame will be created showing
#'      these problems. Provided that all rows reflect the message above,
#'      there is no issue.
#'
#' @seealso Atlantic codebook: \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#' @seealso NE/NC Pacific codebook: \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#'
#' @param basins a multidimensional list of basins each containing a boolean
#'      on whether or not to load the data (TRUE or FALSE) and a url to the
#'      dataset.
#'
#' @import dplyr
#'
#' @return Returns a data frame for each basin, slightly restructured. An
#'      effort is made to keep the data in it's original format as much as
#'      possible. However, each storm has a header row. This header row is the
#'      only row that identifies the storm info (i.e., Name). Without it,
#'      there is no way to differentiate storms. Therefore, the header row is
#'      split and left-binded to the following rows. Therefore, if you perform
#'      a QA-check on nrow of the create dataframe versus nrow of the original
#'      text files, the created data frames will be shorter but have more
#'      columns. Otherwise, data will still need to be cleaned.
#'
#' @examples
#'
#' # Load only Atlantic basin data
#' atlantic_url = "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2015-021716.txt"
#' datasets <- list("atlantic" = c(TRUE, atlantic_url))
#' raw_hurdat(datasets)
#'
#' # Load only Pacific basin data
#' nepac_url = "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2015-022516.txt"
#' datasets <- list("nepac" = c(TRUE, nepac_url))
#' raw_hurdat(datasets)
#'
#' # Load only Atlantic and northeast Pacific basin data
#' datasets <- list("atlantic" = c(TRUE, atlantic_url), "nepac" = c(TRUE, nepac_url))
#' raw_hurdat(datasets)
#'
#' # Default
#' datasets <- list("atlantic" = c(TRUE, atlantic_url),
#'                  "nencpac" = c(TRUE, nencpac_url))
#' raw_hurdat(datasets)
#'
#' @export
#'
raw_hurdat <- function(basins = list("atlantic" = c(TRUE,
                                                    "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2015-021716.txt"),
                                     "nepac" = c(TRUE,
                                                 "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2015-022516.txt"))) {

    invisible(sapply(names(sapply(basins, names)), function(x){
        if(basins[[x]][1] == TRUE) {
            .hurdat_parse(x, basins[[x]][2])
        }
    }))

}

#' Parse HURDAT
#'
#' Receives from \code{\link{raw_hurdat}} a basin and url string. URL is
#'      accessed and parsed into data frame.
#'
#' @param basin character name of basin, i.e., atlantic, nepac, nencpac
#' @param url location of basin's HURDAT file
#' @export
#'
.hurdat_parse <- function(basin, url) {
    df <- readr::read_csv(url, na = c(-999, -99, 0, " ", "  "),
                          col_names = c("StormID", "Time", "Record",
                                        "Status", "Latitude", "Longitude",
                                        "Wind", "Pressure", "WindRadii34NE",
                                        "WindRadii34SE", "WindRadii34SW",
                                        "WindRadii34NW", "WindRadii50NE",
                                        "WindRadii50SE", "WindRadii50SW",
                                        "WindRadii50NW", "WindRadii64NE",
                                        "WindRadii64SE", "WindRadii64SW",
                                        "WindRadii64NW", "ID"),
                          col_types = readr::cols(StormID = "c",
                                           Time = "c",
                                           Record = "c",
                                           Status = "c",
                                           Latitude = "c",
                                           Longitude = "c",
                                           Wind = "i",
                                           Pressure = "i",
                                           WindRadii34NE = "i",
                                           WindRadii34SE = "i",
                                           WindRadii34SW = "i",
                                           WindRadii34NW = "i",
                                           WindRadii50NE = "i",
                                           WindRadii50SE = "i",
                                           WindRadii50SW = "i",
                                           WindRadii50NW = "i",
                                           WindRadii64NE = "i",
                                           WindRadii64SE = "i",
                                           WindRadii64SW = "i",
                                           WindRadii64NW = "i"))
    df_problems <- readr::problems(df)

    header_pattern <- .header_pattern(basin)

    headers <- df[grep(header_pattern, df$StormID), ] %>%
        dplyr::select(StormID:Record)

    headers <- dplyr::mutate(Key = StormID, headers,
                             Basin = substr(StormID, 0, 2),
                             YearNum = substr(StormID, 3, 4),
                             Year = substr(StormID, 5, 8),
                             Name = Time,
                             Lines = Record)

    df <- full_join(df, headers, by = "StormID")

    df$Key <- zoo::na.locf(df$Key)
    df$Basin <- zoo::na.locf(df$Basin)
    df$YearNum <- zoo::na.locf(df$YearNum)
    df$Year <- zoo::na.locf(df$Year)
    df$Name <- zoo::na.locf(df$Name)

    df_headers <- grep(header_pattern, df$StormID)

    df <- df[-c(df_headers), ]

    # Rename df$StormID to df$Date since this is now only a date field
    df <- rename(df, Date = StormID)

    # Make a POSIXct Datetime column off the Date and Time columns using
    # lubridate
    df <- mutate(df, Datetime = lubridate::ymd_hm(paste(df$Date, df$Time.x, sep = " ")))

    # Rename Record.x
    df <- rename(df, Record = Record.x)

    df <- select(df, Datetime, Key:Name, Record:WindRadii64NW)

    assign(basin, df, envir = .GlobalEnv)
    assign(paste(basin, "problems", sep = "_"), df_problems,
           envir = .GlobalEnv)
}

#' grep pattern for isolating header rows from datasets
#'
#' Depending on \code{basin} parameter, returns a pattern string to help
#'      \code{\link{.hurdat_parse}} extract header rows from the raw
#'      dataset.
#'
#' @param basin a character string identifying the basin
#' @export
#'
.header_pattern <- function(basin) {
    switch(basin,
           "atlantic" = "^[AL]",
           "nencpac" = "^[EP]|[CP]",
           "nepac" = "^[EP]",
           stop(sprintf("Unkown basin: %s", basin)))

}
