## Section 2.3 - Tidy Data: Web Scraping

# Web Scraping ------------------------------------------------------------

# Web scraping is extracting data from a website.

# The rvest web harvesting package includes functions to extract nodes of an HTML document: html_nodes() extracts all nodes
# of different types, and html_node() extracts the first node.

# html_table() converts an HTML table to a data frame.

# ...Code...
# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab <- tab[[2]]
tab

tab <- tab %>% html_table
tab
class(tab)


tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

# CSS Selectors -----------------------------------------------------------

# CSS is used to add style to webpages.
# CSS leverages patterns used to define elements (title, headings, itemized lists, tables, and links, for example,
# each receive their own style including font, color, size, and distance from the margin, among others) referred to as selectors.
# An example of pattern we used in a previous video is table but there are many many more.
# If we want to grab data from a webpage and we happen to know a selector that is unique to the part of the page, we can use the
# html_nodes() function.
# To demonstrate the complexity of knowing which selector(s) to use, we will try to extract the recipe name, total preparation time,
# and list of ingredients from an online recipe:
h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
# We recommend installing SelectorGadget, a piece of software that allows you to interactively determine what CSS selector you need
# to extract specific components from the web page. For the guacamole recipe page, we already have done this and determined that we
# need the following selectors:

recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()

# You can see how complex the selectors are. In any case we are now ready to extract what we want and create a list:

guacamole <- list(recipe, prep_time, ingredients)
guacamole

# Since recipe pages from this website follow this general layout, we can use this code to create a function that extracts
# this information:

get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
  prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
  ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
  return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 

# and then use it on any of their webpages:

get_recipe("http://www.foodnetwork.com/recipes/food-network-kitchen/pancakes-recipe-1913844")

# There are several other powerful tools provided by rvest. For example, the functions html_form(), set_values(), and
# submit_form() permit you to query a webpage from R. This is a more advanced topic not covered here.
