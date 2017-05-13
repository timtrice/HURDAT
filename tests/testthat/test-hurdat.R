context("HURDAT")

## ---- Data -------------------------------------------------------------------
test_that("HURDAT url's", {
    expect_identical(al_hurdat2(), "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2016-041117.txt")
    expect_identical(ep_hurdat2(), "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2016-041317.txt")
})

## ---- Errors -----------------------------------------------------------------
test_that("hurdat errors", {
    expect_error(get_hurdat(basin = "CP"), "Basin must be AL for EP")
})