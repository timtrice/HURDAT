#' HURDAT
#'
#' This R package currently aims to reorganize the NOAA HURDAT2
#' dataset for Atlantic, East Pacific and Central Pacific-basin tropical
#' cyclones and present it in a cleaner format.
#'
#' The Atlantic basin dataset covers all cyclones that have developed in the
#' Atlantic Ocean. The eastern Pacific datasets cover cyclones in the Pacifc
#' from the United States/Mexico coastlines to -140&deg;W where the cyclone
#' entered what is referred to as the central Pacific basin. The central
#' Pacific basin extends westward to -180&deg;W.
#'
#' @section Named Cyclones:
#'
#' Cyclones were not named until 1950 and used names of the international
#' phonetic alphabet. For example, Able, Baker, Charlie, etc.
#'
#' In 1953, the \href{http://www.nhc.noaa.gov}{National Hurricane Center} began
#' using female names and by 1954 the NHC would retire some names for storms of
#' significance. Currently the
#' \href{http://www.wmo.int/pages/prog/www/tcp/Storm-naming.html}{World Meteorological Organization}
#' is responsible for maintaining the list of names, retiring names and
#' assigning replacement names.
#'
#' In this dataset, cyclones not named are simply referred to as "UNNAMED". To
#' aid with identification, cyclones will be referenced by their `Key`, a
#' string of alphanumeric characters identifying basin, the number of the storm
#' for the year, followed by the four-digit year.
#'
#' For example, *AL011851*:
#' \itemize{
#'   \item AL = Atlantic Basin (`Basin`)
#'   \item 01 = First storm of the year (`YearNum`)
#'   \item 1851 = Year of the storm (`Year`)
#' }
#'
#' @section Meteorological Definitions:
#'
#' It is useful to understand definitions and classifications of tropical
#' cyclones.
#' \itemize{
#'   \item Cyclone: a system of winds rotating inward to an area of low pressure. This system rotates counter-clockwise in the northern hemisphere and clockwise in the southern hemisphere.
#'   \item Tropical depression: a tropical cyclone with winds less than 35 mph (34 kts).
#'   \item Tropical storm: a tropical  with winds between 35 mph (34 kts) but less than 74mph (64 kts).
#'   \item Hurricane: a tropical cyclone with winds greater than 74 mph (64 kts).
#'   \item Extratropical Cyclone: a cyclone no longer containing tropical characteristics (warm-core center, tight pressure gradient near the center)
#'   \item Subtropical Cyclone: a cyclone containing a mix of tropical and non-tropical characteristics.
#'   \item Tropical cyclone: a warm-core surface low pressure system
#'   \item Tropical Wave: An open area of low pressure (trough) containing tropical characteristics
#'   \item Disturbance: An area of disturbed weather; a large disorganized area of thunderstorms.
#' }
#'
#' @section Error Reporting:
#'
#' Please submit any errors, discrepancies or issues through the
#' \href{https://github.com/timtrice/HURDAT/issues}{timtrice/HURDAT} repository.
#'
#' Errors in the raw data may also be reported to Chris Landsea or the National
#' Hurricane Center Best Track Change Committee
#' \href{http://www.aoml.noaa.gov/hrd/hurdat/submit_re-analysis.html}{as explained on the HRD website}.
#'
#' @docType package
#' @name HURDAT
NULL

if (getRversion() >= "3.2.2")
    utils::globalVariables(c("Key", "Name", "Year", "Month", "Date", "Hour",
                             "Minute", "DateTime", "LatHemi", "Lat", "LonHemi",
                             "Lon"))

#' @importFrom magrittr %>%

#' @importFrom stats complete.cases
#' @export
stats::complete.cases

#' @title al_hurdat2
#' @description URL for the Atlantic HURDAT2 file
#' @source \url{http://www.nhc.noaa.gov/data/#hurdat}
#' @keywords internal
al_hurdat2 <- function() {
    url <- "https://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2017-050118.txt"
    return(url)
}

#' @title ep_hurdat2
#' @description URL for the north east/central Pacific HURDAT2 file
#' @source \url{http://www.nhc.noaa.gov/data/#hurdat}
#' @keywords internal
ep_hurdat2 <- function() {
    url <- "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2016-041317.txt"
    return(url)
}

#' @title get_hurdat
#' @description Retrieve Raw HURDAT files for Atlantic (AL), northeast and
#' central Pacific (EP) basins (northwestern hemisphere)
#' @details Raw text files \emph{should} be found at
#' \url{http://www.nhc.noaa.gov/data/hurdat/} as of this writing. The codebooks
#' are listed below.
#' @seealso Atlantic codebook:
#'     \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#' @seealso NE/NC Pacific codebook:
#'     \url{http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#'
#' @param basin AL or EP. Default is both.
#' @examples
#' \dontrun{
#' # Get Atlantic storms
#' al <- get_hurdat(basin = "AL")
#'
#' # Get northeast and north-central Pacific storms.
#' ep <- get_hurdat(basin = "EP")
#'
#' # Get all storms
#' df <- get_hurdat()
#' }
#' @export
get_hurdat <- function(basin = c("AL", "EP")) {

    basin <- purrr::map_chr(basin, stringr::str_to_upper)

    if (!all(basin %in% c("AL", "EP")))
        stop("Basin must be AL for EP")

    df <- purrr::map_df(.x  = basin, .f  = parse_hurdat)

    return(df)
}

#' @title parse_hurdat
#' @description Parse raw HURDAT files.
#' @param basin character name of basin; c("AL", "EP")
#' @keywords internal
parse_hurdat <- function(basin) {

    if (!all(basin %in% c("AL", "EP")))
        stop("Basin must be AL for EP")

    url = do.call(what = paste(tolower(basin),
                               "hurdat2",
                               sep = "_"),
                  args = list())

    # Expected rows of dataframe:
    n <- length(readr::read_lines(file = url))

    # Import dataset
    data <- readr::read_lines(file = url) %>% tibble::as_data_frame()

    # If length of raw dataset and length of dataset import doesn't match; error
    if (n != nrow(data))
        stop("Unexpected length differences raw and extracted data")

    # Remove all spaces; dataset is comma-delimited
    df <- purrr::map_df(.x = data,
                        .f = stringr::str_replace_all,
                        pattern = "[:blank:]",
                        replacement = "")

    # Expected length of headers
    m <- nrow(df[grep("^[[:upper:]]{2}", df$value),])
    # Expected nrow of final dataset
    o <- n - m

    # Split storm headers into variables
    pattern <- "([:alnum:]{8}),([[:upper:]-]+),([:digit:]+),"
    df <- tidyr::extract_(data = df,
                          col = "value",
                          into = c("Key", "Name", "Lines"),
                          regex = pattern,
                          remove = FALSE,
                          convert = TRUE)

    # Split storm details into variables
    df <- tidyr::separate_(data = df,
                           col = "value",
                           into = c("Date", "Time", "Record", "Status", "Lat",
                                    "Lon", "Wind", "Pressure", "NE34", "SE34",
                                    "SW34", "NW34", "NE50","SE50", "SW50",
                                    "NW50", "NE64", "SE64","SW64", "NW64", "D"),
                           sep = ",",
                           remove = FALSE,
                           convert = TRUE,
                           extra = "merge",
                           fill = "right")

    # Drop "value"
    df$value <- NULL
    # Drop "Lines"
    df$Lines <- NULL
    # Drop "D"; this field only exists cause all lines in raw data end w/ comma
    df$D <- NULL

    # Bring Key, Name to left
    df <- dplyr::select(df, Key, Name, dplyr::everything())

    # Fill Key, Name
    df <- tidyr::fill_(data = df,
                       fill_cols = c("Key", "Name"),
                       .direction = "down")

    # Complete cases between Lat:NE64
    df <- df[complete.cases(df$Lat, df$Lon, df$Wind, df$Pressure,
                           df$NE34, df$SE34, df$SW34, df$NW34,
                           df$NE50, df$SE50, df$SW50, df$NW50,
                           df$NE64, df$SE64, df$SW64, df$NW64),]

    # Make certain values NA
    df[df == ""] <- NA
    df[df == "-99"] <- NA
    df[df == "-999"] <- NA

    # Add DateTime var
    df <- tidyr::extract_(data = df,
                                  col = "Date",
                                  into = c("Year", "Month", "Date"),
                                  regex = "([:digit:]{4})([:digit:]{2})([:digit:]{2})") %>%
        tidyr::extract_(col = "Time",
                        into = c("Hour", "Minute"),
                        regex = "([:digit:]{2})([:digit:]{2})") %>%
        dplyr::mutate(DateTime = lubridate::ymd_hm(paste(paste(Year,
                                                               Month,
                                                               Date,
                                                               sep = "-"),
                                                         paste(Hour,
                                                               Minute,
                                                               sep = ":"),
                                                         sep = " ")),
                      Year = NULL,
                      Month = NULL,
                      Date = NULL,
                      Hour = NULL,
                      Minute = NULL) %>%
        dplyr::select(Key, Name, DateTime, dplyr::everything())

    # Make Lat, Lon numeric; positive if in NE hemisphere, else negative
    df <- tidyr::extract_(data = df,
                         col = "Lat",
                         into = c("Lat", "LatHemi"),
                         regex = "([[:digit:]\\.]+)([:upper:])") %>%
        tidyr::extract_(col = "Lon",
                        into = c("Lon", "LonHemi"),
                        regex = "([[:digit:]\\.]+)([:upper:])")

    df$Lat <- as.numeric(df$Lat)
    df$Lon <- as.numeric(df$Lon)

    df <- dplyr::mutate(.data = df,
                        Lat = ifelse(LatHemi == "N", Lat * 1, Lat * -1),
                        Lon = ifelse(LonHemi == "E", Lon * 1, Lon * -1),
                        LatHemi = NULL,
                        LonHemi = NULL)

    if (!isTRUE(all.equal(dim(df), c(o, 21))))
        warning("Dataframe dimensions do not match expected")

    return(df)
}
