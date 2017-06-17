library(HURDAT)

## ---- Get Atlantic -----------------------------------------------------------
AL <- get_hurdat(basin = "AL")
devtools::use_data(AL, pkg = ".", overwrite = TRUE)
readr::write_csv(AL, path = "./data/AL.csv")

## -- Get Pacific --------------------------------------------------------------
EP <- get_hurdat(basin = "EP")
devtools::use_data(EP, pkg = ".", overwrite = TRUE)
readr::write_csv(EP, path = "./data/EP.csv")
