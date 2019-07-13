context("HURDAT")

## ---- Data -------------------------------------------------------------------
df.al <- get_hurdat(basin = "AL")
df.ep <- get_hurdat(basin = "EP")

## ---- Dataframe Comparison ---------------------------------------------------
test_that("Dataframe Comparison", {
  expect_identical(AL, df.al)
  expect_identical(EP, df.ep)
})

## ---- Errors -----------------------------------------------------------------
test_that("hurdat errors", {
  expect_error(get_hurdat(basin = "CP"), "`basin` must be 'AL' and/or 'EP'.")
})
