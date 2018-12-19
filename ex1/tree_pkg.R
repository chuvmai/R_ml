# install.packages("tidyverse")
# install.packages("funModeling")
# install.packages("Hmisc")

library(funModeling) 
library(tidyverse) 
library(Hmisc)

library(tree)

heart
hd = heart_disease

class(hd) # dataframe

str(hd) # get the structure

#Now, lets examine the column names (and also note how we see how many there are) 
# using colnames, nrow, ncol, dim

coln = colnames(hd)
coln
class(coln)
coln[1]
coln[4]
coln[1:4]

# first two rows
hd[1:2,]
# second row
hd[2,]

# Extract 3rd and 5th row with 2nd and 4th column.
result <- hd[c(3,5),c(2,4)]
print(result)

hd
select(hd, age)

data=heart_disease %>% select(age, max_heart_rate, thal, has_heart_disease)
data <- heart_disease %>% select(age, max_heart_rate, thal, has_heart_disease)

data = select(heart_disease, age, max_heart_rate, thal, has_heart_disease)


glimpse(data)
df_status(data)
freq(data)
plot_num(data)

# create a function
basic_eda <- function(data)
{
    glimpse(data)
    df_status(data)
    freq(data) 
    profiling_num(data)
    plot_num(data)
    describe(data)
}

basic_eda(data)

data_prof=profiling_num(data)
describe(data)
