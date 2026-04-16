here::i_am('code/02_scatterplot.R')

#read dataset
data <- readRDS(
  file = here::here("output/00_load_data.rds")
)

#loading libraries 
library(tidyverse)
library(readr)
library(lubridate)

#cleaned variables 
data <- data %>%
  mutate(
    sample_collect_date = as.Date(sample_collect_date),
    pcr_target_avg_conc = parse_number(pcr_target_avg_conc)  
  )

#created season variable to view trends in RSV concentrations
data <- data %>%
  mutate(
    month = month(sample_collect_date, label = TRUE),
    season = case_when(
      month %in% c("Dec", "Jan", "Feb") ~ "Winter",
      month %in% c("Mar", "Apr", "May") ~ "Spring",
      month %in% c("Jun", "Jul", "Aug") ~ "Summer",
      month %in% c("Sep", "Oct", "Nov") ~ "Fall"
    )
  )

#plotting RSV trends throughout the seasons, high and low points 

scatterplot3 <- 
  ggplot(data, aes(x = sample_collect_date, y = pcr_target_avg_conc, color = season)) +
  geom_point(alpha = 0.4) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Seasonal Patterns in RSV Wastewater Concentration",
    x = "Date",
    y = "RSV Concentration"
  ) +
  theme_minimal()

ggsave(
  file =  here::here("output/02_scatterplot.png"),
  plot = scatterplot3,
  device = "png"
)