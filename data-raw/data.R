library(HURDAT)

## ---- Get Atlantic -----------------------------------------------------------
AL <- get_hurdat(basin = "AL")
usethis::use_data(AL, overwrite = TRUE)

## -- Get Pacific --------------------------------------------------------------
EP <- get_hurdat(basin = "EP")
usethis::use_data(EP, overwrite = TRUE)
