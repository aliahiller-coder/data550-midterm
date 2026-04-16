library(tidyverse)
library(gtsummary)
library(yaml)
library(here)


# Load config
config <- read_yaml(here::here("config.yml"))
county_filter <- config$county

# Load cleaned data
data <- readRDS(here::here("output/00_load_data.rds"))

# Filter by county from config
data_filtered <- data |>
  filter(county_fips == county_filter)

# Count distinct sewersheds
n_sewersheds <- data_filtered |>
  summarise(n = n_distinct(site)) |>
  pull(n)

# Build descriptive table
table1 <- data_filtered |>
  select(sample_matrix, population_served, pcr_target_avg_conc) |>
  tbl_summary(
    statistic = list(
      all_categorical() ~ "{n} ({p}%)",
      all_continuous() ~ "{mean} / {median}"
    ),
    label = list(
      sample_matrix ~ "Sample Matrix",
      population_served ~ "Population Served (avg/median)",
      pcr_target_avg_conc ~ "PCR Target Avg Concentration (avg/median)"
    )
  ) |>
  add_n() |>
  modify_caption(
    paste0("**Table 1. Descriptive Summary** (Distinct Sewersheds: ", n_sewersheds, ")")
  )

# Save output
saveRDS(table1, here::here("output/01_table1.rds"))
