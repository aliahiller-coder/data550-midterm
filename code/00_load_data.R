here::i_am('code/00_load_data.R')

#saving rsv data as an object
data <- read.csv('data/RSV_GA_Data.csv', header=TRUE)

#saving data output
saveRDS(
  data,
  file = here::here("output/00_load_data.rds")
)
