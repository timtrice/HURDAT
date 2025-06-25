.onLoad <- function(libname, pkgname) {
  op <- options()
  op.hurdat <- list(
    hurdat.url.al = "https://www.aoml.noaa.gov/hrd/hurdat/hurdat2.html",
    hurdat.url.ep = "https://www.aoml.noaa.gov/hrd/hurdat/hurdat2-nepac.html"
  )
  toset <- !(names(op.hurdat) %in% names(op))
  if (any(toset)) options(op.hurdat[toset])
  invisible()
}