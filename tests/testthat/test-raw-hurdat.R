# Have to figure out a way to ignore the problems() warning messages for other
#       tests...

context("raw_hurdat()")

# Load only Atlantic basin data
atlantic_url <- "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2015-021716.txt"
datasets <- list("atlantic" = c(TRUE, atlantic_url))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})

# Load only Pacific basin data
nepac_url <- "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2015-022516.txt"
datasets <- list("nepac" = c(TRUE, nepac_url))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})

# Load only Atlantic and northeast Pacific basin data
datasets <- list("atlantic" = c(TRUE, atlantic_url), "nepac" = c(TRUE, nepac_url))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})
