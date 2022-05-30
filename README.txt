Taking notes on the Data Science: Wrangling course; practicing what I've learned during the previous Data Science Productivity Tools course.

Link to HarvardX Data Science: Productivity Tools:
  https://www.edx.org/course/data-science-productivity-tools

Link to HarvardX Data Science: Wrangling:
  https://www.edx.org/course/data-science-wrangling

For most effective navigation--In RStudio, document outine (Ctrl+Shift+O) aligns with the following .R contents:

--- Directory: data_import --- 

-- data-import.R
- working with spreadsheets
  
    - Paths and the Working Directory - review of the working directory and paths
    
    - readr and readxl Packages -  readr and readxl pacakges
    
    - Importing Data Using R-Base Functions - details about the content update that changed the 'read.table' default
    
    - Downloading Files from the Internet -  retrieving data directly from a url
    
-- murders.csv
- Data on US gun murders, copied from the dslabs package

.
..
.
--- Directory: tidy_data ---
-- tidy-data-1.R
    - Tidy Data - examining some differences between wide data and tidy data via code
  
    - Reshaping Data -'gather' and its arguments and on how to convert data from wide to tidy and vice versa
  
    - Separate and Unite - ways you can use 'separate', 'unite', and 'spread' to tidy data
  
-- tidy-data-2.R
    - Combining Tables - differences between '_join' commands
  
    - Binding - binding data frames via dplyr vs. the R-base functions
  
    - Set Operators - working with set operators
  
-- tidy-data-3.R
    - Web Scraping - basic web scraping
  
    - CSS Selectors - working with CSS Selectors

-- fertility.png
- Plot on fertility rates in Germany and South Korea

-- join.png
- Diagram on join functions

-- votes.png
- Plot on electoral votes versus population

.
..
.
--- Directory: string_processing ---
-- string-p-1.R
    - String Parsing -  the common tasks in string processing
  
    - Defining Strings: Single/Double & Esc Quotes -  how to string properly with '' "" and '\'' "\""
  
    - stringr Package - working with the stringr package
    
    - Case Study 1: US Murders - working with some 'str_' functions
  
-- string-p-2.R
    - Case Study 2: Reported Heights - continuation of notes on 'str_' functions
    
    - Regex -  the basics of regular expressions (regex)
    
    - Character Classes, Anchors & Modifiers -  some particulars (class, anchors, and modifiers) of regex
    
    - Search and Replace w/ Regex -  how to search and replace with regex
    
    - Groups w/ Regex - how to use groups to improve value extraction with regex
    
    - Testing and Improving - troubleshooting value extraction with regex
  
-- string-p-3.R
    - Separate w/ Regex - working with the 'extract' function
    
    - Using Groups & Quantifiers - examples of building a fix using regex techniques
    
    - String Splitting -  splitting strings
    
    - Case Study 3: NL Funding Rates by Gender - continuation of notes on splitting strings
    
    - Recoding - some basics of 'recode'
.
..
.
--- Directory: time_text_mining ---
-- time-txt.R
    - Dates and Times -  date-time objects and the lubridate package
    
    - Case Study: Trump Tweets -  text-mining basics
    
    - Text as Data - using tidytext to convert free form text as data
    
    - Sentiment Analysis -  performing sentiment analysis via tidytext

-- sentiment-graph.png
- Graph for sentiment analysis on Trump tweets

-- sentiment-plot.png
- Plot for sentiment analysis of Trump tweets

-- trump-tweets-graph.png
- Graph on Trump tweets, device used for each hour of the day
