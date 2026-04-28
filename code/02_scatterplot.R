here::i_am('code/02_scatterplot.R')

#loading libraries 
library(tidyverse)
library(readr)
library(lubridate)
library(yaml)

# config rule 
config <- yaml::read_yaml(here::here("config.yml"))

#read dataset
data <- readRDS(
  file = here::here("output/00_load_data.rds")
)

county_selected <- config$county$counties_served

data <- data %>%
  mutate(
    sample_collect_date = as.Date(sample_collect_date),
    pcr_target_avg_conc = parse_number(pcr_target_avg_conc),
    counties_served = as.character(counties_served)
  ) %>%
  filter(counties_served == county_selected) %>%
  mutate(
    month = month(sample_collect_date, label = TRUE),
    season = case_when(
      month %in% c("Dec", "Jan", "Feb") ~ "Winter",
      month %in% c("Mar", "Apr", "May") ~ "Spring",
      month %in% c("Jun", "Jul", "Aug") ~ "Summer",
      month %in% c("Sep", "Oct", "Nov") ~ "Fall"
    )
  )

scatterplot3 <- ggplot(data, aes(
  x = sample_collect_date,
  y = pcr_target_avg_conc,
  color = season
)) +
  geom_point(alpha = 0.4) +
  geom_smooth(se = FALSE) +
  labs(
    title = paste("Seasonal Patterns in RSV Wastewater Concentration in", county_selected, "County"),
    x = "Date",
    y = "RSV Concentration",
    color = "Season"
  ) +
  theme_minimal()

ggsave(
  file = here::here("output/02_scatterplot.png"),
  plot = scatterplot3,
  device = "png"
)