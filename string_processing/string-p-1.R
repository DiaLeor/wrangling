## Section 3.1 - String Processing

# String Parsing ----------------------------------------------------------

# The most common tasks in string processing include:
      # extracting numbers from strings
      # removing unwanted characters from text
      # finding and replacing characters
      # extracting specific parts of strings
      # converting free form text to more uniform formats
      # splitting strings into multiple values
      
# The stringr package in the tidyverse contains string processing functions that follow a similar naming format
# (str_functionname) and are compatible with the pipe.

# .. Code ..
# read in raw murders data from Wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_table() %>%
  .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

# inspect data and column classes
head(murders_raw)
class(murders_raw$population)
class(murders_raw$total)

# Defining Strings: Single,  Double,  Esc ---------------------------------

# Define a string by surrounding text with either single quotes or double quotes.

# To include a single quote inside a string, use double quotes on the outside. To include a double quote inside a string,
# use single quotes on the outside.

# The cat() function displays a string as it is represented inside R.

# To include a double quote inside of a string surrounded by double quotes, use the backslash (\) to escape the double quote.
# Escape a single quote to include it inside of a string defined by single quotes.

# We will see additional uses of the escape later.

# .. Code ..
s <- "Hello!"    # double quotes define a string
s <- 'Hello!'    # single quotes define a string
s <- `Hello`    # backquotes do not

s <- "10""    # error - unclosed quotes
s <- '10"'    # correct

# cat shows what the string actually looks like inside R
cat(s)

s <- "5'"
cat(s)

# to include both single and double quotes in string, escape with \
s <- '5'10"'    # error
s <- "5'10""    # error
s <- '5\'10"'    # correct
cat(s)
s <- "5'10\""    # correct
cat(s)

# stringr Package ---------------------------------------------------------

# The main types of string processing tasks are detecting, locating, extracting and replacing elements of strings.

# The stringr package from the tidyverse includes a variety of string processing functions that begin with str_ and take the
# string as the first argument, which makes them compatible with the pipe.

# .. Code ..
# murders_raw defined in web scraping video

# direct conversion to numeric fails because of commas
murders_raw$population[1:3]
as.numeric(murders_raw$population[1:3])

library(tidyverse)    # includes stringr

# Case Study 1 ------------------------------------------------------------

# ***NOTE: The Wikipedia page with US murder data has been updated since these notes were created and is no longer
# easily converted with as.numeric() due to inclusion of endnote links. We will learn more string processing methods later
# that can be used to remove these endnotes.***

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

# parse_number also removes commas and converts to numeric
test_2 <- parse_number(murders_raw$population)
identical(test_1, test_2)

murders_new <- murders_raw %>% mutate_at(2:3, parse_number)
murders_new %>% head



