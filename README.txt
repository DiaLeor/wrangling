Taking notes on the Data Science: Wrangling course; practicing what I've learned during the previous Data Science Productivity Tools course. For most effective navigation--In RStudio, document outine (Ctrl+Shift+O) aligns with the following .R contents:

--- Directory: data_import --- 

-- data-import.R
- Notes on spreadsheets
  
    - Paths and the Working Directory - review of the working directory and paths
    
    - readr and readxl Packages - notes on readr and readxl pacakges
    
    - Importing Data Using R-Base Functions - details about the content update that changed the 'read.table' default
    
    - Downloading Files from the Internet - notes on retrieving data directly from a url
    
-- murders.csv
- Data on US gun murders, copied from the dslabs package

.
..
.
--- Directory: tidy_data ---
-- tidy-data-1.R
    - Tidy Data - examining some differences between wide data and tidy data via code
  
    - Reshaping Data - notes for 'gather' and its arguments and on how to convert data from wide to tidy and vice versa
  
    - Separate and Unite - notes and code on ways you can use 'separate', 'unite', and 'spread' to tidy data
  
-- tidy-data-2.R
    - Combining Tables - notes and code on the differences between '_join' commands
  
    - Binding - notes and code on binding data frames via dplyr vs. the R-base functions
  
    - Set Operators - notes on set operators
  
-- tidy-data-3.R
    - Web Scraping - notes and code on basic web scraping
  
    - CSS Selectors - notes on CSS Selectors

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
    - String Parsing - notes on the common tasks in string processing
  
    - Defining Strings: Single/Double & Esc Quotes - notes on how to string properly with '' "" and '\'' "\""
  
    - stringr Package - notes on the stringr package
    
    - Case Study 1: US Murders - notes on some 'str_' functions
  
-- string-p-2.R
    - Case Study 2: Reported Heights - continuation of notes on 'str_' functions
    
    - Regex - notes on the basics of regular expressions (regex)
    
    - Character Classes, Anchors & Modifiers - notes on some particulars (class, anchors, and modifiers) of regex
    
    - Search and Replace w/ Regex - notes on how to search and replace with regex
    
    - Groups w/ Regex - how to use groups to improve value extraction with regex
    
    - Testing and Improving - troubleshooting value extraction with regex
  
-- string-p-3.R
    - Separate w/ Regex - notes on the 'extract' function
    
    - Using Groups & Quantifiers - examples of building a fix using regex techniques
    
    - String Splitting - notes on splitting strings
    
    - Case Study 3: NL Funding Rates by Gender - continuation of notes on splitting strings
    
    - Recoding - some basics of 'recode'
.
..
.
--- Directory: time_text_mining ---
-- time-txt.R
    - Dates and Times - notes on date-time objects and the lubridate package
    
    - Case Study: Trump Tweets - notes on text-mining basics
    
    - Text as Data - using tidytext to convert free form text as data
    
    - Sentiment Analysis - notes on performing sentiment analysis via tidytext

-- sentiment-graph.png
- Graph for sentiment analysis on Trump tweets

-- sentiment-plot.png
- Plot for sentiment analysis of Trump tweets

-- trump-tweets-graph.png
- Graph on Trump tweets, device used for each hour of the day