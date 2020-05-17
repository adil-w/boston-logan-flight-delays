# loading libraries
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(plotly)
library(lubridate)
library(RColorBrewer)
library(scales)

# modifying chart size
options(repr.plot.width=5, repr.plot.height=3)

#upload excel file
flights0 <- read_csv("flight_data/bos_flights_only.csv")
airline <- read_csv("flight_data/airlines.csv")
airports <- read_csv("flight_data/airports.csv")

flights <- flights0 %>% 
  left_join(airports, by = c("DESTINATION_AIRPORT" = "IATA_CODE")) %>% 
  left_join(airline, by = c("AIRLINE" = "IATA_CODE"))

# How many airports can you fly to from Boston and what were the most popular airports to fly to?
flights %>% 
  count(AIRPORT, CITY, sort = TRUE)

# How many flights are out of Boston each month?
flights %>% count(MONTH, sort = TRUE) %>%
  arrange(desc(n)) %>%
  ggplot() +
  geom_col(aes(x = factor(MONTH), y = n),fill = "#E6AB02") +
  theme(axis.text.x=element_text(angle=90, hjust=1)) +
  labs(title = "Flights By Month", x = "month", y = "count of flights")

