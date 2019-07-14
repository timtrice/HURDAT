#' Run checks before submitting to CRAN
devtools::document()
devtools::spell_check()
devtools::check_rhub()
devtools::check_win_devel()
devtools::check_win_release()
devtools::check_win_oldrelease()
devtools::release()
