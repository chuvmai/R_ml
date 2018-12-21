# Reference: https://ntguardian.wordpress.com/2017/03/27/introduction-stock-market-data-r-1/
# https://ntguardian.wordpress.com/2017/04/03/introduction-stock-market-data-r-2/


# Get quantmod
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

# Let's get Apple stock data; Apple's ticker symbol is AAPL. We use the
# quantmod function getSymbols, and pass a string as a first argument to
# identify the desired ticker symbol, pass 'yahoo' to src for Yahoo!
# Finance, and from and to specify date ranges

# The default behavior for getSymbols is to load data directly into the
# global environment, with the object being named after the loaded ticker
# symbol. This feature may become deprecated in the future, but we exploit
# it now.

getSymbols("AAPL", src = "yahoo", from = start, to = end)

# What is AAPL?
class(AAPL)

names(AAPL)

# Let's see the first few rows
head(AAPL)

tail(AAPL)

plot(AAPL[, "AAPL.Close"], main = "AAPL")

# plot(AAPL[, "AAPL.Close", "AAPL.Open"], main = "AAPL")

candleChart(AAPL, up.col = "black", dn.col = "red", theme = "white")


# Let's get data for Microsoft (MSFT) and Google (GOOG) (actually, Google is
# held by a holding company called Alphabet, Inc., which is the company
# traded on the exchange and uses the ticker symbol GOOG).
getSymbols(c("MSFT", "GOOG"), src = "yahoo", from = start, to = end)


# Create an xts object (xts is loaded with quantmod) that contains closing
# prices for AAPL, MSFT, and GOOG
stocks <- as.xts(data.frame(AAPL = AAPL[, "AAPL.Close"], MSFT = MSFT[, "MSFT.Close"], 
                            GOOG = GOOG[, "GOOG.Close"]))
head(stocks)


# Create a plot showing all series as lines; must use as.zoo to use the zoo
# method for plot, which allows for multiple series to be plotted on same
# plot
plot(as.zoo(stocks), screens = 1, lty = 1:3, xlab = "Date", ylab = "Price")
legend("right", c("AAPL", "MSFT", "GOOG"), lty = 1:3, cex = 0.5)

# stock return
stock_return = apply(stocks, 1, function(x) {x / stocks[1,]}) %>% t %>% as.xts

head(stock_return)

plot(as.zoo(stock_return), screens = 1, lty = 1:3, xlab = "Date", ylab = "Return")
legend("topleft", c( names( stock_return ) ), lty = 1:3, cex = 0.5)
# legend("topleft", c("AAPL", "MSFT", "GOOG"), lty = 1:3, cex = 0.5)


stock_change = stocks %>% log %>% diff(lag = 1)

stock_change = stocks %>% diff(lag = 30) / stocks

head(stock_change)

plot(as.zoo(stock_change), screens = 1, lty = 1:3, xlab = "Date", ylab = "Log Difference")
legend("topleft", c("AAPL", "MSFT", "GOOG"), lty = 1:3, cex = 0.5)

# quantmod allows for easily adding moving averages to charts, via the addSMA() function.
candleChart(AAPL, up.col = "black", dn.col = "red", theme = "white")
addSMA( n = c(10,20,30,90))
# addSMA(n = 10, col = 'red')
# addSMA(n = 20, col = 'blue')
# addSMA(n = 30, col = 'green')
# addSMA(n = 90, col = 'brown')
