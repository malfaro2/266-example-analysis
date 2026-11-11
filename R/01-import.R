# Step 1: read the four raw files exactly as downloaded.
# Nothing in this step changes the data. It only deals with *how* each
# file has to be read. Files in data/raw/ are never edited by hand.

library(readr)
library(dplyr)

# Gapminder: tab-separated, one row per country-year (long format).
gapminder_raw <- read_tsv("data/raw/gapminder.tsv", show_col_types = FALSE)

# World Bank fertility: comma-separated, one column per year (wide format).
# The first 4 lines are notes about the download, not data, so we skip them.
# Every line ends in a comma, which creates an empty unnamed last column;
# name_repair = "unique_quiet" names it "...71" without a warning and we drop it.
fertility_raw <- read_csv(
  "data/raw/wb_fertility_wide.csv",
  skip = 4,
  show_col_types = FALSE,
  name_repair = "unique_quiet"
) |>
  select(-starts_with("..."))

# World Bank country metadata: region and income group for each country code.
# Same trailing-comma problem as above.
country_meta_raw <- read_csv(
  "data/raw/wb_country_metadata.csv",
  show_col_types = FALSE,
  name_repair = "unique_quiet"
) |>
  select(-starts_with("..."))

# Our World in Data CO2 emissions per capita: one row per entity-year (long).
co2_raw <- read_csv("data/raw/owid_co2_per_capita.csv", show_col_types = FALSE)

# Hand-written lookup for country names that differ between sources.
name_fixes <- read_csv("data/reference/country_name_fixes.csv", show_col_types = FALSE)
