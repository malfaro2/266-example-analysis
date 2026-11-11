# Data

## `raw/`: downloaded files, never edited by hand

All four files were downloaded on 2026-11-11 and are committed unchanged, so the
analysis does not depend on a website staying the same.

| File | Source | What it contains | License |
|---|---|---|---|
| `gapminder.tsv` | Jennifer Bryan's `gapminder` R package, <https://github.com/jennybc/gapminder> (`inst/extdata/gapminder.tsv`), data from Gapminder | Life expectancy, population, GDP per capita for 142 countries, every 5 years from 1952 to 2007. Long format, tab-separated. | CC BY (Gapminder) |
| `wb_fertility_wide.csv` | World Bank, World Development Indicators, indicator `SP.DYN.TFRT.IN`, <https://data.worldbank.org/indicator/SP.DYN.TFRT.IN> (CSV download, file `API_SP.DYN.TFRT.IN_DS2_en_csv_v2_259446.csv`) | Total fertility rate (births per woman), 1960-2025, for countries **and** aggregates such as "World". Wide format: one column per year. Has 4 lines of notes above the header and a trailing comma on every line. | CC BY 4.0 |
| `wb_country_metadata.csv` | Same World Bank download (file `Metadata_Country_...csv`) | Region and income group for each country code. Aggregates have an empty `Region`. | CC BY 4.0 |
| `owid_co2_per_capita.csv` | Our World in Data, <https://ourworldindata.org/grapher/co-emissions-per-capita>, based on the Global Carbon Budget | CO₂ emissions per person (tonnes), by country and year. Aggregates have no code or an `OWID_` code. | CC BY 4.0 |

## `reference/`: small hand-written tables

- `country_name_fixes.csv`: ISO3 codes for the 11 Gapminder country names that are spelled differently in the OWID file. Written by hand; edit it if a new mismatch appears.

## `processed/`: written by the pipeline

- `analysis.csv`: one row per country-year, all sources joined. Created by `R/03-reshape-join.R`. Not tracked in git; render `run-analysis.qmd` to rebuild it.
