
library(gapminder)


head(gapminder)


# What is the population of Asia in 1998

gapminder |>
  filter(year == 1977) |>
  group_by(continent) |>
  summarise(
    total_population = sum(pop)
  )


x <- "24655643 Famagusta Branch "


str_extract(x, "[0-9]{8}")
