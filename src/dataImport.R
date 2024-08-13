library(tidyverse)
library(baseballr)

fgData2015 <- fg_batter_leaders(startseason = 2015, endseason = 2015, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2016 <- fg_batter_leaders(startseason = 2016, endseason = 2016, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2017 <- fg_batter_leaders(startseason = 2017, endseason = 2017, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2018 <- fg_batter_leaders(startseason = 2018, endseason = 2018, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2019 <- fg_batter_leaders(startseason = 2019, endseason = 2019, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2020 <- fg_batter_leaders(startseason = 2020, endseason = 2020, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2021 <- fg_batter_leaders(startseason = 2021, endseason = 2021, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2022 <- fg_batter_leaders(startseason = 2022, endseason = 2022, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)
fgData2023 <- fg_batter_leaders(startseason = 2023, endseason = 2023, qual = 50) %>%
  select(Season, xMLBAMID, PlayerName, Age, PA, wOBA)

fgFull <- rbind(fgData2015, fgData2016, fgData2017, fgData2018, fgData2019,
                fgData2020, fgData2021, fgData2022, fgData2023) %>%
  rename(year = "Season", player_id = "xMLBAMID", player_name = "PlayerName",
         age = "Age", pa = "PA")

scData2015 <- statcast_leaderboards(year=2015, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2016 <- statcast_leaderboards(year=2016, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2017 <- statcast_leaderboards(year=2017, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2018 <- statcast_leaderboards(year=2018, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2019 <- statcast_leaderboards(year=2019, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2020 <- statcast_leaderboards(year=2020, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2021 <- statcast_leaderboards(year=2021, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2022 <- statcast_leaderboards(year=2022, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)
scData2023 <- statcast_leaderboards(year=2023, min_pa = 50) %>%
  select(year, player_id, `last_name, first_name`,
         max_hit_speed, avg_hit_speed, ev50, brl_percent)

scFull <- rbind(scData2015, scData2016, scData2017, scData2018, scData2019,
                scData2020, scData2021, scData2022, scData2023) %>%
  rename(player_name = "last_name, first_name", max_ev = "max_hit_speed",
         avg_ev = "avg_hit_speed", brl_rate = "brl_percent")

data <- inner_join(scFull, fgFull, by = join_by(player_id, year)) %>%
  select(-player_name.y) %>%
  rename(player_name = "player_name.x")

write_csv(data, "data/data_combined.csv")
