## Section 1 - Data Import
# Many datasets are stored in spreadsheets. A spreadsheet is essentially a file version of a data frame with rows and columns.

# Spreadsheets have rows separated by returns and columns separated by a delimiter. The most common delimiters are comma,
# semicolon, white space and tab.

# Many spreadsheets are raw text files and can be read with any basic text editor. However, some formats are proprietary and
# cannot be read with a text editor, such as Microsoft Excel files (.xls).

# Most import functions assume that the first row of a spreadsheet file is a header with column names. To know if the file
# has a header, it helps to look at the file with a text editor before trying to import it.

# Paths and the Working Directory -----------------------------------------
# The working directory is where R looks for files and saves files by default.

# See your working directory with getwd(). Change your working directory with setwd().

# We suggest you create a directory for each project and keep your raw data inside that directory.

# Use the file.path() function to generate a full path from a relative path and a file name. Use file.path() instead of
# paste() because file.path() is aware of your operating system and will use the correct slashes to navigate your machine.

# The file.copy() function copies a file to a new path.

# .. Code ..
# see working directory
getwd()

# change your working directory
setwd()

# set path to the location for raw data files in the dslabs package and list files
path <- system.file("extdata", package="dslabs")
list.files(path)

# generate a full path to a file
filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath

# copy file from dslabs package to your working directory
file.copy(fullpath, getwd())

# check if the file exists
file.exists(filename)

# readr and readxl Packages -----------------------------------------------
# readr is the tidyverse library that includes functions for reading data stored in text file spreadsheets into R.
# Functions in the package include read_csv(), read_tsv(), read_delim() and more. These differ by the delimiter they
# use to split columns.

# The readxl package provides functions to read Microsoft Excel formatted files.

# The excel_sheets() function gives the names of the sheets in the Excel file. These names are passed to the sheet
# argument for the readxl functions read_excel(), read_xls() and read_xlsx().

# The read_lines() function shows the first few lines of a file in R.

# .. Code ..
library(dslabs)
library(tidyverse)    # includes readr
library(readxl)

# inspect the first 3 lines
read_lines("murders.csv", n_max = 3)

# read file in CSV format
dat <- read_csv(filename)

#read using full path
dat <- read_csv(fullpath)
head(dat)

#Ex：
path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files

filename <- "murders.csv"
filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
filename2 <- "fertility-two-countries-example.csv"
dat=read_csv(file.path(path, filename))
dat1=read_csv(file.path(path, filename1))
dat2=read_csv(file.path(path, filename2))

# Importing Data Using R-Base Functions -----------------------------------
# The read_table() family of commands will produce a tibble. While the read.table() commands will produce a normal data frame.

# Starting from R 4.0.0, the function read.table() changed its default from stringsAsFactors = TRUE to
# stringsAsFactors = FALSE.

# In this way, when we are using read.table(), read.csv(), or read.delim(), the character features in
# the data file won't be automatically read in as "factor", but instead will remain as "character".

# read.csv converts strings to factors
dat3 <- read.csv(filename)

# compare dat2 and dat3
dat2 # a tibble
class(dat2)

dat3 # a normal data frame
class(dat3)

# Downloading Files from the Internet -------------------------------------
# The read_csv() function and other import functions can read a URL directly.

# If you want to have a local copy of the file, you can use download.file().

# tempdir() creates a directory with a name that is very unlikely not to be unique.

# tempfile() creates a character string that is likely to be a unique filename.

# .. Code ..
url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)
download.file(url, "murders.csv")

tempfile() # unique file name
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)