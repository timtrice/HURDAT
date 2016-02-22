#' Clean latitude and longitude from character string to double
#'
#' The latitude/longitude values \emph{must} contain the hemisphere identifier
#'      at the end otherwise bad values are introduced. In this instance, a
#'      new data table will be created called \code{lat_problems} or
#'      \code{lon_problems} and a warning message is displayed. However,
#'      \strong{all} values are returned.
#'
#' @export
#' @param lat character list or data.frame object containing only Latitude
#' @param lon character list or data.frame object containing only Longitude
#' @return numeric list with positive and/or negative numbers
#' @examples
#' # All values except the last Latitude or Longitude are returned as
#' # expected. The bad value in the last row generates the lat_problems and
#' # lon_problems data frames.
#' x <- data.frame(
#'     ID = 1:11,
#'     Latitude = c("1.0S", "5S", "10.S", "28.1S", "28.15S", "1.0N", "5N",
#'                  "10.N", "28.1N", "28.15N", "1.0"),
#'     Longitude = c("1.0E", "5E", "10.E", "28.1E", "128.15E", "1.0W", "5W",
#'                  "10.W", "28.1W", "128.15W", "1.0"),
#'     stringsAsFactors = FALSE)
#' x$Latitude <- clean_lat(x$Latitude)
#' x$Longitude <- clean_lon(x$Longitude)
#'
clean_lat <- function(lat = NULL) {
    if(is.null(lat)) stop("No data received.")
    if(is.character(lat)) {
        lat <- as.data.frame(lat)
        names(lat) <- "Latitude"
    }
    lat <- tidyr::separate(lat, Latitude, c("Lat", "Hemi"), sep = -2,
                           remove = FALSE, convert = TRUE)
    problems <- dplyr::filter(lat, Hemi != "N" & Hemi != "S")
    if(nrow(problems) > 0) warning("lat_problems created.")
    assign("lat_problems", problems, envir = .GlobalEnv)
    lat$Latitude <- ifelse(lat$Hemi == "N", lat$Lat, lat$Lat * -1)
    lat$Latitude
}

#' @rdname clean_lat
#' @export
clean_lon <- function(lon = NULL) {
    if(is.null(lon)) stop("No data received.")
    if(is.character(lon)) {
        lon <- as.data.frame(lon)
        names(lon) <- "Longitude"
    }
    lon <- tidyr::separate(lon, Longitude, c("Lon", "Hemi"), sep = -2,
                           remove = FALSE, convert = TRUE)
    problems <- dplyr::filter(lon, Hemi != "E" & Hemi != "W")
    if(nrow(problems) > 0) warning("lon_problems created.")
    assign("lon_problems", problems, envir = .GlobalEnv)
    lon$Longitude <- ifelse(lon$Hemi == "E", lon$Lon, lon$Lon * -1)
    lon$Longitude
}
