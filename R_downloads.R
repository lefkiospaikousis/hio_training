

library(tidyverse)
library(cranlogs)
library(glue)

dta <- cran_downloads("dplyr",  from = "2019-01-01")


dta |>
  as_tibble() |>
  group_by(date) |>
  #group_by(year = lubridate::year(date), month = lubridate::month(date) )|>
  summarise(count = sum(count), .groups = "drop") |>
  filter(count < 100000) |>
  ggplot( aes(date, count) ) +
  geom_line()+
  scale_y_continuous(labels = scales::label_number(suffix = "K", scale = 1e-3))+
  scale_x_date(date_breaks = "6 months", labels = function(x) format(x, "%d/%m"))


r_logs <- cran_downloads("R", from = as.Date("2019-01-01"), to = Sys.Date())



r_data <- r_logs |>
  as_tibble() |>
  #filter(date < as.Date("2022-10-01")) |>
  #arrange(desc(count))
  #filter(version < "4.2.0") |>
  #filter(count < 50000) |>
  group_by(date) |>
  summarise(count = sum(count)) |>
  filter(count < 40000)

r_data |>
  ggplot(aes(date, count))+
  geom_line()+
  geom_smooth(method = "lm")+
  scale_x_date(date_breaks = "6 months", labels = function(x) format(x, "%Y/%m"))+
  geom_line()+
  scale_y_continuous(labels = scales::label_number(suffix = "K", scale = 1e-3))+
  labs(y = "", x = "",
       title = glue("R daily downloads since {format(min(r_data$date), '%d/%m/%Y')}"),
       subtitle = glue::glue("Period: {format(min(r_data$date), '%d/%m/%Y')} - {format(max(r_data$date), '%d/%m/%Y')}"),
       caption = "Counts extracted using the {cranlogs} package\
       RSTUDIO CRAN package mirror at http://cran-logs.rstudio.com.
       @lpaikousis
       "
  )+
  theme_bw(16)
