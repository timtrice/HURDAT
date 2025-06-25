#' HURDAT
#'
#' This R package currently aims to reorganize the NOAA HURDAT2
#' dataset for Atlantic, East Pacific and Central Pacific-basin tropical
#' cyclones and present it in a cleaner format.
#'
#' The Atlantic basin dataset covers all cyclones that have developed in the
#' Atlantic Ocean. The eastern Pacific datasets cover cyclones in the Pacific
#' from the United States/Mexico coastlines to -140&deg;W where the cyclone
#' entered what is referred to as the central Pacific basin. The central
#' Pacific basin extends westward to -180&deg;W.
#'
#' @section Named Cyclones:
#'
#' Cyclones were not named until 1950 and used names of the international
#' phonetic alphabet. For example, Able, Baker, Charlie, etc.
#'
#' In 1953, the \href{https://www.nhc.noaa.gov}{National Hurricane Center} began
#' using female names and by 1954 the NHC would retire some names for storms of
#' significance. Currently the
#' \href{https://public.wmo.int/en/our-mandate/focus-areas/natural-hazards-and-disaster-risk-reduction/tropical-cyclones/Naming}{World
#'   Meteorological Organization}
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
#'   \item Cyclone: a system of winds rotating inward to an area of low
#'     pressure. This system rotates counter-clockwise in the northern
#'     hemisphere and clockwise in the southern hemisphere.
#'   \item Tropical depression: a tropical cyclone with winds less than 35 mph
#'     (34 kts).
#'   \item Tropical storm: a tropical  with winds between 35 mph (34 kts) but
#'     less than 74mph (64 kts).
#'   \item Hurricane: a tropical cyclone with winds greater than 74 mph
#'     (64 kts).
#'   \item Extratropical Cyclone: a cyclone no longer containing tropical
#'     characteristics (warm-core center, tight pressure gradient near the
#'    center)
#'   \item Subtropical Cyclone: a cyclone containing a mix of tropical and
#'     non-tropical characteristics.
#'   \item Tropical cyclone: a warm-core surface low pressure system
#'   \item Tropical Wave: An open area of low pressure (trough) containing
#'     tropical characteristics
#'   \item Disturbance: An area of disturbed weather; a large disorganized area
#'     of thunderstorms.
#' }
#'
#' @section Error Reporting:
#'
#' Please submit any errors, discrepancies or issues through the
#' \href{https://github.com/timtrice/HURDAT/issues}{timtrice/HURDAT} repository.
#'
#' Errors in the raw data may also be reported to Chris Landsea or the National
#' Hurricane Center Best Track Change Committee
#' \href{https://www.aoml.noaa.gov/hrd/hurdat/submit_re-analysis.html}{as
#'   explained on the HRD website}.
#'
#' @importFrom rlang .data
#' @name HURDAT
#'
#' @details Run an audit on the HURDAT dataset and identifies duplicate records of `Key` and `DateTime`.
#'
#' @param df Dataframe, parsed HURDAT dataset
#'
#' @keywords internal
audit_hurdat <- function(df) {
  problems <- dplyr::group_by(df, .data$Key, .data$DateTime)

  problems <- dplyr::count(problems)

  problems <- dplyr::filter(problems, .data$n > 1)

  dplyr::arrange(problems, .data$n, .data$Key, .data$DateTime)
}

#' Get HURDAT and parse to dataframe
#'
#' Retrieve Raw HURDAT files for Atlantic (AL), northeast and central Pacific
#'   (EP) basins (northwestern hemisphere)
#'
#' @details Raw text files \emph{should} be found at
#'   \url{https://www.nhc.noaa.gov/data/hurdat/} as of this writing. The
#'  codebooks are listed below.
#'
#' @seealso Atlantic codebook:
#'     \url{https://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#'
#' @seealso NE/NC Pacific codebook:
#'     \url{https://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf}
#'
#' @param basin AL or EP. Default is both.
#'
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
  basin <- toupper(basin)

  if (!all(basin %in% c("AL", "EP"))) {
    rlang::abort(message = "`basin` must be 'AL' and/or 'EP'.")
  }

  # Get URLs for `basin`
  urls <- unlist(
    options()[paste0("hurdat.url.", tolower(basin))],
    use.names = FALSE
  )

  txt <- purrr::map(urls, readr::read_lines)

  txt <- purrr::flatten_chr(txt)

  keep_lines <- grep(
    pattern = "^[[:alpha:]{2}[:digit:]{6}]|[[:digit:]]{8}",
    x = txt
  )

  txt <- txt[keep_lines]

  parse_hurdat(txt)
}

#' Parse HURDAT
#'
#' Take a vector of lines with raw HURDAT information and convert to a
#'   dataframe object.
#'
#' @param x A character vector.
#'
#' @keywords internal
parse_hurdat <- function(x) {
  hurdat <- as.data.frame(x, stringsAsFactors = FALSE)

  header_rows <- grep(pattern = "^[[:alpha:]]{2}[[:digit:]]{6}.+", x)

  # Split header_rows into variables
  hurdat <- tidyr::extract(
    data = hurdat,
    col = "x",
    into = c("Key", "Name", "Lines"),
    regex = paste0(
      "([[:alpha:]]{2}[[:digit:]]{6}),\\s+", # Key
      "([[:upper:][:digit:]-]+)\\s*,\\s+", # Name
      "([[:digit:]]+)," # Number of lines that follow
    ),
    remove = FALSE,
    convert = TRUE
  )

  # Fill headers down
  hurdat <- tidyr::fill(data = hurdat, Key, Name, Lines)

  # Remove original header rows
  hurdat <- hurdat[-header_rows, ]

  # Split storm details into variables
  hurdat <- tidyr::extract(
    data = hurdat,
    col = "x",
    into = c(
      "Year",
      "Month",
      "Date",
      "Hour",
      "Minute",
      "Record",
      "Status",
      "Lat",
      "LatHemi",
      "Lon",
      "LonHemi",
      "Wind",
      "Pressure",
      "NE34",
      "SE34",
      "SW34",
      "NW34",
      "NE50",
      "SE50",
      "SW50",
      "NW50",
      "NE64",
      "SE64",
      "SW64",
      "NW64"
    ),
    regex = paste0(
      "^([[:digit:]]{4})", # Year
      "([[:digit:]]{2})", # Month
      "([[:digit:]]{2}),\\s+", # Date
      "([[:digit:]]{2})", # Hour
      "([[:digit:]]{2}),\\s+", # Minute
      "([[:alpha:]]*),\\s+", # Record
      "([[:alpha:]]{2}),\\s+", # Status
      "([[:digit:]]{1,2}\\.[[:digit:]]{1})", # Latitude
      "([[:alpha:]]{1}),\\s+", # Hemisphere
      "([[:digit:]]{1,3}\\.[[:digit:]]{1})", # Longitude
      "([[:alpha:]]{1}),\\s+", # Hemisphere
      "([[:digit:]-]+),\\s+", # Wind
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+),\\s+", #
      "([[:digit:]-]+).*" #
    ),
    remove = FALSE,
    convert = TRUE
  )

  hurdat <- dplyr::mutate(
    .data = hurdat,
    Lat = dplyr::if_else(
      LatHemi == "N", Lat * 1, Lat * -1
    ),
    Lon = dplyr::if_else(
      LonHemi == "E", Lon * 1, Lon * -1
    )
  )

  hurdat$DateTime <- paste(
    paste(hurdat$Year, hurdat$Month, hurdat$Date, sep = "-"),
    paste(hurdat$Hour, hurdat$Minute, "00", sep = ":"),
    sep = " "
  )

  hurdat <- dplyr::select(
    .data = hurdat,
    Key, Name, DateTime, Record:Lat,
    Lon, Wind:NW64
  )

  hurdat <- unique(hurdat)

  # Run audit and throw warning if any issues.
  if (nrow(audit_hurdat(hurdat)) > 0) {
    rlang::warn(
      message = paste0(
        "Observations received are not equal to those expected.",
        "Run `audit_hurdat()` for discrepancy table."
      )
    )
  }

  # Make certain values NA
  # I do this before converting `DateTime` because if that field has already
  # been converted then this cleaning will generate an error,
  # >  character string is not in a standard unambiguous format
  hurdat <-
    dplyr::mutate_at(
      .tbl = hurdat,
      .vars = dplyr::vars(
        Key:Status,
        Wind:NW64
      ),
      .funs = ~replace(
        x = .,
        list = . %in% c("", "0", -99, -999),
        values = NA
      )
    )

  hurdat$DateTime <- as.POSIXct(
    strptime(hurdat$DateTime, format = "%Y-%m-%d %H:%M:%S")
  )

  dplyr::arrange(hurdat, .data$DateTime, .data$Key)
}
