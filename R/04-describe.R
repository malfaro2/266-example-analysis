# Step 4: descriptive summaries and figures.
# Tables go to output/tables/ and figures to output/figures/.

library(dplyr)
library(ggplot2)
library(readr)

# Median of each variable by region and year.
life_by_region <- analysis |>
  group_by(region, year) |>
  summarize(median_life_exp = round(median(life_exp, na.rm = T), 1), .groups = "drop")

fertility_by_region <- analysis |>
  group_by(region, year) |>
  summarize(median_fertility = round(median(fertility, na.rm = T), 1), .groups = "drop")

co2_by_region <- analysis |>
  group_by(region, year) |>
  summarize(median_co2 = round(median(co2_per_capita, na.rm = T), 2), .groups = "drop")

region_summary <- life_by_region |>
  left_join(fertility_by_region, by = c("region", "year")) |>
  left_join(co2_by_region, by = c("region", "year"))

write_csv(region_summary, "output/tables/region_summary.csv")

# Figure 1: fertility against life expectancy in 2007, one point per country.
fig_scatter <- analysis |>
  filter(year == 2007) |>
  ggplot(aes(x = fertility, y = life_exp, color = region, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_size_area(max_size = 10, guide = "none") +
  labs(
    title = "Countries with lower fertility have longer life expectancy (2007)",
    x = "Fertility rate (births per woman)",
    y = "Life expectancy (years)",
    color = "World Bank region",
    caption = "Sources: Gapminder; World Bank WDI. Point size is population."
  ) +
  theme_minimal()

ggsave("output/figures/fertility_vs_life_exp_2007.png", fig_scatter, width = 8, height = 5, dpi = 150)

# Figure 2: regional medians over time, one panel per variable.
region_long <- region_summary |>
  tidyr::pivot_longer(starts_with("median_"), names_to = "variable", values_to = "median") |>
  mutate(variable = recode(variable,
    median_life_exp = "Life expectancy (years)",
    median_fertility = "Fertility (births per woman)",
    median_co2 = "CO2 per capita (tonnes)"
  ))

fig_trends <- ggplot(region_long, aes(x = year, y = median, color = region)) +
  geom_line(linewidth = 0.8) +
  facet_wrap(~variable, scales = "free_y", ncol = 1) +
  labs(
    title = "Regional medians, by year",
    x = NULL, y = NULL, color = "World Bank region",
    caption = "Sources: Gapminder; World Bank WDI; Our World in Data / Global Carbon Budget."
  ) +
  theme_minimal()

ggsave("output/figures/regional_trends.png", fig_trends, width = 8, height = 8, dpi = 150)
