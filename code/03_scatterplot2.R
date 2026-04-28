here::i_am('code/03_scatterplot2.R')

#read dataset
data <- readRDS(
  file = here::here("output/00_load_data.rds")
  )

#convert population_served variable to numeric
data$population_served = as.numeric(gsub(",", "", data$population_served))


#allows config settings in yml file to run 
config <- yaml::read_yaml(here::here("config.yml"))

#highlighted data point based on site number
highlight_id <- config$facility$site

#make scatterplot
library(ggplot2)

scatterplot2 <- 
  ggplot(data, aes(x = population_served, y = flow_rate)) +
  geom_point(
    aes(color = if (!is.null(highlight_id)) site == highlight_id else FALSE),
    size = 2, show.legend = FALSE
  ) +
  scale_color_manual(values = c("FALSE" = "black", "TRUE" = "green"))+
  geom_smooth(method = "lm", color = "pink") +
  labs(title = "Scatterplot of Population Served vs Flow Rate",
       subtitle = paste("Highlighted Data From Site:", config$facility$site)) +
  scale_x_log10() +
  theme_bw() 

ggsave(
  file =  here::here("output/03_scatterplot2.png"),
  plot = scatterplot2,
  device = "png"
)
