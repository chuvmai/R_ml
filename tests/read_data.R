library(maps)
library(mapproj)
source("helpers.R")

counties <- readRDS("data/counties.rds")
head(counties)

percent_map(counties$white, "darkgreen", "% White")
