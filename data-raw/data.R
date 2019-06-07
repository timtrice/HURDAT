library(HURDAT)

## ---- Get Atlantic -----------------------------------------------------------
AL <- get_hurdat(basin = "AL")
usethis::use_data(AL, overwrite = TRUE)
readr::write_csv(AL, path = "./data/AL.csv")

## -- Get Pacific --------------------------------------------------------------
EP <- get_hurdat(basin = "EP")
usethis::use_data(EP, overwrite = TRUE)
readr::write_csv(EP, path = "./data/EP.csv")
