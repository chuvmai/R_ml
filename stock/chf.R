# get chf prices

if (!require("quantmod")) {
    install.packages("quantmod")
    library(quantmod)
}

# Get me my beloved pipe operator!
if (!require("magrittr")) {
    install.packages("magrittr")
    library(magrittr)
}

start <- as.Date("2016-01-01")
end <- as.Date("2018-12-01")

getFX("CHF/EUR", src = "yahoo", from = start, to = end)