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
end <- as.Date("2018-12-20")

getFX("CHF/EUR", src = "yahoo", from = start, to = end)

class(CHFEUR)

head(CHFEUR)

plot(CHFEUR[, "CHF.EUR"], main = "CHF/EUR")

candleChart(CHFEUR)
addSMA(n = 10, col = 'red')
addSMA(n = 20, col = 'blue')
addSMA(n = 30, col = 'violet')
addSMA(n = 50, col = 'yellow')
