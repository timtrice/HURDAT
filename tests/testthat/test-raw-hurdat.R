# Have to figure out a way to ignore the problems() warning messages for other
#       tests...

context("raw_hurdat()")

url = "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2014-021616.txt"
dataset1 <- list("nepac" = c(TRUE, url))

dataset2 <- list("nothing" = c(TRUE, url))

test_that("raw_hudat()", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(dataset1), "parsing failures.")
})
