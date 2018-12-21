library(maps)
library(mapproj)
library(Hmisc)
source("helpers.R")

counties <- readRDS("data/counties.rds")
head(counties)

summary(counties)

describe(counties)

percent_map(counties$white, "darkgreen", "% White")
