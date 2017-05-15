# HURDAT 0.1.0

## Major new features

HURDAT is a R library that scrapes the most recent HURDAT dataset from the National Hurricane Center. Datasets cover the Atlantic and northwestern Pacific ocean. This dataset is a best-track post-storm analysis as determined by the Hurricane Research Division.

**Dataset may contain errors**; particularly with latitude and longitude. This is in the original dataset; not an issue with the scraping function. However, if you notice any errors, please send post them to the GitHub repo: https://github.com/timtrice/HURDAT/issues.

Access Atlantic basin data with the call `data("AL")`; Pacific data with `data("EP"). 
