# HURDAT v0.2.1 (2019-06-16)
==========================

## NEW FEATURES

* NA

## MINOR IMPROVEMENTS

* `AL` dataset updated for 2018 cyclones

## BUG FIXES

* NA

## DEPRECATED AND DEFUNCT

* NA

# HURDAT v0.2.0 (2018-05-20)
==========================

## NEW FEATURES

* NA

## MINOR IMPROVEMENTS

* Updated `AL` dataset for 2017 Atlantic tropical cyclone data.

* Updated `EP` dataset for 2017 northeast Pacific tropical cyclone data.

## BUG FIXES

* NA

## DEPRECATED AND DEFUNCT

* NA

# HURDAT 0.1.0 (2017-08-10)
===========================

## Major new features

HURDAT is a R library that scrapes the most recent HURDAT dataset from the National Hurricane Center. Datasets cover the Atlantic and northwestern Pacific ocean. This dataset is a best-track post-storm analysis as determined by the Hurricane Research Division.

**Dataset may contain errors**; particularly with latitude and longitude. This is in the original dataset; not an issue with the scraping function. However, if you notice any errors, please send post them to the GitHub repo: https://github.com/timtrice/HURDAT/issues.

Access Atlantic basin data with the call `data("AL")`; Pacific data with `data("EP"). 
