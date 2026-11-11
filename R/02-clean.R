# Step 2: clean each table and give every country the same key (ISO3 code).
# Gapminder only has country *names*; the other sources use ISO3 codes.
# We get each Gapminder country's code from the OWID file, by name, and fix
# the 11 names that are spelled differently with data/reference/country_name_fixes.csv.

library(dplyr)

# OWID lists countries and also aggregates such as "World" or "Africa".
# Real countries have a 3-letter code; aggregates have no code or "OWID_...".
df2 <- co2_raw |>
  distinct(entity, code) |>
  filter(!is.na(code), nchar(code) == 3)

gapminder <- gapminder_raw |>
  left_join(df2, by = c("country" = "entity")) |>
  left_join(name_fixes, by = c("country" = "gapminder_name")) |>
  mutate(iso3 = coalesce(code, iso3)) |>
  select(country, iso3, continent, year, life_exp = lifeExp, pop, gdp_percap = gdpPercap)

# Every Gapminder country must now have a code. If a name is still unmatched,
# stop here and add it to country_name_fixes.csv.
stopifnot(!any(is.na(gapminder$iso3)))
check_unique_key(gapminder, c("iso3", "year"))

# remove countries with missing data
tmp <- country_meta_raw |>
  filter(!is.na(Region)) |>
  select(iso3 = `Country Code`, region = Region, income_group = IncomeGroup)

country_meta <- tmp
check_unique_key(country_meta, "iso3")

co2 <- co2_raw |>
  filter(!is.na(code), nchar(code) == 3) |>
  select(iso3 = code, year, co2_per_capita = emissions_total_per_capita)

check_unique_key(co2, c("iso3", "year"))
