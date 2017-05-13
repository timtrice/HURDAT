# Have to figure out a way to ignore the problems() warning messages for other
# tests...

context("raw_hurdat()")

# Load only Atlantic basin data
datasets <- list("atlantic" = c(TRUE, al_hurdat2()))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})

# Load only Pacific basin data
datasets <- list("nepac" = c(TRUE, ep_hurdat2()))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})

# Load only Atlantic and northeast Pacific basin data
datasets <- list("atlantic" = c(TRUE, al_hurdat2()),
                 "nepac"    = c(TRUE, ep_hurdat2()))
test_that("raw_hurdat(datasets)", {
    # Parsing failures for expecting 21 columns, getting only 4. This is fine.
    expect_warning(raw_hurdat(datasets), "parsing failures.")
})
