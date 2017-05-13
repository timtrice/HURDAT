context("HURDAT")

## ---- Data -------------------------------------------------------------------
df.al <- get_hurdat(basin = "AL")
df.ep <- get_hurdat(basin = "EP")

## ---- Saved Data -------------------------------------------------------------
load(system.file("extdata", "al.Rda", package = "HURDAT"))
load(system.file("extdata", "ep.Rda", package = "HURDAT"))

## ---- HURDAT url's -----------------------------------------------------------
test_that("HURDAT url's", {
    expect_identical(al_hurdat2(), "http://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2016-041117.txt")
    expect_identical(ep_hurdat2(), "http://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2016-041317.txt")
})

## ---- Dataframe Comparison ---------------------------------------------------
test_that("Dataframe Comparison", {
    expect_identical(al, df.al)
    expect_identical(ep, df.ep)
})

## ---- Errors -----------------------------------------------------------------
test_that("hurdat errors", {
    expect_error(get_hurdat(basin = "CP"), "Basin must be AL for EP")
})