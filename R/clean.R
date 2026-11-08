library(tidyverse)
library(here)

raw <- read_csv(here('data', 'raw', 'wave1.csv'))
items <- paste0('sdo_', 1:6)
rev_items <- c('sdo_2', 'sdo_4', 'sdo_6')
scored <- c('sdo_1', 'sdo_2_r', 'sdo_3', 'sdo_4_r', 'sdo_5', 'sdo_6_r')

dat <- raw |>
  mutate(across(all_of(items), ~ na_if(.x, -99))) |>
  mutate(across(all_of(rev_items), ~ 7 - .x, .names = '{.col}_r')) |>
  mutate(
    n_valid = rowSums(!is.na(pick(all_of(scored)))),
    sdo_mean = if_else(n_valid >= 4,
                       rowMeans(pick(all_of(scored)), na.rm = TRUE),
                       NA_real_)
  )

dir.create(here('data', 'clean'), showWarnings = FALSE)
write_csv(dat, here('data', 'clean', 'wave1_clean.csv'))