## Section 3.2 - String Processing
# Case Study 1: US Murders ------------------------------------------------------------

# Use the str_detect() function to determine whether a string contains a certain pattern.

# Use the str_replace_all() function to replace all instances of one pattern with another pattern. To remove a pattern,
# replace with the empty string ("").

# The parse_number() function removes punctuation from strings and converts them to numeric.

# mutate_at() performs the same transformation on the specified column numbers.

# .. Code ..
# murders_raw was defined in the web scraping section

# detect whether there are commas
commas <- function(x) any(str_detect(x, ","))
murders_raw %>% summarize_all(funs(commas))

# replace commas with the empty string and convert to numeric
test_1 <- str_replace_all(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)
test_1
# parse_number also removes commas and converts to numeric
test_2 <- parse_number(murders_raw$population)
test_2

identical(test_1, test_2).

murders_new <- murders_raw %>% mutate_at(2:3, parse_number)
murders_new %>% head

# Case Study 2: Reported Heights ------------------------------------------------------------

# In the raw heights data, many students did not report their height as the number of inches as requested. There are many entries
# with real height information but in the wrong format, which we can extract with string processing. 

# When there are both text and numeric entries in a column, the column will be a character vector. Converting this column to
# numeric will result in NAs for some entries.

# To correct problematic entries, look for patterns that are shared across large numbers of entries, then define rules that
# identify those patterns and use these rules to write string processing tasks.

# Use suppressWarnings() to hide warning messages for a function.

# .. Code ..
# load raw heights data and inspect
library(dslabs)
data(reported_heights)
class(reported_heights$height)

# convert to numeric, inspect, count NAs
x <- as.numeric(reported_heights$height)
head(x)
sum(is.na(x))

# keep only entries that result in NAs
reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height)) %>% 
  head(n=10)

# calculate cutoffs that cover 99.999% of human population
alpha <- 1/10^6
qnorm(1-alpha/2, 69.1, 2.9)
qnorm(alpha/2, 63.7, 2.7)

# keep only entries that either result in NAs or are outside the plausible range of heights
not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

# number of problematic entries
problems <- reported_heights %>% 
  filter(not_inches(height)) %>%
  .$height
length(problems)

# 10 examples of x'y or x'y" or x'y\"
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of x.y or x,y
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of entries in cm rather than inches
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54, 54, 81) )
ind <- ind[!is.na(ind)]
problems[ind] %>% head(n=10) %>% cat
