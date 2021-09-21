## Section 3.3 - String Processing

# Separate w/ Regex -------------------------------------------------------

# The extract() function behaves similarly to the separate() function but allows extraction of groups from regular expressions.

# .. Code ..
# first example - normally formatted heights
s <- c("5'10", "6'1")
tab <- data.frame(x = s)

# the separate and extract functions behave similarly
tab %>% separate(x, c("feet", "inches"), sep = "'")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")

# second example - some heights with unusual formats
s <- c("5'10", "6'1\"","5'8inches")
tab <- data.frame(x = s)

# separate fails because it leaves in extra characters, but extract keeps only the digits because of regex groups
tab %>% separate(x, c("feet","inches"), sep = "'", fill = "right")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")

# Using Groups & Quantifiers ----------------------------------------------

# Four clear patterns of entries have arisen along with some other minor problems:

# Many students measuring exactly 5 or 6 feet did not enter any inches. For example, 6' - our pattern requires that
# inches be included.

# Some students measuring exactly 5 or 6 feet entered just that number.

# Some of the inches were entered with decimal points. For example 5'7.5''. Our pattern only looks for two digits.

# Some entries have spaces at the end, for example 5 ' 9.

# Some entries are in meters and some of these use European decimals: 1.6, 1,7.

# Two students added cm.

# One student spelled out the numbers: Five foot eight inches.

# It is not necessarily clear that it is worth writing code to handle all these cases since they might be rare enough.
# However, some give us an opportunity to learn some more regex techniques so we will build a fix.

# .. Case 1 ..
# For case 1, if we add a '0 to, for example, convert all 6 to 6'0, then our pattern will match. This can be done using
# groups using the following code:
yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0")
# The pattern says it has to start (^), be followed with a digit between 4 and 7, and then end there ($). The parenthesis
# defines the group that we pass as \\1 to the replace regex.

# .. Case 2 & 4 ..
# We can adapt this code slightly to handle case 2 as well which covers the entry 5'. Note that the 5' is left untouched
# by the code above. This is because the extra ' makes the pattern not match since we have to end with a 5 or 6. To handle
# case 2, we want to permit the 5 or 6 to be followed by no or one symbol for feet. So we can simply add '{0,1} after
# the ' to do this. We can also use the none or once special character ?. As we saw previously, this is different
# from * which is none or more. We now see that this code also handles the fourth case as well:
str_replace(s, "^([56])'?$", "\\1'0")

# Note that here we only permit 5 and 6 but not 4 and 7. This is because heights of exactly 5 and exactly 6 feet tall are
# quite common, so we assume those that typed 5 or 6 really meant either 60 or 72 inches. However, heights of exactly 4
# or exactly 7 feet tall are so rare that, although we accept 84 as a valid entry, we assume that a 7 was entered in error.

# .. Case 3 ..
# We can use quantifiers to deal with  case 3. These entries are not matched because the inches include decimals and our
# pattern does not permit this. We need allow the second group to include decimals and not just digits. This means we must
# permit zero or one period . followed by zero or more digits. So we will use both ? and *. Also remember that for this
# particular case, the period needs to be escaped since it is a special character (it means any character except a line break).

#So we can adapt our pattern, currently ^[4-7]\\s*'\\s*\\d{1,2}$, to permit a decimal at the end:
pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"

# .. Case 5 ..
# Case 5, meters using commas, we can approach similarly to how we converted the x.y to x'y. A difference is that we require
# that the first digit is 1 or 2:
yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") # We will later check if the entries are meters using
# their numeric values

# .. Trimming ..
# In general, spaces at the start or end of the string are uninformative. These can be particularly deceptive because
# sometimes they can be hard to see:
s <- "Hi "
cat(s)
identical(s, "Hi") # This is a general enough problem that there is a function dedicated to removing them: str_trim.
str_trim("5 ' 9 ")

# .. Upper & lower case ..
# One of the entries writes out numbers as words: Five foot eight inches. Although not efficient, we could add 12 extra
# str_replace to convert zero to 0, one to 1, and so on. To avoid having to write two separate operations for Zero and zero,
# One and one, etc., we can use the str_to_lower() function to make all words lower case first:
s <- c("Five feet eight inches")
str_to_lower(s)

# .. Putting it into a Funciton ..
# We are now ready to define a procedure that handles converting all the problematic cases.
 
# We can now put all this together into a function that takes a string vector and tries to convert as many strings as
# possible to a single format. Below is a function that puts together the previous code replacements:
convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
    str_replace_all("inches|in|''|\"|cm|and", "") %>%  #remove inches and other symbols
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>% #change x.y, x,y x y
    str_replace("^([56])'?$", "\\1'0") %>% #add 0 when to 5 or 6
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>% #change european decimal
    str_trim() #remove extra space
}
# We can also write a function that converts words to numbers:
words_to_numbers <- function(s){
  str_to_lower(s) %>%  
    str_replace_all("zero", "0") %>%
    str_replace_all("one", "1") %>%
    str_replace_all("two", "2") %>%
    str_replace_all("three", "3") %>%
    str_replace_all("four", "4") %>%
    str_replace_all("five", "5") %>%
    str_replace_all("six", "6") %>%
    str_replace_all("seven", "7") %>%
    str_replace_all("eight", "8") %>%
    str_replace_all("nine", "9") %>%
    str_replace_all("ten", "10") %>%
    str_replace_all("eleven", "11")
}

# Now we can see which problematic entries remain:
# converted <- problems %>% words_to_numbers %>% convert_format
remaining_problems <- converted[not_inches_or_cm(converted)]
pattern <- "^[4-7]\\s*'\\s*\\d+\\.?\\d*$"
index <- str_detect(remaining_problems, pattern)
remaining_problems[!index]

# .. Putting it all together ..
# We are now ready to put everything we've done so far together and wrangle our reported heights data as we try to
# recover as many heights as possible. The code is complex but we will break it down into parts.
 
# We start by cleaning up the height column so that the heights are closer to a feet'inches format. We added an
# original heights column so we can compare before and after.
 
# Let's start by writing a function that cleans up strings so that all the feet and inches formats use the same x'y
# format when appropriate.
pattern <- "^([4-7])\\s*'\\s*(\\d+\\.?\\d*)$"

smallest <- 50
tallest <- 84
new_heights <- reported_heights %>% 
  mutate(original = height, 
         height = words_to_numbers(height) %>% convert_format()) %>%
  extract(height, c("feet", "inches"), regex = pattern, remove = FALSE) %>% 
  mutate_at(c("height", "feet", "inches"), as.numeric) %>%
  mutate(guess = 12*feet + inches) %>%
  mutate(height = case_when(
    !is.na(height) & between(height, smallest, tallest) ~ height, #inches 
    !is.na(height) & between(height/2.54, smallest, tallest) ~ height/2.54, #centimeters
    !is.na(height) & between(height*100/2.54, smallest, tallest) ~ height*100/2.54, #meters
    !is.na(guess) & inches < 12 & between(guess, smallest, tallest) ~ guess, #feet'inches
    TRUE ~ as.numeric(NA))) %>%
  select(-guess)

# We can check all the entries we converted using the following code:
new_heights %>%
  filter(not_inches(original)) %>%
  select(original, height) %>% 
  arrange(height) %>%
  View()

# Let's take a look at the shortest students in our dataset using the following code:
new_heights %>% arrange(height) %>% head(n=7)

# We see heights of 53, 54, and 55. In the original heights column, we also have 51 and 52. These short heights are
# very rare and it is likely that the students actually meant 5'1, 5'2, 5'3, 5'4, and 5'5. But because we are not
# completely sure, we will leave them as reported.

# String Splitting --------------------------------------------------------

# The function str_split() splits a string into a character vector on a delimiter (such as a comma, space or underscore).
# By default, str_split() generates a list with one element for each original string. Use the function argument simplify=TRUE
# to have str_split() return a matrix instead.

# The map() function from the purrr package applies the same function to each element of a list. To extract the ith entry of
# each element x, use map(x, i).

# map() always returns a list. Use map_chr() to return a character vector and map_int() to return an integer.

# .. Code ..
# read raw murders data line by line
filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)
lines %>% head()

# split at commas with str_split function, remove row of column names
x <- str_split(lines, ",") 
x %>% head()
col_names <- x[[1]]
x <- x[-1]

# extract first element of each list entry
library(purrr)
map(x, function(y) y[1]) %>% head()
map(x, 1) %>% head()

# extract columns 1-5 as characters, then convert to proper format - NOTE: DIFFERENT FROM VIDEO
dat <- data.frame(parse_guess(map_chr(x, 1)),
                  parse_guess(map_chr(x, 2)),
                  parse_guess(map_chr(x, 3)),
                  parse_guess(map_chr(x, 4)),
                  parse_guess(map_chr(x, 5))) %>%
  setNames(col_names)

dat %>% head

# more efficient code for the same thing
dat <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>% 
  as.data.frame() 

# the simplify argument makes str_split return a matrix instead of a list
x <- str_split(lines, ",", simplify = TRUE) 
col_names <- x[1,]
x <- x[-1,]
x %>% as_data_frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)

# Case Study 3: NL Funding Rates by Gender -------------------------------------

# One of the datasets provided in dslabs shows scientific funding rates by gender in the Netherlands:
library(dslabs)
data("research_funding_rates")
research_funding_rates

# The data come from a paper External link published in the prestigious journal PNAS. However, the data are not provided
# in a spreadsheet; they are in a table in a PDF document. We could extract the numbers by hand, but this could lead to
# human error. Instead we can try to wrangle the data using R.

# .. Downloading the data ..
# We start by downloading the PDF document then importing it into R using the following code:
library("pdftools")
temp_file <- tempfile()
url <- "http://www.pnas.org/content/suppl/2015/09/16/1510159112.DCSupplemental/pnas.201510159SI.pdf"
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)

# If we examine the object text we notice that it is a character vector with an entry for each page. So we keep the page
# we want using the following code:
raw_data_research_funding_rates <- txt[2]

# The steps above can actually be skipped because we include the raw data in the dslabs package as well:
data("raw_data_research_funding_rates")

# .. Looking at the download ..
# Examining this object,
raw_data_research_funding_rates %>% head

# we see that it is a long string. Each line on the page, including the table rows, is separated by the symbol for newline: \n.

# We can therefore can create a list with the lines of the text as elements:
tab <- str_split(raw_data_research_funding_rates, "\n")

# Because we start off with just one element in the string, we end up with a list with just one entry:
tab <- tab[[1]]

# By examining this object,
tab %>% head

# we see that the information for the column names is the third and fourth entries:
the_names_1 <- tab[3]
the_names_2 <- tab[4]

# In the table, the column information is spread across two lines. We want to create one vector with one name for each
# column. We can do this using some of the functions we have just learned.

# .. Extracting the table data ..
# Let's start with the first line:
the_names_1

# We want to remove the leading space and everything following the comma. We can use regex for the latter. Then we can obtain
# the elements by splitting using the space. We want to split only when there are 2 or more spaces to avoid splitting success
# rate. So we use the regex \\s{2,} as follows:
the_names_1 <- the_names_1 %>%
  str_trim() %>%
  str_replace_all(",\\s.", "") %>%
  str_split("\\s{2,}", simplify = TRUE)
the_names_1

# Now let's look at the second line:
the_names_2

# Here we want to trim the leading space and then split by space as we did for the first line:
the_names_2 <- the_names_2 %>%
  str_trim() %>%
  str_split("\\s+", simplify = TRUE)
the_names_2

# Now we can join these to generate one name for each column:
tmp_names <- str_c(rep(the_names_1, each = 3), the_names_2[-1], sep = "_")
the_names <- c(the_names_2[1], tmp_names) %>%
  str_to_lower() %>%
  str_replace_all("\\s", "_")
the_names

# Now we are ready to get the actual data. By examining the tab object, we notice that the information is in lines 6
# through 14. We can use str_split() again to achieve our goal:
new_research_funding_rates <- tab[6:14] %>%
  str_trim %>%
  str_split("\\s{2,}", simplify = TRUE) %>%
  data.frame(stringsAsFactors = FALSE) %>%
  setNames(the_names) %>%
  mutate_at(-1, parse_number)
new_research_funding_rates %>% head()

# We can see that the objects are identical:
identical(research_funding_rates, new_research_funding_rates)

# Recoding ----------------------------------------------------------------

# Change long factor names with the recode() function from the tidyverse. 

# Other similar functions include recode_factor() and fct_recoder() in the forcats package in the tidyverse. The same
# result could be obtained using the case_when() function, but recode() is more efficient to write.

# .. Code ..
# life expectancy time series for Caribbean countries
library(dslabs)
data("gapminder")
gapminder %>% 
  filter(region=="Caribbean") %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()

# display long country names
gapminder %>% 
  filter(region=="Caribbean") %>%
  filter(str_length(country) >= 12) %>%
  distinct(country) 

# recode long country names and remake plot
gapminder %>% filter(region=="Caribbean") %>%
  mutate(country = recode(country, 
                          'Antigua and Barbuda'="Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad")) %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()
