context("HURDAT")

# ---- variables ----
col_names <- c(
  "Key", "Name", "DateTime", "Record", "Status", "Lat", "Lon", "Wind",
  "Pressure", "NE34", "SE34", "SW34", "NW34", "NE50", "SE50", "SW50", "NW50",
  "NE64", "SE64", "SW64", "NW64"
)

# ---- Test default options ----
test_that(
  desc = "Test default options",
  code = {
    hurdat.url.al <- getOption("hurdat.url.al")

    hurdat.url.ep <- getOption("hurdat.url.ep")

    expect_identical(
      hurdat.url.al,
      "https://www.aoml.noaa.gov/hrd/hurdat/hurdat2.html"
    )

    expect_identical(
      hurdat.url.ep,
      "https://www.aoml.noaa.gov/hrd/hurdat/hurdat2-nepac.html"
    )
  }
)

# ---- Test AL HURDAT ----
test_that(
  desc = "Test AL",
  code = {
    al <- get_hurdat("AL")

    # Arrange dataset
    al <- dplyr::arrange(al, DateTime, Key)

    # dimensions
    expect_identical(ncol(al), 21L)

    # column names
    expect_identical(names(al), col_names)

    # column classes
    expect_identical(class(al$Key), "character")
    expect_identical(class(al$Name), "character")
    expect_identical(class(al$DateTime), c("POSIXct", "POSIXt"))
    expect_identical(class(al$Record), "character")
    expect_identical(class(al$Status), "character")
    expect_identical(class(al$Lat), "numeric")
    expect_identical(class(al$Lon), "numeric")
    expect_identical(class(al$Wind), "integer")
    expect_identical(class(al$Pressure), "integer")
    expect_identical(class(al$NE34), "integer")
    expect_identical(class(al$SE34), "integer")
    expect_identical(class(al$SW34), "integer")
    expect_identical(class(al$NW34), "integer")
    expect_identical(class(al$NE50), "integer")
    expect_identical(class(al$SE50), "integer")
    expect_identical(class(al$SW50), "integer")
    expect_identical(class(al$NW50), "integer")
    expect_identical(class(al$NE64), "integer")
    expect_identical(class(al$SE64), "integer")
    expect_identical(class(al$SW64), "integer")
    expect_identical(class(al$NW64), "integer")

    # Check distinction
    expect_identical(al, dplyr::distinct(al))
  }
)

# ---- Test EP HURDAT ----
test_that(
  desc = "Test EP HURDAT",
  code = {
    ep <- get_hurdat("EP")

    # Arrange dataset
    ep <- dplyr::arrange(ep, DateTime, Key)

    # dimensions
    expect_identical(ncol(ep), 21L)

    # column names
    expect_identical(names(ep), col_names)

    # column classes
    expect_identical(class(ep$Key), "character")
    expect_identical(class(ep$Name), "character")
    expect_identical(class(ep$DateTime), c("POSIXct", "POSIXt"))
    expect_identical(class(ep$Record), "character")
    expect_identical(class(ep$Status), "character")
    expect_identical(class(ep$Lat), "numeric")
    expect_identical(class(ep$Lon), "numeric")
    expect_identical(class(ep$Wind), "integer")
    expect_identical(class(ep$Pressure), "integer")
    expect_identical(class(ep$NE34), "integer")
    expect_identical(class(ep$SE34), "integer")
    expect_identical(class(ep$SW34), "integer")
    expect_identical(class(ep$NW34), "integer")
    expect_identical(class(ep$NE50), "integer")
    expect_identical(class(ep$SE50), "integer")
    expect_identical(class(ep$SW50), "integer")
    expect_identical(class(ep$NW50), "integer")
    expect_identical(class(ep$NE64), "integer")
    expect_identical(class(ep$SE64), "integer")
    expect_identical(class(ep$SW64), "integer")
    expect_identical(class(ep$NW64), "integer")

    # Check distinction
    expect_identical(ep, dplyr::distinct(ep))
  }
)

# ---- Test HURDAT errors and warnings ----
test_that(
  desc = "Test HURDAT errors",
  code = {
    expect_error(get_hurdat(basin = "CP"), "`basin` must be 'AL' and/or 'EP'.")
  }
)

#' Should produce no errors or warnings. This test is to identify two things
#' noticed in current or previous datasets;
#'   1. A dash followed by a number in the name. This exists for EP081970
#'     ("IONE-2") and EP091970 ("IONE-1"). These examples are included in the
#'     test dataset.
#'   2. A space following the name but preceeding the comma delimiter. This
#'     occurs for EP081994 ("LI"). This exaple is also included.
test_that(
  desc = "tests_no_errors",
  code = {
    no_errors <- system.file(
      "extdata",
      "tests_no_errors.txt",
      package = "HURDAT"
    )

    txt <- readr::read_lines(no_errors)

    df <- parse_hurdat(txt)

    #' Expect six `Key` values
    expect_identical(length(unique(df$Key)), 6L)

    #' `Key` values expected.
    expect_identical(
      unique(df$Key),
      c("AL011851", "AL021851", "AL031851", "EP081970", "EP091970", "EP081994")
    )

    #' Expect dimensions
    expect_identical(dim(df), c(108L, 21L))
  }
)

#' #' One previous dataset contained duplicate records for EP142016 ("MADELINE").
#' #' This test checks for discrepancies and sends a warning if found.
#' test_that(
#'   desc = "tests_duplicate_data",
#'   code = {
#'     duplicate_data <- system.file(
#'       "extdata",
#'       "tests_duplicate_data.txt",
#'       package = "HURDAT"
#'     )
#' 
#'     txt <- readr::read_lines(duplicate_data)
#' 
#'     expect_warning(
#'       df <- parse_hurdat(txt),
#'       paste0(
#'         "Observations received are not equal to those expected.",
#'         "Run `audit_hurdat\\(\\)` for discrepancy table."
#'       )
#'     )
#' 
#'     expect_identical(dim(df), c(85L, 21L))
#' 
#'     discrepancies <- audit_hurdat(df)
#' 
#'     expect_identical(dim(discrepancies), c(33L, 3L))
#'   }
#' )
