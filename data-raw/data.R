library(HURDAT)

## ---- Get Atlantic -----------------------------------------------------------
al <- get_hurdat(basin = "AL")
devtools::use_data(al, pkg = ".", overwrite = TRUE)

## -- Get Pacific --------------------------------------------------------------
ep <- get_hurdat(basin = "EP")
devtools::use_data(ep, pkg = ".", overwrite = TRUE)