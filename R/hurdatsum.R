# http://arctic.som.ou.edu/tburg/products/realtime/tropical/
# https://deepmind.google.com/science/weatherlab
  
library(tidyverse)
library(HURDAT)
al <- get_hurdat(basin = "AL")

al |> filter(Status=='HU') -> hu
hu |> group_by(Key) |> slice_min(DateTime, n=1) -> hu
hu |> filter(DateTime >= as.Date('1994-01-01')) -> hu
hu$month=month(hu$DateTime)
hu$yr=year(hu$DateTime)

# Distribution of all hurricanes: 16%
hu |> group_by(month) |> summarize(share=n()/nrow(hu)) |> ungroup()

# other approach
hu |> group_by(yr, month) |> summarize(num=n()) -> monthly
monthly |> group_by(yr) |> mutate(yrtotal=sum(num)) -> monthly
monthly |> filter(yrtotal >= 10) -> monthly
monthly |> mutate(sh=num/yrtotal) -> monthly



join_df <- expand.grid(yr = unique(monthly$yr),
                      month=unique(monthly$month))

  full_join(join_df, monthly, by = c("yr", "month")) |>
  tidyr::replace_na(list(sh = 0)) |>
  arrange(yr, month) -> monthly

  monthly |> group_by(yr) |> mutate(yrtotal=sum(num, na.rm = T)) -> monthly
  monthly |> replace_na(list(num=0)) -> monthly
  monthly |> group_by(yr) |> mutate(yrcum=cumsum(num)) -> monthly

  # Years >=10 monthly: 21%
  monthly |> ungroup() |> group_by(month) |> summarize(m=median(sh))
  monthly |> ungroup() |> group_by(month) |> summarize(m=mean(sh))


  # years with 8 hurricanes by sep-end ->. 2/5 had 11+ 40%
  monthly |> filter(month==9, yrcum==8) |> pull(yr) -> eightsep
  monthly |> filter(yr %in% eightsep) |> filter(yrtotal>=11)

  # years with 9 hurricanes by oct-end -> none had 11+
  monthly |> filter(month==10, yrcum==10) |> pull(yr) -> tenoct
  monthly |> filter(yr %in% tenoct) |> filter(yrtotal>=11)


  # Probability Oct = 34%
  monthly |> filter(month==10) -> october
  october |> filter(num>2) |> nrow()/nrow(october)

  # Probability Nov = 34%
  monthly |> filter(month==11) -> november
  november |> filter(!is.na(num)) |> nrow()/nrow(december)
  
  
  # naive > 8
  (hu |> group_by(yr) |> tally() |> filter(n>8) |> nrow())/(hu |> group_by(yr) |> tally() |> nrow())
  hu |> group_by(yr) |> tally() |> summarize(sum(p=ifelse(n>8,1,0))/n())
  
  ## Tropical Storms
  al |> filter(Status=='TS') -> ts
  ts |> group_by(Key) |> slice_min(DateTime, n=1) -> ts
  ts |> filter(DateTime >= as.Date('1960-01-01')) -> ts
  ts$month=month(ts$DateTime)
  ts$yr=year(ts$DateTime)

    