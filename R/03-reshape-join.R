# Step 3: reshape the World Bank table to long format and join all sources
# into one analysis table with one row per country-year.

library(dplyr)
library(tidyr)
library(readr)

# Wide -> long: the year columns ("1960", "1961", ...) become rows.
fertility <- fertility_raw |>
  pivot_longer(
    cols = matches("^[0-9]{4}$"),
    names_to = "year",
    values_to = "fertility"
  ) |>
  transmute(iso3 = `Country Code`, year = as.integer(year), fertility)

check_unique_key(fertility, c("iso3", "year"))

# Gapminder decides which country-years we keep (left joins), so the other
# sources only add columns. Count rows before and after every join.
x <- gapminder |>
  left_join(fertility, by = c("iso3", "year")) |>
  left_join(co2, by = c("iso3", "year")) |>
  left_join(country_meta, by = "iso3")

report_rows(gapminder, x, "Joins")

analysis <- na.omit(x)

write_csv(analysis, "data/processed/analysis.csv")
